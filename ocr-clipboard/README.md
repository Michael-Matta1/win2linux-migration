# OCR Clipboard Shortcut for Linux

A lightweight, customizable script that lets you take a screenshot of any area on your screen, extract text using **OCR (Optical Character Recognition)**, and copy it directly to your clipboard — all with a single keyboard shortcut.

This is a Linux alternative to Windows PowerToys Text Extractor, using a lightweight script-based approach.

> **💡 Why not a prebuilt tool like NormCap?**
> I have tried prebuilt tools like `normcap`, but found them to be too heavy. They occasionally had bugs or crashes, weren't always precise, and lacked the extendability and customizability that power users need. This lightweight script-based approach overcomes all of these issues while staying fast and reliable.

---

## 📑 Table of Contents

- [Why This Script?](#-why-this-script)
- [Dependencies](#-dependencies)
- [Installation](#-installation)
- [Ensure Flameshot is Running](#-ensure-flameshot-is-running)
- [Set Up Keyboard Shortcut](#️-set-up-keyboard-shortcut)
- [Usage](#-usage)
- [Multi-Language OCR Support (Optional)](#-multi-language-ocr-support-optional)
- [Customization Ideas](#-customization-ideas)
- [Troubleshooting](#-troubleshooting)
- [License](#-license)
- [Related Guides](#-related-guides)

---

## 🎯 Why This Script?

A custom script approach offers several advantages for OCR workflow:

- ⚡ **Fast** - launches instantly with minimal overhead
- 🪶 **Lightweight** - uses only standard system tools
- 🛠️ **Fully customizable** - easy to modify and extend
- 💪 **Reliable** - simple pipeline with fewer failure points

---

## 📋 Dependencies

You'll need these tools installed on your system:

- **flameshot** - Screenshot tool with selection interface
- **tesseract-ocr** - OCR engine for text extraction
- **xclip** - Clipboard management (X11) or **wl-clipboard** (Wayland) — the script auto-detects which to use
- **libnotify-bin** - Desktop notifications
- **pulseaudio-utils** or **pipewire** - Sound playback (optional)
- **imagemagick** - Image preprocessing (grayscale, dark-mode detection, upscaling, sharpening) — required only if you use **`ocr_clipboard_v2.sh`**
- **bc** - Command-line calculator used for the dark/light detection check — required only if you use **`ocr_clipboard_v2.sh`**

> **📸 Note about Flameshot:** Flameshot is a screenshot tool that offers many more features than default screenshot utilities (annotations, arrows, blur, pixelate, text, etc.). You can also set up Flameshot for regular screenshots with keyboard shortcuts. See the [Area Screenshot guide](../area-screenshot/README.md) for a complete setup walkthrough.

### Check if You're Using X11 or Wayland

> **ℹ️ Note:** Most Linux users are running **X11** by default. Wayland is a newer display server protocol that some modern distributions are starting to adopt. The OCR script auto-detects your display server at runtime, but you need to install the correct clipboard package for your setup.

To check which display server you're using, run this command in your terminal:

```bash
echo $XDG_SESSION_TYPE
```

- If it returns **`x11`** → Install **xclip** using the **X11** commands below
- If it returns **`wayland`** → Install **wl-clipboard** using the **Wayland** commands below

### Installation Commands by Distribution

**For X11 users (most common):**

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Linux Mint</b></summary>

```bash
sudo apt update
sudo apt install flameshot tesseract-ocr xclip libnotify-bin pulseaudio-utils
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo apt install imagemagick bc
> ```

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>

```bash
sudo dnf install flameshot tesseract xclip libnotify pulseaudio-utils
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo dnf install ImageMagick bc
> ```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>

```bash
sudo pacman -S flameshot tesseract xclip libnotify pulseaudio
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo pacman -S imagemagick bc
> ```

</details>

<details>
<summary><b>openSUSE</b></summary>

```bash
sudo zypper install flameshot tesseract-ocr xclip libnotify-tools pulseaudio-utils
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo zypper install ImageMagick bc
> ```

</details>

<details>
<summary><b>Void Linux</b></summary>

```bash
sudo xbps-install -S flameshot tesseract xclip libnotify pulseaudio-utils
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo xbps-install -S ImageMagick bc
> ```

</details>

**For Wayland users:**

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Linux Mint (Wayland)</b></summary>

```bash
sudo apt update
sudo apt install flameshot tesseract-ocr wl-clipboard libnotify-bin pulseaudio-utils
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo apt install imagemagick bc
> ```

</details>

<details>
<summary><b>Fedora / RHEL / CentOS (Wayland)</b></summary>

```bash
sudo dnf install flameshot tesseract wl-clipboard libnotify pulseaudio-utils
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo dnf install ImageMagick bc
> ```

</details>

<details>
<summary><b>Arch Linux / Manjaro (Wayland)</b></summary>

```bash
sudo pacman -S flameshot tesseract wl-clipboard libnotify pulseaudio
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo pacman -S imagemagick bc
> ```

</details>

<details>
<summary><b>openSUSE (Wayland)</b></summary>

```bash
sudo zypper install flameshot tesseract-ocr wl-clipboard libnotify-tools pulseaudio-utils
```

> If you plan to use `ocr_clipboard_v2.sh`, also install:
> ```bash
> sudo zypper install ImageMagick bc
> ```

</details>

---

## 🚀 Installation

### 1. Create the Script

Two script versions are provided:
- **`ocr_clipboard.sh`** - The original script. Lightweight, fast, minimal dependencies.
- **`ocr_clipboard_v2.sh`** - An enhanced version that preprocesses the screenshot with ImageMagick (grayscale, dark-mode inversion, upscaling, contrast stretch, sharpening) before running it through Tesseract. This provides better text detection quality, at the cost of being slower by a few milliseconds. It's optimized for English characters via a `WHITELIST` variable in the script, but this can be edited to match your desired language. See [Dependencies](#-dependencies) for the extra packages it needs.

You can install one or both — pick whichever fits your needs, or keep both and switch between them.

**Option 1: Download the scripts (Recommended)**

```bash
mkdir -p ~/.local/bin

# Download ocr_clipboard.sh
curl -o ~/.local/bin/ocr_clipboard.sh https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/ocr-clipboard/ocr_clipboard.sh
chmod +x ~/.local/bin/ocr_clipboard.sh

# Download ocr_clipboard_v2.sh (better text detection quality, needs imagemagick + bc)
curl -o ~/.local/bin/ocr_clipboard_v2.sh https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/ocr-clipboard/ocr_clipboard_v2.sh
chmod +x ~/.local/bin/ocr_clipboard_v2.sh
```

> **Note:** Both scripts automatically detect whether you are running X11 or Wayland and use the appropriate clipboard command (`xclip` or `wl-copy`). No manual editing required.

<details>
<summary><b>Or create the scripts manually</b></summary>

The two scripts have different code. Create one or both depending on which you want.

**Create the script file(s):**

```bash
mkdir -p ~/.local/bin

# Create ocr_clipboard.sh
nano ~/.local/bin/ocr_clipboard.sh

# And/or create ocr_clipboard_v2.sh
nano ~/.local/bin/ocr_clipboard_v2.sh
```

**Copy this content into `ocr_clipboard.sh`:**

```bash
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
```

**Copy this content into `ocr_clipboard_v2.sh`:**

```bash
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
```

> **Note:** `ocr_clipboard_v2.sh` is optimized for English characters via the `WHITELIST` variable. If you want to recognize another language, edit `WHITELIST` to include the characters you need (and update the `-l eng` flag with the appropriate Tesseract language code — see [Multi-Language OCR Support](#-multi-language-ocr-support-optional)).

**Make executable:**

```bash
# Make ocr_clipboard.sh executable
chmod +x ~/.local/bin/ocr_clipboard.sh

# And/or make ocr_clipboard_v2.sh executable
chmod +x ~/.local/bin/ocr_clipboard_v2.sh
```

</details>

### 2. Test the Script

Run it manually to make sure it works:

```bash
# Test ocr_clipboard.sh
~/.local/bin/ocr_clipboard.sh

# Or test ocr_clipboard_v2.sh
~/.local/bin/ocr_clipboard_v2.sh
```

You should see the Flameshot selection interface appear. Select some text on your screen and it should be copied to your clipboard.

---

## 🔥 Ensure Flameshot is Running

The OCR script relies on Flameshot to capture the screen area. **Flameshot must be running** before you use the shortcut — otherwise, the script will fail silently.

For a consistent experience, configure Flameshot to **start automatically** when you log in so it's always available:

<details>
<summary><b>Quick Setup (Recommended)</b></summary>

```bash
mkdir -p ~/.config/autostart
curl -o ~/.config/autostart/flameshot.desktop https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/area-screenshot/flameshot.desktop
```

Log out and back in. Flameshot will now start automatically and appear in your system tray.

</details>

<details>
<summary><b>Manual Start (Without Autostart)</b></summary>

If you prefer not to autostart Flameshot, run it manually before using the OCR shortcut:

```bash
flameshot &
```

</details>

> **📖 For more autostart options** (GNOME GUI method, KDE Plasma method, or manual desktop file creation), see the [Area Screenshot guide — Auto-Start Flameshot](../area-screenshot/README.md#9-auto-start-flameshot-optional).

---

## ⌨️ Set Up Keyboard Shortcut

Now bind the script to a keyboard shortcut so you can trigger it anytime.

> **Note:** The examples below use `ocr_clipboard.sh`. If you're using `ocr_clipboard_v2.sh` instead, replace the script name in the command paths accordingly.

**Choose your desktop environment:**

<details>
<summary><b>GNOME / Ubuntu / Pop!_OS</b></summary>

1. Open **Settings** → **Keyboard** → **Keyboard Shortcuts**
2. Scroll down and click **"+"** or **"Add Custom Shortcut"**
3. Fill in the details:
   - **Name**: `OCR Screenshot`
   - **Command**: `/home/YOUR_USERNAME/.local/bin/ocr_clipboard.sh`
     - (Replace `YOUR_USERNAME` with your actual username, or use the full path)
   - **Shortcut**: Click "Set Shortcut" and press your desired key combination
     - Suggested: `Super+Shift+T` or `Super+Shift+O`
4. Click **Add**

</details>

<details>
<summary><b>KDE Plasma</b></summary>

1. Open **System Settings** → **Shortcuts** → **Custom Shortcuts**
2. Click **Edit** → **New** → **Global Shortcut** → **Command/URL**
3. In the **Trigger** tab, set your keyboard shortcut
4. In the **Action** tab, enter: `/home/YOUR_USERNAME/.local/bin/ocr_clipboard.sh`
5. Click **Apply**

</details>

<details>
<summary><b>XFCE</b></summary>

1. Open **Settings** → **Keyboard** → **Application Shortcuts**
2. Click **Add**
3. Enter command: `/home/YOUR_USERNAME/.local/bin/ocr_clipboard.sh`
4. Click **OK** and press your desired key combination

</details>

<details>
<summary><b>i3 / Sway (Tiling Window Managers)</b></summary>

Add this line to your config file (`~/.config/i3/config` or `~/.config/sway/config`):

```bash
bindsym $mod+Shift+t exec ~/.local/bin/ocr_clipboard.sh
```

Then reload your config: `i3-msg reload` or `swaymsg reload`

</details>

---

## ✅ Usage

1. Press your keyboard shortcut (e.g., `Super+Shift+T`)
2. **Select the area** containing text with your mouse
3. Wait for the notification
4. **Paste** the extracted text anywhere with `Ctrl+V`

---

## 🌍 Multi-Language OCR Support (Optional)

By default, Tesseract only recognizes English. To add support for other languages:

### Install Language Packs

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Mint</b></summary>

```bash
# List available languages
apt-cache search tesseract-ocr-

# Install specific languages
sudo apt install tesseract-ocr-fra  # French
sudo apt install tesseract-ocr-spa  # Spanish
sudo apt install tesseract-ocr-deu  # German
sudo apt install tesseract-ocr-ara  # Arabic
sudo apt install tesseract-ocr-chi-sim  # Chinese Simplified
sudo apt install tesseract-ocr-jpn  # Japanese
```

</details>

<details>
<summary><b>Fedora</b></summary>

```bash
sudo dnf install tesseract-langpack-fra  # French
sudo dnf install tesseract-langpack-spa  # Spanish
sudo dnf install tesseract-langpack-deu  # German
sudo dnf install tesseract-langpack-ara  # Arabic
```

</details>

<details>
<summary><b>Arch Linux</b></summary>

```bash
sudo pacman -S tesseract-data-fra  # French
sudo pacman -S tesseract-data-spa  # Spanish
sudo pacman -S tesseract-data-deu  # German
sudo pacman -S tesseract-data-ara  # Arabic
```

</details>

<details>
<summary><b>openSUSE</b></summary>

```bash
sudo zypper install tesseract-ocr-traineddata-french   # French
sudo zypper install tesseract-ocr-traineddata-spanish   # Spanish
sudo zypper install tesseract-ocr-traineddata-german    # German
sudo zypper install tesseract-ocr-traineddata-arabic    # Arabic
```

</details>

### Modify the Script for Multi-Language

**If you're using `ocr_clipboard.sh`:** edit the script and change this line:

```bash
text=$(flameshot gui --raw 2>/dev/null | tesseract stdin stdout --psm 6 2>/dev/null | tr -d '\f')
```

To this (add languages with `+`):

```bash
text=$(flameshot gui --raw 2>/dev/null | tesseract stdin stdout -l eng+ara+fra --psm 6 2>/dev/null | tr -d '\f')
```

This example enables English, Arabic, and French simultaneously.

**If you're using `ocr_clipboard_v2.sh`:** it's optimized for English out of the box, so two edits are needed. Update the `-l eng` flag the same way as above (e.g. `-l eng+ara+fra`), and also expand the `WHITELIST` variable to include the characters of your target language(s) — otherwise Tesseract will still discard any recognized character that isn't in the whitelist.

---

## 🎨 Customization Ideas

The script is designed to be easily customizable. Here are some ideas:

<details>
<summary><b>1. Copy to Both Clipboards (Primary + Clipboard)</b></summary>

```bash
# Replace the clipboard line with:
echo -n "$text" | tee >(xclip -selection clipboard -i) | xclip -selection primary -i
```
Now you can paste with both `Ctrl+V` and middle-click.

> **Note:** This example uses X11-specific commands (`xclip`). For Wayland, use `wl-copy` for primary clipboard functionality using `wl-copy --primary`.

</details>

<details>
<summary><b>2. Add Word/Character Count</b></summary>

```bash
# Add before the notification:
char_count=$(echo -n "$text" | wc -c)
word_count=$(echo "$text" | wc -w)

# Modify notification:
notify-send -t 3000 "OCR Complete ✓" "$preview...\n\n📝 $word_count words · $char_count chars"
```

</details>

<details>
<summary><b>3. Save to History File</b></summary>

```bash
# Add after copying to clipboard:
echo -e "\n=== $(date '+%Y-%m-%d %H:%M:%S') ===\n$text\n" >> ~/.ocr-history.log
```

</details>

<details>
<summary><b>4. Save Last OCR to Temp File</b></summary>

```bash
# Add after text extraction:
echo "$text" > /tmp/last-ocr.txt
```
Now you can quickly access the last OCR with: `cat /tmp/last-ocr.txt`

</details>

<details>
<summary><b>5. Different OCR Modes</b></summary>

Tesseract has different page segmentation modes (PSM):
- `--psm 6` - Uniform block of text (default in script, suitable for most cases)
- `--psm 11` - Sparse text (good for UI elements, buttons)
- `--psm 13` - Raw line (single line of text)
- `--psm 3` - Fully automatic (complex layouts)

Create multiple scripts for different scenarios if needed!

</details>

---

## 🐛 Troubleshooting

<details>
<summary><b>"Command not found" when pressing shortcut</b></summary>

- Make sure the path in your keyboard shortcut uses your full username
- Try using absolute path: `/home/username/.local/bin/ocr_clipboard.sh`
- Check if `~/.local/bin` is in your PATH: `echo $PATH`

</details>

<details>
<summary><b>No notification appears</b></summary>

- Install libnotify: `sudo apt install libnotify-bin`
- Test manually: `notify-send "Test" "This is a test"`

</details>

<details>
<summary><b>Clipboard doesn't work</b></summary>

- First, check if you're using X11 or Wayland: `echo $XDG_SESSION_TYPE`
- For X11: Make sure `xclip` is installed
- For Wayland: Make sure `wl-clipboard` is installed — the script auto-detects and uses the correct clipboard command

</details>

<details>
<summary><b>OCR accuracy is poor</b></summary>

- Ensure the screenshot has good contrast and resolution
- Try different `--psm` modes
- Install language packs for non-English text
- Consider using `--psm 6` for regular text, `--psm 11` for scattered UI text

</details>

<details>
<summary><b>Sound doesn't play</b></summary>

- Check if the sound file exists: `ls /usr/share/sounds/freedesktop/stereo/complete.oga`
- Test manually: `paplay /usr/share/sounds/freedesktop/stereo/complete.oga`
- Remove the sound line if you don't want audio feedback

</details>


---

## 📝 License

MIT License - feel free to modify and share!

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [🖼️ Area Screenshot (Flameshot)](../area-screenshot/README.md) — Screenshot tool with annotation
- [📋 Clipboard History (CopyQ)](../clipboard-history/README.md) — Advanced clipboard manager
- [🐬 Dolphin Service Menus](../dolphin-menus/README.md) — Custom right-click actions for Dolphin
- [🐚 Editor-Like Shell (zsh-edit-select)](../editor-like-shell/README.md) — Edit your command line like a text editor — Shift+Arrow/mouse selection, copy/cut/paste/undo, and more
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts

---