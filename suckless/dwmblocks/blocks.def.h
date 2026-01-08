// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {"", "/home/loaay/dotfiles/scripts/pray.sh", 60, 10},
    // {"Mem: ", "free -h | awk '/^Mem/ { print $3 }' | sed s/i//g",  30, 0},
    { "",    "/home/loaay/dotfiles/scripts/screencast_dwm.sh",   0,    10 },
    { "", "/home/loaay/dotfiles/scripts/pomodoro.sh", 10, 10 },
    {"", "/home/loaay/dotfiles/scripts/keyboard_dwm.sh", 0, 30},
    {"🔊 ", "/home/loaay/dotfiles/scripts/volume_dwm.sh", 0, 30},
    {"", "date '+%a %d %b - %H:%M'", 5, 0},
    {"", "/home/loaay/dotfiles/scripts/battery.sh", 15, 10},
};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
