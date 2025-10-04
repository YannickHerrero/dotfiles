#!/bin/bash
STATE_FILE="/tmp/keyboard-toggle-state"

if [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "enabled" ]; then
  echo '{"text": "󰌌", "tooltip": "Laptop keyboard enabled", "class": "enabled"}'
else
  echo '{"text": "󰌐", "tooltip": "Laptop keyboard disabled", "class": "disabled"}'
fi
