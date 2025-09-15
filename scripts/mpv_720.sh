#!/bin/sh
url=$(xclip -o -selection clipboard)

[ -z "$url" ] && notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "No URL found" && exit 1

notify-send -t 20000 -i /usr/share/icons/hicolor/64x64/apps/mpv.png "Mpv loading...720p"

exec mpv --no-resume-playback --ytdl-format="bestvideo[height<=720]+bestaudio/best[height<=720]/best" "$url" || exec mpv --no-resume-playback --ytdl-format="best" "$url"
