#!/usr/bin/env bash

mkdir -p ~/Pictures/Screenshots
FILE=~/Pictures/Screenshots/$(date +%F_%H-%M-%S).png
echo "$FILE" | xclip -selection clipboard
maim "$@" | tee "$FILE" | xclip -selection clipboard -t image/png

