#! /usr/bin/env bash

# run this only if there xinput command and is "Logitech USB Trackball" in the `xinput list` output
if command -v xinput &> /dev/null && xinput list | grep -qE "Logitech USB Trackball|Logitech MX750"; then
  # logitech marble mouse settings to be able to scroll - seems to work for ubuntu 22.04
  # from: https://ubuntuforums.org/showthread.php?t=2491926
  # regarding left/right click & natural scroll - use standard mouse settings
  # get value with: gsettings list-recursively org.gnome.desktop.peripherals.trackball
  gsettings set org.gnome.desktop.peripherals.trackball middle-click-emulation true
  # 8 for left button (thumb right handed), 9 for right button (thumb left handed)
  gsettings set org.gnome.desktop.peripherals.trackball scroll-wheel-emulation-button 9
fi
