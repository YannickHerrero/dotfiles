#!/bin/bash
STATE_FILE="/tmp/keyboard-toggle-state"

if [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "enabled" ]; then
  hyprctl keyword device[apple-mtp-keyboard]:enabled false > /dev/null
  echo "disabled" > "$STATE_FILE"
  echo "Laptop keyboard disabled"
else
  hyprctl keyword device[apple-mtp-keyboard]:enabled true > /dev/null
  echo "enabled" > "$STATE_FILE"
  echo "Laptop keyboard enabled"
fi
