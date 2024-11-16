#! /usr/bin/env bash
# Description: Utility functions

# make directory and cd into it
function mcd () {
  mkdir -v -p "$1"
  cd "$1" || exit
}
