#!/bin/bash

# =====================================================================
# Script Name: emoji-menu.sh
# Description: A simple script to choose and insert emojis into an editor or terminal.
# Author: Edmond Kacaj <info@edmondkacaj.com>
# License: GNU General Public License v3.0
# Dependencies:
# - `xdotool`: For simulating keyboard input (used by default for X11).
# - `rofi`: For displaying the emoji selection menu.
# - `wget`: For downloading the emoji list.
# - `libnotify-bin`: For sending desktop notifications (optional).
#
# System Requirements:
# This script is designed for **Debian-based systems** such as Debian, Ubuntu, and other derivatives.
#
# The script will check and install the required dependencies automatically, if they are not already installed.
#
# How to Use:
# 
# 1. **Run the Script**:
# You can manually run the script from the terminal with either of the following commands:
# - **Multi-Select Mode** (allows you to select multiple emojis):
#     ```bash
#     ./emoji-menu.sh --multi
#     ```
# - **Single-Select Mode** (only allows one emoji selection):
#     ```bash
#     ./emoji-menu.sh --single
#     ```
#
# 2. **Setting up a Shortcut**:
# - If you want to trigger the script using a keyboard shortcut, you can configure it within your desktop environment's shortcut settings.
# - Example: If you're using a shortcut like **`ALT+SHIFT+E`**:
#     1. Open **"Keyboard Settings"** or **"Keyboard Shortcuts"** (depending on your system).
#     2. Create a new custom shortcut and set it to run the script, such as `/path/to/emoji-menu.sh --multi` for multi-select or `/path/to/emoji-menu.sh --single` for single-select.
#     3. Assign **`ALT+SHIFT+E`** as the shortcut key.
#     4. Save the changes, and now you can press `ALT+SHIFT+E` to open the emoji selection menu.
#
# =====================================================================

# Default Parameters
MULTI_SELECT=false


# Parse command line arguments for multi-select option
while [[ $# -gt 0 ]]; do
    case "$1" in
        --multi)
            MULTI_SELECT=true
            shift
            ;;
        --single)
            MULTI_SELECT=false
            shift
            ;;
        *)
            echo "Usage: $0 [--multi | --single]"
            exit 1
            ;;
    esac
done

# Paths
EMOJI_DIR="$HOME/.cache"
RAW_EMOJI_FILE="$EMOJI_DIR/raw-emoji-test.txt"
EMOJI_URL="https://unicode.org/Public/emoji/15.0/emoji-test.txt"

# Ensure cache directory exists
mkdir -p "$EMOJI_DIR"

# If the emoji file doesn't exist, download it with wget
if [ ! -f "$RAW_EMOJI_FILE" ]; then
    echo "Downloading emoji list with wget..."
    wget -q --show-progress --timeout=30 --tries=3 --limit-rate=500k --compression=gzip -O "$RAW_EMOJI_FILE" "$EMOJI_URL"
fi

# Process the emoji list only when reading and extract only the emoji characters
EMOJI_LIST=$(grep '; fully-qualified' "$RAW_EMOJI_FILE" | awk -F '#' '{print $2}' | sed 's/^ *//')

# Choose emojis using rofi with multi-select or single-select
if $MULTI_SELECT; then
    CHOSEN_EMOJIS=$(echo "$EMOJI_LIST" | rofi -dmenu -i -p "Select Emojis (Use SHIFT+ENTER to select multiple)" -multi-select -mesg "Use SHIFT+ENTER to select multiple, Press Enter to confirm")
else
    CHOSEN_EMOJIS=$(echo "$EMOJI_LIST" | rofi -dmenu -i -p "Select Emoji (Press Enter to confirm)")
fi

# If any emojis were selected, process and type them into the active window
if [ -n "$CHOSEN_EMOJIS" ]; then
    # Extract only the emoji characters (removes version/description)
    EMOJIS_TO_TYPE=$(echo "$CHOSEN_EMOJIS" | sed 's/ [^[:space:]]*//g' | tr '\n' ' ' | sed 's/ $//')

    # Use xdotool to type the emojis into the focused window
    xdotool type --clearmodifiers "$EMOJIS_TO_TYPE"
    
    # Send a desktop notification about the emojis typed (optional)
    notify-send "Emojis typed into active window!" "$EMOJIS_TO_TYPE"
fi
