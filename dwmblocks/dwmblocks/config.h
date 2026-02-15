#ifndef CONFIG_H
#define CONFIG_H

// String used to delimit block outputs in the status.
#define DELIMITER "  "

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 45

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 1

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)                                \
    X("", "~/.local/bin/status/music.sh", 1, 1)     /* Music */ \
    X("", "~/.local/bin/status/ram.sh", 10, 2)      /* RAM */ \
    X("", "~/.local/bin/status/wifi.sh", 10, 0)    /* Wi-Fi */ \
    X("", "~/.local/bin/status/cpu.sh", 5, 3)      /* CPU */ \
    X("", "~/.local/bin/status/volume.sh", 0, 10)  /* Volume */ \
    X("", "date '+%b %d (%a) %I:%M %p'", 5, 0)     /* Date */

#endif  // CONFIG_H
