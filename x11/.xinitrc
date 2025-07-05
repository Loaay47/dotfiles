# Start D-Bus session
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

setxkbmap -layout us,ara -variant ,digits -option grp:alt_caps_toggle,caps:swapescape

#Changing Background
#feh --bg-fill ~/Downloads/solid-color-image.png

# Mounting sdb5 / sdb6 automatically
if ! findmnt -S /dev/sdb5 > /dev/null 2>&1; then
    udisksctl mount -b /dev/sdb5
fi

# Check and mount /dev/sda6 if not mounted
if ! findmnt -S /dev/sdb6 > /dev/null 2>&1; then
    udisksctl mount -b /dev/sdb6
fi

export PATH="$PATH:$HOME/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin"

# Background services
sxhkd & 
#dwmblocks &
#blueman-applet &
dunst &
# picom -b --experimental-backends &
exec dwm




