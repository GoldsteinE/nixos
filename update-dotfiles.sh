#!/bin/sh
set -e
cd hosts/think
nix flake lock --update-input dotfiles
cd ../metal
nix flake lock --update-input dotfiles
cd ../..
git add hosts
git commit -m 'update dotfiles'
