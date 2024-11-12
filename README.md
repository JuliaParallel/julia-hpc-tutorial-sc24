![plot](./assets/banner.png)


# The Julia Language for Productive High-Performance Computing Tutorial @ SC24

This repository contains the material used for [The Julia Language for Productive High-Performance Computing Tutorial @ Supercomputing 2024](https://sc24.conference-program.com/presentation/?id=tut130&sess=sess433).

## Apply for your Training at a DOE Supercomputer Now!

We will post a signup form soon. Please check here again at least one month before the start of SC24

## Julia for HPC Birds of a Feather session @ SC24

We will again host a [Julia for HPC BoF at SC24](https://github.com/JuliaParallel/julia-hpc-bof-sc24)

## Running Gray Scott reaction diffusion model on NERSC


## Running notebooks with JupyterLab

### On NERSC

We will post instructions on how to use this repo's Jupyter Kernel at NERSC

<details>
<summary>Running the notebooks locally if you don't have access to Perlmutter</summary>

### Locally

Clone this repository (make sure to [install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)) and then enter inside the new directory by running the following commands in a terminal (we recommend using [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.4) if on Windows):

```sh
git clone https://github.com/JuliaParallel/julia-hpc-tutorial-sc24
cd julia-hpc-tutorial-sc24
```

After [installing Julia](https://julialang.org/downloads/), start it with
```sh
julia --project=.
```

and then inside the Julia [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) you can run [JupyterLab](https://jupyterlab.readthedocs.io/en/latest/) with

```julia
# Necessary only the first time, to instantiate the environment
using Pkg
Pkg.instantiate()

# Set the number of threads used by julia inside  Jupyter
ENV["JULIA_NUM_THREADS"] = "auto"

# Run JupyterLab
import IJulia
IJulia.jupyterlab()
```

This should open a tab in your default browser showing the JupyterLab interface.

### Using a Docker container

We also provide a [Docker image](https://github.com/JuliaParallel/julia-hpc-tutorial-sc24/pkgs/container/julia-hpc-tutorial-sc24) (built for `linux/amd64` and `linux/arm64`) for running the notebook, which you can pull with

```sh
docker pull ghcr.io/juliaparallel/julia-hpc-tutorial-sc24:main
```

[JupyterLab](https://jupyterlab.readthedocs.io/en/latest/) can then be run on MacOS or Linux with

```sh
docker run -p 8888:8888 ghcr.io/juliaparallel/julia-hpc-tutorial-sc24:main julia -e 'import Conda; run(`$(joinpath(Conda.SCRIPTDIR, "jupyter")) lab --allow-root --ip 0.0.0.0 --port 8888`)'
```

or if using PowerShell on Windows with

```PowerShell
docker run -p 8888:8888 ghcr.io/juliaparallel/julia-hpc-tutorial-sc24:main julia -e 'import Conda; run(`$(joinpath(Conda.SCRIPTDIR, """""jupyter""""")) lab --allow-root --ip 0.0.0.0 --port 8888`)'
```

This will launch JupyterLabl within the container, and if successful you should see a message similar to

```
    To access the server, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/jpserver-13-open.html
    Or copy and paste one of these URLs:
        http://7a88b848fcf0:8888/lab?token=4775e74fd85e95632e1cfeb32753eb3d009ca0fb76fca3b0
        http://127.0.0.1:8888/lab?token=4775e74fd85e95632e1cfeb32753eb3d009ca0fb76fca3b0
```

where `4775e74fd85e95632e1cfeb32753eb3d009ca0fb76fca3b0` in the URL will be replaced with another random alphanumeric string.
The JupyterLab environment is accessed as a web app, so you should open a browser window and navigate to the `http://127.0.0.1:8888/lab?token=....` URL indicated in the message to open the JupyterLab interface.
If you get `Unable to connect` message or similar when trying to open the URL, you may need to replace the `0.0.0.0` component with `localhost`, so for the example above you would navigate to `http://localhost:8888/lab?token=4775e74fd85e95632e1cfeb32753eb3d009ca0fb76fca3b0`.

### GitHub Codespaces

> [!NOTE]
> GitHub Codespaces is a convenient environment for running notebooks on the web for free, but the resources on the free plan are limited, and parallel scaling efficiency may be be poor in some cases.

You can also take advantage of the ability of [GitHub Codespaces](https://github.com/features/codespaces) to run custom web apps.
Go go the [Codespaces page of this repository](https://github.com/JuliaParallel/julia-hpc-tutorial-sc24/codespaces), click on the green button on the top right "Create codespace on main" and wait a few seconds for the codespace to start.
In the bottom panel, go to the "Terminal" tab (other tabs should be "Problems", "Output", "Debug console", "Ports") and when you see the message (this can take a few seconds to appear after the codespace started, hold on)

```
    To access the server, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/jpserver-13-open.html
    Or copy and paste one of these URLs:
        http://7a88b848fcf0:8888/lab
        http://127.0.0.1:8888/lab
```

go to the "Ports" tab, right click on the port 8888 and click on "Open in browser" (alternatively, click on the globe-shaped button under the "Forwarded Addresses" column).
This will open the JupyterLab landing page in a new tab in your browser.

If you want to make your app accessible to others (please remember to make sure there's no sensitive or private data in it!), navigate to the "Ports" tab, right click on the port 8888 and then "Port visibility" -> "Public".

The `.devcontainer` used here has been adapted from the [Julia workshop for the UCL Festival of Digital Research & Scholarship 2024](https://github.com/UCL-ARC/julia-workshop), in turn based on the [Zero-setup R workshops with GitHub Codespaces](https://github.com/revodavid/devcontainers-rstudio) repository presented at [rstudio::conf 2022](https://rstudioconf2022.sched.com/event/11iag/zero-setup-r-workshops-with-github-codespaces).

</details>

## Further resources

If you have further questions about the use of Julia, especially in HPC setting, check out

* the [Julia Discourse web forum](https://discourse.julialang.org/) for asking questions
* the [Julia on HPC clusters notes](https://juliahpc.github.io/)

Everyone is also welcome to join the fortnightly [Julia HPC community calls](https://julialang.org/community/#events), the 2nd Thursday and the 4th Tuesday of the month.
