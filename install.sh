#!/bin/bash
set -xeuo pipefail

PWD=$(pwd)

ln -s $PWD/modules/nix $HOME/.config/nix
ln -s $PWD/modules/home-manager $HOME/.config/home-manager
ln -s $PWD/modules/emacs $HOME/.config/emacs
ln -s $PWD/modules/doom $HOME/.config/doom

nix run home-manager/release-24.05 -- init --switch $PWD/modules/home-manager
