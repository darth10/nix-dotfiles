#!/usr/bin/env bash
set -xeuo pipefail

PWD=$(pwd)

# TODO doom-emacs doesn't have to be a git submodule
# TODO refactor function for creating symbolic links
ln -s $PWD/modules/nix $HOME/.config/nix
ln -s $PWD/modules/home-manager $HOME/.config/home-manager
ln -s $PWD/modules/emacs $HOME/.config/emacs
ln -s $PWD/modules/doom $HOME/.config/doom

if [ -e /etc/NIXOS ]; then
    sudo rm /etc/nixos/configuration.nix
    sudo ln -s $PWD/modules/nixos/configuration.nix /etc/nixos/configuration.nix
    sudo ln -s $PWD/modules/nixos/flake.nix /etc/nixos/flake.nix
    sudo ln -s $PWD/modules/nixos/flake.lock /etc/nixos/flake.lock
fi

nix run home-manager/release-24.05 -- init --impure --switch $PWD/modules/home-manager
