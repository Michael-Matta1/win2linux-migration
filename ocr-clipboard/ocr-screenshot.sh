#!/bin/bash

# Capture screenshot area and extract text via OCR
text=$(flameshot gui --raw 2>/dev/null | tesseract stdin stdout --psm 6 2>/dev/null | tr -d '\f')

# Check if we got text
if [ -z "$text" ]; then
    notify-send -u normal "OCR" "Screenshot cancelled or no text found"
    exit 0
fi

# Copy to clipboard (auto-detect X11 or Wayland)
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo -n "$text" | wl-copy
else
    echo -n "$text" | xclip -selection clipboard -i
fi

# Show notification with preview (first 100 chars)
preview=$(echo "$text" | head -c 100)
notify-send -t 3000 "OCR Complete ✓" "$preview..."

# Optional: Play sound
paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
