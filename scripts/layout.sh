#!/usr/bin/env bash

LAYFILE="/tmp/.current_layout"
current=$(xkb-switch 2>/dev/null)

[ -f "$LAYFILE" ] && last=$(cat "$LAYFILE") || last=""

if [ "$current" != "$last" ]; then
  echo "$current" > "$LAYFILE"
  pkill -RTMIN+5 dwmblocks
fi

if [ "$current" = "us" ]; then
  echo "us"
else
  echo "ar"
fi
