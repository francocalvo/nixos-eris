#!/bin/sh
xrandr --output DVI-D-0 --off --output DP-0 --off --output DP-1 --off --output HDMI-0 --mode 2560x1080 --noprimary --pos 0x0 --rate 60 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --mode 1920x1080 --pos 2560x0 --rotate normal --rate 144 --primary --output DP-5 --off

feh --no-fehbg --bg-center '/home/calvo/.config/i3/wal.jpg'
