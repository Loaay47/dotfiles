#!/usr/bin/env bash

PASS_DIR="$HOME/.password-store"

selected=$(find "$PASS_DIR" -name "*.gpg" | \
    sed "s|$PASS_DIR/||" | sed 's/\.gpg$//' | \
    dmenu -i -l 8 -p "Pass:")

[ -z "$selected" ] && exit

clipctl disable
pass show -c "$selected" 2>/dev/null
clipctl enable
