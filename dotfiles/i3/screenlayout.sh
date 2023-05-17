#!/bin/sh
xrandr --output DisplayPort-1 --primary --mode 1920x1080 -r 144.00 --pos 2560x0 --rotate normal --output DisplayPort-0 --primary --mode 1920x1080 --pos 4480x0 --rotate normal --output DisplayPort-2 --off --output HDMI-A-0 --mode 2560x1080 --pos 0x0 --rotate normal
feh --no-fehbg --bg-center '/home/calvo/.config/i3/wal.jpg' 
