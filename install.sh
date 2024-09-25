#!/usr/bin/env bash
set -xeuo pipefail

PWD=$(pwd)

# For README:
# nix shell nixpkgs#git --extra-experimental-features 'nix-command flakes'
# git clone ~/Downloads/dotfiles-nix.bundle ~/.nix-dotfiles -b master --recursive

nix run --extra-experimental-features 'nix-command flakes' home-manager/release-24.05 -- init --switch .

if [ -e /etc/NIXOS ]; then
    # Make sure changes to `hardware-configuration.nix` are staged or committed:
    cp /etc/nixos/hardware-configuration.nix $PWD/modules/nixos/hardware-configuration.nix

    sudo mv /etc/nixos /etc/nixos.orig
    sudo ln -s $PWD /etc/nixos
    sudo nixos-rebuild switch
    sudo nixos-rebuild switch --flake $PWD#starf0rge
fi
