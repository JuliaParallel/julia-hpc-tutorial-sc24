# GPU Acceleration

This section will teach you GPU programming in Julia, with a focus on using CUDA.jl and KernelAbstractions.jl.

To run the notebooks on Perlmutter, please clone this repository if you haven't done so already:

```sh
git clone https://github.com/JuliaParallel/julia-hpc-tutorial-sc24
cd julia-hpc-tutorial-sc24
```

It is recommended to access the Jupyter notebook for this section through this website:   

[NERSC Jupyter notebook](https://jupyter.nersc.gov/)

## Introduction to GPU programming in Julia

If you're looking for an introductory overview of GPU programming in Julia or GPU programming concepts in general, feel free to explore this [notebook](https://github.com/JuliaParallel/julia-hpc-tutorial-sc24/blob/main/parts/gpu/gpu_introduction.ipynb).

## Heat Diffusion Simulation Using Julia

This [notebook](https://github.com/JuliaParallel/julia-hpc-tutorial-sc24/blob/main/parts/gpu/Heat_Diffusion.ipynb) introduces the heat diffusion problem using a finite difference method, demonstrating stencil computations optimized for GPU acceleration in Julia. It highlights performance gains from parallel computing, showcasing Julia's capabilities for efficient numerical simulations on GPUs.

##  Gray-Scott Reaction-Diffusion Model Using Julia
This [notebook](https://github.com/JuliaParallel/julia-hpc-tutorial-sc24/blob/main/parts/gpu/stencil.ipynb) introduces Gray-Scott Reaction-Diffusion model using Julia. 
 
