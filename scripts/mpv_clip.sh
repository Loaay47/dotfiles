#!/bin/sh

url=$(xclip -o -selection clipboard)
notify-send -i /usr/share/icons/hicolor/64x64/apps/mpv.png "Mpv loading..."
mpv $url

