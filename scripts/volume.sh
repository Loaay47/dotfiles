#!/usr/bin/env bash

arg=$1
STEP=0.05
case "$arg" in
  up)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}+
    ;;
  down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}-
    ;;
  toggle)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
  *)
    echo "Usage: $0 {up|down|toggle}"
    ;;
esac


read -r _ vol mute <<<"$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
VOL=$(awk -v v="$vol" 'BEGIN {print int(v*100)}')
[ "$VOL" -gt 100 ] && wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.0 && VOL=100
ICON=$(echo "$mute" | grep -q "MUTED" && echo "🔇" || echo "🔊")
notify-send -h string:x-canonical-private-synchronous:volume \
    -u low -t 700 "$ICON Volume: ${VOL}%"

pkill -RTMIN+30 dwmblocks
sleep 0.1

