# Sourcing xprofile
if [ -f ~/.xprofile ]; then
    source ~/.xprofile
fi

# Start D-Bus session early
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval "$(dbus-launch --sh-syntax)"
  export DBUS_SESSION_BUS_ADDRESS
fi

# Start D-Bus session
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL


# XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export PATH="$HOME/.local/bin:$PATH"

setxkbmap -layout us,ara -variant ,digits -option grp:alt_caps_toggle,caps:swapescape

#Changing Background
feh --bg-fill ~/Downloads/solid-color-image.png

export PATH="$PATH:$HOME/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin"

eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

~/dotfiles/scripts/restore_brightness.sh &

# Background services
sxhkd &
keynav &
dwmblocks &
blueman-applet &
dunst &
gromit-mpx &
syncthing serve --no-browser --logfile=default &
# picom -b --experimental-backends &
pgrep -x go-pray || go-pray daemon &
exec dwm

