#!/bin/bash

file=$(find ~/personal/deen/pdfs ~/Downloads ~/personal/books ~/localsend -type f -name "*.pdf" 2>/dev/null | rofi -dmenu -i -p "Open PDF:")

[ -n "$file" ] && zathura "$file" &

