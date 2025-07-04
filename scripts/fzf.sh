#!/bin/bash

# Let user pick a process (full command shown)
line=$(ps -u "$USER" -o pid,cmd --sort=-%mem | fzf --header="Select a process to kill")

# Extract PID and full command
pid=$(awk '{print $1}' <<< "$line")
cmd=$(cut -d' ' -f2- <<< "$line")

# Extract the last command word (remove flags/paths)
name=$(echo "$cmd" | awk '{print $NF}' | xargs basename)

# Kill and notify
if [ -n "$pid" ]; then
    kill "$pid" && notify-send "Killed $name (PID $pid)"
fi
