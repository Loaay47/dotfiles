#!/bin/sh

choice=$(echo "shutdown\nreboot\nexit" | dmenu -i -p "Choose action : ")

[ $choice = "shutdown" ] && doas poweroff
[ $choice = "reboot" ] && doas reboot
[ $choice = "exit" ] && pkill dwm 
