#!/bin/bash
if systemctl is-active --quiet keyd; then
  hyprctl keyword device[apple-mtp-keyboard]:enabled false
  sudo systemctl stop keyd
else
  hyprctl keyword device[apple-mtp-keyboard]:enabled true
  sudo systemctl start keyd
fi
