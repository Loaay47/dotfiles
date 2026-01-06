#!/usr/bin/env bash

emoji_file="$HOME/.config/emojis.txt"
choice=$(cat "$emoji_file" | dmenu -i -l 7 -p "Emoji:")
echo $choice | awk '{print $NF}' | xclip -selection clipboard

