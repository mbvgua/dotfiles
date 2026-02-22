#!/bin/bash

# polkit
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# background
# handled in ./../settings/screens.py to allow for random wallpapers
# feh --bg-fill  ~/.config/qtile/wallpapers/ &

# compositor
# start in grayscale mode
picom --config ~/.config/picom/picom-grayscale.conf -b &

# Notifications
dunst -config ~/.config/dunst/dunstrc &

# network manager
nm-applet --indicator &

# bluetooth manager
blueman-applet &

# blue light filter
redshift-gtk &

# battery power management
xfce4-power-manager &

# lockscreen functionality, turns out xfce is nice!
xfce4-screensaver &
