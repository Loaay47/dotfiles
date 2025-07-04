#!/bin/sh

for i in $(seq 1 10); do
    if [ -S /run/user/$(id -u)/bus ]; then
        export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
        go-pray daemon &
        exit 0
    fi
    sleep 2
done

