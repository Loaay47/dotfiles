#!/usr/bin/env bash

arg=$1
ID_FILE="/tmp/vol_notify_id"
# ICON="🔊"
case "$arg" in
  up)
    amixer -q sset Master 5%+
    ;;
  down)
    amixer -q sset Master 5%-
    ;;
  toggle)
    muted=$(amixer get Master | grep '\[off\]')
    if [ -n "$muted" ]; then
        amixer -q set Master unmute
    else
        amixer -q set Master mute
    fi
    ;;
  *)
    echo "Usage: $0 {up|down|toggle}"
    ;;
esac
pkill -RTMIN+30 dwmblocks

# # Get volume and mute state
# amixer_output=$(amixer get Master)
# muted=$(echo "$amixer_output" | grep '\[off\]')
# volume=$(echo "$amixer_output" | awk -F'[][]' '/Left:/ { print $2 }' | tr -d '%' | head -n1)
# [ -z "$volume" ] && volume=0


# # Generate smooth fancy bar (like brightness)
# generate_bar() {
#     percent=$1
#     total_blocks=20
#     full_blocks=$((percent * total_blocks / 100))
#     partial_index=$(((percent * total_blocks % 100) / 5))
#     chars=(" " "▏" "▎" "▍" "▌" "▋" "▊" "▉" "█")

#     bar=""
#     for i in $(seq 1 $total_blocks); do
#         if [ $i -le $full_blocks ]; then
#             bar="${bar}█"
#         elif [ $i -eq $((full_blocks + 1)) ] && [ $partial_index -gt 0 ]; then
#             bar="${bar}${chars[$partial_index]}"
#         else
#             bar="${bar}░"
#         fi
#     done
#     echo "$bar"
# }

# bar=$(generate_bar "$percent")

# Show/replace Dunst notification
# [ -f "$ID_FILE" ] && ID=$(cat "$ID_FILE") || ID=0
# newid=$(dunstify -r "$ID" -t 1000 "$icon Volume" "<b><tt>$bar</tt>  $percent%</b>" -p)
# echo "$newid" > "$ID_FILE"
