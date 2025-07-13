#!/bin/bash

query="$(rofi -dmenu -p 'YouTube Search:')"
[ -z "$query" ] && exit 0

url="https://www.youtube.com/results?search_query=$(printf "%s" "$query" | jq -s -R -r @uri)"

qutebrowser "$url" &
sleep 0.5
xdotool key super+1

