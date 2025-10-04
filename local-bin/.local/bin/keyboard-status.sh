#!/bin/bash
if systemctl is-active --quiet keyd; then
  echo '{"text": "󰌌", "tooltip": "Laptop keyboard enabled", "class": "enabled"}'
else
  echo '{"text": "󰌐", "tooltip": "Laptop keyboard disabled", "class": "disabled"}'
fi
