# OCR Clipboard Shortcut for Linux

A lightweight, customizable script that lets you take a screenshot of any area on your screen, extract text using **OCR (Optical Character Recognition)**, and copy it directly to your clipboard — all with a single keyboard shortcut.

This is a Linux alternative to Windows PowerToys Text Extractor, using a lightweight script-based approach.

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

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>

```bash
sudo dnf install flameshot tesseract xclip libnotify pulseaudio-utils
```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>

```bash
sudo pacman -S flameshot tesseract xclip libnotify pulseaudio
```

</details>

<details>
<summary><b>openSUSE</b></summary>

```bash
sudo zypper install flameshot tesseract-ocr xclip libnotify-tools pulseaudio-utils
```

</details>

<details>
<summary><b>Void Linux</b></summary>

```bash
sudo xbps-install -S flameshot tesseract xclip libnotify pulseaudio-utils
```

</details>

**For Wayland users:**

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Linux Mint (Wayland)</b></summary>

```bash
sudo apt update
sudo apt install flameshot tesseract-ocr wl-clipboard libnotify-bin pulseaudio-utils
```

</details>

<details>
<summary><b>Fedora / RHEL / CentOS (Wayland)</b></summary>

```bash
sudo dnf install flameshot tesseract wl-clipboard libnotify pulseaudio-utils
```

</details>

<details>
<summary><b>Arch Linux / Manjaro (Wayland)</b></summary>

```bash
sudo pacman -S flameshot tesseract wl-clipboard libnotify pulseaudio
```

</details>

<details>
<summary><b>openSUSE (Wayland)</b></summary>

```bash
sudo zypper install flameshot tesseract-ocr wl-clipboard libnotify-tools pulseaudio-utils
```

</details>

---

## 🚀 Installation

### 1. Create the Script

Two script names are provided for flexibility (both are identical and auto-detect X11/Wayland):
- **`ocr-screenshot.sh`** - Descriptive name emphasizing it's for screenshots
- **`ocr_clipboard.sh`** - Alternative name emphasizing clipboard functionality

You can install one or both — they have the same code and functionality.

**Option 1: Download the scripts (Recommended)**

```bash
mkdir -p ~/.local/bin

# Download ocr-screenshot.sh
curl -o ~/.local/bin/ocr-screenshot.sh https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/ocr-clipboard/ocr-screenshot.sh
chmod +x ~/.local/bin/ocr-screenshot.sh

# Download ocr_clipboard.sh (alternative name, same functionality)
curl -o ~/.local/bin/ocr_clipboard.sh https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/ocr-clipboard/ocr_clipboard.sh
chmod +x ~/.local/bin/ocr_clipboard.sh
```

> **Note:** Both scripts automatically detect whether you are running X11 or Wayland and use the appropriate clipboard command (`xclip` or `wl-copy`). No manual editing required.

<details>
<summary><b>Or create the scripts manually</b></summary>

Both scripts have identical code. You can create one or both depending on your naming preference.

**Create the script file(s):**

```bash
mkdir -p ~/.local/bin

# Create ocr-screenshot.sh (or choose the name you prefer)
nano ~/.local/bin/ocr-screenshot.sh

# Or create ocr_clipboard.sh
nano ~/.local/bin/ocr_clipboard.sh
```

**Copy this content into the file(s):**

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

**Make executable:**

```bash
# Make ocr-screenshot.sh executable
chmod +x ~/.local/bin/ocr-screenshot.sh

# Or make ocr_clipboard.sh executable (if you created it)
chmod +x ~/.local/bin/ocr_clipboard.sh
```

</details>

### 2. Test the Script

Run it manually to make sure it works:

```bash
# Test ocr-screenshot.sh
~/.local/bin/ocr-screenshot.sh

# Or test ocr_clipboard.sh
~/.local/bin/ocr_clipboard.sh
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

> **Note:** The examples below use `ocr-screenshot.sh`. If you created `ocr_clipboard.sh` instead, replace the script name in the command paths accordingly.

**Choose your desktop environment:**

<details>
<summary><b>GNOME / Ubuntu / Pop!_OS</b></summary>

1. Open **Settings** → **Keyboard** → **Keyboard Shortcuts**
2. Scroll down and click **"+"** or **"Add Custom Shortcut"**
3. Fill in the details:
   - **Name**: `OCR Screenshot`
   - **Command**: `/home/YOUR_USERNAME/.local/bin/ocr-screenshot.sh`
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
4. In the **Action** tab, enter: `/home/YOUR_USERNAME/.local/bin/ocr-screenshot.sh`
5. Click **Apply**

</details>

<details>
<summary><b>XFCE</b></summary>

1. Open **Settings** → **Keyboard** → **Application Shortcuts**
2. Click **Add**
3. Enter command: `/home/YOUR_USERNAME/.local/bin/ocr-screenshot.sh`
4. Click **OK** and press your desired key combination

</details>

<details>
<summary><b>i3 / Sway (Tiling Window Managers)</b></summary>

Add this line to your config file (`~/.config/i3/config` or `~/.config/sway/config`):

```bash
bindsym $mod+Shift+t exec ~/.local/bin/ocr-screenshot.sh
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

Edit your script and change this line:

```bash
text=$(flameshot gui --raw 2>/dev/null | tesseract stdin stdout --psm 6 2>/dev/null | tr -d '\f')
```

To this (add languages with `+`):

```bash
text=$(flameshot gui --raw 2>/dev/null | tesseract stdin stdout -l eng+ara+fra --psm 6 2>/dev/null | tr -d '\f')
```

This example enables English, Arabic, and French simultaneously.

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
- Try using absolute path: `/home/username/.local/bin/ocr-screenshot.sh`
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
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts

---
