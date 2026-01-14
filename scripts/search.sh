#!/usr/bin/env bash

input="$(dmenu -p "🔍 Search:" < /dev/null)"

[ -z "$input" ] && exit 0

prev=$input

# shebang with duckduckgo
if echo "$input" | grep -q '^!'; then
    encoded_input=$(printf "%s" "$input" | jq -s -R -r @uri)
    input="https://duckduckgo.com/?q=$encoded_input"

# direct url
elif echo "$input" | grep -Eiq '^[a-zA-Z]+://|localhost|[^ ]+\.[^ ]+'; then
    if ! echo "$input" | grep -Eiq '^[a-zA-Z]+://'; then
        input="https://$input"
    fi

# normal search
else
    input="https://www.google.com/search?udm=14&q=$(printf "%s" "$input" | jq -s -R -r @uri)"
fi

if echo "$prev" | grep -q '^ '; then
    brave --incognito "$input" & disown
    exit
fi

"$BROWSER" "$input" & disown
xdotool key super+1
