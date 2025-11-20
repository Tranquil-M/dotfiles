#!/usr/bin/env bash
set -euo pipefail

# Directory for saving screenshots
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Timestamp for unique filename
FILENAME="$(date +'%m %d %Y : %I:%M:%S').png"
FILEPATH="$SAVE_DIR/$FILENAME"

# 1. Select region with slurp and take screenshot with grim
REGION=$(slurp)
grim -g "$REGION" "$FILEPATH"

# 2. Open screenshot in satty for annotation/editing
satty --filename "$FILEPATH"

# 3. When satty is closed, copy the (possibly edited) file to clipboard
wl-copy < "$FILEPATH"

# 4. Notify user (optional)
notify-send "Screenshot" "Screenshot saved to default Screenshots directory!"
echo "Screenshot saved to $FILEPATH and copied to clipboard"

