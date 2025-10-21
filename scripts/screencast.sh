#!/usr/bin/env bash

RECORDING_FILE="$HOME/screencast/recording_$(date +%F_%T).mp4"
PIDFILE="/tmp/screencast.pid"
MONITOR=$(pactl info | awk -F': ' '/Default Sink:/ {print $2".monitor"}')

if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" && rm "$PIDFILE"
    pkill -RTMIN+10 dwmblocks
else
    ffmpeg \
        -f x11grab -framerate 15 -i :0.0 \
        -f pulse -i $MONITOR \
        -f pulse -i default \
        -filter_complex "[1:a][2:a]amix=inputs=2:duration=longest:dropout_transition=2" \
        -vaapi_device /dev/dri/renderD128 \
        -vf 'format=nv12,hwupload,scale_vaapi=w=1280:h=720' \
        -c:v h264_vaapi \
        -c:a aac -b:a 128k \
        "$RECORDING_FILE" > /tmp/ffmpeg.log 2>&1 &

    echo $! > "$PIDFILE"
    sleep 1
    pkill -RTMIN+10 dwmblocks
fi

