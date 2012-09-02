# Dotfiles

## Install

    curl -s https://raw.github.com/boldfield/dotfiles/master/script/install.sh | sh

The install process will `git clone` the project if `git` is available or
download the project via `curl`. It will then `make` the project.

## Pre-Install

The default install directory is `$HOME/.dotfiles`. That path can be
overridden in the `$HOME/.dotrc` file by defining the `DOTFILES`
variable. For example:

    DOTFILES="$HOME/path/to/dotfiles"

## Pre-Requisites

### Required

- sh
- mkdir
- curl
- make

### Optional

- git

## TODO

The bashrc flow takes too long. There should be a make recipe to combine
all scripts into a single script to eliminate includes.
