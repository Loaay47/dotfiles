#!/usr/bin/env bash

USAGE_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/pdf_usage.txt"

mkdir -p "$(dirname "$USAGE_FILE")"
touch "$USAGE_FILE"

pdf_list=$(find ~/personal/deen/pdfs ~/Downloads ~/personal/books ~/localsend -type f -name "*.pdf" 2>/dev/null)

menu=$(awk -v pdfs="$pdf_list" '
BEGIN {
    split(pdfs, arr, "\n")
    for (i in arr) if (arr[i] != "") usage[arr[i]] = 0
}
{
    usage[$2] = $1
}
END {
    for (f in usage) print usage[f], f
}' "$USAGE_FILE" | sort -nr | cut -d' ' -f2-)

file=$(echo "$menu" | rofi -dmenu -i -p "Open PDF:")

if [ -n "$file" ] && [ -f "$file" ]; then
    count=$(awk -v f="$file" '$2==f {print $1}' "$USAGE_FILE")
    count=$((count+1))
    grep -vF "$file" "$USAGE_FILE" > "$USAGE_FILE.tmp"
    echo "$count $file" >> "$USAGE_FILE.tmp"
    mv "$USAGE_FILE.tmp" "$USAGE_FILE"
    zathura "$file" &
fi

