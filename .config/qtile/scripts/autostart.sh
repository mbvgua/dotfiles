#!/bin/sh

# polkit
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# background
feh --bg-fill  ~/.config/qtile/wallpapers/ &

# compositor
picom --config ~/.config/picom/picom.conf -b &

# Notifications
dunst -config ~/.config/dunst/dunstrc &

# network manager
nm-applet --indicator &

# bluetooth manager
blueman-applet &

# night light.ish features
redshift-gtk &

# battery power management
xfce4-power-manager &

# lockscreen functionality, turns out xfce is nice!
xfce4-screensaver &

# start mpd daemon
mpd ~/.config/mpd/mpd.conf &
