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
export CM_LAUNCHER=rofi
export GTK_THEME=Adwaita-dark
export QT_QPA_PLATFORMTHEME=qt5ct
export QT6CT_PLATFORMTHEME=qt6ct


# XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export PATH="$HOME/.local/bin:$PATH"

# Set env vars
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=brave
export TERMINAL=wezterm
export FILE_MANAGER=lf

# keyboard conf
# setxkbmap -layout us,us,ara -variant ,dvorak,digits -option grp:alt_shift_toggle,caps:escape
setxkbmap -layout us,ara -variant ,digits -option grp:alt_shift_toggle,caps:escape
xmodmap ~/.Xmodmap

# Increase volume of Bluetooth mic to 150%
btmic=$(pactl list short sources | awk '/bluez_input/ { print $2; exit }')
[ -n "$btmic" ] && pactl set-source-volume "$btmic" 135%

#Changing Background
feh --bg-fill ~/Pictures/hyprland_wallpapers/Dark_Nature.png

eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

~/dotfiles/scripts/restore_brightness.sh &
~/dotfiles/scripts/keyboard_watcher.sh &

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
