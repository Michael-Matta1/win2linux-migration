# **Complete Guide: Transform GNOME Desktop to Feel Like Windows**

After years of using Windows, switching to Linux with GNOME can feel disorienting. The desktop layout, taskbar behavior, and window management work completely differently. This comprehensive guide will help you transform your GNOME desktop to closely match the Windows experience using extensions and built-in customization tools.

---

## 📑 **Table of Contents**

- [What This Guide Covers](#what-this-guide-covers)
- [Prerequisites](#1-prerequisites)
- [Installing GNOME Tweaks](#2-installing-gnome-tweaks)
- [Installing Extensions](#3-installing-extensions)
- [Essential Extensions](#4-essential-extensions-breakdown)
- [Optional Extensions](#5-optional-extensions)
- [Configuration Guide](#6-configuration-guide)
- [System Settings](#7-system-settings-customization)
- [Troubleshooting](#8-troubleshooting)
- [Setup Checklist](#9-complete-setup-checklist)
- [Final Tips](#10-final-tips-and-best-practices)

---

## **What This Guide Covers**

By the end of this guide, your GNOME desktop will have:

- ✅ A Windows-style taskbar at the bottom with window previews
- ✅ A start menu button in the bottom-left corner
- ✅ "Show Desktop" functionality
- ✅ Intelligent auto-hide for the taskbar and top bar
- ✅ Visual improvements like blur effects
- ✅ Better app search functionality
- ✅ Quick desktop shortcuts creation
- ✅ macOS-style menu (optional alternative)

---

## **1. Prerequisites**

### **Understanding GNOME Extensions**

GNOME Extensions are small programs that modify and enhance the GNOME desktop environment. They can change the appearance, add features, or modify existing functionality.

### **Required Tools**

Ensure you have:

1. **A GNOME-based Linux distribution** (Ubuntu, Pop!_OS, Fedora, etc.)
2. **Terminal access**
3. **Internet connection**

---

## **2. Installing GNOME Tweaks**

**GNOME Tweaks** (also called "Tweaks") is an essential utility application for customizing GNOME desktop environments. It provides access to many settings that aren't available in the standard Settings app.

### **Installation**

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Linux Mint</b></summary>
```bash
sudo apt update
sudo apt install gnome-tweaks
```

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>
```bash
sudo dnf install gnome-tweaks
```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>
```bash
sudo pacman -S gnome-tweaks
```

</details>

<details>
<summary><b>openSUSE</b></summary>

```bash
sudo zypper install gnome-tweaks
```

</details>

### **Launching Tweaks**

After installation, you can launch it by:
- Searching for "Tweaks" in your application menu
- Running `gnome-tweaks` in terminal

<details>
<summary><b>What Tweaks Allows You to Do</b></summary>

- Manage GNOME extensions (enable/disable)
- Customize fonts and appearance
- Configure window behavior
- Modify the top bar
- Change mouse and touchpad settings
- Adjust startup applications

</details>

---

## **3. Installing Extensions**

There are multiple ways to install GNOME extensions:

### **Method 1: Using Extension Manager (Recommended)**

Extension Manager is a modern, user-friendly app for managing GNOME extensions.

<details>
<summary><b>Installation via APT</b></summary>
```bash
sudo apt install gnome-shell-extension-manager
```

</details>

<details>
<summary><b>Installation via Flatpak</b></summary>
```bash
flatpak install flathub com.mattjakeman.ExtensionManager
```

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>

```bash
sudo dnf install gnome-extensions-app
```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>

```bash
sudo pacman -S extension-manager
```

Alternatively, install via Flatpak (see above).

</details>

<details>
<summary><b>openSUSE</b></summary>

```bash
sudo zypper install gnome-extensions
```

Alternatively, install via Flatpak (see above).

</details>

**Usage:**
1. Open **Extension Manager** from your applications
2. Browse or search for extensions
3. Click **Install** to add them
4. Toggle extensions on/off as needed

<details>
<summary><b>Method 2: Using extensions.gnome.org (Alternative)</b></summary>

1. Install browser integration:
```bash
   sudo apt install chrome-gnome-shell
```

2. Visit [extensions.gnome.org](https://extensions.gnome.org)
3. Install the browser extension when prompted
4. Search for extensions and toggle them on to install

</details>

<details>
<summary><b>Method 3: Manual Installation via Command Line</b></summary>

For advanced users, you can install extensions directly:
```bash
# Install gnome-shell-extensions package (provides common extensions)
sudo apt install gnome-shell-extensions

# For individual extensions, download and extract to:
~/.local/share/gnome-shell/extensions/
```

</details>

---

## **4. Essential Extensions Breakdown**

Here are the core extensions that will transform your GNOME desktop to feel like Windows:

### **4.1. Dash to Panel** ⭐⭐⭐

**Extension ID:** `dash-to-panel@jderose9.github.com`

**What it does:**
This is an essential extension for achieving a Windows-like experience. It combines the Activities button, application dash, and system tray into a single taskbar panel.

<details>
<summary><b>Windows Features it Brings</b></summary>

✅ **Taskbar-style panel** at the bottom (or top/sides if you prefer)
✅ **Window previews on hover** - Just like Windows, hover over an app icon to see thumbnail previews of open windows
✅ **Show Desktop button** - Click the button in the bottom-left corner (or wherever you position it) to minimize all windows and show the desktop
✅ **Grouped application windows** - Multiple windows of the same app group together under one icon
✅ **Running application indicators** - See which apps are currently running
✅ **Panel intellihide** - Automatically hide the panel until you hover over its area (like Windows auto-hide taskbar)
✅ **System tray integration** - All your system icons in one place
✅ **App launcher button** - Activities/Start menu access with a single click

</details>

**Installation:**
- Search for "Dash to Panel" in Extension Manager
- Or visit: https://extensions.gnome.org/extension/1160/dash-to-panel/

<details>
<summary><b>Important Note for Pop!_OS Users</b></summary>

Pop!_OS comes with its own dock called "Cosmic Dock" which **will conflict** with Dash to Panel. You must disable it:

1. Open **GNOME Tweaks** (or Extension Manager)
2. Find **"Cosmic Dock"** or **"Ubuntu Dock"** in the extensions list
3. Toggle it **OFF**
4. Log out and log back in (or restart GNOME with `Alt+F2`, type `r`, press Enter)

**For other Ubuntu-based systems:**
- Look for "Ubuntu Dock" and disable it similarly

</details>

---

### **4.2. Hide Top Bar**

**Extension ID:** `hidetopbar@mathieu.bidon.ca`

**What it does:**
Automatically hides the top bar (which contains the clock, system menu, and notifications) when not in use, giving you more screen real estate.

<details>
<summary><b>Windows Features it Brings</b></summary>

✅ **Auto-hide top panel** - Similar to how Windows can auto-hide the taskbar, this hides the top bar
✅ **More screen space** - Especially useful for laptops and smaller displays
✅ **Smart reveal** - Shows the top bar when you hover near it or press the Super key
✅ **Configurable hide behavior** - Choose when and how the bar should hide

</details>

<details>
<summary><b>Configuration Options</b></summary>

The extension offers extensive customization:
- **Intellihide** - Hide only when windows overlap the top bar
- **Always hide** - Hide the top bar at all times
- **Show on mouse hover** - Reveal when mouse approaches the top edge
- **Pressure sensitivity** - How hard you need to push the mouse to reveal it
- **Animation speed** - Control how fast it appears/disappears

</details>

**Installation:**
- Search for "Hide Top Bar" in Extension Manager
- Or visit: https://extensions.gnome.org/extension/545/hide-top-bar/

**Why This Matters:**
While Dash to Panel handles the taskbar at the bottom, the top bar in GNOME still takes up space. With this extension, you get a full-screen experience similar to Windows' maximized windows, but with the ability to access the top bar when needed.

---

### **4.3. Blur my Shell**

**Extension ID:** `blur-my-shell@aunetx`

**What it does:**
Adds beautiful blur effects to various parts of the GNOME Shell, making the interface feel more modern and polished—similar to Windows 11's acrylic/blur effects.

<details>
<summary><b>Windows Features it Brings</b></summary>

✅ **Modern visual aesthetics** - Blur effects similar to Windows 11
✅ **Improved readability** - Blurred backgrounds make text on panels more readable
✅ **Customizable transparency** - Control how much blur and transparency you want
✅ **Professional appearance** - Makes the desktop look more refined and premium

</details>

<details>
<summary><b>What Gets Blurred</b></summary>

- Overview background
- Panel (top bar and/or Dash to Panel taskbar)
- App folders
- Dash and dock
- Window thumbnails
- Screenshot UI
- Lockscreen

</details>

**Installation:**
- Search for "Blur my Shell" in Extension Manager
- Or visit: https://extensions.gnome.org/extension/3193/blur-my-shell/

<details>
<summary><b>Configuration Options</b></summary>

The extension has extensive settings to control:
- Blur intensity and brightness
- Which elements to blur
- Static or dynamic blur
- Performance options for older hardware

</details>

---

### **4.4. GNOME Fuzzy App Search**

**Extension ID:** `gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com`

**What it does:**
Improves the application search in GNOME's Activities overview with fuzzy search, making it faster and more forgiving—similar to Windows Search.

<details>
<summary><b>Windows Features it Brings</b></summary>

✅ **Better search tolerance** - Find apps even with typos or partial names
✅ **Faster app launching** - Type a few letters and find what you need
✅ **Windows-like search behavior** - Similar to Windows Start menu search

</details>

<details>
<summary><b>How Fuzzy Search Works</b></summary>

Instead of requiring exact matches, fuzzy search finds applications based on pattern matching:

- **Traditional search:** Typing "fire" only finds "Firefox"
- **Fuzzy search:** Typing "ffx" also finds "Firefox"
- **Traditional search:** Typing "cal" finds "Calculator"
- **Fuzzy search:** Typing "clc" also finds "Calculator"

</details>

**Installation:**
- Search for "GNOME Fuzzy App Search" in Extension Manager
- Or visit: https://extensions.gnome.org/extension/3956/gnome-fuzzy-app-search/

---

### **4.5. Add to Desktop**

**Extension ID:** `add-to-desktop@tommimon.github.com`

**What it does:**
Adds a convenient context menu option to create desktop shortcuts for applications and websites, just like in Windows.

<details>
<summary><b>Windows Features it Brings</b></summary>

✅ **Desktop shortcuts creation** - Right-click to add shortcuts to desktop
✅ **Quick access** - Launch frequently used apps directly from desktop
✅ **Familiar workflow** - Matches Windows desktop shortcut behavior

</details>

<details>
<summary><b>How to Use</b></summary>

1. Open the application overview (Activities)
2. Right-click on any application
3. Select **"Add to Desktop"**
4. The shortcut appears on your desktop

You can also create website shortcuts that open in your default browser.

</details>

**Installation:**
- Search for "Add to Desktop" in Extension Manager
- Or visit: https://extensions.gnome.org/extension/3240/add-to-desktop/

---

### **4.6. Logo Menu**

**Extension ID:** `logomenu@aryan_k`

**What it does:**
Replaces the "Activities" text in the top bar with a customizable logo/icon, giving you a macOS-style menu button (or Windows logo if you prefer).

<details>
<summary><b>What it Brings</b></summary>

✅ **Cleaner top bar** - Replace text with an icon
✅ **Customizable logo** - Use any icon you like (Windows logo, distro logo, etc.)
✅ **Professional appearance** - Looks more polished than plain text
✅ **Click to open Activities** - Same functionality, better aesthetics

</details>

**Installation:**
- Search for "Logo Menu" in Extension Manager
- Or visit: https://extensions.gnome.org/extension/4451/logo-menu/

<details>
<summary><b>Configuration Options</b></summary>

You can customize:
- Which icon to display
- Icon size
- Click behavior
- Menu options

**Note:** If you're using Dash to Panel, the Activities button can be replaced there too, making this extension optional depending on your setup.

</details>

---

## **5. Optional Extensions**

<details>
<summary><b>5.1. Open Bar (Alternative Approach)</b></summary>

**Extension ID:** `openbar@neuromorph`

**What it does:**
A highly customizable top bar/panel extension that offers a different approach to panel customization. Think of it as an alternative or complement to Dash to Panel.

**Features:**
- Top Bar / Top Panel customization
- Menu bar functionality
- Dash / Dock integration
- Extensive theming options for GTK apps
- Modular design with multiple customization options

**When to Use This:**
- If you want a macOS-like top menu bar instead of bottom taskbar
- If you want more advanced customization beyond Dash to Panel
- If you prefer a hybrid approach with both top and bottom panels

**Installation:**
- Search for "Open Bar" in Extension Manager
- Or visit: https://extensions.gnome.org/extension/6940/openbar/

**Note:** This extension offers many features and can be complex to configure. It's recommended for users who want fine-grained control over their desktop layout. You may not need this if Dash to Panel already meets your needs.

</details>

---

## **6. Configuration Guide**

Now that you've installed the extensions, let's configure them to create a Windows-like experience.

### **6.1. Configuring Dash to Panel**

This is the key configuration, as it creates your Windows-style taskbar.

**Accessing Settings:**
1. Open **Extension Manager** or **GNOME Tweaks**
2. Find **Dash to Panel**
3. Click the **Settings** (gear) icon

<details>
<summary><b>Position and Style Tab Settings</b></summary>

- **Panel screen position:** Bottom
- **Panel size (height):** 40-48px (adjust to your preference)
- **Panel thickness:** Dynamic or Fit icons
- **Icon padding:** 4-8px
- **App icon margin:** 4-8px
- **Panel corners:** Rounded (optional, for modern look)

</details>

<details>
<summary><b>Behavior Tab Settings</b></summary>

- **Isolate workspaces:** ❌ Disabled (show all windows on all workspaces, like Windows)
- **Show window previews on hover:** ✅ **Enabled** (essential Windows feature!)
  - **Preview timeout:** 250ms
  - **Preview size:** Medium or Large
  - **Show app icon:** ✅ Enabled
  - **Show window title:** ✅ Enabled
- **Ungroup applications:** ❌ Disabled (group windows by app, like Windows 7+)
- **Click action:** Cycle through windows or Toggle window previews
- **Scroll action:** Cycle windows

</details>

<details>
<summary><b>Action Buttons Tab Settings</b></summary>

- **Show Activities button:** ✅ Enabled
  - **Position:** Leftmost (like Windows Start button)
  - **Icon:** You can customize to Windows logo if desired
- **Show Desktop button:** ✅ **Enabled** (essential Windows feature!)
  - **Position:** Left (next to Activities) or Right (traditional Windows location)
  - **Click action:** Show desktop
- **Show App Menu:** Optional (Windows doesn't have this)

</details>

<details>
<summary><b>Fine-Tune Tab Settings</b></summary>

- **Animate window launch:** ✅ Enabled (polished feel)
- **Animate icon launch:** ✅ Enabled
- **Panel intellihide:** ✅ **Enabled** if you want auto-hide taskbar
  - **Enable in overview:** ❌ Disabled
  - **Dodge windows:** Only focused window
  - **Hide delay:** 500ms
  - **Show delay:** 200ms
  - **Pressure threshold:** 100-200
- **Window demands attention:** Flash or Blink

</details>

**After Configuration:**
- Close settings
- Your panel should now look and behave like a Windows taskbar
- Test window preview by hovering over app icons
- Test "Show Desktop" button

---

### **6.2. Configuring Hide Top Bar**

**Accessing Settings:**
1. Open **Extension Manager** or **GNOME Tweaks**
2. Find **Hide Top Bar**
3. Click the **Settings** icon

<details>
<summary><b>Recommended Settings</b></summary>

#### **Sensitivity:**
- **Animation duration:** 0.2 seconds (fast and responsive)
- **Pressure threshold:** 100-200 (how hard to push mouse to reveal)
- **Pressure timeout:** 1000ms

#### **Intellihide:**
- **Intellihide:** ✅ **Enabled** (recommended - hides only when windows overlap)
  - This is smarter than "always hide" because the bar stays visible when no windows cover it
- **Only hide on primary monitor:** ✅ Enabled (if you have multiple monitors)

#### **Visibility:**
- **Show panel on mouse-over:** ✅ Enabled
- **Show panel in overview:** ✅ Enabled (recommended)
- **Show panel when a window is maximized:** ❌ Disabled (for full-screen experience)

#### **Shortcuts:**
- **Keyboard shortcut to toggle:** Optional (e.g., `Super+T`)

**Recommended Setup:**
For a Windows-like experience:
- Enable **intellihide mode**
- Enable **show on mouse-over**
- Set animation to **0.2 seconds** for snappy response

This gives you maximum screen space while keeping the top bar accessible when needed.

</details>

---

### **6.3. Configuring Blur my Shell**

**Accessing Settings:**
1. Open **Extension Manager** or **GNOME Tweaks**
2. Find **Blur my Shell**
3. Click the **Settings** icon

<details>
<summary><b>Recommended Settings</b></summary>

#### **Panel Blur:**
- **Enable:** ✅ Enabled
- **Blur type:** Dynamic (changes based on background)
- **Sigma (blur strength):** 30-40
- **Brightness:** 0.6-0.8
- **Override background:** Optional (for custom color)

#### **Overview:**
- **Blur type:** Static or Dynamic
- **Sigma:** 30
- **Brightness:** 0.6

#### **Dash/Dock:**
- If using Dash to Panel, configure blur for the panel
- **Blur:** ✅ Enabled
- **Sigma:** 30-40

#### **Applications:**
- **Blur behind windows:** Optional (Windows 11-like effect)
- **Blur intensity:** Low-Medium (high can impact performance)

#### **Performance:**
- **Hack level:** Default or Optimized
- **Disable in overview:** ❌ Disabled (keep effects everywhere)

**Visual Polish Tips:**
- Use **dynamic blur** for modern look that adapts to wallpaper
- Keep **sigma around 30-40** for a balance of visibility and aesthetics
- If you notice performance issues, reduce blur intensity or disable blur for certain elements

</details>

---

### **6.4. Configuring GNOME Fuzzy App Search**

This extension typically works out of the box with minimal configuration needed.

<details>
<summary><b>Testing the Extension</b></summary>

1. Press `Super` key to open Activities
2. Start typing an app name with missing letters:
   - Type "ffx" → Should find "Firefox"
   - Type "clc" → Should find "Calculator"
   - Type "txted" → Should find "Text Editor"

If search results appear with fuzzy matching, the extension is working!

</details>

---

### **6.5. Configuring Add to Desktop**

This extension works through context menus and typically requires no configuration.

<details>
<summary><b>How to Use</b></summary>

1. Press `Super` to open Activities overview
2. Right-click on any application icon
3. Select **"Add to Desktop"**
4. A `.desktop` shortcut file appears on your desktop

**For Websites:**
1. Open the extension settings (if available)
2. Look for "Add website to desktop" option
3. Enter URL and name to create web shortcuts

</details>

---

### **6.6. Configuring Logo Menu**

**Accessing Settings:**
1. Open **Extension Manager** or **GNOME Tweaks**
2. Find **Logo Menu**
3. Click the **Settings** icon

<details>
<summary><b>Recommended Settings</b></summary>

#### **Icon:**
- **Icon type:** System icon or Custom image
- **Icon name/path:**
  - For Windows logo: `windows` or `start-here`
  - For distro logo: `distributor-logo` or similar
  - For custom: Select an image file

#### **Menu:**
- **Show menu items:** Customize what appears when clicking the icon
- **Menu position:** Left or Center

**Custom Icon Tips:**

To use a Windows logo:
1. Download a Windows logo PNG (search "Windows logo PNG transparent")
2. Save it to `~/Pictures/windows-logo.png`
3. In Logo Menu settings, select Custom image
4. Browse to your saved image

</details>

---

## **7. System Settings Customization**

Beyond extensions, GNOME's built-in Settings app offers valuable customization options.

<details>
<summary><b>7.1. Dock Settings (If Using Original Dock)</b></summary>

If you're **NOT** using Dash to Panel and prefer the original GNOME dock:

1. Open **Settings** → **Appearance** (or **Dock**)
2. Configure:
   - **Auto-hide the Dock:** ✅ **Enabled** (intelligently hide when not needed)
   - **Position on screen:** Bottom, Left, or Right
   - **Icon size:** Adjust to preference
   - **Show trash:** ✅ Enabled
   - **Show mounted drives:** ✅ Enabled

**Note:** This native dock auto-hide feature works similarly to Dash to Panel's intellihide, but Dash to Panel provides more Windows-like functionality overall.

</details>

<details>
<summary><b>7.2. Multitasking Settings</b></summary>

1. Open **Settings** → **Multitasking**
2. **Workspaces:**
   - **Fixed number of workspaces:** 4 (or Dynamic)
   - Windows users typically use 1 workspace, so you might prefer **Fixed: 1**
3. **Multi-Monitor:**
   - **Workspaces on all displays:** On (for Windows-like behavior)
4. **Application Switching:**
   - **Include apps from current workspace only:** ❌ Disabled (show all windows in Alt+Tab)

</details>

<details>
<summary><b>7.3. Appearance Settings</b></summary>

1. Open **Settings** → **Appearance**
2. **Style:** Light or Dark (Windows 11 offers both)
3. **Accent color:** Choose your preference (Windows 11-style)
4. **Background:** Select wallpaper
5. **Lock screen:** Customize lock screen background

</details>

<details>
<summary><b>7.4. Window Management</b></summary>

For additional Windows-like window behavior:

1. Open **GNOME Tweaks** → **Windows** tab
2. Configure:
   - **Attach modal dialogs:** ✅ Enabled
   - **Center new windows:** ✅ Enabled (Windows behavior)
   - **Resize with secondary-click:** ❌ Disabled
   - **Window focus mode:** Click to focus (Windows default)
   - **Titlebar actions:**
     - **Double-click:** Maximize (Windows behavior)
     - **Middle-click:** Menu
     - **Secondary-click:** Menu

</details>

<details>
<summary><b>7.5. Keyboard Shortcuts</b></summary>

Check and customize shortcuts to match Windows (see the keyboard remapping guide for detailed instructions):

1. Open **Settings** → **Keyboard** → **Keyboard Shortcuts**
2. Review and modify as needed:
   - **Super + D:** Show desktop (already configured by Dash to Panel's show desktop button)
   - **Alt + Tab:** Switch windows
   - **Super + L:** Lock screen
   - **Ctrl + Alt + T:** Open terminal

</details>

---

## **8. Troubleshooting**

<details>
<summary><b>Extensions Not Working After Installation</b></summary>

**Problem:** Installed extension doesn't appear or function

**Solutions:**

1. **Restart GNOME Shell:**
   - Press `Alt + F2`
   - Type `r`
   - Press `Enter`
   - Or log out and log back in

2. **Check Extension Compatibility:**
   - Extensions must match your GNOME Shell version
   - In Extension Manager, verify the extension supports your version
   - Update GNOME Shell if necessary

3. **Enable the Extension:**
   - Open Extension Manager or GNOME Tweaks
   - Ensure the toggle is **ON** for the extension

4. **Check for Conflicts:**
   - Disable conflicting extensions (e.g., Ubuntu Dock vs Dash to Panel)
   - Try disabling all extensions, then enable one at a time

</details>

<details>
<summary><b>Dash to Panel Conflicts with System Dock</b></summary>

**Problem:** Both Dash to Panel and the original dock are showing

**Solution:**

1. Open **GNOME Tweaks** or **Extension Manager**
2. Find and **disable** these extensions:
   - **Ubuntu Dock** (Ubuntu)
   - **Cosmic Dock** (Pop!_OS)
   - **Dash to Dock** (some distros)
3. Restart GNOME Shell (`Alt + F2`, type `r`, Enter)

</details>

<details>
<summary><b>Top Bar Not Hiding</b></summary>

**Problem:** Hide Top Bar extension doesn't hide the top bar

**Solutions:**

1. **Check Extension Settings:**
   - Ensure "Intellihide" or "Hide mode" is properly configured
   - Try switching between Intellihide and Always Hide to test

2. **Verify Mouse Sensitivity:**
   - Lower the pressure threshold in settings
   - Increase animation speed

3. **Disable Conflicting Extensions:**
   - Some extensions modify the top bar and may conflict
   - Try disabling other panel-related extensions temporarily

4. **Check for Maximized Windows:**
   - Intellihide only hides when windows overlap the bar
   - Maximize a window to test

</details>

<details>
<summary><b>Window Previews Not Showing</b></summary>

**Problem:** Hovering over Dash to Panel icons doesn't show window previews

**Solutions:**

1. **Enable in Dash to Panel Settings:**
   - Settings → Behavior → Window Preview
   - Ensure **"Show window previews on hover"** is ✅ **Enabled**

2. **Adjust Preview Timeout:**
   - Set timeout to 100-200ms for faster response

3. **Check Window Count:**
   - Previews typically show when multiple windows are open
   - Open 2+ windows of the same app to test

</details>

<details>
<summary><b>Blur Effects Causing Performance Issues</b></summary>

**Problem:** Desktop feels sluggish after enabling Blur my Shell

**Solutions:**

1. **Reduce Blur Intensity:**
   - Lower sigma value to 20-25
   - Disable blur for some elements (e.g., overview only)

2. **Change Blur Type:**
   - Switch from Dynamic to Static blur
   - Disable blur for windows and app folders

3. **Optimize Performance:**
   - In Blur my Shell settings → Performance
   - Increase "Hack level" for better optimization
   - Disable blur on older/weaker hardware

4. **Hardware Acceleration:**
   - Ensure your GPU drivers are properly installed
   - Check if hardware acceleration is enabled in GNOME

</details>

<details>
<summary><b>Extension Settings Not Saving</b></summary>

**Problem:** Changes to extension settings don't persist

**Solutions:**

1. **Check File Permissions:**
```bash
   ls -la ~/.local/share/gnome-shell/extensions/
```
   - Ensure you own the extension directories

2. **Reset Extension:**
   - Disable the extension
   - Remove it completely
   - Reinstall and reconfigure

3. **Check for Schema Conflicts:**
```bash
   sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
```

</details>

<details>
<summary><b>Activities Button Missing or Broken</b></summary>

**Problem:** Can't access Activities/applications overview

**Solutions:**

1. **Check Dash to Panel Settings:**
   - Ensure "Show Activities button" is enabled
   - Verify button position

2. **Keyboard Shortcut:**
   - Press `Super` key to open Activities
   - This always works regardless of panel configuration

3. **Hot Corner:**
   - Move mouse to top-left corner (if enabled)
   - Enable in GNOME Tweaks → Top Bar → Activities Overview Hot Corner

</details>

<details>
<summary><b>Desktop Icons Not Showing</b></summary>

**Problem:** Can't see desktop icons or shortcuts

**Solutions:**

1. **Enable Desktop Icons:**
   - Install extension: **Desktop Icons NG (DING)**
```bash
   sudo apt install gnome-shell-extension-desktop-icons-ng
```
   - Or search "Desktop Icons NG" in Extension Manager

2. **Check GNOME Tweaks:**
   - Extensions tab → Enable Desktop Icons extension

3. **File Manager Integration:**
   - Some distros require additional configuration
   - Check if Nautilus desktop is enabled
   - Consider using a more feature-rich file manager — see the [File Manager Customization guide](../file-manager/README.md) for alternatives like Dolphin or Nemo

</details>

---

## **9. Complete Setup Checklist**

<details>
<summary><b>Phase 1: Core Installation</b></summary>

- [ ] Install GNOME Tweaks
- [ ] Install Extension Manager (or browser integration)
- [ ] Install Dash to Panel extension
- [ ] Disable conflicting dock (Ubuntu Dock / Cosmic Dock)
- [ ] Install Hide Top Bar extension
- [ ] Install Blur my Shell extension
- [ ] Install GNOME Fuzzy App Search extension
- [ ] Install Add to Desktop extension
- [ ] Install Logo Menu extension

</details>

<details>
<summary><b>Phase 2: Configuration</b></summary>

- [ ] Configure Dash to Panel:
  - [ ] Set position to bottom
  - [ ] Enable window previews on hover
  - [ ] Enable Show Desktop button
  - [ ] Configure panel intellihide (if desired)
  - [ ] Adjust icon size and spacing
- [ ] Configure Hide Top Bar:
  - [ ] Enable intellihide mode
  - [ ] Set mouse sensitivity
  - [ ] Adjust animation speed
- [ ] Configure Blur my Shell:
  - [ ] Enable panel blur
  - [ ] Adjust blur intensity
  - [ ] Configure overview blur
- [ ] Configure Logo Menu (optional):
  - [ ] Choose icon (Windows logo or distro logo)
  - [ ] Set menu behavior
- [ ] Test GNOME Fuzzy App Search with fuzzy queries

</details>

<details>
<summary><b>Phase 3: System Settings</b></summary>

- [ ] Configure Multitasking:
  - [ ] Set workspace behavior
  - [ ] Configure application switching
- [ ] Customize Appearance:
  - [ ] Choose Light or Dark theme
  - [ ] Set accent color
  - [ ] Select wallpaper
- [ ] Adjust Window Management in GNOME Tweaks:
  - [ ] Set window focus mode to Click
  - [ ] Configure double-click to maximize
- [ ] Review and customize keyboard shortcuts

</details>

<details>
<summary><b>Phase 4: Testing</b></summary>

- [ ] Test window previews by hovering over Dash to Panel icons
- [ ] Test Show Desktop button functionality
- [ ] Test panel intellihide (if enabled)
- [ ] Test top bar intellihide
- [ ] Test Activities button (or Logo Menu)
- [ ] Test fuzzy app search
- [ ] Create a desktop shortcut using Add to Desktop
- [ ] Verify blur effects are working
- [ ] Check all visual elements look correct

</details>

<details>
<summary><b>Phase 5: Optional Enhancements</b></summary>

- [ ] Install Open Bar (if desired for advanced customization)
- [ ] Set up desktop icons extension (if needed)
- [ ] Customize additional keyboard shortcuts (see keyboard remapping guide)
- [ ] Install additional themes from GNOME Look
- [ ] Configure startup applications

</details>

---

## **10. Final Tips and Best Practices**

### **Performance Optimization**

1. **Disable unused extensions** - Only keep what you actively use
2. **Reduce animations** if on older hardware (GNOME Tweaks → Appearance → Animations: Off)
3. **Limit blur effects** on integrated graphics
4. **Monitor resource usage** with System Monitor

<details>
<summary><b>Backup Your Configuration</b></summary>

Your extension settings and configurations are stored in:
- `~/.local/share/gnome-shell/extensions/` - Extension files
- `~/.config/` - Extension settings (dconf)

**To backup:**
```bash
# Backup all extensions
tar -czf gnome-extensions-backup.tar.gz ~/.local/share/gnome-shell/extensions/

# Backup dconf settings
dconf dump / > dconf-settings-backup.txt
```

**To restore:**
```bash
# Restore extensions
tar -xzf gnome-extensions-backup.tar.gz -C ~/

# Restore dconf settings
dconf load / < dconf-settings-backup.txt
```

</details>

<details>
<summary><b>Keeping Extensions Updated</b></summary>

1. **Check for updates regularly:**
   - Open Extension Manager
   - Look for update notifications
   - Click "Update" when available

2. **GNOME updates may break extensions:**
   - After major GNOME updates, some extensions may stop working
   - Wait a few days for extension developers to release compatible versions
   - Check extension pages for compatibility information

</details>

<details>
<summary><b>Community Resources</b></summary>

- **GNOME Extensions Website:** https://extensions.gnome.org
- **GNOME Reddit:** r/gnome for tips and troubleshooting
- **Each extension's GitHub page:** For bug reports and feature requests
- **GNOME GitLab:** https://gitlab.gnome.org for GNOME development

</details>

### **Remember**

- **Explore extension settings** - Most extensions offer extensive customization beyond what's covered here
- **Don't forget system settings** - Many useful features are built into GNOME, not just extensions
- **Experiment** - Try different configurations to find what works best for you
- **Be patient** - Some extensions require tweaking to achieve the desired configuration
- **Ask for help** - The Linux community is very helpful when you encounter issues

---

## **Quick Reference: Extension URLs**

<details>
<summary><b>Direct Links to All Extensions</b></summary>

| Extension | URL |
|-----------|-----|
| Dash to Panel | https://extensions.gnome.org/extension/1160/dash-to-panel/ |
| Hide Top Bar | https://extensions.gnome.org/extension/545/hide-top-bar/ |
| Blur my Shell | https://extensions.gnome.org/extension/3193/blur-my-shell/ |
| GNOME Fuzzy App Search | https://extensions.gnome.org/extension/3956/gnome-fuzzy-app-search/ |
| Add to Desktop | https://extensions.gnome.org/extension/3240/add-to-desktop/ |
| Logo Menu | https://extensions.gnome.org/extension/4451/logo-menu/ |
| Open Bar (Optional) | https://extensions.gnome.org/extension/6940/openbar/ |

</details>

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [🖼️ Area Screenshot (Flameshot)](../area-screenshot/README.md) — Screenshot tool with annotation
- [📋 Clipboard History (CopyQ)](../clipboard-history/README.md) — Advanced clipboard manager
- [🐬 Dolphin Service Menus](../dolphin-menus/README.md) — Custom right-click actions for Dolphin
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🔍 OCR Clipboard](../ocr-clipboard/README.md) — Extract text from screenshots
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts
