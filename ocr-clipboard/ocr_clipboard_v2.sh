#!/bin/bash

raw_image=$(mktemp --suffix=.png)
proc_image=$(mktemp --suffix=.pgm)
trap 'rm -f "$raw_image" "$proc_image"' EXIT

# Capture screenshot area
flameshot gui --raw 2>/dev/null > "$raw_image"

# Quick dark/light check on a tiny sampled thumbnail — cheap regardless of
# how big the actual capture is
mean=$(convert "$raw_image" -colorspace Gray -sample 32x32 -format "%[fx:mean]" info: 2>/dev/null)
negate_flag=""
if [ -n "$mean" ] && (( $(echo "$mean < 0.5" | bc -l) )); then
    negate_flag="-negate"
fi

# Single pass: grayscale, invert if dark-mode, upscale small captures for
# quality, cap oversized captures (multi-monitor/4K grabs) so neither
# ImageMagick nor tesseract waste time on more pixels than OCR needs,
# contrast stretch, gentle sharpen
convert "$raw_image" -colorspace Gray $negate_flag \
    -filter Lanczos -resize '1400x1400<' -resize '2400x2400>' \
    -contrast-stretch 0.5%x0.5% \
    -unsharp 0x0.75+0.75+0.02 \
    "$proc_image" 2>/dev/null

WHITELIST=$'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 !"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'

# OCR — --oem 1 forces LSTM-only, skipping the slower legacy engine pass
text=$(tesseract "$proc_image" stdout \
    -l eng --oem 1 --psm 6 \
    -c user_defined_dpi=300 \
    -c tessedit_char_whitelist="$WHITELIST" \
    -c load_system_dawg=0 \
    -c load_freq_dawg=0 \
    -c load_punc_dawg=0 \
    -c load_number_dawg=0 \
    -c load_unambig_dawg=0 \
    -c load_bigram_dawg=0 \
    -c tessedit_enable_dict_correction=0 \
    -c preserve_interword_spaces=1 \
    2>/dev/null | tr -d '\f')

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
preview=$(printf '%s' "$text" | head -c 100 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
notify-send -t 3000 -- "OCR Complete ✓" "$preview..."

# Optional: Play sound
paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
