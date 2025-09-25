#!/bin/sh
url=$(xclip -o -selection clipboard)

[ -z "$url" ] && notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "No URL found" && exit 1

if ! printf '%s' "$url" | grep -Eq '^https?://'; then
    notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "Invalid URL: $url"
    exit 1
fi

notify-send -t 20000 -i /usr/share/icons/hicolor/64x64/apps/mpv.png "Mpv loading...480p"

exec mpv --no-resume-playback --ytdl-format="bestvideo[height<=480]+bestaudio/best[height<=480]/best" "$url" || exec mpv --no-resume-playback --ytdl-format="best" "$url"
