#!/bin/bash

mkdir -p ~/Pictures/Screenshots
FILE=~/Pictures/Screenshots/$(date +%F_%H-%M-%S).png
maim "$@" | tee "$FILE" | xclip -selection clipboard -t image/png

