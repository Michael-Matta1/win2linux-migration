# **Guide: Taking Screenshots with Flameshot Using Windows-Style Shortcuts (Win+Shift+S)**

If you're coming from Windows, you're probably familiar with the **Win+Shift+S** shortcut for taking screenshots of a selected area. In Linux, you can recreate this exact workflow using **Flameshot**—a feature-rich screenshot tool that offers annotation, editing, and sharing capabilities built right in.

This guide will show you how to install Flameshot and configure **Super+Shift+S** (the Linux equivalent of Win+Shift+S) to capture screenshots just like in Windows.

---

## 📑 **Table of Contents**

- [What is Flameshot?](#what-is-flameshot)
- [Installation](#1-install-flameshot)
- [Basic Setup](#2-open-keyboard-shortcuts-settings)
- [Configuration](#6-flameshot-usage-modes-and-commands)
- [Advanced Features](#8-configure-flameshot-settings)
- [Troubleshooting](#10-troubleshooting)
- [Tips and Tricks](#13-pro-tips)

---

## **What is Flameshot?**

**Flameshot** is an open-source screenshot tool for Linux that provides:
- **Area selection** for capturing specific parts of your screen
- **Built-in annotation tools** (arrows, text, shapes, highlighting)
- **Instant editing** before saving or sharing
- **Multiple save options** (clipboard, file, upload)
- **Customizable shortcuts** for different screenshot modes

It serves a similar purpose as Windows' Snipping Tool, with additional features and integration with Linux workflows.

---

## **1. Install Flameshot**

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Linux Mint</b></summary>

```bash
sudo apt update
sudo apt install flameshot
```

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>

```bash
sudo dnf install flameshot
```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>

```bash
sudo pacman -S flameshot
```

</details>

<details>
<summary><b>openSUSE</b></summary>

```bash
sudo zypper install flameshot
```

</details>

### **Verify Installation**

Check that Flameshot is installed correctly:

```bash
flameshot --version
```

You should see output like:

```text
Flameshot v12.1.0
```

> **Note:** The version number may vary depending on your system's repositories.

---

## **2. Open Keyboard Shortcuts Settings**

Now let's create the custom keyboard shortcut:

1. Press **Super** (Windows key) to open the Activities overview
2. Search for **"Keyboard"** and open **Keyboard Settings**
3. Click on **"View and Customize Shortcuts"** or **"Keyboard Shortcuts"**
4. Scroll to the bottom and click on **"Custom Shortcuts"** (or look for a **"+"** button to add a custom shortcut)

---

## **3. Add Flameshot Screenshot Shortcut**

### **Create the Custom Shortcut:**

1. Click the **"+"** button to add a new custom shortcut
2. Fill in the following fields:

   - **Name:** `Screenshot Area Selection` (or any descriptive name like "Flameshot Screenshot")
   - **Command:**
   ```bash
   flameshot gui
   ```
   - **Shortcut:** Click **"Set Shortcut"** and press **Super + Shift + S**

3. Click **"Add"** or **"Save"** to create the shortcut

> **What does `flameshot gui` do?** This command launches Flameshot's graphical interface in selection mode, allowing you to click and drag to select the area you want to capture—exactly like Windows' Win+Shift+S behavior.

---

## **4. Handle Potential Shortcut Conflicts**

### **Check for Existing Super+Shift+S Binding:**

GNOME desktop environments often use **Super+Shift+S** for the built-in screenshot tool. If your shortcut doesn't work, you may need to disable the existing binding:

1. In **Keyboard Shortcuts**, search for "screenshot" or look under the **"Screenshots"** category
2. Find any shortcut assigned to **Super+Shift+S**
3. Click on it and either:
   - Press **Backspace** to disable it, or
   - Assign it to a different key combination

4. Now try setting your Flameshot shortcut to **Super+Shift+S** again

<details>
<summary><b>Alternative: Use a Different Shortcut</b></summary>

If you prefer to keep the GNOME screenshot tool for other purposes, you can use an alternative shortcut for Flameshot:

- **Print Screen** (PrtSc) for full-screen instant capture
- **Super+S** (without Shift) for area selection
- **Ctrl+Print Screen** for area selection

</details>

---

## **5. Test Your Screenshot Shortcut**

1. Press **Super + Shift + S**
2. Your screen should dim slightly, and your cursor will change to a crosshair
3. **Click and drag** to select the area you want to capture
4. Release the mouse button to capture the selected area

### **What Happens Next?**

After capturing, Flameshot opens an **annotation toolbar** where you can:
- ✏️ Draw arrows, lines, and shapes
- 📝 Add text annotations
- 🖍️ Highlight areas
- ✂️ Crop or blur sensitive information
- 💾 Save to a file
- 📋 Copy to clipboard
- 🌐 Upload and share

---

## **6. Flameshot Usage Modes and Commands**

Flameshot offers several capture modes. Here are the most useful commands you can bind to different shortcuts:

### **Common Flameshot Commands:**

| Command | Description | Recommended Shortcut |
|---------|-------------|----------------------|
| `flameshot gui` | Interactive area selection (Windows-style) | **Super+Shift+S** |
| `flameshot full` | Capture entire screen instantly | **Print Screen** |
| `flameshot screen` | Capture specific monitor | **Super+Print** |
| `flameshot launcher` | Opens mode selection menu | **Ctrl+Print** |

<details>
<summary><b>Advanced Commands with Auto-Save</b></summary>

If you want screenshots to automatically save to a specific folder with timestamps:

```bash
flameshot gui --path ~/Pictures/Screenshots
```

Or save with a custom filename:

```bash
flameshot gui --path ~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png
```

> **Create the Screenshots folder first:**
> ```bash
> mkdir -p ~/Pictures/Screenshots
> ```

</details>

---

## **7. Create Multiple Screenshot Shortcuts (Optional)**

To fully replicate a Windows-like screenshot workflow, you can create multiple shortcuts:

<details>
<summary><b>Shortcut 1: Area Selection (Interactive)</b></summary>

- **Name:** `Screenshot - Select Area`
- **Command:** `flameshot gui`
- **Shortcut:** **Super+Shift+S**

</details>

<details>
<summary><b>Shortcut 2: Full Screen (Instant)</b></summary>

- **Name:** `Screenshot - Full Screen`
- **Command:** `flameshot full --path ~/Pictures/Screenshots`
- **Shortcut:** **Print Screen**

</details>

<details>
<summary><b>Shortcut 3: Current Window</b></summary>

- **Name:** `Screenshot - Active Window`
- **Command:** `flameshot screen --path ~/Pictures/Screenshots`
- **Shortcut:** **Alt+Print Screen**

</details>

<details>
<summary><b>Shortcut 4: Auto-Save with Timestamp</b></summary>

- **Name:** `Screenshot - Auto-Save`
- **Command:** `flameshot gui --path ~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png`
- **Shortcut:** **Ctrl+Shift+S**

</details>

---

## **8. Configure Flameshot Settings**

You can customize Flameshot's behavior through its configuration GUI:

1. Launch Flameshot configuration:
   ```bash
   flameshot config
   ```

2. Or find it in your application menu: **Flameshot → Configuration**

<details>
<summary><b>Useful Settings to Configure</b></summary>

### **General:**
- ✅ Show desktop notifications
- ✅ Show the help message on startup (disable once familiar)
- ✅ Use JPG format for screenshots (if you prefer smaller file sizes)

### **Interface:**
- Choose button layout and toolbar position
- Set default save location
- Configure filename pattern

### **Shortcuts:**
- You can also set shortcuts within Flameshot itself, though system-level shortcuts (GNOME Settings) are generally more reliable

</details>

---

## **9. Auto-Start Flameshot (Optional)**

For faster access and system tray integration, make Flameshot start automatically when you log in:

<details>
<summary><b>GNOME / Ubuntu / Pop!_OS (GUI Method)</b></summary>

1. Open **Startup Applications** (search in your app menu) or **GNOME Tweaks → Startup Applications**
2. Click **"Add"**
3. Fill in:
   - **Name:** `Flameshot`
   - **Command:** `flameshot`
   - **Comment:** `Screenshot tool`
4. Click **"Add"** or **"OK"**

</details>

<details>
<summary><b>KDE Plasma (GUI Method)</b></summary>

1. Open **System Settings → Startup and Shutdown → Autostart**
2. Click **"Add... → Add Application"**
3. Search for **Flameshot** and select it
4. Click **"OK"**

</details>

<details>
<summary><b>Universal Method (Desktop File)</b></summary>

**Option 1: Download the autostart file**

```bash
mkdir -p ~/.config/autostart
curl -o ~/.config/autostart/flameshot.desktop https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/area-screenshot/flameshot.desktop
```

**Option 2: Create manually**

```bash
mkdir -p ~/.config/autostart
nano ~/.config/autostart/flameshot.desktop
```

Paste this content:

```ini
[Desktop Entry]
Type=Application
Name=Flameshot
Comment=Screenshot tool with annotation
Exec=flameshot
Icon=flameshot
Terminal=false
Categories=Graphics;Utility;
X-GNOME-Autostart-enabled=true
```

Save and exit (`Ctrl+X`, then `Y`, then `Enter`).

</details>

After setting up autostart, log out and back in. Flameshot will now run in your system tray with quick access to its features.

---

## **10. Troubleshooting**

<details>
<summary><b>Shortcut doesn't trigger Flameshot</b></summary>

- ✅ Verify Flameshot is installed: `flameshot --version`
- ✅ Check for conflicts with existing GNOME shortcuts
- ✅ Try running `flameshot gui` manually in a terminal to ensure it works
- ✅ Restart your session or log out and back in

</details>

<details>
<summary><b>Flameshot window doesn't appear</b></summary>

- ✅ Make sure you're using `flameshot gui` and not just `flameshot`
- ✅ Check if Flameshot is already running (check system tray)
- ✅ Try killing existing Flameshot processes: `killall flameshot` then retry

</details>

<details>
<summary><b>Screenshots not saving</b></summary>

- ✅ Ensure the save path exists: `mkdir -p ~/Pictures/Screenshots`
- ✅ Check file permissions for the target directory
- ✅ Try saving to clipboard first (`Ctrl+C` in Flameshot's annotation window) then paste elsewhere

</details>

<details>
<summary><b>Super+Shift+S does nothing</b></summary>

- ✅ Disable GNOME's built-in screenshot tool binding for this shortcut
- ✅ Check if another application is claiming this shortcut
- ✅ Try a different shortcut temporarily to isolate the issue

</details>

<details>
<summary><b>Annotation toolbar doesn't appear</b></summary>

- ✅ You might be using `flameshot full` instead of `flameshot gui`
- ✅ Update Flameshot to the latest version
- ✅ Check Flameshot configuration settings

</details>

---

## **11. Flameshot Keyboard Shortcuts (During Capture)**

Once you've triggered Flameshot with **Super+Shift+S**, you can use these keyboard shortcuts while in selection mode:

### **Selection Mode:**

| Shortcut | Action |
|----------|--------|
| **Click + Drag** | Select capture area |
| **Enter** | Confirm selection and open editor |
| **Spacebar** | Take full-screen screenshot |
| **Right Click** | Show color picker |
| **Mouse Wheel** | Resize selection |
| **Shift + Drag** | Move selection area |
| **Esc** | Cancel screenshot |

<details>
<summary><b>Annotation Mode Shortcuts</b></summary>

| Shortcut | Action |
|----------|--------|
| **Ctrl+C** | Copy to clipboard |
| **Ctrl+S** | Save to file |
| **Ctrl+Z** | Undo last annotation |
| **Ctrl+Shift+Z** | Redo |
| **Esc** | Exit without saving |

</details>

---

## **12. Advanced: Flameshot with Auto-Upload**

<details>
<summary><b>Upload Screenshots to Image Hosting Services</b></summary>

For users who frequently share screenshots, Flameshot can upload directly to image hosting services:

### **Example: Upload to Imgur**

```bash
flameshot gui --upload
```

This will:
1. Let you select an area
2. Annotate if desired
3. Automatically upload to Imgur
4. Copy the URL to your clipboard

You can configure the default upload destination in Flameshot's settings.

</details>

---

## **13. Pro Tips**

1. **Quick Copy to Clipboard:** After selecting an area in Flameshot, press **Ctrl+C** to copy directly to clipboard without saving a file

2. **Pin Screenshots:** Use Flameshot's "pin" feature to keep screenshots on top of all windows for reference while working

3. **Use Tray Icon:** With Flameshot auto-starting, you can quickly access different screenshot modes from the system tray

4. **Create Templates:** Save frequently used annotations (like watermarks or signatures) for quick reuse

5. **Combine with File Manager:** Right-click screenshots in Nautilus → "Open With" → Flameshot to edit existing images

6. **Extend with OCR:** You can extend Flameshot with text extraction capabilities by following the [OCR Clipboard guide](../ocr-clipboard/README.md) to extract text from your screenshots

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [📋 Clipboard History (CopyQ)](../clipboard-history/README.md) — Advanced clipboard manager
- [🐬 Dolphin Service Menus](../dolphin-menus/README.md) — Custom right-click actions for Dolphin
- [🐚 Editor-Like Shell (zsh-edit-select)](../editor-like-shell/README.md) — Edit your command line like a text editor — Shift+Arrow/mouse selection, copy/cut/paste/undo, and more
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🔍 OCR Clipboard](../ocr-clipboard/README.md) — Extract text from screenshots
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts
