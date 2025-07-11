#!/bin/sh

pidfile="$HOME/.cache/pomo_pid"

if [ -f "$pidfile" ]; then
  pid=$(cat "$pidfile" 2>/dev/null)
  if kill -0 "$pid" 2>/dev/null; then
    cat "$HOME/.cache/pomo_status" 2>/dev/null
  else
    echo "" > "$HOME/.cache/pomo_status"
    rm -f "$pidfile"
  fi
fi

