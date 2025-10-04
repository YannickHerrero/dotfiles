#!/bin/bash

# Default temperature values
ON_TEMP=3000
OFF_TEMP=6000

# Query the current temperature
CURRENT_TEMP=$(hyprctl hyprsunset temperature 2>/dev/null | grep -oE '[0-9]+')

if [[ "$CURRENT_TEMP" == "$ON_TEMP" ]]; then
  echo '{"text": "  󰖔  ", "tooltip": "Nightlight ON"}'
else
  echo '{"text": "  󰖨  ", "tooltip": "Nightlight OFF"}'
fi
