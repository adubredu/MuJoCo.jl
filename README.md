# MuJoCo.jl
A light-weight Julia wrapper for the [MuJoCo Physics Simulator](https://mujoco.org/) 

## Installation
1. Install anaconda by following the instructions on this [website](https://docs.anaconda.com/anaconda/install/index.html). 
2. Run `echo export JULIA_CONDAPKG_BACKEND="System" > ~/.bashrc` in your terminal.
3. Run `source ~/.bashrc` in your terminal.
4. Open your Julia REPL by typing  `julia` in your terminal.
5. Press `]` on your keyboard to enter the package manager 
7. Enter command `add https://github.com/adubredu/MuJoCo.jl` and press 
`Enter` on your keyboard to install this package.
8. Press the `Backspace` key on your keyboard to return to the REPL

## Features
This package wraps DeepMind's [dm_control](https://github.com/deepmind/dm_control) Python package that provides access to the core MuJoCo package as well as some useful environments for Reinforcement Learning and interactive simulator viewing.

## Usage
See the [examples](examples) folder for usage examples.
