# Conda CWD Env ZSH Plugin

The conda_cwd_env ZSH plugin provides a command for creating a Conda virtual environment in the current working directory (CWD).

## Prerequisites

This plugin requires Conda to be installed and available on your system.

## Installation

1. Clone the plugin:

  ```bash
  git clone https://github.com/adambytes/conda-cwd ~/.oh-my-zsh/custom/plugins/conda-cwd
  ```

2. Include conda-cwd in your .zshrc's plugin list:

```config
plugins=(... conda-cwd)
```

3. Restart your terminal or run source ~/.zshrc.

## Usage

To create a new Conda environment in your current directory, use the create_conda_cwd_env command:

```bash
ccwd # Should create .conda in your current working dir
```

By default, it creates a Conda environment using Python version 3.11. If you want to specify a different Python version, pass it as an argument:

```bash
ccwd 3.8
```

If a requirements.txt file exists in the current directory, the command will also attempt to install the specified packages into the new environment. It first tries to install packages with conda and, if that fails, with pip.

## License

MIT License
