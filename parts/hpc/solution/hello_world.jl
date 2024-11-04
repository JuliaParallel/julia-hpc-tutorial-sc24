using MPI

MPI.Init()

comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)
name = gethostname()

print("Hello world, I am rank $(rank) of $(size) on $(name)\n")

MPI.Barrier(comm)

if rank == 0
    print(MPI.versioninfo())
end
