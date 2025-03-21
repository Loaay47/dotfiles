#!/bin/sh
# usbmount.sh - A script to mount/unmount USB drives via dmenu + doas
# Requirements:
#   - dmenu
#   - doas (or sudo; replace doas with sudo if needed)
#   - lsblk
#   - A Linux system that uses /mnt/ as a mountpoint

uid=$(id -u)
gid=$(id -g)

# 1. Find all USB block devices (type=disk, transport=usb).
usbdevs=$(lsblk -lno NAME,TYPE,TRAN | awk '$2=="disk" && $3=="usb" {print $1}')

# 2. If no USB drives found, display a message and exit.
if [ -z "$usbdevs" ]; then
    echo "No USB drives found" | dmenu -p "USB Drives:"
    exit 1
fi

# 3. Convert each device name (e.g. sdb) to its /dev/ path.
devpaths=$(echo "$usbdevs" | sed 's|^|/dev/|')

# 4. Let the user pick from all partitions/blocks on those USB devices.
#    - lsblk -rno SIZE,NAME,MOUNTPOINT shows lines like "14.5G sdb /mnt/sdb" or "14.5G sdb"
#    - We exclude tiny partitions by ignoring lines with "M" or "K" (like /dev/loop devices).
#    - Then we display them in dmenu, showing size name mountpoint. The user picks one,
#      and we awk out just the device name (e.g. "sdb").
selected=$(
    lsblk -rno SIZE,NAME,MOUNTPOINT $devpaths | \
    awk '($1!="M" && $1!="K") {printf "%s %s %s\n", $2, $1, $3}' | \
    dmenu -l 5 -p "USB Drives:" | awk '{print $1}'
)

# If user hits Esc or picks nothing, exit quietly.
[ -z "$selected" ] && exit 0

# 5. Check if /dev/$selected is currently mounted by looking at /proc/mounts.
if grep -qs "$selected" /proc/mounts; then
    # It's already mounted => Unmount it.
    if doas umount /dev/"$selected"; then
        # Optionally remove the empty directory in /mnt if we created it.
        rmdir /mnt/"$selected" 2>/dev/null
        # Optional desktop notification (requires something like 'notify-send').
        notify-send "Unmounted /dev/$selected"
    else
        notify-send "Failed to unmount /dev/$selected"
    fi
else
    # It's not mounted => Mount it at /mnt/<device>.
    mkdir -p /mnt/"$selected"
    if doas mount -o uid="$uid",gid="$gid" /dev/"$selected" /mnt/"$selected"; then
        notify-send "Mounted /dev/$selected at /mnt/$selected"
    else
        notify-send "Failed to mount /dev/$selected"
    fi
fi
