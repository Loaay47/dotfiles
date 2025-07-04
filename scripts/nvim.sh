#!/bin/bash

notify-send -t 1500 "nvim loading..." >/dev/null 2>&1

selected=$(fzf -m --preview="bat --color=always {}" 2>/dev/null)

exec nvim "$selected"
