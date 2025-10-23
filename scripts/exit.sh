#!/usr/bin/env bash

choice=$(echo -e "⏻  shutdown\n  reboot\n  exit" | rofi -dmenu -p "Choose action:")

[ "$choice" = "⏻  shutdown" ] && doas poweroff
[ "$choice" = "  reboot" ] && doas reboot
[ "$choice" = "  exit" ] && pkill dwm

