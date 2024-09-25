#!/usr/bin/env bash

# Add -x flag to debug
set -euo pipefail

PWD=$(pwd)

# For README:
# - install https://github.com/DeterminateSystems/nix-installer
#   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
# - Setup ssh-key
# - nix shell nixpkgs#git --extra-experimental-features 'nix-command flakes'
# - git clone  --recursive ~/Downloads/dotfiles-nix.bundle ~/.nix-dotfiles -b master

nix run --extra-experimental-features 'nix-command flakes' \
    home-manager/release-24.05 -- -b backup switch --flake .

# NixOS
if [ -e /etc/NIXOS ]; then
    # Make sure changes to `hardware-configuration.nix` are staged or committed:
    cp /etc/nixos/hardware-configuration.nix $PWD/modules/nixos/hardware-configuration.nix

    sudo mv /etc/nixos /etc/nixos.orig
    sudo ln -s $PWD /etc/nixos
    # TODO show hosts, using: nix flake show --json | jq -r '"Hosts: \u001b[36m\(.nixosConfigurations | keys)"'
    # also check more than 1 of: nix flake show --json | jq -r ".nixosConfigurations | keys | length"
    # and read host into variable using: read -p "Host: " NIX_OS_HOST
    # and to pass to this command as: nixos-rebuild switch --flake .#$NIX_OS_HOST":
    sudo nixos-rebuild switch --flake .#starf0rge
fi

# Other Linux
if [ ! -e /etc/NIXOS ] && [ $OSTYPE == 'linux-gnu' ]; then
     NIX_ZSH=$(ls ~/.nix-profile/bin/zsh)
     printf "\n\e[93mAdding $NIX_ZSH to /etc/shells\e[0m\n\n"
     echo $NIX_ZSH | sudo tee -a /etc/shells > /dev/null
     printf "\n\e[93m"
     chsh -s $NIX_ZSH
     printf "\n\e[0m"
fi

printf '\e[92mDone!\nMake sure you logout or reboot.\e[0m\n\n'
