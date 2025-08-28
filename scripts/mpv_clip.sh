#!/bin/sh

url=$(xclip -o -selection clipboard)

[ -z "$url" ] && notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "No URL found" && exit 1

notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "Mpv loading...480p"

exec mpv --no-resume-playback --ytdl-format="bestvideo[height<=480]+bestaudio/best[height<=480]/best" "$url" || exec mpv --no-resume-playback --ytdl-format="best" "$url"
