#!/usr/bin/env bash

file="$HOME/notes/vocab.txt"
mkdir -p "$(basename "$file")"

word=$(dmenu -p "📖 Define:" < /dev/null) || exit 0


# Check for empty word or special characters
[[ -z "$word" || "$word" =~ [\/] ]] && notify-send -u critical -t 3000 "❌ Invalid input" && exit 0

query=$(curl -s --connect-timeout 5 --max-time 10 "https://api.dictionaryapi.dev/api/v2/entries/en_US/$word")

# Check for connection error (curl exit status stored in $?)
[ $? -ne 0 ] && notify-send -u critical -t 3000 "⚠️ Connection error" && exit 1

# Check for invalid word response
[[ "$query" == *"No Definitions Found"* ]] && notify-send -u critical -t 3000 "❌ Invalid word" && exit 0

# Show only first 3 definitions
def=$(echo "$query" | jq -r '[.[].meanings[] | {pos: .partOfSpeech, def: .definitions[].definition}] | .[:3].[] | "\n\(.pos). \(.def)"')

# Requires a notification daemon to be installed
notify-send -t 8000 "📖 $word" "$def"
grep -qxF "$word" "$file" 2>/dev/null || echo "$word" >> "$file"
### MORE OPTIONS :)

# Show first definition for each part of speech (thanks @morgengabe1 on youtube)
# def=$(echo "$query" | jq -r '.[0].meanings[] | "\(.partOfSpeech): \(.definitions[0].definition)\n"')

# Show all definitions
# def=$(echo "$query" | jq -r '.[].meanings[] | "\n\(.partOfSpeech). \(.definitions[].definition)"')

# bold=$(tput bold) # Print text bold with echo, for visual clarity
# normal=$(tput sgr0) # Reset text to normal
# echo "${bold}Definition of $word"
# echo "${normal}$def"
