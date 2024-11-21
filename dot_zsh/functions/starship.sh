#! /usr/bin/env bash

# run starship if available
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi
