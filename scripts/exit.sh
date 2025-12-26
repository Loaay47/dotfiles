#!/usr/bin/env bash

choice=$(echo -e "⏻  shutdown\n  reboot\n  logout" | rofi -dmenu -p "Choose action:")

[ "$choice" = "⏻  shutdown" ] && doas poweroff
[ "$choice" = "  reboot" ] && doas reboot
[ "$choice" = "  logout" ] && pkill dwm

