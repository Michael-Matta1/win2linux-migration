# **Guide: Remapping Linux Keyboard Shortcuts to Match Your Windows Workflow**

After decades of using the same keyboard shortcuts in Windows, they become second nature—making the transition to Linux challenging. This guide shows you how to remap Linux keyboard shortcuts to match those you're familiar with in Windows, making your Linux experience feel more natural and productive.

> **Tip:** If you use want to edit commands like PowerShell — with Shift+Arrow or mouse selection, typing to replace selections, copy/cut/paste/undo — check out the [Editor-Like Shell guide](../editor-like-shell/README.md). It complements AutoKey by handling shortcuts at the shell level.

---

## 📑 **Table of Contents**

- [Understanding the Problem](#understanding-the-problem)
- [The Solution: AutoKey](#the-solution-autokey)
- [Installation](#1-install-autokey)
- [Setup and Configuration](#2-enable-accessibility-support)
- [Creating Custom Shortcuts](#4-create-your-custom-keyboard-shortcut-script)
- [AutoKey Autostart](#5-set-autokey-to-start-automatically-recommended)
- [Examples and Use Cases](#8-creating-multiple-shortcuts)
- [Advanced Usage](#9-advanced-application-specific-remapping)
- [Troubleshooting](#10-troubleshooting)
- [Best Practices](#11-best-practices)
- [Complete Examples](#12-example-complete-nautilus-windows-style-setup)
- [System-Wide Shortcuts](#13-beyond-nautilus-system-wide-shortcuts)

---

## **Understanding the Problem**

Different operating systems and applications use different keyboard shortcuts for the same actions. For example:

| Action | Windows | Linux (Nautilus) |
|--------|---------|------------------|
| Focus location bar | `Alt+D` | `Ctrl+L` |
| Copy | `Ctrl+C` | `Ctrl+C` (same) |
| Paste | `Ctrl+V` | `Ctrl+V` (same) |

While some shortcuts remain consistent, many don't—and relearning them can significantly slow down your workflow.

---

## **The Solution: AutoKey**

**AutoKey** is a desktop automation utility for Linux that lets you:
- Create custom keyboard shortcuts
- Remap existing shortcuts to new key combinations
- Trigger scripts based on specific applications
- Automate repetitive tasks

In this guide, **Nautilus (GNOME Files)** is used as an example, remapping `Alt+D` to focus the location bar (instead of the default `Ctrl+L`)—but the same method works for **any application** and **any keyboard shortcut**.

---

## **1. Install AutoKey**

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Linux Mint</b></summary>
```bash
sudo apt update
sudo apt install autokey-gtk
```

> **Note:** Use `autokey-qt` if you prefer the Qt version instead of GTK.

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>
```bash
sudo dnf install autokey-gtk
```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>
```bash
sudo pacman -S autokey-gtk
# or for Qt version:
sudo pacman -S autokey-qt
```

</details>

<details>
<summary><b>openSUSE</b></summary>
```bash
sudo zypper install autokey-gtk
```

</details>

---

## **2. Enable Accessibility Support**

AutoKey requires accessibility features to send synthetic keyboard events to applications:
```bash
gsettings set org.gnome.desktop.interface toolkit-accessibility true
```

This is essential for AutoKey to interact with application windows like Nautilus.

---

## **3. Identify the Target Application's Window Class**

To make your custom shortcut work **across multiple contexts** (e.g., file manager AND browser file upload dialogs), you need to identify all relevant window classes.

<details>
<summary><b>Method 1: Using xprop (Command Line)</b></summary>

1. Open the target application (**Files/Nautilus** in this example)
2. Open a terminal and run:
```bash
xprop | grep WM_CLASS
```

3. Click on the **Nautilus window** (your cursor will turn into a crosshair)
4. The terminal will display something like:
```text
WM_CLASS(STRING) = "org.gnome.Nautilus.Org.gnome.Nautilus", "Org.gnome.Nautilus"
```

> Use the **first string** (`org.gnome.Nautilus.Org.gnome.Nautilus`) as the window class in AutoKey.

> **Note for Dolphin users:** If you use the Dolphin file manager (KDE), use `dolphin.dolphin` as the window class instead of the Nautilus class. If you use both Nautilus and Dolphin, combine them in a single window filter:
> ```text
> File Upload|org.gnome.Nautilus.Org.gnome.Nautilus|dolphin.dolphin
> ```
> For more information about Dolphin, see the [File Manager Customization guide](../file-manager/README.md).

5. **Repeat for browser file upload dialogs:**
   - Open a file upload dialog in your browser (e.g., click "Choose File" on a website)
   - Run `xprop | grep WM_CLASS` again
   - Click on the file upload dialog
   - You should see something like:
```text
WM_CLASS(STRING) = "File Upload", "firefox"
```

</details>

<details>
<summary><b>Method 2: Using AutoKey's Built-in Tool (Recommended)</b></summary>

1. Open **AutoKey**
2. Click on the **AutoKey tray icon** in your system tray
3. From the tray icon menu, click **"Display Window Information"**
4. Your cursor will turn into a crosshair—click on the **target application window**
5. A dialog will appear showing:
   - **Window Title**
   - **Window Class**

   Copy these values for use in your window filters.

> **Tip:** This method is much faster and doesn't require terminal commands! Use it to check both Nautilus and browser file upload dialogs.

6. **Test with multiple windows:**
   - Click on a regular Nautilus window
   - Click on a browser file upload dialog
   - Note down both window class values

</details>

---

## **4. Create Your Custom Keyboard Shortcut Script**

Now let's create a script to remap `Alt+D` to focus the location bar across both Nautilus and file upload dialogs:

### Step 1: Create New Script

1. Open **AutoKey** → Navigate to **File → New → Script** (or right-click **My Scripts** → **New → Script**)
2. Give it a descriptive name: `Focus Location Bar (Alt+D)`
3. Paste the following script:
```python
# AutoKey script: Focus location bar in Nautilus and file dialogs (Windows Alt+D equivalent)
keyboard.send_keys("<ctrl>+l")  # Sends Ctrl+L to focus the location bar
```

### Step 2: Set the Hotkey

- Click on **Set** next to **Hotkey**
- Press `Alt+D` (or whatever Windows shortcut you want to use)
- Click **OK**

### Step 3: Configure Window Filter for Multiple Contexts

- Click on **Set** next to **Window Filter**
- In the **Window class** field, enter:
```text
File Upload|org.gnome.Nautilus.Org.gnome.Nautilus
```

- **Check the box** for **"Use regex"** (this allows the `|` pipe character to match multiple window classes)
- Click **OK**

> **Why this filter?** By including both `File Upload` (browser file dialogs) and `org.gnome.Nautilus.Org.gnome.Nautilus` (file manager), you ensure that `Alt+D` consistently focuses the location bar across **all file browsing workflows**—whether you're navigating in Nautilus or selecting files to upload in your browser. This creates a seamless, Windows-like experience!
>
> **Dolphin users:** If you also use the [Dolphin file manager](../file-manager/README.md), extend the filter to include it:
> ```text
> File Upload|org.gnome.Nautilus.Org.gnome.Nautilus|dolphin.dolphin
> ```

### Step 4: Save the Script

Click **Save** to save your script.

---

## **5. Set AutoKey to Start Automatically (Recommended)**

To ensure your custom shortcuts work immediately after login, configure AutoKey to start automatically:

<details>
<summary><b>GNOME / Ubuntu / Pop!_OS</b></summary>

**Method 1: Using Startup Applications (GUI)**

1. Open **Startup Applications** (search in your app menu) or **GNOME Tweaks → Startup Applications**
2. Click **"Add"**
3. Fill in:
   - **Name:** `AutoKey`
   - **Command:** `autokey-gtk` (or `autokey-qt` if you installed the Qt version)
   - **Comment:** `Keyboard shortcut automation`
4. Click **"Add"** or **"OK"**

**Method 2: Using Desktop File**

```bash
mkdir -p ~/.config/autostart
cp /usr/share/applications/autokey-gtk.desktop ~/.config/autostart/
# or for Qt version:
# cp /usr/share/applications/autokey-qt.desktop ~/.config/autostart/
```

</details>

<details>
<summary><b>KDE Plasma</b></summary>

1. Open **System Settings → Startup and Shutdown → Autostart**
2. Click **"Add... → Add Application"**
3. Search for **AutoKey** and select it
4. Click **"OK"**

</details>

<details>
<summary><b>XFCE / Other Desktop Environments</b></summary>

**Method 1: Session and Startup (GUI)**

1. Open **Settings → Session and Startup**
2. Go to **Application Autostart** tab
3. Click **"Add"**
4. Fill in:
   - **Name:** `AutoKey`
   - **Command:** `autokey-gtk`
   - **Description:** `Keyboard shortcut automation`
5. Click **"OK"**

**Method 2: Terminal**

```bash
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/autokey.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=AutoKey
Comment=Keyboard shortcut automation
Exec=autokey-gtk
Icon=autokey
Terminal=false
Categories=Utility;
X-GNOME-Autostart-enabled=true
EOF
```

</details>

After setting up autostart, log out and back in. AutoKey will now run automatically, and your custom shortcuts will be ready to use.

---

## **6. Test Your Custom Shortcut**

1. Make sure **AutoKey is running** (check the system tray)
2. **Test in Nautilus:**
   - Open **Nautilus** and navigate to any folder
   - Press **Alt+D**
   - The location bar should now be focused and the path highlighted
3. **Test in browser file upload dialog:**
   - Open your web browser (Firefox, Chrome, etc.)
   - Navigate to a website with a file upload button
   - Click the upload button to open the file selection dialog
   - Press **Alt+D**
   - The location bar in the file dialog should now be focused

✅ **Now you have consistent `Alt+D` behavior across all file browsing contexts—just like in Windows!**

---

## **7. Understanding the Script Components**

### **Key Syntax in AutoKey:**

- `<ctrl>` = Control key
- `<alt>` = Alt key
- `<shift>` = Shift key
- `<super>` = Windows/Super key
- `+` = Combine keys (press together)

<details>
<summary><b>Window Filter Patterns</b></summary>

When using regex in window filters, you can match multiple window classes:

- **Single application:** `org.gnome.Nautilus`
- **Multiple applications:** `File Upload|org.gnome.Nautilus.Org.gnome.Nautilus`
- **Any Firefox window:** `Navigator.Firefox|firefox`
- **Pattern matching:** `(gedit|pluma|xed)` for multiple text editors

> **Pro Tip:** The pipe character `|` acts as "OR" in regex—meaning the shortcut will work if the window class matches **either** pattern.

</details>

<details>
<summary><b>Examples of Remapping</b></summary>

**Example 1: Remap Ctrl+W to close window (like Windows)**
```python
keyboard.send_keys("<alt>+<f4>")  # Linux equivalent of closing window
```

**Example 2: Remap Ctrl+E to open file properties**
```python
keyboard.send_keys("<alt>+<return>")  # Opens properties in Nautilus
```

**Example 3: Multi-step automation**
```python
keyboard.send_keys("<ctrl>+l")  # Focus location bar
time.sleep(0.1)  # Brief pause
keyboard.send_keys("<ctrl>+c")  # Copy the path
```

</details>

---

## **8. Creating Multiple Shortcuts**

You can create as many remapped shortcuts as you need. Here's a workflow example:

### **Common Windows → Linux Remappings:**

| Windows Action | Windows Shortcut | Linux Default | AutoKey Script | Window Filter |
|----------------|------------------|---------------|----------------|---------------|
| Focus location bar | `Alt+D` | `Ctrl+L` | `keyboard.send_keys("<ctrl>+l")` | `File Upload\|org.gnome.Nautilus.Org.gnome.Nautilus` (add `\|dolphin.dolphin` if using Dolphin) |
| Refresh | `F5` | `Ctrl+R` | `keyboard.send_keys("<ctrl>+r")` | `org.gnome.Nautilus.Org.gnome.Nautilus` |
| Show hidden files | N/A | `Ctrl+H` | `keyboard.send_keys("<ctrl>+h")` | `org.gnome.Nautilus.Org.gnome.Nautilus` |
| New folder | `Ctrl+Shift+N` | `Ctrl+Shift+N` | Already matches! | N/A |

For each shortcut you want to remap:
1. Create a new script in AutoKey
2. Use the appropriate `keyboard.send_keys()` command
3. Assign your preferred Windows hotkey
4. Set the window filter to the target application(s)
5. Enable regex if using multiple window classes with `|`

---

## **9. Advanced: Application-Specific Remapping**

You can create different remappings for different applications by using window filters:

<details>
<summary><b>For Web Browsers (Firefox, Chrome)</b></summary>

Window class examples:
- Firefox: `Navigator.Firefox` or `firefox`
- Chrome: `google-chrome.Google-chrome` or `chromium`

</details>

<details>
<summary><b>For Text Editors</b></summary>

- gedit: `org.gnome.gedit`
- VS Code: `code.Code`
- Multiple editors: `(org.gnome.gedit|code.Code|pluma)` (with regex enabled)

</details>

<details>
<summary><b>For File Dialogs Across Applications</b></summary>

File upload/download dialogs often share the same window class (`File Upload`), making it easy to create consistent shortcuts:
```text
File Upload
```

Or combine with specific applications:
```text
File Upload|org.gnome.Nautilus.Org.gnome.Nautilus|Thunar
```

> **Remember:** Enable **"Use regex"** when using the pipe `|` character!

</details>

---

## **10. Troubleshooting**

<details>
<summary><b>Hotkey doesn't work automatically</b></summary>

- ✅ Ensure AutoKey is running (check system tray)
- ✅ Verify accessibility is enabled (see Step 2)
- ✅ Confirm window class matches using `xprop` or AutoKey's **"Display Window Information"** tool
- ✅ If using regex patterns with `|`, make sure **"Use regex"** is checked
- ✅ Try temporarily removing the window filter to test if it's a filter issue

</details>

<details>
<summary><b>Script runs manually but not with hotkey</b></summary>

- This usually indicates a **window filter mismatch**
- Use AutoKey's **"Display Window Information"** feature (from the tray icon) to get the exact window class
- Make sure the window class string is entered exactly as shown
- Verify regex is enabled if using multiple patterns

</details>

<details>
<summary><b>Shortcut works in Nautilus but not in file upload dialogs (or vice versa)</b></summary>

- Double-check that you've included both window classes in your filter: `File Upload|org.gnome.Nautilus.Org.gnome.Nautilus`
- Ensure **"Use regex"** is checked
- Test each window class individually to isolate the issue
- Use **"Display Window Information"** to verify the exact window class of the problematic dialog

</details>

<details>
<summary><b>Shortcut conflicts with system shortcuts</b></summary>

- Some shortcuts may be claimed by the system or desktop environment
- Try a different key combination
- Check GNOME Settings → Keyboard → Keyboard Shortcuts for conflicts

</details>

<details>
<summary><b>AutoKey doesn't start automatically</b></summary>

1. Open **Startup Applications** (search in your app menu)
2. Click **Add**
3. Name: `AutoKey`
4. Command: `autokey-gtk` (or `autokey-qt`)
5. Click **Add** and **Close**

</details>

---

## **11. Best Practices**

1. **Organize your scripts:** Create folders in AutoKey for different applications (e.g., "Nautilus Scripts", "Browser Scripts", "Global Shortcuts")
2. **Use descriptive names:** Name scripts clearly (e.g., "Focus Location Bar (Alt+D) - Nautilus + File Dialogs")
3. **Test incrementally:** Create one shortcut at a time and test thoroughly before adding more
4. **Document your shortcuts:** Keep a text file listing your custom shortcuts for reference
5. **Back up your configuration:** AutoKey stores scripts in `~/.config/autokey/` - back this up regularly
6. **Use consistent patterns:** When creating shortcuts that should work across multiple contexts (like file browsing), always include all relevant window classes
7. **Leverage regex:** Use regex patterns to avoid creating duplicate scripts for similar functionality

---

## **12. Example: Complete Nautilus Windows-Style Setup**

Here's a complete set of scripts to make Nautilus feel more like Windows Explorer:

<details>
<summary><b>Script 1: Alt+D (Focus Location Bar - Universal)</b></summary>
```python
keyboard.send_keys("<ctrl>+l")
```
- **Hotkey:** `Alt+D`
- **Window class:** `File Upload|org.gnome.Nautilus.Org.gnome.Nautilus` (add `|dolphin.dolphin` if you also use Dolphin)
- **Regex:** ✅ Enabled
- **Purpose:** Works in both file manager and browser file upload dialogs for consistent behavior

</details>

<details>
<summary><b>Script 2: Alt+Up (Go to Parent Folder)</b></summary>
```python
keyboard.send_keys("<alt>+<up>")
```
- **Hotkey:** `Alt+Up`
- **Window class:** `org.gnome.Nautilus.Org.gnome.Nautilus`
- **Regex:** ❌ Not needed (single application)

</details>

<details>
<summary><b>Script 3: Backspace (Go Back)</b></summary>
```python
keyboard.send_keys("<alt>+<left>")
```
- **Hotkey:** `Backspace`
- **Window class:** `org.gnome.Nautilus.Org.gnome.Nautilus`
- **Regex:** ❌ Not needed (single application)

</details>

<details>
<summary><b>Script 4: F5 (Refresh)</b></summary>
```python
keyboard.send_keys("<ctrl>+r")
```
- **Hotkey:** `F5`
- **Window class:** `org.gnome.Nautilus.Org.gnome.Nautilus`
- **Regex:** ❌ Not needed (single application)

</details>

---

## **13. Beyond Nautilus: System-Wide Shortcuts**

You can also create shortcuts that work across **all applications** by leaving the window filter empty.

<details>
<summary><b>Example: Global Clipboard Manager Shortcut</b></summary>
```python
keyboard.send_keys("<ctrl>+<alt>+v")  # Opens clipboard history
```
- **Hotkey:** `Win+V` (like Windows)
- **Window filter:** (empty - works everywhere)

</details>

<details>
<summary><b>Example: Global Screenshot with Windows-Style Shortcut</b></summary>
```python
keyboard.send_keys("<shift>+<ctrl>+<print>")  # GNOME screenshot tool
```
- **Hotkey:** `Win+Shift+S` (like Windows Snipping Tool)
- **Window filter:** (empty - works everywhere)

</details>

---

## **14. Pro Tips for Cross-Application Consistency**

### **Identifying Common Window Classes:**

Many applications share window classes for specific dialogs. Here are some common ones:

- **File dialogs:** `File Upload`, `GtkFileChooserDialog`
- **Save dialogs:** `Save File`, `GtkFileChooserDialog`
- **Print dialogs:** `Print`, `GtkPrintUnixDialog`

By including these in your window filters, you can create shortcuts that work consistently across all applications that use these standard dialogs.

<details>
<summary><b>Example: Universal File Dialog Navigation</b></summary>

Create a single script that works in **all** file dialogs:
```python
keyboard.send_keys("<ctrl>+l")
```
- **Hotkey:** `Alt+D`
- **Window class:** `File Upload|Save File|GtkFileChooserDialog|org.gnome.Nautilus.Org.gnome.Nautilus|dolphin.dolphin`
- **Regex:** ✅ Enabled

This ensures `Alt+D` focuses the location bar whether you're:
- Browsing in Nautilus or [Dolphin](../file-manager/README.md)
- Uploading a file in Firefox
- Saving a document in LibreOffice
- Opening a file in GIMP

</details>

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [🖼️ Area Screenshot (Flameshot)](../area-screenshot/README.md) — Screenshot tool with annotation
- [📋 Clipboard History (CopyQ)](../clipboard-history/README.md) — Advanced clipboard manager
- [🐬 Dolphin Service Menus](../dolphin-menus/README.md) — Custom right-click actions for Dolphin
- [🐚 Editor-Like Shell (zsh-edit-select)](../editor-like-shell/README.md) — Edit your command line like a text editor — Shift+Arrow/mouse selection, copy/cut/paste/undo, and more
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🔍 OCR Clipboard](../ocr-clipboard/README.md) — Extract text from screenshots
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus


