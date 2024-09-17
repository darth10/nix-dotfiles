#!/usr/bin/env bash
set -xeuo pipefail

PWD=$(pwd)

# TODO refactor function for creating symbolic links
ln -s $PWD/modules/nix $HOME/.config/nix
ln -s $PWD/modules/home-manager $HOME/.config/home-manager
ln -s $PWD/modules/doom $HOME/.config/doom

if [ -e /etc/NIXOS ]; then
    # Make sure changes to `hardware-configuration.nix` are staged or committed:
    nixos-generate-config --show-hardware-config > $PWD/modules/nixos/hardware-configuration.nix

    sudo mv /etc/nixos /etc/nixos.orig
    sudo ln -s $PWD/modules/nixos /etc/nixos
fi

nix run home-manager/release-24.05 -- init --impure --switch $PWD/modules/home-manager
