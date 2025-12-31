#!/usr/bin/env bash

cd "$(tmux display-message -p "#{pane_start_path}")" || exit
url="$(git remote get-url origin)"

if [[ $url == *github.com* ]]; then
    if [[ $url == git@* ]]; then
        url="${url#git@}"
        url="${url/:/\/}"
        url="https://${url%.git}"
    fi
    "$BROWSER" "$url" > /dev/null 2>&1 & disown
    sleep 0.1
    xdotool key super+1
else
    echo "This repo is not hosted on github"
fi

