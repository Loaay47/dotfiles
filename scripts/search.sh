#!/usr/bin/env bash

input="$(echo "" | dmenu -p 'Search:')"

[ -z "$input" ] && exit 0

# shebang with duckduckgo
if echo "$input" | grep -q '^!'; then
    encoded_input=$(printf "%s" "$input" | jq -s -R -r @uri)
    input="https://duckduckgo.com/?q=$encoded_input"

# direct url
elif echo "$input" | grep -Eiq '^[a-zA-Z]+://|localhost|\.com|\.org|\.net|\.io|\.dev'; then
    if ! echo "$input" | grep -iq '^[a-zA-Z]+://'; then
        input="https://$input"
    fi

# normal search
else
    input="https://www.google.com/search?udm=14&q=$(printf "%s" "$input" | jq -s -R -r @uri)"
fi


"$BROWSER" "$input" & disown
xdotool key super+1
