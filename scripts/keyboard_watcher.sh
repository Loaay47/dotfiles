#!/usr/bin/env bash

if pgrep -f keyboard_watcher.sh | grep -v $$ >/dev/null; then
    exit 0
fi

current=""

while true; do
    new=$(xkblayout-state print "%s")

    if [ "$new" != "$current" ]; then
        current="$new"
        pkill -RTMIN+30 dwmblocks
    fi

    sleep 0.1
done

