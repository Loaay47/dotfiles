#!/usr/bin/env bash

choice=$(printf "⏻  shutdown\n  reboot\n  logout" | dmenu -i -l 3 -p "Choose action:")

[ "$choice" = "⏻  shutdown" ] && doas poweroff
[ "$choice" = "  reboot" ] && doas reboot
[ "$choice" = "  logout" ] && pkill dwm
