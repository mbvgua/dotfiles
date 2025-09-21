#!/bin/sh

# polkit
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# background
# fixed in config.py
# feh --bg-fill  ~/.config/qtile/wallpapers/ &

# compositor
picom --config ~/.config/picom/picom.conf -b &

# Notifications
dunst -config ~/.config/dunst/dunstrc &

# network manager
nm-applet &

# bluetooth manager
blueman-applet &

# night light.ish features
redshift-gtk &
