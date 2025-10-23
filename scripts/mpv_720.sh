#!/usr/bin/env bash
url=$(xclip -o -selection clipboard)

[ -z "$url" ] && notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "No URL found" && exit 1

if ! printf '%s' "$url" | grep -Eq '^https?://'; then
    notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "Invalid URL: $url"
    exit 1
fi

notify-send -t 20000 -i /usr/share/icons/hicolor/64x64/apps/mpv.png "Mpv loading...720p"

if ! mpv --no-resume-playback --ytdl-format="bestvideo[height<=720]+bestaudio/best[height<=720]/best" "$url"; then
    # If fallback also fails, notify error
    if ! mpv --no-resume-playback --ytdl-format="best" "$url"; then
        notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "mpv failed to play URL"
        exit 1
    fi
fi

# exec mpv --no-resume-playback --ytdl-format="bestvideo[height<=720]+bestaudio/best[height<=720]/best" "$url" || exec mpv --no-resume-playback --ytdl-format="best" "$url"

