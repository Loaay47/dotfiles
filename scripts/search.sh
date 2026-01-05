#!/usr/bin/env bash

input="$(echo "" | dmenu -p 'Search:')"

[ -z "$input" ] && exit 0

# if it doesn't look like a URL
# treat it as search
if ! echo "$input" | grep -Eiq '^[a-zA-Z]+://|localhost|\.com|\.org|\.net|\.io|\.dev'; then
    input="https://www.google.com/search?udm=14&q=$(printf "%s" "$input" | jq -s -R -r @uri)"
fi

"$BROWSER" "$input" & disown
sleep 0.1
xdotool key super+1
