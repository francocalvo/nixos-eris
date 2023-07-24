#!/usr/bin/env bash
# Get the HDMI outputs

enable_i3wm_rule() {
  swaymsg 'for_window [instance="steam"] floating enable, resize set 3840 2160, move position 3000 0'
}

# Function to disable the i3WM-specific rule for Steam BigPicture
disable_i3wm_rule() {
  swaymsg '[con_mark="steam_bigpicture"] kill'
}

output=(
  $(swaymsg -t get_outputs | jq -r 'sort_by(.rect.x) | .[].name' | grep 'HDMI')
)

# Check if the output array is not empty
if [ ${#output[@]} -gt 0 ]; then
  status=$(swaymsg -t get_outputs | jq -r 'map(select(.name == "'"$output"'"))[0].active') # Get the status of the first HDMI output

  if [ "$status" = "true" ]; then
    # If HDMI output is enabled, disable it
    swaymsg output "${output[0]}" disable
    xrandr --output DP-1 --primary

    # Set the default audio sink to the non-HDMI output (assuming it's the first in the list)
    non_hdmi_sink=$(pactl list short sinks | awk '{print $1}' | head -n 1)
    pactl set-default-sink "$non_hdmi_sink"
    disable_i3wm_rule
  else
    # If HDMI output is not enabled, proceed with enabling it
    # Assign the workspace 11 to the first HDMI output
    swaymsg workspace 11 output "${output[0]}"

    # Enable the first HDMI output
    swaymsg output "${output[0]}" enable

    # Focus the first HDMI output
    swaymsg focus output "${output[0]}"

    # Make main monitor for Xwayland
    xrandr --output ${output[0]} --primary

    # Set the default audio sink to the HDMI TV
    hdmi_sink=$(pactl list short sinks | grep ".hdmi-stereo-" | awk '{print $1}')
    pactl set-default-sink "$hdmi_sink"

    # Open Steam BigPicture in the first HDMI output
    echo "opening steam"
    enable_i3wm_rule
    steam -bigpicture
  fi
fi



    # If HDMI output is not enabled, proceed with enabling it
    # Assign the workspace 11 to the first HDMI output
    swaymsg workspace 11 output "${hdmi_output}"

    # Enable the first HDMI output
    swaymsg output "${hdmi_output}" enable

    # Focus the first HDMI output
    swaymsg focus output "${hdmi_output}"

    # Make main monitor for Xwayland
    xrandr --output "${hdmi_output}" --primary


    # Open Steam BigPicture in the first HDMI output
    echo "opening steam"
    steam -bigpicture
  fi
    disable_i3wm_rule
fi
