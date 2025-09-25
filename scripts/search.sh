#!/usr/bin/env bash

input="$(rofi -dmenu -p 'Search:')"

[ -z "$input" ] && exit 0

# if it doesn't look like a URL, treat as search
if ! echo "$input" | grep -Eiq '^[a-zA-Z]+://|localhost|\.com|\.org|\.net|\.io|\.dev'; then
    input="https://www.duckduckgo.com/search?q=$(printf "%s" "$input" | jq -s -R -r @uri)"
fi

zen-browser "$input"
sleep 0.5
xdotool key super+1
