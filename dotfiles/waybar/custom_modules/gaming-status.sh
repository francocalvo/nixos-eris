#!/usr/bin/env bash
# Get the HDMI outputs

output=(
  $(swaymsg -t get_outputs | jq -r 'sort_by(.rect.x) | .[].name' | grep 'HDMI')
)

# Check if the output array is not empty
if [ ${#output[@]} -gt 0 ]; then
  status=$(swaymsg -t get_outputs | jq -r 'map(select(.name == "'"$output"'"))[0].active') # Get the status of the first HDMI output

  if [ "$status" = "true" ]; then
    # If HDMI output is enabled, disable it
	  echo '{"alt": "Enabled"}'
  else
	  echo '{"alt": "Disabled"}'
  fi
else
	echo '{"alt": "Disabled"}'
fi

echo '{"alt": "Disabled"}'
