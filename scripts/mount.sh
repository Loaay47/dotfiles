#!/usr/bin/env bash

uid=$(id -u)
gid=$(id -g)

usbdev=$(lsblk -rno NAME,TRAN | awk '$2=="usb" {print "/dev/"$1}')

if [ "$usbdev" ]; then
    selected=$( \
        lsblk -rno SIZE,NAME,MOUNTPOINT $usbdev | \
        awk '!/K/ && !/M/ {printf "%s\t%s\t%s\n", $2, $1, $3}' | \
        dmenu -l 5 -i -p "USB Drives:" | awk '{print $1}'
    )

    if [ -z "$selected" ]; then
        exit 1
    fi

    if grep -qs "/dev/$selected" /proc/mounts; then
        sync
        doas umount "/dev/$selected"
        if ! grep -qs "/dev/$selected" /proc/mounts; then
            doas rm -rf "/mnt/$selected"
        fi
    else
        [ ! -d "/mnt/$selected" ] && doas mkdir "/mnt/$selected"
        doas mount -o uid=$uid,gid=$gid "/dev/$selected" "/mnt/$selected"
    fi
else
    echo "No drives connected" | dmenu -i -p "USB Drives: "
    exit 1
fi
