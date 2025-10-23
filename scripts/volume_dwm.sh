#!/usr/bin/env bash

info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume=$(echo "$info" | awk '{print int($2 * 100)}')
muted=$(echo "$info" | grep -o '\[MUTED\]')

if [ -n "$muted" ]; then
  echo "Muted"
elif [ "$volume" -eq 0 ]; then
  echo "0%"
else
  echo "${volume}%"
fi

