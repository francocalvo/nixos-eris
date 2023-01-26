#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
sleep 1

# polybar main -c $HOME/.config/polybar/config.ini &

# Launch polybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
 MONITOR=$m polybar main -c $HOME/.config/polybar/config.ini &
done
