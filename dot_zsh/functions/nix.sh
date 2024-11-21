#! /usr/bin/env bash

# shellcheck disable=SC1091

# run this only if $HOME/.nix-profile/ exists
if [ -d "$HOME/.nix-profile" ]; then
  # nix-direnv
  # see: https://github.com/nix-community/nix-direnv
  # install with nix profile install nixpkgs#nix-direnv
  source "$HOME"/.nix-profile/share/nix-direnv/direnvrc
fi
