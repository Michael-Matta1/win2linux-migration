# **Guide: Enable Clipboard History in Linux with CopyQ (Windows Win+V Style)**

One of the most productive features in Windows 10/11 is the clipboard history activated with **Win+V**. This allows you to access previously copied items instead of just the last one. In Linux, you can recreate this exact workflow using **CopyQ**—a feature-rich clipboard manager.

Among the available clipboard managers — including Diodon, Clipman, and Clipboard Indicator — **CopyQ** provides a feature-rich clipboard management experience with extensive customization options.

This guide will show you how to install and configure CopyQ to work exactly like Windows, using **Super+V** for quick clipboard history and **Super+Shift+V** for the full history window.

---

## 📑 **Table of Contents**

- [What is CopyQ?](#what-is-copyq)
- [Installation](#1-install-copyq)
- [Configuration](#2-launch-and-configure-copyq)
- [Setting Up Shortcuts](#3-create-system-keyboard-shortcuts)
- [Usage and Workflow](#8-copyq-usage-tips-and-workflow)
- [Advanced Features](#9-advanced-copyq-features)
- [Troubleshooting](#12-troubleshooting)
- [Pro Tips](#14-pro-tips-for-maximum-productivity)

---

## **What is CopyQ?**

**CopyQ** is an advanced clipboard manager for Linux that provides:
- **Unlimited clipboard history** (configurable)
- **Search and filter** through clipboard items
- **Support for multiple formats** (text, images, HTML, files)
- **Keyboard-driven workflow** for power users
- **Custom commands and scripting** for automation
- **Synchronization** across devices (optional)
- **Tabs and organization** for different clipboard categories

CopyQ includes scripting, tabs, and format-aware history for a comprehensive clipboard management experience.

---

## **1. Install CopyQ**

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Linux Mint</b></summary>
```bash
sudo apt update
sudo apt install copyq
```

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>
```bash
sudo dnf install copyq
```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>
```bash
sudo pacman -S copyq
```

</details>

<details>
<summary><b>openSUSE</b></summary>
```bash
sudo zypper install copyq
```

</details>

### **Verify Installation**

Check that CopyQ is installed correctly:
```bash
copyq --version
```

You should see output like:
```text
CopyQ v6.1.0
```

> **Note:** Version numbers may vary depending on your distribution's repositories.

---

## **2. Launch and Configure CopyQ**

### **Start CopyQ:**

1. Press **Super** (Windows key) and search for **"CopyQ"**
2. Click to launch the application
3. CopyQ will start and place an icon in your **system tray** (usually in the top-right corner)

> **Important:** CopyQ needs to be running in the background to capture clipboard history. Auto-start configuration is covered later in this guide.

### **Open CopyQ Preferences:**

1. **Right-click** the CopyQ tray icon
2. Select **"Preferences"** or **"Show/Hide"** to open the main window, then go to **File → Preferences**

### **Essential Settings to Customize:**

<details>
<summary><b>General Tab Settings</b></summary>

- ✅ **"Start CopyQ automatically on system startup"** (check this box)
- **Maximum number of items in history:** Set to your preference (default: 200, recommended: 500-1000)
- ✅ **"Store clipboard automatically"** (should be checked)
- ✅ **"Save items to clipboard"** (should be checked)

</details>

<details>
<summary><b>Layout Tab Settings</b></summary>

- **Item preview:** Choose how items are displayed in the history
- **Show/hide tabs:** Customize which tabs are visible
- **Maximum width of items:** Adjust for readability

</details>

<details>
<summary><b>History Tab Settings</b></summary>

- ✅ **"Store text"** (essential for text copying)
- ✅ **"Store images"** (enables screenshot and image clipboard support)
- ✅ **"Store HTML"** (preserves formatting from web pages)
- **Maximum image size:** Set based on your needs (default is usually fine)
- **Clear history after:** Set retention period (or leave unlimited)

</details>

<details>
<summary><b>Items Tab Settings</b></summary>

- Configure how items are displayed and edited
- Set text wrapping preferences
- Choose font and size for preview

</details>

<details>
<summary><b>Shortcuts Tab</b></summary>

- This is where you can set **additional** shortcuts within CopyQ itself
- However, **system-level shortcuts** are generally preferred for better integration

</details>

> **Pro Tip:** Take a few minutes to explore all preference tabs. CopyQ is highly customizable, and tweaking these settings will significantly improve your workflow.

---

## **3. Create System Keyboard Shortcuts**

Now let's configure the Windows-style **Super+V** shortcut for quick clipboard history access.

### **Open Keyboard Shortcuts Settings:**

1. Press **Super** (Windows key) to open Activities
2. Search for **"Keyboard"** and open **Keyboard Settings**
3. Click on **"View and Customize Shortcuts"** or **"Keyboard Shortcuts"**
4. Scroll to the bottom and click on **"Custom Shortcuts"**
5. Click the **"+"** button to add a new custom shortcut

---

## **4. Add Quick Clipboard Menu (Super+V)**

This shortcut shows a **compact menu** of recent clipboard items, matching the Windows Win+V behavior.

### **Create the Shortcut:**

1. Click **"+"** to add a new custom shortcut
2. Fill in the following fields:

   - **Name:** `Clipboard History Menu` (or "CopyQ Quick Menu")
   - **Command:**
```bash
   copyq menu
```
   - **Shortcut:** Click **"Set Shortcut"** and press **Super + V**

3. Click **"Add"** or **"Save"**

### **What does `copyq menu` do?**

This command opens a **small, focused menu** near your cursor showing the most recent clipboard items (default: 10 items). You can:
- Navigate with **arrow keys** or **mouse**
- Press **Enter** or **click** to paste an item
- Press **Esc** to cancel
- Start typing to **search/filter** items

This is the **exact behavior** of Windows' Win+V clipboard history!

---

## **5. Add Full Clipboard Window (Super+Shift+V) - Bonus**

<details>
<summary><b>Create Full History Window Shortcut (Optional)</b></summary>

For power users who want access to the **complete clipboard history** with full search and editing capabilities, create a second shortcut:

### **Create the Full Window Shortcut:**

1. Click **"+"** to add another custom shortcut
2. Fill in the following fields:

   - **Name:** `Clipboard History - Full Window` (or "CopyQ Toggle")
   - **Command:**
```bash
   copyq toggle
```
   - **Shortcut:** Click **"Set Shortcut"** and press **Super + Shift + V**

3. Click **"Add"** or **"Save"**

### **What does `copyq toggle` do?**

This command opens the **full CopyQ window** with:
- **Complete clipboard history** (all items, not just recent)
- **Search bar** for filtering items
- **Preview panel** showing full content
- **Tabs** for organizing different clipboard categories
- **Edit capabilities** for modifying items before pasting
- **Multiple columns** with timestamps and metadata

Think of this as the "power user" mode for your clipboard history.

</details>

---

## **6. Handle Potential Shortcut Conflicts**

### **Check for Existing Super+V Binding:**

Some desktop environments or applications might already use **Super+V**. If your shortcut doesn't work:

1. In **Keyboard Shortcuts**, search for any existing **Super+V** binding
2. Disable or reassign any conflicting shortcuts
3. Try setting your CopyQ shortcut again

<details>
<summary><b>Common Conflicts</b></summary>

- **GNOME Extensions:** Some clipboard extensions may claim Super+V
- **Custom applications:** Video players or IDEs might use this shortcut
- **Other clipboard managers:** If you had Diodon, Clipman, or Clipboard Indicator installed, disable or uninstall them first

</details>

---

## **7. Test Your Clipboard History**

Now let's verify everything works correctly:

### **Test 1: Copy Multiple Items**

1. Open a text editor or web browser
2. Copy several different pieces of text (Ctrl+C each one)
3. Copy an image (right-click an image → Copy)
4. Copy a file path from your file manager

### **Test 2: Access Quick Menu (Super+V)**

1. Press **Super + V**
2. A small menu should appear near your cursor showing recent clipboard items
3. Use **arrow keys** to navigate or **click** with mouse
4. Press **Enter** to paste a selected item
5. Verify the correct content is pasted

<details>
<summary><b>Test 3: Access Full Window (Super+Shift+V) - If Configured</b></summary>

1. Press **Super + Shift + V**
2. The full CopyQ window should open
3. You should see **all** clipboard items in a list
4. Try using the **search bar** to filter items
5. Double-click an item or press **Enter** to paste it

</details>

✅ **If the shortcuts work, you've successfully replicated Windows clipboard history in Linux!**

---

## **8. CopyQ Usage Tips and Workflow**

### **Quick Menu (Super+V) Workflow:**

1. Press **Super+V** to open the menu
2. **Start typing** to instantly filter items (fuzzy search works!)
3. **Arrow keys** to navigate
4. **Enter** to paste selected item
5. **Esc** to dismiss menu

> **Pro Tip:** You can type part of any word in the clipboard item to filter. For example, if you copied "https://example.com", typing "exam" will find it.

<details>
<summary><b>Full Window (Super+Shift+V) Workflow</b></summary>

1. Press **Super+Shift+V** to open the full window
2. Use **Ctrl+F** or click the search bar to filter
3. **Double-click** or press **Enter** to paste
4. **Right-click** items for more options:
   - Edit content before pasting
   - Remove from history
   - Pin to keep permanently
   - Copy to a specific tab/category
5. Press **Esc** or click **X** to close

</details>

---

## **9. Advanced CopyQ Features**

<details>
<summary><b>Tabs for Organization</b></summary>

Create custom tabs to organize clipboard items by category:

1. Open CopyQ (Super+Shift+V)
2. Right-click the tab bar → **"New Tab"**
3. Name it (e.g., "Code Snippets", "Passwords", "URLs")
4. Drag items between tabs to organize

</details>

<details>
<summary><b>Pinning Important Items</b></summary>

Keep frequently used items permanently:

1. Right-click any clipboard item
2. Select **"Pin"** or press **Ctrl+P**
3. Pinned items stay at the top and won't be removed

</details>

<details>
<summary><b>Editing Before Pasting</b></summary>

Modify clipboard content on the fly:

1. Open CopyQ full window
2. Select an item
3. Press **F2** or right-click → **"Edit"**
4. Make changes
5. Press **Enter** to paste the edited version

</details>

<details>
<summary><b>Image Support</b></summary>

CopyQ handles images seamlessly:

- Take a screenshot (Flameshot, GNOME Screenshot, etc.)
- The image is automatically added to CopyQ
- Press **Super+V** to see image thumbnails
- Select and paste the image into any application

</details>

<details>
<summary><b>Clipboard Search</b></summary>

In the full window (Super+Shift+V):

- Press **Ctrl+F** to focus search
- Use **regex** for advanced filtering
- Filter by **type** (text, image, HTML)
- Search within **specific tabs**

</details>

---

## **10. Auto-Start CopyQ on System Boot**

To ensure CopyQ is always running and capturing clipboard history:

<details>
<summary><b>Method 1: Using CopyQ Preferences (Recommended)</b></summary>

1. Open CopyQ preferences (right-click tray icon → Preferences)
2. Go to the **"General"** tab
3. ✅ Check **"Autostart"** or **"Start CopyQ automatically on system startup"**
4. Click **OK**

</details>

<details>
<summary><b>Method 2: Using Startup Applications (Manual)</b></summary>

If the above doesn't work:

1. Open **Startup Applications** (search in app menu)
2. Click **"Add"**
3. Fill in:
   - **Name:** `CopyQ`
   - **Command:** `copyq`
   - **Comment:** `Clipboard manager`
4. Click **"Add"**

> **Verify:** Log out and back in, then check if CopyQ tray icon appears automatically.

</details>

---

## **11. CopyQ Commands Reference**

<details>
<summary><b>Useful CopyQ Commands</b></summary>

Here are useful CopyQ commands you can bind to shortcuts or use in terminal:

| Command | Description | Suggested Shortcut |
|---------|-------------|--------------------|
| `copyq menu` | Show quick clipboard menu | **Super+V** |
| `copyq toggle` | Toggle full CopyQ window | **Super+Shift+V** |
| `copyq show` | Show CopyQ window | Alternative to toggle |
| `copyq hide` | Hide CopyQ window | N/A (auto-hides) |
| `copyq clipboard` | Print current clipboard content | N/A |
| `copyq copy "text"` | Add text to clipboard | Script usage |
| `copyq clear` | Clear clipboard history | **Ctrl+Shift+Del** (custom) |

</details>

---

## **12. Troubleshooting**

<details>
<summary><b>Shortcut doesn't trigger CopyQ</b></summary>

- ✅ Verify CopyQ is installed: `copyq --version`
- ✅ Check if CopyQ is running (look for tray icon)
- ✅ Start CopyQ manually: `copyq` in terminal
- ✅ Check for keyboard shortcut conflicts in GNOME settings
- ✅ Try running `copyq menu` directly in terminal to test

</details>

<details>
<summary><b>CopyQ tray icon doesn't appear</b></summary>

- ✅ Ensure your desktop environment supports system tray icons
- ✅ Install GNOME extensions like "AppIndicator Support" if needed:
```bash
  sudo apt install gnome-shell-extension-appindicator
```
- ✅ Restart GNOME Shell: Press **Alt+F2**, type `r`, press **Enter**

</details>

<details>
<summary><b>Clipboard history not saving items</b></summary>

- ✅ Check CopyQ Preferences → **History** tab
- ✅ Ensure **"Store text"** and other format options are checked
- ✅ Verify CopyQ has permission to access clipboard
- ✅ Restart CopyQ: `killall copyq && copyq`

</details>

<details>
<summary><b>Images not appearing in clipboard</b></summary>

- ✅ Check Preferences → **History** → **"Store images"** is enabled
- ✅ Increase **"Maximum image size"** if large images aren't captured
- ✅ Verify image format is supported (PNG, JPG, GIF, BMP)

</details>

<details>
<summary><b>Super+V shows wrong menu or doesn't work</b></summary>

- ✅ Disable other clipboard managers (Diodon, Clipman, etc.):
```bash
  sudo apt remove diodon clipman
```
- ✅ Clear any conflicting GNOME shortcuts
- ✅ Log out and back in after making changes

</details>

<details>
<summary><b>CopyQ window opens instead of menu</b></summary>

- ✅ Double-check you're using `copyq menu` not `copyq toggle` or `copyq show`
- ✅ Verify the exact command in your keyboard shortcut settings

</details>

---

## **13. Uninstalling Other Clipboard Managers**

<details>
<summary><b>Remove Conflicting Clipboard Managers</b></summary>

If you previously installed other clipboard managers, remove them to avoid conflicts:
```bash
# Remove Diodon
sudo apt remove diodon

# Remove Clipman
sudo apt remove clipman

# Remove Clipboard Indicator
sudo apt remove clipboard-indicator
```

After removal, restart your session to ensure they're fully disabled.

</details>

---

## **14. Pro Tips for Maximum Productivity**

1. **Use Search Aggressively:** In the quick menu (Super+V), start typing immediately—no need to click the search bar

2. **Pin Your Most-Used Items:** Right-click frequently used text snippets, commands, or templates and pin them to the top

3. **Create Tab Workflows:** Use tabs to separate work contexts (e.g., "Development", "Writing", "Personal")

4. **Combine with Text Expanders:** Use CopyQ alongside text expansion tools for even more automation

5. **Script Custom Commands:** CopyQ supports JavaScript for advanced automation—check the documentation for examples

6. **Clear Sensitive Data:** Right-click the tray icon → **"Clear clipboard history"** when working with passwords or sensitive info

7. **Use Keyboard Navigation:** Learn keyboard shortcuts in CopyQ for efficient clipboard management without touching the mouse

8. **Export/Import Configuration:** Back up your CopyQ settings via **File → Export** for easy restoration on new systems

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [🖼️ Area Screenshot (Flameshot)](../area-screenshot/README.md) — Screenshot tool with annotation
- [🐬 Dolphin Service Menus](../dolphin-menus/README.md) — Custom right-click actions for Dolphin
- [🐚 Editor-Like Shell (zsh-edit-select)](../editor-like-shell/README.md) — Edit your command line like a text editor — Shift+Arrow/mouse selection, copy/cut/paste/undo (integrates seamlessly with CopyQ)
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🔍 OCR Clipboard](../ocr-clipboard/README.md) — Extract text from screenshots
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts
