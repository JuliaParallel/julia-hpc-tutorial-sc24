# 2D linear diffusion solver - MPI
using Printf
using JLD2
using MPI
include(joinpath(@__DIR__, "shared.jl"))

# convenience macros simply to avoid writing nested finite-difference expression
macro qx(ix, iy) esc(:(-D * (C[$ix+1, $iy] - C[$ix, $iy]) / dx)) end
macro qy(ix, iy) esc(:(-D * (C[$ix, $iy+1] - C[$ix, $iy]) / dy)) end

function diffusion_step!(params, C2, C)
    (; dx, dy, dt, D) = params
    for iy in 1:size(C, 2)-2
        for ix in 1:size(C, 1)-2
            @inbounds C2[ix+1, iy+1] = C[ix+1, iy+1] - dt * ((@qx(ix+1, iy+1) - @qx(ix, iy+1)) / dx +
                                                             (@qy(ix+1, iy+1) - @qy(ix+1, iy)) / dy)
        end
    end
    return nothing
end

# MPI functions
@views function update_halo!(A, bufs, neighbors, comm)
    #
    # !!! TODO
    #
    # Complete the halo exchange implementation. Specifically, use non-blocking
    # MPI communication (Irecv and Isend) at the positions marked by "TODO..." below.
    #
    # Help:
    #   left neighbor:  neighbors.x[1]
    #   right neighbor: neighbors.x[2]
    #   up neighbor:    neighbors.y[1]
    #   down neighbor:  neighbors.y[2]
    #

    # dim-1 (x)
    (neighbors.x[1] != MPI.PROC_NULL) && copyto!(bufs.send_1_1, A[2    , :])
    (neighbors.x[2] != MPI.PROC_NULL) && copyto!(bufs.send_1_2, A[end-1, :])

    reqs = MPI.MultiRequest(4)
    (neighbors.x[1] != MPI.PROC_NULL) && # TODO... receive from left neighbor into bufs.recv_1_1
    (neighbors.x[2] != MPI.PROC_NULL) && # TODO... receive from right neighbor into bufs.recv_1_2

    (neighbors.x[1] != MPI.PROC_NULL) && # TODO... send bufs.send_1_1 to left neighbor
    (neighbors.x[2] != MPI.PROC_NULL) && # TODO... send bufs.send_1_2 to right neighbor
    MPI.Waitall(reqs) # blocking

    (neighbors.x[1] != MPI.PROC_NULL) && copyto!(A[1  , :], bufs.recv_1_1)
    (neighbors.x[2] != MPI.PROC_NULL) && copyto!(A[end, :], bufs.recv_1_2)

    # dim-2 (y)
    (neighbors.y[1] != MPI.PROC_NULL) && copyto!(bufs.send_2_1, A[:, 2    ])
    (neighbors.y[2] != MPI.PROC_NULL) && copyto!(bufs.send_2_2, A[:, end-1])

    reqs = MPI.MultiRequest(4)
    (neighbors.y[1] != MPI.PROC_NULL) && # TODO... receive from up neighbor into bufs.recv_2_1
    (neighbors.y[2] != MPI.PROC_NULL) && # TODO... receive from down neighbor into bufs.recv_2_2

    (neighbors.y[1] != MPI.PROC_NULL) && # TODO... send bufs.send_2_1 to up neighbor
    (neighbors.y[2] != MPI.PROC_NULL) && # TODO... send bufs.send_2_2 to down neighbor
    MPI.Waitall(reqs) # blocking

    (neighbors.y[1] != MPI.PROC_NULL) && copyto!(A[:, 1  ], bufs.recv_2_1)
    (neighbors.y[2] != MPI.PROC_NULL) && copyto!(A[:, end], bufs.recv_2_2)
    return nothing
end

function init_bufs(A)
    return (; send_1_1=zeros(size(A, 2)), send_1_2=zeros(size(A, 2)),
              send_2_1=zeros(size(A, 1)), send_2_2=zeros(size(A, 1)),
              recv_1_1=zeros(size(A, 2)), recv_1_2=zeros(size(A, 2)),
              recv_2_1=zeros(size(A, 1)), recv_2_2=zeros(size(A, 1)))
end

function run_diffusion(; ns=64, nt=100, do_save=false)
    MPI.Init()
    comm      = MPI.COMM_WORLD
    nprocs    = MPI.Comm_size(comm)
    dims      = MPI.Dims_create(nprocs, (0, 0)) |> Tuple
    comm_cart = MPI.Cart_create(comm, dims)
    me        = MPI.Comm_rank(comm_cart)
    coords    = MPI.Cart_coords(comm_cart) |> Tuple
    neighbors = (; x=MPI.Cart_shift(comm_cart, 0, 1), y=MPI.Cart_shift(comm_cart, 1, 1))
    (me == 0) && println("nprocs = $(nprocs), dims = $dims")

    params = init_params_mpi(; dims, coords, ns, nt, do_save)
    C, C2  = init_arrays_mpi(params)
    bufs   = init_bufs(C)
    t_tic  = 0.0
    # time loop
    for it in 1:nt
        # time after warmup (ignore first 10 iterations)
        (it == 11) && (t_tic = Base.time())
        # diffusion
        diffusion_step!(params, C2, C)
        update_halo!(C2, bufs, neighbors, comm_cart)
        C, C2 = C2, C # pointer swap
    end
    t_toc = (Base.time() - t_tic)
    # "master" prints performance
    (me == 0) && print_perf(params, t_toc)
    # save to (maybe) visualize later
    if do_save
        jldsave(joinpath(@__DIR__, "out_$(me).jld2"); C = Array(C[2:end-1, 2:end-1]), lxy = (; lx=params.L, ly=params.L))
    end
    MPI.Finalize()
    return nothing
end

# Running things...

# enable save to disk by default
(!@isdefined do_save) && (do_save = true)
# enable execution by default
(!@isdefined do_run) && (do_run = true)

if do_run
    if !isempty(ARGS)
        run_diffusion(; ns=parse(Int, ARGS[1]), do_save)
    else
        run_diffusion(; ns=256, do_save)
    end
end
