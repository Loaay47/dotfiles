#!/bin/sh

arg=$1

[ $arg = "up" ] && amixer -q sset Master 5%+
[ $arg = "down" ] && amixer -q sset Master 5%-
[ $arg = "toggle" ] && amixer set Master toggle

pkill -RTMIN+30 dwmblocks
#$HOME/script/dwmStatusBarRefresh.sh &
