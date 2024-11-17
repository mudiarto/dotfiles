#! /usr/bin/env bash
# Description: Utility functions

# make directory and cd into it
function mcd () {
  mkdir -v -p "$1"
  cd "$1" || exit
}


# battery status
# from: https://askubuntu.com/questions/1450723/thinkpad-t480-linux-battery-performance
# use tlp tlp-rdw powertop to also manage power
alias batt0="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'state|to\ full|percentage'"
alias batt1="upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E 'state|to\ full|percentage'"
