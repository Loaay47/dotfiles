#!/bin/bash

RECORDING_FILE="$HOME/screencast/recording_$(date +%F_%T).mkv"
PIDFILE="/tmp/screencast.pid"

if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" && rm "$PIDFILE"
    pkill -RTMIN+10 dwmblocks
else
    ffmpeg \
        -f x11grab -framerate 15 -i :0.0 \
        -f pulse -i default \
        -vaapi_device /dev/dri/renderD128 \
        -vf 'format=nv12,hwupload,scale_vaapi=w=1920:h=1080' \
        -c:v h264_vaapi \
        -c:a aac -b:a 96k \
        "$RECORDING_FILE" > /tmp/ffmpeg.log 2>&1 &

    echo $! > "$PIDFILE"
    sleep 1
    pkill -RTMIN+10 dwmblocks
fi

