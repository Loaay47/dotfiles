# ===============================================================
# 3. EXPORTS
# ===============================================================

HISTFILE=~/.cache/bash/.histfile
HISTSIZE=5000
HISTFILESIZE=5000
shopt -s histappend

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=brave
export TERMINAL=wezterm
export FILE_MANAGER=lf
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/dotfiles/scripts"
export PATH="$PATH:$HOME/.cargo/bin"
export GTK_THEME=Materia-Dark
export GTK_ICON_THEME=Papirus-Dark
export MANPAGER="nvim +Man!"
export MANROFFOPT="-c"
export _JAVA_AWT_WM_NONREPARENTING=1



# ===============================================================
# 4. ALIASES
# ===============================================================

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias yay='paru'

## xbps
alias i='doas pacman -S --needed'
alias u='doas pacman -Syu'
alias q='doas pacman -Ss'
alias r='doas pacman -Rns'

alias vi='nvim'
alias lf='lfub.sh'
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias cclip="xclip -selection clipboard"
alias mpvs="mpv --no-video"
alias net="vnstat -i wlp1s0 --oneline"
alias nb="newsboat"
alias ya='timer 600 && { notify-send -t 39000 -u critical "🕌 Iqamah" "Get up for prayer" & mpv --no-config --volume=80  ~/sounds/iqamah.mp3 }'

alias dop='cd "/media/fun/_loaay_data"'
alias phone='scrcpy --max-size=1024 --video-codec=h264 --video-encoder=OMX.qcom.video.encoder.avc --video-bit-rate=4M'
alias d='scrcpy --max-size=1024 --video-codec=h264  --video-bit-rate=4M & disown'
alias rain='mpv --no-video --volume=26 --cache=yes --cache-secs=30 --ytdl-format=bestaudio "https://youtube.com/watch?v=nDq6TstdEi8"'
alias lst="yt-dlp --cookies-from-browser brave --flat-playlist --print '%(title)s___SEP___%(url)s' 'https://www.youtube.com/playlist?list=WL' | awk -F '___SEP___' '{printf \"%s\n%s\n\n\", \$1, \$2}' | cat - ~/vault/1\ -\ Rough\ notes/towatch.md > ~/vault/1\ -\ Rough\ notes/towatch.md.tmp && mv ~/vault/1\ -\ Rough\ notes/towatch.md.tmp ~/vault/1\ -\ Rough\ notes/towatch.md"
alias ytd="yt-dlp -f \"bestvideo[height<=720]+bestaudio/best[height<=720]\" --embed-metadata --merge-output-format mp4 "
alias yt="yt-dlp -f \"bestvideo[height<=480]+bestaudio/best[height<=480]\" --embed-metadata --merge-output-format mp4 "

alias wo="pomodoro work"
alias br="pomodoro break"
alias gl="git log --oneline --graph --decorate"


# ===============================================================
# 5. FUNCTIONS
# ===============================================================

function zsh_add_file() {
  [ -f "$HOME/$1" ] && source "$HOME/$1"
}

jaber() {
    start=$(printf "%03d" "$1")
    end="$2"

    if [ -z "$end" ]; then
        mpv --no-video --volume=40 --cache=yes --cache-secs=30 "https://server11.mp3quran.net/a_jbr/${start}.mp3"
    else
        for ((i=$1; i<=$end; i++)); do
            surah=$(printf "%03d" "$i")
            mpv --no-video --volume=40 --cache=yes --cache-secs=30 "https://server11.mp3quran.net/a_jbr/${surah}.mp3"
        done
    fi
}

husr() {
    start=$(printf "%03d" "$1")
    end="$2"

    if [ -z "$end" ]; then
        mpv --no-video --volume=40 --cache=yes --cache-secs=30 "https://server13.mp3quran.net/husr/${start}.mp3"
    else
        for ((i=$1; i<=$end; i++)); do
            surah=$(printf "%03d" "$i")
            mpv --no-video --volume=40 --cache=yes --cache-secs=30 "https://server13.mp3quran.net/husr/${surah}.mp3"
        done
    fi
}

yasser() {
    start=$(printf "%03d" "$1")
    end="$2"

    if [ -z "$end" ]; then
         mpv --no-video --volume=40 --cache=yes --cache-secs=30 "https://server11.mp3quran.net/yasser/${start}.mp3"
    else
        for ((i=$1; i<=$end; i++)); do
            surah=$(printf "%03d" "$i")
            mpv --no-video --volume=40 --cache=yes --cache-secs=30 "https://server11.mp3quran.net/yasser/${surah}.mp3"
        done
    fi
}

c() {
  local dir
  dir=$(find . \
    \( -path './node_modules' -o -path './.git' -o -path './.npm' -o -path './.local' -o -path './.cache' -o -path './.cargo' \) -prune -o \
    -type d -print 2>/dev/null | fzf)
  [ -n "$dir" ] && cd "$dir"
}
declare -A pomo_options=(
  [work]=50
  [break]=10
)

declare -A pomo_icons=(
  [work]="🧠"
  [break]="💤"
)

pomodoro () {
  local val minutes start_time end_time icon display_text
  local cache_file="$HOME/.cache/pomo_status"
  local pid_file="$HOME/.cache/pomo_pid"

  echo "" > "$cache_file"
  pkill -RTMIN+10 dwmblocks

  if [[ -n "$1" && -n "${pomo_options[$1]}" ]]; then
    val="$1"
    minutes="${pomo_options[$val]}"
    start_time=$(date +"%H:%M")
    end_time=$(date -d "+${minutes} minutes" +"%H:%M")
    icon="${pomo_icons[$val]}"
    display_text="${val^}"

    paplay ~/sounds/${val}.wav &>/dev/null &
    notify-send "${icon}  $display_text till $end_time"

    echo -e "\n${icon}  \033[1m${display_text}\033[0m Session"
    echo -e "⏱  Starts at: \033[32m$start_time\033[0m"
    echo -e "🏁 Ends at:   \033[31m$end_time\033[0m\n"

    (
      trap 'echo "" > "$cache_file"; rm -f "$pid_file"; pkill -RTMIN+10 dwmblocks; exit' INT TERM

      echo $$ > "$pid_file"

      for ((i = minutes; i > 0; i--)); do
        local done=$((minutes - i))
        local percent=$((done * 10 / minutes))
        local bar=$(printf '%s%s' "$(printf '#%.0s' $(seq 1 $percent))" "$(printf '.%.0s' $(seq 1 $((10 - percent))))")

        echo "$icon [$bar] ${i}m" > "$cache_file"
        pkill -RTMIN+10 dwmblocks
        sleep 60
      done

      echo "" > "$cache_file"
      rm -f "$pid_file"
      pkill -RTMIN+10 dwmblocks
    ) &

    timer "${minutes}m"
  else
    echo "Usage: pomodoro [work|break]"
  fi
}

cy() {
  pomodoro work
  while [ -f "$HOME/.cache/pomo_pid" ]; do
    sleep 5
  done
  pomodoro break
}

lfcd() {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}


# ===============================================================
# 6. VIM MODE SETTINGS
# ===============================================================

set -o vi

# ===============================================================
# 7. KEYBINDINGS & FZF
# ===============================================================

[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

# ===============================================================
# 8. COMPLETION SYSTEM
# ===============================================================


# ===============================================================
# 9. THEMES
# ===============================================================

git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n $branch ]] && echo " ($branch)"
}

PROMPT_COMMAND='PS1="\[\033[38;2;102;205;170m\]\W\[\033[0m\]\[\033[38;2;127;161;182m\]$(git_branch)\[\033[0m\] \[\033[38;2;255;80;80m\]❯\[\033[0m\] "'

