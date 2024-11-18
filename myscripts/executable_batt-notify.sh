#! /usr/bin/env bash

# use notify-send to alert user when battery is low
# we'd like to be alerted when battery is at 10% or lower
# need this for my laptop to ensure I don't get to 0% battery (ideally 2% or so)


# use crontab -e
# from: https://stackoverflow.com/questions/16519673/cron-with-notify-send
# * * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) /home/kusno/myscripts/batt-notify.sh

# use upower to get battery info for both Bat0 and Bat1
battery0_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
battery0_percentage=$(echo "$battery0_info" | grep -oP 'percentage:\s+\K\d+')
battery0_state=$(echo "$battery0_info" | grep -oP 'state:\s+\K\w+')

battery1_info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1)
battery1_percentage=$(echo "$battery1_info" | grep -oP 'percentage:\s+\K\d+')
battery1_state=$(echo "$battery1_info" | grep -oP 'state:\s+\K\w+')

# echo BAT0 percentage: $battery0_percentage
# echo BAT0 state: $battery0_state
# echo BAT1 percentage: $battery1_percentage
# echo BAT1 state: $battery1_state

# check if both batteries are discharging and if their percentage is less than or equal to 10
if [[ $battery0_percentage -le 10 && $battery0_state == 'discharging' ]] || [[ $battery1_percentage -le 10 && $battery1_state == 'discharging' ]]; then
    notify-send -u NORMAL -t 1000 "Low Battery!" "BAT0:$battery0_state:$battery0_percentage% BAT1:$battery1_state:$battery1_percentage%"
fi
