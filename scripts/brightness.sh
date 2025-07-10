#!/bin/bash

STEP="5%"
STATE_FILE="$HOME/.brightness_level"
ID_FILE="/tmp/bright_notify_id"
ICON="🌞"

# Change brightness
case "$1" in
    up)
        doas brightnessctl set +$STEP
        ;;
    down)
        doas brightnessctl set $STEP-
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Save current brightness
current=$(brightnessctl get)
echo "$current" > "$STATE_FILE"

# Get percent brightness
max=$(brightnessctl max)
percent=$((current * 100 / max))

# Generate smooth bar (20 blocks, Unicode fill levels)
generate_bar() {
    local percent=$1
    local total_blocks=20
    local full_blocks=$((percent * total_blocks / 100))
    local partial_index=$(((percent * total_blocks % 100) / 5))

    # Partial fill characters: 0–8 (space to full)
    local partial_chars=(" " "▏" "▎" "▍" "▌" "▋" "▊" "▉" "█")

    local bar=""
    for ((i = 1; i <= total_blocks; i++)); do
        if (( i <= full_blocks )); then
            bar+="█"
        elif (( i == full_blocks + 1 && partial_index > 0 )); then
            bar+=${partial_chars[partial_index]}
        else
            bar+="░"
        fi
    done
    echo "$bar"
}

bar=$(generate_bar "$percent")

# Read last notification ID
[ -f "$ID_FILE" ] && ID=$(cat "$ID_FILE") || ID=0

# Send minimal, glazy white-styled notification (no extra styling added)
newid=$(dunstify -r "$ID" -t 1000 "$ICON Brightness" "<b><tt>$bar</tt>  $percent%</b>" -p)

echo "$newid" > "$ID_FILE"

