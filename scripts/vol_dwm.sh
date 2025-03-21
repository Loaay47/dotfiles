#!/bin/sh

# Get volume percentage or state (Muted/Unmuted)
volume=$(amixer get Master | awk -F'[][]' '/%/ {print $2; exit}' | tr -d '%')
muted=$(amixer get Master | grep -oE '\[off\]' | head -n 1)

if [ "$muted" = "[off]" ]; then
  echo "Muted"
elif [ "$volume" -eq 0 ]; then
  echo "0%"
elif [ "$volume" -le 50 ]; then
  echo "$volume%"
else
  echo "$volume%"
fi
