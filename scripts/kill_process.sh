#!/usr/bin/env bash

ps -u "$USER" -o pid,comm,%cpu,%mem | dmenu -i -c -l 10 -p Kill: | awk '{print $1}' | xargs -r kill

