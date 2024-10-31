import Pkg

@info "Checking if the IJulia package has been installed, and can be imported:"

# Check if package is already installed
isinstalled(pkg) = isnothing(Base.identify_package(pkg)) ? false :
                   haskey(Pkg.dependencies(), Base.identify_package(pkg).uuid)

# A broken manifest might trigger isinstalled to fail
try isinstalled("IJulia")
catch e
    @warn "Could not interrogate environment for IJulia:" e
    @info "Trying Pkg.resolve"
    Pkg.resolve()
    @info "Trying Pkg.instantiate"
    Pkg.instantiate()
end

# If IJulia is not installed, install it
if isinstalled("IJulia")
    @info "IJulia has been found in the active environment"
else
    @warn "IJulia has not been found in the active environment => installing"
    Pkg.add("IJulia")
end

# The environment might be fine, but the module is broken
try
    import IJulia
catch e
    @warn "Failed to import IJulia with error:" e
    @info "Updating IJulia (and any of its dependencies)"
    Pkg.update("IJulia"; preserve=Pkg.PRESERVE_NONE)
    @info "Trying Pkg.build(\"IJulia\")"
    Pkg.build("IJulia")
finally
    import IJulia
end

@info "Success! IJulia found and seems to be working"
# Last line of output needs to be path the of the kernel.jl -- calling script
# will ignore earlier logging output
println(joinpath(splitpath(pathof(IJulia))[1:end-1]..., "kernel.jl"))

