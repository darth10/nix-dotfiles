#!/usr/bin/env bash
set -xeuo pipefail

PWD=$(pwd)

# For README:
# nix profile install nixpkgs#git --extra-experimental-features 'nix-command flakes' --priority 7
# git clone ~/Downloads/dotfiles-nix.bundle ~/.nix-dotfiles -b master --recursive

ln -s $PWD/modules/nix $HOME/.config/nix # TODO remove this module
ln -s $PWD/modules/doom $HOME/.config/doom

nix run --extra-experimental-features 'nix-command flakes' home-manager/release-24.05 -- init --switch .

if [ -e /etc/NIXOS ]; then
    # Make sure changes to `hardware-configuration.nix` are staged or committed:
    cp /etc/nixos/hardware-configuration.nix $PWD/modules/nixos/hardware-configuration.nix

    sudo mv /etc/nixos /etc/nixos.orig
    sudo ln -s $PWD /etc/nixos
    sudo nixos-rebuild switch
    sudo nixos-rebuild switch --flake $PWD#starf0rge
fi
