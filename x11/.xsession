trap 'kill $(jobs -p)' EXIT
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
export GNOME_KEYRING_CONTROL
export CM_LAUNCHER=dmenu
export GTK_THEME=Adwaita-dark
export QT_QPA_PLATFORMTHEME=qt5ct
export QT6CT_PLATFORMTHEME=qt6ct


# XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export PATH="$HOME/.local/bin:$PATH"
export CM_IGNORE_WINDOW="Keepassxc|Bitwarden"
export CM_SELECTIONS="clipboard"

# Set env vars
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=brave
export TERMINAL=wezterm
export FILE_MANAGER=lf

# keyboard conf
setxkbmap -layout us,ara -variant dvorak,digits -option grp:alt_shift_toggle,caps:escape
xmodmap ~/.Xmodmap
echo "2" > /tmp/keyboard_layout.pid

# Increase volume of Bluetooth mic to 150%
btmic=$(pactl list short sources | awk '/bluez_input/ { print $2; exit }')
[ -n "$btmic" ] && pactl set-source-volume "$btmic" 135%

#Changing Background
feh --bg-fill ~/Pictures/gray.png

~/dotfiles/scripts/restore_brightness.sh &
~/dotfiles/scripts/keyboard_watcher.sh &
gpg -q -d ~/.gnupg/empty_file_encrypted_once.gpg >/dev/null 2>&1


# Background services
sxhkd &
mpris-proxy &
# keynav &
dwmblocks &
blueman-applet &
dunst &
# gromit-mpx &
syncthing serve --no-browser --logfile=default &
picom -b &
clipmenud &
# go-pray daemon &
exec dwm
# exec i3
