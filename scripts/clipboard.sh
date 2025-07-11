#!/bin/sh
cliphist list | rofi -dmenu -p "Clipboard" | cliphist decode | xclip -selection clipboard

