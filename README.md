![plot](./assets/banner.png)


# The Julia Language for Productive High-Performance Computing Tutorial @ SC24

This repository contains the material used for [The Julia Language for Productive High-Performance Computing Tutorial @ Supercomputing 2024](https://sc24.conference-program.com/presentation/?id=tut130&sess=sess433).

## Apply for your Training at a DOE Supercomputer Now!

1. Go to: https://iris.nersc.gov/train

2. Enter the Training Code: `azvr` along with your details
Note: if you have previously registered an account using a different code please recreate it.

3. You will see a screen like this:
<img src="https://github.com/user-attachments/assets/40556925-1c3e-4aee-9b1f-cee721f5c1a9" width="480">

**Important:** make a copy of your login and password you won’t be able to change these, nor recover them later!!!

## Sign up for the tutorial's Slack workspace

Please use [this link](https://join.slack.com/t/juliahpctutor-7z54837/shared_invite/zt-2t4ythu1d-20M9Nw6Zzd7TAeJyZDl2oQ) to sign up for our Slack workspace. This will also let you ask questions after the event.

## Julia for HPC Birds of a Feather session @ SC24

We will again host a [Julia for HPC BoF at SC24](https://github.com/JuliaParallel/julia-hpc-bof-sc24)

## Getting Started at NERSC

The [Cheat Sheet](./Cheat%20Sheet.pdf) outlines the steps you need to get started at NERSC.  

### Special Considerations for Running on NERSC

NERSC has about 10000 users, therefore the system-wide configurations are
pretty bare-bones. On single-user systems (like your local workstation, laptop,
or even the cloud), we've fallen into the habbit of making the system-wide
configurations our own. Sadly we can't do that on a shared system like NERSC's
Perlmutter supercomputer -- just imagine the pandemonium for thousands of users
customizing YOUR shell.

The solution presented here is to install all necessary Julia packages using
the `install.sh` script. This script also generates `activate.sh` which
activates any customizations to the user shell environment.

### Running Gray Scott reaction diffusion model on NERSC

Please refer to [installation and configuration](https://juliaornl.github.io/TutorialJuliaHPC/applications/GrayScott/06-Perlmutter.html) instructions for Perlmutter.

## Running Notebooks with JupyterLab

<details>
<summary>
    Running the notebooks on Perlmutter
</summary>

### On NERSC

Jupyter on HPC is a little different from running it locally or in the cloud.
These instructiosn are based on NERSC's 
[official documentation for Jupyter](https://docs.nersc.gov/services/jupyter/) 
The key difference is that you need to use the `install.sh` script to put the
Jupyer kernel specs in the location that JupyterHub expects
(`~/.local/share/jupyter/kernels`). The `install.sh` script is fairly involved
because it tries to streamline the process by:

1. Gernerating a single-threaded and a multi-threaded kernel (the multi-threaded
   kernel is different form the single-threaded case because sets the
   `JULIA_NUM_THREADS` environment variable) from a template 
   (`nersc/jupyter/template`)

2. Generating a `activate.sh` script which activates any customizations to the
   user shell environment

### Step-By-Step Guide for setting up Juputer Kernels at NERSC:


1. Go to https://jupyter.nersc.gov and log in with your credentials -- you should see soemthing like this:
<img width="825" alt="image" src="https://github.com/user-attachments/assets/7abc3be2-1ad2-43f4-b2d1-fe6e7b5e8e5a">
You might not see the bright red “stop” button, and probably fewer rows/columns – that’s OK. Select “Server” in the “Login Node” column and “Perlmutter” row (red box)

2. After a short while, you should see a blue button (with a “+” sign) in the top left hand corner. Push it, and then select “Terminal” (you might need to scroll)
<img width="818" alt="image" src="https://github.com/user-attachments/assets/c642bfec-d525-4d87-a53b-16625e16ed81">

3. If you did everything correctly, you should see a terminal window in the left-hand tab:
<img width="793" alt="image" src="https://github.com/user-attachments/assets/a7d0a60f-e20c-465d-89c8-433fb146b5d7">

4. Clone the tutorial repository:
```sh
git clone https://github.com/JuliaParallel/julia-hpc-tutorial-sc24
```

5. Enter the tutorial folder:
```sh
git clone https://github.com/JuliaParallel/julia-hpc-tutorial-sc24
cd julia-hpc-tutorial-sc24
```

6. Run the install script:
```sh
./install.sh
```
(this might take some time – that’s OK)

</details>

<details>
<summary>
    Running the notebooks locally if you don't have access to Perlmutter
</summary>

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
