#!/usr/bin/env bash

base_personal="$HOME/personal/courses/fun/"
base_disk="/media/fun/_loaay_data/3. Fun/"

choice=$(find "$base_personal" "$base_disk" -maxdepth 1 -type f -printf "%f\n" | dmenu -i -l 6 -p "Play:")

[[ -z "$choice" ]] && exit 0

if [[ -f "${base_personal}${choice}" ]]; then
    full_path="${base_personal}${choice}"
elif [[ -f "${base_disk}${choice}" ]]; then
    full_path="${base_disk}${choice}"
fi

xdotool key super+2

mpv "$full_path"

