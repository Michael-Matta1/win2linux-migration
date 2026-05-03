# **Complete Guide: Choosing the Right File Manager for Windows Users on Linux**

As a Windows user transitioning to Linux, you'll quickly notice that **Nautilus** (GNOME Files), the default file manager in many distributions, lacks many features you're accustomed to in Windows Explorer. While Nautilus is clean and simple, it can feel limiting if you're used to advanced features like dual-pane views, extensive customization, detailed file information, and rich context menus.

This guide will help you choose and configure a feature-rich file manager that feels more like home.

> **Note:** If you are already using **KDE Plasma** as your desktop environment, Dolphin comes pre-installed — you don't need to follow this guide. This installation guide is for users on **other desktop environments** (GNOME, XFCE, etc.) who want to use Dolphin.

---

## 📑 **Table of Contents**

- [The Problem with Nautilus](#1-the-problem-with-nautilus)
- [File Manager Options](#2-file-manager-options-overview)
- [Dolphin File Manager (Recommended)](#3-recommended-dolphin-file-manager)
- [Nemo File Manager (Alternative)](#4-alternative-nemo-file-manager)
- [Setting Default File Manager](#5-setting-your-default-file-manager)
- [Troubleshooting](#6-troubleshooting)
- [Final Recommendations](#final-recommendations)

---

## **1. The Problem with Nautilus**

**Nautilus** (also called "Files" in GNOME) is the default file manager in Ubuntu, Pop!_OS, Fedora, and many other GNOME-based distributions. While it has a clean, minimalist interface, it lacks several features that Windows users rely on:

<details>
<summary><b>What Nautilus is Missing</b></summary>

❌ **No dual-pane (split view)** - Can't view two folders side by side
❌ **Limited customization** - Toolbar and view options are minimal
❌ **Basic context menus** - Fewer right-click options compared to Windows Explorer
❌ **No detailed status bar** - Limited file information display
❌ **Fewer keyboard shortcuts** - Less power-user functionality
❌ **Limited plugin ecosystem** - Fewer extensions available
❌ **No tabs** (in older versions) - Though newer versions have added this
❌ **No integrated terminal** - Can't open terminal in current directory easily
❌ **Less detailed file properties** - Simplified information panels

</details>

<details>
<summary><b>What Windows Explorer Has</b></summary>

✅ Ribbon interface with extensive options
✅ Detailed status bar with file counts and sizes
✅ Rich context menus with many actions
✅ Quick access toolbar customization
✅ Built-in compression tools (right-click → compress)
✅ Preview pane for files
✅ Network drive mapping
✅ Extensive keyboard shortcuts

</details>

**The good news:** Linux offers alternative file managers that restore and even exceed Windows Explorer's functionality!

---

## **2. File Manager Options Overview**

Among the available file managers for GNOME-based Linux distributions, two stand out for Windows migrants:

### **🏆 Dolphin (Recommended)**

<details>
<summary><b>Dolphin Overview</b></summary>

- **Desktop Environment:** KDE Plasma (but works on GNOME with configuration)
- **Best For:** Users who want maximum features and customization
- **Similar To:** Windows Explorer with extra power features
- **Pros:**
  - Extremely feature-rich
  - Highly customizable
  - Split view / dual pane
  - Integrated terminal
  - Extensive keyboard shortcuts
  - Rich plugin system
  - Detailed information panel
- **Cons:**
  - Requires KDE dependencies on GNOME
  - Needs initial configuration for best integration
  - Can feel overwhelming initially

</details>

### **🥈 Nemo (Easier Alternative)**

<details>
<summary><b>Nemo Overview</b></summary>

- **Desktop Environment:** Cinnamon (but works perfectly on GNOME)
- **Best For:** Users who want more features than Nautilus but less complexity than Dolphin
- **Similar To:** Nautilus with added functionality
- **Pros:**
  - Familiar Nautilus-like interface
  - Minimal configuration needed
  - Works out-of-the-box on GNOME
  - Good balance of features and simplicity
  - No KDE dependencies
- **Cons:**
  - Fewer features than Dolphin
  - Less customizable than Dolphin
  - Smaller plugin ecosystem

</details>

<details>
<summary><b>Other Options (Not Recommended for Beginners)</b></summary>

- **Thunar** - Lightweight but basic
- **PCManFM** - Very minimal, lacks features
- **Krusader** - Feature-rich but complex (dual-pane focused)
- **Nautilus (Files)** - Default, but too limited

</details>

---

## **3. Recommended: Dolphin File Manager**

**Dolphin** is the file manager from KDE Plasma. It provides a Windows Explorer-like experience with features including split view, integrated terminal, and tabbed browsing.

### **3.1. Why Dolphin?**

<details>
<summary><b>Dolphin brings back all the features Windows users expect</b></summary>

✅ **Split view / Dual pane** - View two folders side by side
✅ **Integrated terminal** - F4 opens terminal in current folder
✅ **Rich context menus** - Extensive right-click options
✅ **Information panel** - Detailed file metadata and previews
✅ **Tabs** - Open multiple locations in tabs
✅ **Customizable toolbar** - Add/remove actions as needed
✅ **Detailed status bar** - File counts, sizes, free space
✅ **Extensive keyboard shortcuts** - Power user friendly
✅ **Plugin support** - Version control integration, file properties, etc.
✅ **Network support** - Easy SMB, FTP, SSH browsing
✅ **Breadcrumb navigation** - Just like Windows
✅ **Search as you type** - Fast inline searching
✅ **Hidden file toggle** - Easy show/hide with Ctrl+H

</details>

### **3.2. Installing Dolphin on GNOME**

Since Dolphin is a KDE application, some KDE dependencies are needed to ensure it works smoothly on GNOME.

<details>
<summary><b>Step 1: Install Dolphin and Required KDE Components</b></summary>

Open a terminal and run:
```bash
sudo apt update
sudo apt install dolphin kde-standard kde-cli-tools kio kio-extras breeze-icon-theme
```

**What each package does:**

- **dolphin** - The file manager itself
- **kde-standard** - Standard KDE applications and tools
- **kde-cli-tools** - Command-line tools for KDE integration
- **kio** - KDE's I/O framework (enables network protocols, trash, etc.)
- **kio-extras** - Additional KIO protocols (SMB, FTP, SSH, etc.)
- **breeze-icon-theme** - KDE's icon theme for proper icon display

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>

```bash
sudo dnf install dolphin kde-cli-tools kio-extras breeze-icon-theme
```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>

```bash
sudo pacman -S dolphin kde-cli-tools kio-extras breeze-icons
```

</details>

<details>
<summary><b>openSUSE</b></summary>

```bash
sudo zypper install dolphin kde-cli-tools kio-extras breeze-icons
```

</details>

<details>
<summary><b>⚠️ IMPORTANT: Display Manager Selection</b></summary>

During installation, you'll be asked to choose a **display manager** (the login screen):

**When prompted, choose `gdm3`. Do NOT select `sddm`.**

- **GDM3** - GNOME Display Manager (what you're currently using)
- **SDDM** - KDE's display manager (switching to this will change your login screen and may cause issues)

**Why?** You want to keep your GNOME login screen and session. Selecting SDDM would switch your entire system to a KDE-oriented setup.

**If you accidentally selected SDDM:**

You can switch back by running:
```bash
sudo dpkg-reconfigure gdm3
```

Then select `gdm3` when prompted.

</details>

<details>
<summary><b>Step 2: Install Plasma Integration (Optional)</b></summary>

For Full integration, install:
```bash
sudo apt install plasma-integration
```

**What this provides:**

- Full file dialogs in KDE apps
- Complete theme consistency

</details>

<details>
<summary><b>Step 3: Install Qt Theming Tools</b></summary>

To make Dolphin (and other Qt applications) look good in GNOME, Qt theming support is needed:
```bash
sudo apt install qt5-style-plugins qt5ct
```

**What these packages do:**

- **qt5-style-plugins** - Provides Qt5 style plugins for theming
- **qt5ct** - Qt5 Configuration Tool (allows you to set Qt themes manually)

</details>

<details>
<summary><b>Step 4: Configure Qt Platform Theme</b></summary>

Now Qt applications need to be configured to use `qt5ct` for theming.

#### **Method 1: System-Wide Configuration (Recommended)**

**1️⃣ Open `/etc/environment` with a text editor**

You need root permissions:
```bash
sudo nano /etc/environment
```

*Or if you prefer a GUI editor:*
```bash
sudo gedit /etc/environment
```

**2️⃣ Add the environment variable**

At the **end of the file**, add this line:
```ini
QT_QPA_PLATFORMTHEME=qt5ct
```

**⚠️ Important Notes:**

- **Don't remove existing lines** - Only add this new line
- **No spaces around `=`** - The format must be exactly `KEY=VALUE`
- **Each variable on its own line** - Don't combine with other variables

**Example `/etc/environment` file:**
```ini
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
QT_QPA_PLATFORMTHEME=qt5ct
```

**3️⃣ Save and exit**

- In `nano`: Press `Ctrl+O` to save, then `Ctrl+X` to exit
- In `gedit`: Click Save and close the window

**4️⃣ Apply changes**

Log out of your GNOME session and log back in for changes to take effect.

#### **Method 2: User-Specific Configuration (If Method 1 Doesn't Work)**

If the system-wide method doesn't work for some reason, use this user-specific approach:

**1️⃣ Create systemd user environment directory and file**
```bash
mkdir -p ~/.config/environment.d
nano ~/.config/environment.d/90-qt5ct.conf
```

**2️⃣ Add the environment variable**

In the file, add:
```ini
QT_QPA_PLATFORMTHEME=qt5ct
```

**⚠️ Important:**

- **No `export` keyword** - Just `KEY=VALUE` format
- **File name can start with a number** - This controls load order (90 loads late, which is good)

**3️⃣ Save and exit**

Press `Ctrl+O` to save, then `Ctrl+X` to exit.

**4️⃣ Reload systemd user environment**

Log out of your GNOME session and log back in.

</details>

<details>
<summary><b>Step 5: Configure Qt5ct (Qt Theme Settings)</b></summary>

Now that Qt applications know to use `qt5ct`, let's configure the theme:

**1️⃣ Launch Qt5 Settings**
```bash
qt5ct
```

Or search for "Qt5 Settings" in your application menu.

**2️⃣ Configure Appearance**

In the **Appearance** tab:

- **Style:** Select **Breeze** or **gtk2** (for GNOME integration)
  - **Breeze** - KDE's native style (clean and modern)
  - **gtk2** - Attempts to match your GTK theme (better GNOME integration)
- **Palette:**
  - Select **Default** for light theme
  - Or choose a custom palette to match your GNOME theme
- **Font:** Adjust if needed to match GNOME fonts

**3️⃣ Configure Icon Theme**

In the **Icon Theme** tab:

- Select **breeze** or **Adwaita** (GNOME's default icons)
- This ensures icons look consistent with your GNOME desktop

**4️⃣ Configure Fonts**

In the **Fonts** tab:

- Set to match your GNOME font settings
- Default is usually fine: **Sans Serif, 10pt**

**5️⃣ Apply and Save**

Click **Apply** and close Qt5ct.

</details>

<details>
<summary><b>Step 6: Verify Installation</b></summary>

**1️⃣ Launch Dolphin**
```bash
dolphin
```

Or search for "Dolphin" in your application menu.

**2️⃣ Check Integration**

- Dolphin should open with a clean interface
- Icons should match your GNOME theme
- No visual glitches or missing elements

**3️⃣ Test Features**

- Press **F4** - Integrated terminal should appear at bottom
- Press **F3** - Split view should activate (dual pane)
- Press **Ctrl+H** - Hidden files should toggle
- Right-click a file - Context menu should appear with many options

✅ **If everything works, you're all set!**

</details>

---

### **3.3. Applying Dark Theme to Dolphin (Optional)**

If you prefer a dark theme (similar to Windows 11's dark mode), Dolphin can be fully themed to match your preferences.

<details>
<summary><b>Why Apply a Custom Dark Theme?</b></summary>

While Qt5ct provides basic theming, Dolphin's file viewing area often remains white/light even with dark system themes. This comprehensive dark theme guide ensures every part of Dolphin—from the file list to menus to scrollbars—uses a consistent dark color scheme, just like Windows 11's dark mode.

</details>

<details>
<summary><b>Prerequisites Check</b></summary>

Make sure you have these packages installed (most should already be installed from earlier steps):
```bash
sudo apt install qt5ct qt5-style-plugins breeze breeze-cursor-theme
```

</details>

<details>
<summary><b>Step 1: Configure Qt5ct for Dark Theme Foundation</b></summary>

Before applying the custom stylesheet, configure Qt5ct for dark colors:

**1️⃣ Open Qt5 Settings**
```bash
qt5ct
```

**2️⃣ Configure Dark Appearance**

In the **Appearance** tab:

- **Style:** Select **"Fusion"** (works best with dark themes)
- **Palette:** Select **"Custom"** (this enables the color scheme options)
- **Color scheme:** Select **"darker"** (provides dark base colors)
- Click **Apply** and **OK**

**⚠️ Important:** In the **Style Sheets** tab, ensure that there are **no style sheets activated**. Any active style sheets can interfere with the dark theme configuration and cause visual inconsistencies.

**3️⃣ Test Dolphin**

Open Dolphin to see the basic dark theme applied. However, you'll notice some areas (especially the file viewing area) may still have light backgrounds. That's where the custom stylesheet comes in!

</details>

<details>
<summary><b>Step 2: Create Custom Dark Stylesheet</b></summary>

This stylesheet provides comprehensive dark theming for every element in Dolphin:

**Option 1: Download the stylesheet (Recommended)**

```bash
# Download the pre-configured dark theme
curl -o ~/.config/dolphin-dark.qss https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/file-manager/dolphin-dark.qss
```

**Option 2: Create it manually**

**1️⃣ Create the stylesheet file:**
```bash
nano ~/.config/dolphin-dark.qss
```

**2️⃣ Paste the complete stylesheet:**
```css
/* Main view area - dark background */
DolphinViewContainer > DolphinView > QAbstractScrollArea {
    background-color: #1e1e1e;
    color: #e0e0e0;
}

/* File/folder list views */
QListView, QTreeView, QTableView {
    background-color: #1e1e1e;
    color: #e0e0e0;
    border: none;
    selection-background-color: #0d7377;
    selection-color: #ffffff;
    alternate-background-color: #252525;
}

/* Items on hover */
QListView::item:hover, QTreeView::item:hover, QTableView::item:hover {
    background-color: #2d2d2d;
}

/* Selected items */
QListView::item:selected, QTreeView::item:selected, QTableView::item:selected {
    background-color: #0d7377;
    color: #ffffff;
}

/* Scrollbars */
QScrollBar:vertical, QScrollBar:horizontal {
    background-color: #1e1e1e;
    width: 12px;
    height: 12px;
}

QScrollBar::handle:vertical, QScrollBar::handle:horizontal {
    background-color: #3e3e3e;
    border-radius: 6px;
    min-height: 20px;
}

QScrollBar::handle:vertical:hover, QScrollBar::handle:horizontal:hover {
    background-color: #4e4e4e;
}

/* Text input fields */
QLineEdit, QTextEdit, QPlainTextEdit {
    background-color: #2d2d2d;
    color: #e0e0e0;
    border: 1px solid #3e3e3e;
    border-radius: 3px;
    padding: 3px;
}

QLineEdit:focus, QTextEdit:focus, QPlainTextEdit:focus {
    border: 1px solid #0d7377;
}

/* Status bar at bottom */
QStatusBar {
    background-color: #252525;
    color: #b0b0b0;
}

/* Toolbar */
QToolBar {
    background-color: #2d2d2d;
    border: none;
    spacing: 3px;
}

/* Buttons */
QPushButton {
    background-color: #2d2d2d;
    color: #e0e0e0;
    border: 1px solid #3e3e3e;
    border-radius: 3px;
    padding: 5px 10px;
}

QPushButton:hover {
    background-color: #3e3e3e;
}

QPushButton:pressed {
    background-color: #0d7377;
}

/* Context menus */
QMenu {
    background-color: #2d2d2d;
    color: #e0e0e0;
    border: 1px solid #3e3e3e;
}

QMenu::item:selected {
    background-color: #0d7377;
}

/* Headers in detailed view */
QHeaderView::section {
    background-color: #252525;
    color: #b0b0b0;
    border: none;
    padding: 5px;
}
```

**3️⃣ Save and exit:**

Press `Ctrl+X`, then `Y`, then `Enter`

</details>

<details>
<summary><b>Step 3: Test the Dark Theme</b></summary>

Before making it permanent, test the stylesheet:
```bash
dolphin -stylesheet ~/.config/dolphin-dark.qss
```

Dolphin should open with a complete dark theme applied to all areas. If it looks good, proceed to make it permanent!

</details>

<details>
<summary><b>Step 4: Make Dark Theme Permanent</b></summary>

To apply the dark theme automatically every time Dolphin opens (from dock, application menu, keyboard shortcut, etc.):

**1️⃣ Get your username:**
```bash
echo $USER
```

Remember this output (e.g., "john", "sarah", "alex", etc.)

**2️⃣ Copy Dolphin's launcher to your local applications:**
```bash
cp /usr/share/applications/org.kde.dolphin.desktop ~/.local/share/applications/
```

**3️⃣ Edit the launcher file:**
```bash
nano ~/.local/share/applications/org.kde.dolphin.desktop
```

**4️⃣ Find and modify the Exec line:**

Look for the line starting with `Exec=` (usually appears as `Exec=dolphin %u`)

**Change it to include the stylesheet:**

**Before:**
```ini
Exec=dolphin %u
```

**After (replace `YOUR_USERNAME` with your actual username):**
```ini
Exec=dolphin -stylesheet /home/YOUR_USERNAME/.config/dolphin-dark.qss %u
```

**Example:** If your username is "john":
```ini
Exec=dolphin -stylesheet /home/john/.config/dolphin-dark.qss %u
```

**5️⃣ Save and exit:**

Press `Ctrl+X`, then `Y`, then `Enter`

**6️⃣ Update the desktop database:**
```bash
update-desktop-database ~/.local/share/applications
```

**7️⃣ Test the permanent theme:**

- Close all Dolphin windows
- Open Dolphin from your application menu or dock
- The dark theme should apply automatically!

</details>

<details>
<summary><b>Customizing Your Dark Theme</b></summary>

**Change the Accent Color:**

The default accent color is teal (`#0d7377`). To change it:

1. Open the stylesheet:
```bash
   nano ~/.config/dolphin-dark.qss
```

2. Find and replace all instances of `#0d7377` with your preferred color:
   - **Blue:** `#4a90e2` (Windows 11-like blue)
   - **Purple:** `#7c3aed`
   - **Green:** `#10b981`
   - **Red:** `#ef4444`
   - **Orange:** `#f59e0b`
   - **Custom:** Use any hex color code

3. Save and reopen Dolphin

**Adjust Background Darkness:**

You can make backgrounds lighter or darker by changing these values in the stylesheet:

- **Main background:** `#1e1e1e`
  - Darker: `#121212` or `#0d0d0d`
  - Lighter: `#2a2a2a` or `#333333`
- **Secondary background:** `#2d2d2d`
- **Tertiary background:** `#252525`

Lower hex values = darker, higher values = lighter

</details>

<details>
<summary><b>Dark Theme Troubleshooting</b></summary>

**Problem: Theme doesn't apply when opening from dock/menu**

**Solution:**
- Verify you replaced `YOUR_USERNAME` with your actual username in the Exec line
- Run `update-desktop-database ~/.local/share/applications`
- Close ALL Dolphin windows before testing
- Log out and back in if still not working

**Problem: Dolphin still has white/light background**

**Solution:**
1. Verify stylesheet exists:
```bash
   cat ~/.config/dolphin-dark.qss
```
2. Test manually:
```bash
   dolphin -stylesheet ~/.config/dolphin-dark.qss
```
3. Check desktop file for typos:
```bash
   grep "Exec=" ~/.local/share/applications/org.kde.dolphin.desktop
```

**Problem: Only some parts are dark, others remain light**

**Solution:**
- Make sure you completed **both** Qt5ct configuration AND the stylesheet
- Restart Dolphin completely (close all windows)
- Check that Qt5ct palette is set to "darker"

**Reverting to Light Theme:**

To remove the dark theme:
```bash
# Remove custom launcher
rm ~/.local/share/applications/org.kde.dolphin.desktop
update-desktop-database ~/.local/share/applications

# Optionally remove stylesheet
rm ~/.config/dolphin-dark.qss

# Reset Qt5ct (open qt5ct and set to default style/palette)
```

</details>

---

### **3.4. Configuring Dolphin for Windows-Like Experience**

Now let's configure Dolphin to feel more like Windows Explorer:

<details>
<summary><b>Essential Settings</b></summary>

**1️⃣ Open Settings**

In Dolphin, go to: **Settings → Configure Dolphin** (or press `Ctrl+Shift+,`)

**2️⃣ General Settings - Startup Tab:**
- **Show on startup:** Choose your preferred start location
  - Home folder (like Windows My Documents)
  - A custom folder
  - Or "Remember location from last time"

**3️⃣ General Settings - Behavior Tab:**
- **Show selection marker:** ✅ Enabled (shows checkboxes for files)
- **Rename inline:** ✅ Enabled (click name to rename, like Windows)
- **Open folders during drag operations:** ✅ Enabled (Windows behavior)
- **Double-click to open files and folders:** ✅ Enabled (Windows default)

**4️⃣ View Modes - Icons Tab:**
- Configure icon sizes and spacing to your preference
- Windows users typically prefer: **Medium icons (48-64px)**

**5️⃣ View Modes - Details Tab (Recommended for Windows Users):**
- **Use as default view mode:** ✅ Enabled
- This gives you a Windows Explorer-style list view with columns
- **Expandable folders:** ✅ Enabled (tree view like Windows)

**6️⃣ Navigation - General Tab:**
- **Show full path in title bar:** ✅ Enabled (like Windows)
- **Editable location bar:** ✅ Enabled (click path to edit, like Windows Alt+D)

**7️⃣ Navigation - Location Bar:**
- Choose **Breadcrumb** for Windows-style navigation
- Or **Editable** for classic path bar

**8️⃣ Information Panel**

Go to: **View → Panels → Information**

This adds a side panel showing:
- File preview
- Detailed metadata
- File size and dates
- Comments

Similar to Windows Explorer's Details pane!

**9️⃣ Status Bar**

Ensure status bar is visible: **Settings → Show Statusbar** (or `Ctrl+Alt+M`)

Status bar shows:
- Number of items in folder
- Total size of selected files
- Free disk space
- Loading indicators

**🔟 Toolbar Customization**

Right-click the toolbar → **Configure Toolbars**

Add frequently used actions:
- **Copy** / **Paste** / **Cut**
- **New Folder**
- **Delete**
- **Properties**
- **Split View**
- **Terminal**

Arrange them like Windows' Quick Access Toolbar!

</details>

---

### **3.5. Essential Dolphin Keyboard Shortcuts**

<details>
<summary><b>Keyboard Shortcuts Reference</b></summary>

These shortcuts will make you productive immediately:

| Action | Shortcut | Windows Equivalent |
|--------|----------|-------------------|
| Focus address bar | `Ctrl+L` | `Alt+D` (can be remapped) |
| Show hidden files | `Ctrl+H` | N/A |
| New folder | `F10` or `Ctrl+Shift+N` | `Ctrl+Shift+N` |
| New tab | `Ctrl+T` | `Ctrl+T` |
| Close tab | `Ctrl+W` | `Ctrl+W` |
| Properties | `Alt+Enter` | `Alt+Enter` |
| Rename | `F2` | `F2` |
| Delete | `Del` | `Del` |
| Refresh | `F5` | `F5` |
| Search | `Ctrl+F` | `Ctrl+F` |
| Go up one folder | `Alt+Up` | `Alt+Up` |
| Go back | `Alt+Left` | `Alt+Left` |
| Go forward | `Alt+Right` | `Alt+Right` |
| **Split view (dual pane)** | **F3** | N/A (Windows doesn't have this!) |
| **Integrated terminal** | **F4** | N/A |
| Select all | `Ctrl+A` | `Ctrl+A` |
| Invert selection | `Ctrl+Shift+A` | N/A |

**Pro Tip:** You can customize any keyboard shortcut in **Settings → Configure Shortcuts**.

</details>

---

### **3.6. Advanced Dolphin Features**

<details>
<summary><b>📁 Split View / Dual Pane (F3)</b></summary>

- View two folders side by side
- Perfect for copying/moving files between locations
- Each pane can have different views (icons, details, etc.)
- Independent navigation per pane

</details>

<details>
<summary><b>⌨️ Integrated Terminal (F4)</b></summary>

- Built-in terminal at the bottom
- Automatically follows your current folder
- Run commands without leaving the file manager
- Perfect for advanced operations

</details>

<details>
<summary><b>🌐 Network Browsing</b></summary>

Dolphin natively supports:
- **SMB/Windows shares:** `smb://server/share`
- **FTP:** `ftp://server`
- **SFTP/SSH:** `sftp://user@server` or `fish://user@server`
- **WebDAV:** `webdav://server`

Just type these in the address bar!

</details>

<details>
<summary><b>🔍 Advanced Search</b></summary>

- Search by name, content, date, size, type
- Save searches for reuse
- Filter by multiple criteria simultaneously

</details>

<details>
<summary><b>🎨 Customizable Context Menus</b></summary>

Install "Service Menus" to add custom actions:
- Compress files to various formats
- Convert images
- Send files via email
- Open in specific applications
- Run custom scripts

**To add service menus:**
Search online for "Dolphin service menus" - many are available for download.

</details>

<details>
<summary><b>📋 Batch Rename</b></summary>

Select multiple files → Right-click → **Rename** (or `F2`)

Offers batch renaming:
- Number sequences
- Find and replace
- Insert text at positions
- Preview before applying

</details>

<details>
<summary><b>🔖 Places Panel</b></summary>

Bookmark frequently used locations:
- Drag folders to Places panel
- Quick access to any location
- Organize bookmarks into groups

</details>

---

### **3.7. Dolphin Tips for Windows Users**

<details>
<summary><b>Making Dolphin Feel Even More Like Windows</b></summary>

1. **Set Details View as Default:**
   - Settings → View Modes → Details → Use as default
   - This gives you the column-based view Windows users love

2. **Enable Tree View:**
   - View → Panels → Folders
   - This adds a folder tree on the left, just like Windows Explorer

3. **Show All File Extensions:**
   - Settings → Configure Dolphin → General → Show file extensions

4. **Adjust Icon Sizes:**
   - Use the slider in the toolbar (right side)
   - Or `Ctrl + Mouse Wheel` to zoom

5. **Customize Status Bar:**
   - Settings → Configure Dolphin → General → Status Bar
   - Enable "Show space information"

6. **Use Breadcrumb Navigation:**
   - Settings → Configure Dolphin → Navigation
   - Set to "Breadcrumb" mode
   - Click path segments to navigate, just like Windows

</details>

---

### **3.8. Shell Aliases for Quick Dolphin Access**

Add these convenient aliases to your shell configuration file (`.bashrc` for bash or `.zshrc` for zsh):

<details>
<summary><b>Bash Users (~/.bashrc)</b></summary>

```bash
# Open current directory in Dolphin
alias open='dolphin . &>/dev/null & disown'

# Open Dolphin with dark theme applied automatically
alias dolphin='dolphin -stylesheet ~/.config/dolphin-dark.qss'

# Open specific directory in Dolphin
alias d='dolphin'
```

**To apply changes:**
```bash
source ~/.bashrc
```

</details>

<details>
<summary><b>Zsh Users (~/.zshrc)</b></summary>

```bash
# Open current directory in Dolphin
alias open='dolphin . &>/dev/null & disown'

# Open Dolphin with dark theme applied automatically
alias dolphin='dolphin -stylesheet ~/.config/dolphin-dark.qss'

# Open specific directory in Dolphin
alias d='dolphin'
```

**To apply changes:**
```bash
source ~/.zshrc
```

</details>

**Usage Examples:**

```bash
# Open current directory
open

# Open Dolphin without arguments (opens home)
d

# Open specific directory
d /var/log

# Open Downloads folder
d ~/Downloads
```

> **Note:** The `open` alias mimics macOS behavior, and the second `dolphin` alias automatically applies your dark theme if configured. If you haven't set up the dark theme, remove the `-stylesheet` parameter.

> **Tip:** For keyboard shortcut configuration to detect Dolphin windows (e.g., with AutoKey), see the [Shortcuts Mapping guide](../shortcuts-mapping/README.md).

---

## **4. Alternative: Nemo File Manager**

If Dolphin feels too complex or you want something that requires less configuration, **Nemo** is an excellent alternative.

### **4.1. Why Nemo?**

<details>
<summary><b>Nemo Features Overview</b></summary>

Nemo is a fork of Nautilus (GNOME Files) created by Linux Mint. It keeps Nautilus's simplicity while adding essential features:

✅ **Familiar interface** - Looks like Nautilus, feels like an improved Windows Explorer
✅ **Minimal configuration needed** - Works great out of the box
✅ **No KDE dependencies** - Lightweight installation on GNOME
✅ **Dual pane view** - Split screen functionality
✅ **Better context menus** - More right-click options than Nautilus
✅ **Customizable toolbar** - Add/remove actions
✅ **Plugin support** - Extensions for added functionality
✅ **Traditional menu bar** - File/Edit/View menus like classic Windows
✅ **Better file operations** - Progress dialog, queue management

</details>

### **4.2. Installing Nemo**

Installation is straightforward—no complex dependencies:

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Mint</b></summary>

```bash
sudo apt update
sudo apt install nemo nemo-fileroller
```

</details>

<details>
<summary><b>Fedora</b></summary>

```bash
sudo dnf install nemo nemo-fileroller
```

</details>

<details>
<summary><b>Arch Linux</b></summary>

```bash
sudo pacman -S nemo nemo-fileroller
```

</details>

<details>
<summary><b>openSUSE</b></summary>

```bash
sudo zypper install nemo nemo-fileroller
```

</details>

**What gets installed:**

- **nemo** - The file manager
- **nemo-fileroller** - Archive integration (zip, tar, etc.)

<details>
<summary><b>Optional Recommended Packages</b></summary>
```bash
# Image preview and manipulation
sudo apt install nemo-image-converter

# Audio/video preview
sudo apt install nemo-audio-tab

# Dropbox integration (if you use Dropbox)
sudo apt install nemo-dropbox

# Advanced bulk renaming
sudo apt install nemo-bulk-renamer

# Share files via email/social media
sudo apt install nemo-share
```

</details>

---

### **4.3. Configuring Nemo**

Nemo works well out of the box, but here are some recommended settings:

<details>
<summary><b>Configuration Steps</b></summary>

**1️⃣ Open Preferences**

In Nemo: **Edit → Preferences** (or press `Ctrl+,`)

**2️⃣ Views Tab**

- **Default view:** Choose **List View** for Windows-style details
- **Sort folders before files:** ✅ Enabled (Windows behavior)
- **Show hidden and backup files:** ❌ Disabled (toggle with `Ctrl+H` as needed)

**3️⃣ Behavior Tab**

- **Single click to open items:** ❌ Disabled (use double-click like Windows)
- **Open each folder in a new window:** ❌ Disabled (use tabs/same window)
- **Ask before emptying the Trash:** ✅ Enabled (safety)

**4️⃣ Display Tab**

- **Format:** Choose your preferred date/time format
- **Show full path in title bar:** ✅ Enabled (see current location)

**5️⃣ Toolbar Tab**

Customize what appears in the toolbar:
- **Back/Forward buttons:** ✅ Enabled
- **Up button:** ✅ Enabled (go to parent folder)
- **Search:** ✅ Enabled
- **Reload:** Optional

</details>

---

### **4.4. Nemo Features**

<details>
<summary><b>Key Nemo Features</b></summary>

**Dual Pane View (F3):**
- Press `F3` to split the window
- View and manage two folders simultaneously
- Perfect for file transfers

**Menu Bar:**
- Traditional File/Edit/View menus
- Access all functions easily
- More discoverable than hidden menus

**Better Archive Handling:**
- Right-click → **Compress** to create archives
- Supports ZIP, TAR.GZ, 7Z, and more
- Right-click archives → **Extract Here** or **Extract To**

**Plugin Ecosystem:**
- Many community plugins available
- Easy to install via package manager
- Extends functionality without complexity

</details>

---

## **5. Setting Your Default File Manager**

Once you've installed and configured Dolphin or Nemo, you'll want to make it your default file manager.

### **5.1. Set Default File Manager via Command Line**

To ensure your chosen file manager opens for all file browsing operations, you need to set it as the default for multiple MIME types (file associations).

<details>
<summary><b>For Dolphin</b></summary>

Run these commands to set Dolphin as default for all directory-related MIME types:
```bash
xdg-mime default org.kde.dolphin.desktop inode/directory
xdg-mime default org.kde.dolphin.desktop application/x-directory
xdg-mime default org.kde.dolphin.desktop x-directory/normal
xdg-mime default org.kde.dolphin.desktop application/x-gnome-saved-search
```

**Or use this one-liner:**
```bash
xdg-mime default org.kde.dolphin.desktop inode/directory && xdg-mime default org.kde.dolphin.desktop application/x-directory && xdg-mime default org.kde.dolphin.desktop x-directory/normal && xdg-mime default org.kde.dolphin.desktop application/x-gnome-saved-search
```

**Why multiple MIME types?**

Different applications and contexts use different MIME types to refer to directories:
- `inode/directory` - Standard directory MIME type
- `application/x-directory` - Alternative directory designation
- `x-directory/normal` - Legacy directory type
- `application/x-gnome-saved-search` - GNOME search results

Setting all of them ensures Dolphin opens in every scenario—clicking folders, opening from applications, search results, etc.

</details>

<details>
<summary><b>For Nemo</b></summary>
```bash
xdg-mime default nemo.desktop inode/directory
xdg-mime default nemo.desktop application/x-directory
xdg-mime default nemo.desktop x-directory/normal
xdg-mime default nemo.desktop application/x-gnome-saved-search
```

**Or one-liner:**
```bash
xdg-mime default nemo.desktop inode/directory && xdg-mime default nemo.desktop application/x-directory && xdg-mime default nemo.desktop x-directory/normal && xdg-mime default nemo.desktop application/x-gnome-saved-search
```

</details>

<details>
<summary><b>Verify it Worked</b></summary>

Check each MIME type:
```bash
xdg-mime query default inode/directory
xdg-mime query default application/x-directory
xdg-mime query default x-directory/normal
xdg-mime query default application/x-gnome-saved-search
```

All should output:
- `org.kde.dolphin.desktop` (if you chose Dolphin)
- `nemo.desktop` (if you chose Nemo)

**Quick verification:**

If all four commands return the same file manager, you're all set! If any return different results or `nautilus.desktop`, re-run the `xdg-mime default` commands above.

</details>

---

### **5.2. Set Default File Manager via GUI (Alternative Method)**

<details>
<summary><b>Using GNOME Settings</b></summary>

1. Open **Settings** → **Default Applications**
2. Look for **File Manager** or **Files**
3. Select **Dolphin** or **Nemo** from the dropdown

*Note: Not all GNOME versions show this option directly.*

</details>

<details>
<summary><b>Using `mimeapps.list` file</b></summary>

1. Open the file:
```bash
   nano ~/.config/mimeapps.list
```

2. Find or add these lines under `[Default Applications]`:

   **For Dolphin:**
```ini
   inode/directory=org.kde.dolphin.desktop
   application/x-gnome-saved-search=org.kde.dolphin.desktop
```

   **For Nemo:**
```ini
   inode/directory=nemo.desktop
   application/x-gnome-saved-search=nemo.desktop
```

3. Save and exit (`Ctrl+O`, then `Ctrl+X`)

</details>

---

### **5.3. Create a Keyboard Shortcut to Open File Manager**

<details>
<summary><b>Windows users are accustomed to `Win+E` opening File Explorer. Let's recreate that:</b></summary>

**1️⃣ Open GNOME Settings**

Go to: **Settings → Keyboard → Keyboard Shortcuts**

**2️⃣ Scroll to Custom Shortcuts**

Click **Custom Shortcuts** at the bottom

**3️⃣ Add New Shortcut**

Click the **+** button to add a custom shortcut

**4️⃣ Configure the Shortcut**

- **Name:** `Open File Manager` (or any name you like)
- **Command:**
  - For Dolphin: `dolphin`
  - For Nemo: `nemo`
- **Shortcut:** Press `Super+E`

**5️⃣ Save and Test**

- Click **Add**
- Press `Super+E` to test
- Your chosen file manager should open!

</details>

---

## **6. Troubleshooting**

### **6.1. Dolphin Issues**

<details>
<summary><b>Dolphin looks ugly / has wrong icons</b></summary>

**Solution:**

1. Make sure `breeze-icon-theme` is installed:
```bash
   sudo apt install breeze-icon-theme
```

2. Configure Qt5ct:
```bash
   qt5ct
```
   - Set Icon Theme to **breeze** or **Adwaita**
   - Set Style to **Breeze** or **gtk2**

3. Verify `QT_QPA_PLATFORMTHEME=qt5ct` is set:
```bash
   echo $QT_QPA_PLATFORMTHEME
```
   Should output: `qt5ct`

   If not, check `/etc/environment` or `~/.config/environment.d/90-qt5ct.conf`

</details>

<details>
<summary><b>Dolphin crashes or won't open</b></summary>

**Solution:**

1. Check if KIO is working:
```bash
   kbuildsycoca5 --noincremental
```

2. Reset Dolphin configuration:
```bash
   mv ~/.config/dolphinrc ~/.config/dolphinrc.backup
   mv ~/.local/share/dolphin ~/.local/share/dolphin.backup
```
   Then restart Dolphin

3. Check for error messages:
```bash
   dolphin
```
   (Run from terminal to see error output)

</details>

<details>
<summary><b>Dolphin's integrated terminal doesn't work</b></summary>

**Solution:**

1. Install Konsole (KDE's terminal):
```bash
   sudo apt install konsole
```

2. Or set your preferred terminal in Dolphin settings:
   - Settings → Configure Dolphin → General → Terminal
   - Choose your preferred terminal application

</details>

<details>
<summary><b>Display manager changed to SDDM accidentally</b></summary>

**Solution:**

Switch back to GDM3:
```bash
sudo dpkg-reconfigure gdm3
```

Select **gdm3** when prompted, then reboot.

</details>

---

### **6.2. Nemo Issues**

<details>
<summary><b>Nemo and Nautilus both running</b></summary>

**Solution:**

This usually happens when GNOME is trying to manage the desktop with Nautilus.

Disable Nautilus desktop handling:
```bash
gsettings set org.gnome.desktop.background show-desktop-icons false
```

Or completely disable Nautilus from starting:
```bash
mkdir -p ~/.config/autostart
cp /etc/xdg/autostart/org.gnome.Nautilus.desktop ~/.config/autostart/
echo "Hidden=true" >> ~/.config/autostart/org.gnome.Nautilus.desktop
```

</details>

<details>
<summary><b>Nemo won't become default file manager</b></summary>

**Solution:**

Force set Nemo as default:
```bash
xdg-mime default nemo.desktop inode/directory
xdg-mime default nemo.desktop application/x-gnome-saved-search

# Also update mimeapps.list
echo "inode/directory=nemo.desktop" >> ~/.config/mimeapps.list
echo "application/x-gnome-saved-search=nemo.desktop" >> ~/.config/mimeapps.list
```

Then log out and log back in.

</details>

---

### **6.3. General Issues**

<details>
<summary><b>File manager doesn't open when clicking folders</b></summary>

**Solution:**

1. Check what's currently set as default:
```bash
   xdg-mime query default inode/directory
```

2. Re-set your preferred file manager (see Section 5.1)

3. Update desktop database:
```bash
   update-desktop-database ~/.local/share/applications
```

4. Log out and log back in

</details>

<details>
<summary><b>Icons missing in file manager</b></summary>

**Solution:**

Install a complete icon theme:
```bash
# For Dolphin
sudo apt install breeze-icon-theme

# For Nemo (or general use)
sudo apt install gnome-icon-theme-full
```

Then select the icon theme in:
- **Qt5ct** (for Dolphin)
- **GNOME Tweaks → Appearance → Icons** (for Nemo)

</details>

---

## **Final Recommendations**

### **Choose Dolphin if you:**

- ✅ Want a **feature-rich** file manager with maximum customization
- ✅ Need **advanced features** like integrated terminal and extensive customization
- ✅ Are willing to invest time in initial setup and configuration
- ✅ Want features **beyond** what Windows Explorer offers
- ✅ Don't mind installing KDE dependencies
- ✅ Are a **power user** who uses keyboard shortcuts extensively

---

### **Choose Nemo if you:**

- ✅ Want something **better than Nautilus** but simpler than Dolphin
- ✅ Prefer **minimal configuration** - just install and use
- ✅ Want **GTK-native** application (better GNOME integration)
- ✅ Don't need advanced features like integrated terminal
- ✅ Want a good **balance** between features and simplicity
- ✅ Are coming from Windows and want familiar features without overwhelming options

---

### **Stick with Nautilus if you:**

- ✅ Prefer **absolute minimalism**
- ✅ Don't need dual-pane, terminal, or advanced features
- ✅ Want the **lightest** possible solution
- ✅ Are happy with very basic file management

---

## **Quick Start Reference**

<details>
<summary><b>For Dolphin</b></summary>
```bash
# Install
sudo apt install dolphin kde-standard kde-cli-tools kio kio-extras breeze-icon-theme
sudo apt install plasma-integration  # Optional but recommended
sudo apt install qt5-style-plugins qt5ct

# Configure Qt theme environment variable
echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment

# Set as default file manager (all MIME types for full compatibility)
xdg-mime default org.kde.dolphin.desktop inode/directory
xdg-mime default org.kde.dolphin.desktop application/x-directory
xdg-mime default org.kde.dolphin.desktop x-directory/normal
xdg-mime default org.kde.dolphin.desktop application/x-gnome-saved-search

# Log out and back in, then:
# 1. Run qt5ct to configure theme (choose Fusion style, darker palette)
# 2. Optionally apply dark theme (see section 3.3 for full dark theme setup)
```

</details>

<details>
<summary><b>For Nemo</b></summary>
```bash
# Install
sudo apt install nemo nemo-fileroller

# Optional plugins for enhanced functionality
sudo apt install nemo-image-converter nemo-audio-tab

# Set as default file manager (all MIME types for full compatibility)
xdg-mime default nemo.desktop inode/directory
xdg-mime default nemo.desktop application/x-directory
xdg-mime default nemo.desktop x-directory/normal
xdg-mime default nemo.desktop application/x-gnome-saved-search

# Done! No additional configuration needed
```

</details>

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [🖼️ Area Screenshot (Flameshot)](../area-screenshot/README.md) — Screenshot tool with annotation
- [📋 Clipboard History (CopyQ)](../clipboard-history/README.md) — Advanced clipboard manager
- [🐬 Dolphin Service Menus](../dolphin-menus/README.md) — Custom right-click actions for Dolphin
- [🐚 Editor-Like Shell (zsh-edit-select)](../editor-like-shell/README.md) — Edit your command line like a text editor — Shift+Arrow/mouse selection, copy/cut/paste/undo, and more
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🔍 OCR Clipboard](../ocr-clipboard/README.md) — Extract text from screenshots
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts
