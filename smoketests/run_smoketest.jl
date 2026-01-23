using TOML

backend = ARGS[1]

# Base configuration with fixed parameters
base_config = Dict(
    "Du" => 0.2,
    "Dv" => 0.1,
    "F" => 0.02,
    "k" => 0.048,
    "dt" => 1.0,
    "plotgap" => 10,
    "noise" => 0.1,
    "checkpoint" => false,
    "checkpoint_freq" => 700,
    "checkpoint_output" => "ckpt.bp",
    "restart" => false,
    "restart_input" => "ckpt.bp",
    "mesh_type" => "image",
    "verbose" => false,
)

# Parameter ranges for grid search
L_values = [2^i for i in 6:10]  # 8 to 1024 in powers of 2
steps_values = [1000, 10000, 50000, 100000]
precision_values = ["Float32", "Float64"]
kernel_language_values = ["Plain", "KernelAbstractions"]

# Create output directory if it doesn't exist
mkpath("configs")

# Counter for configurations
config_count = 0

# Generate all combinations and run simulations
for L in L_values,
    steps in steps_values,
    precision in precision_values,
    kernel_language in kernel_language_values

    # Create a copy of base configuration
    config = copy(base_config)

    # Add variable parameters
    config["L"] = L
    config["steps"] = steps
    config["precision"] = precision
    config["backend"] = backend
    config["kernel_language"] = kernel_language

    # Generate unique output filename based on parameters
    output_filename = "gs-$(backend)-$(L)L-$(precision).bp"
    config["output"] = output_filename

    # Create config filename
    config_filename = "configs/config_$(config_count).toml"

    # Write configuration to TOML file
    open(config_filename, "w") do io
        TOML.print(io, config)
    end

    # Run simulation with this configuration
    if backend == "CUDA"
        run_cmd = `julia --project -e 'import GrayScott, CUDA; GrayScott.main(ARGS)' $config_filename`
    else
        run_cmd = `julia --project -e 'import GrayScott; GrayScott.main(ARGS)' $config_filename`
    end

    # Print information about current run
    println("Running configuration $config_count:")
    println("L: $L, Steps: $steps, Precision: $precision, Backend: $backend, Kernel: $kernel_language")

    # Run the simulation
    run(run_cmd)
    println("Successfully completed configuration $config_count")

    global config_count += 1
end

println("Completed all $config_count configurations")
