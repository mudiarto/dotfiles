#! /usr/bin/env bash

# atuin - magical shell history
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi
