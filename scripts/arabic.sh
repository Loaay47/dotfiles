#!/usr/bin/env bash
xclip -o -selection clipboard | fold -s -w 100 | rofi -dmenu -p "Clipboard"


