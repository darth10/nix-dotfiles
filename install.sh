#!/usr/bin/env bash

# Add -x flag to debug
set -euo pipefail

nix run home-manager/release-24.05 -- -b backup switch \
    --flake ".#$USER"

# NixOS
if [ -e /etc/NIXOS ]; then
    PWD=$(pwd)
    # Make sure changes to `hardware-configuration.nix` are staged or committed:
    cp /etc/nixos/hardware-configuration.nix "$PWD/modules/hosts/$HOST/hardware-configuration.nix"
    sudo mv /etc/nixos /etc/nixos.orig
    sudo ln -s $PWD /etc/nixos
    sudo nixos-rebuild switch --flake ".#$HOST"
fi

# Other Linux
if [ ! -e /etc/NIXOS ] && [ $OSTYPE == 'linux-gnu' ]; then
     NIX_ZSH=$(ls ~/.local/state/nix/profile/bin/zsh)
     printf "\n\e[93mAdding %s to /etc/shells\e[0m\n\n" $NIX_ZSH
     echo $NIX_ZSH | sudo tee -a /etc/shells > /dev/null
     printf "\n\e[93m"
     chsh -s $NIX_ZSH
     printf "\n\e[0m"
fi

printf '\e[92mDone!\nMake sure you logout or reboot.\e[0m\n\n'
