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


# assh: smarter ssh client
# see: https://github.com/moul/assh
alias assh.build="assh config build --no-automatic-rewrite > ~/.ssh/config"
alias assh.edit="vi ~/.ssh/assh.yml && assh.build"

# recommended by assh to use this alias so we can rebuild config as needed
alias ssh="assh wrapper ssh --"
