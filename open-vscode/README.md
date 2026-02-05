# 💻 Open in VS Code — Nautilus Context Menu Extension

A lightweight Nautilus extension that adds **"Open in VS Code"** to the right-click context menu for folders, allowing you to quickly open any directory in [Visual Studio Code](https://code.visualstudio.com/).

![Nautilus with VS Code context menu](https://img.shields.io/badge/Nautilus-Extension-blue) ![Python](https://img.shields.io/badge/Python-3.6+-green) ![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📑 Table of Contents

- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Usage](#-usage)
- [Configuration](#-configuration)
- [Advanced Options (Optional)](#️-advanced-options-optional)
- [Troubleshooting](#-troubleshooting)
- [Uninstallation](#️-uninstallation)
- [License](#-license)
- [Additional Resources](#-additional-resources)

---

## ✨ Features

- 🎯 **Folder-only detection** — Shows only on folders, not files (files can be opened by double-clicking)
- 🔍 **Auto-detection** — Automatically finds VS Code, VS Code Insiders, or VSCodium
- 🛡️ **Robust error handling** — Graceful failures with helpful error messages
- 📝 **Clean tooltips** — Shows folder names in menu items
- 🚀 **Process isolation** — VS Code runs independently of Nautilus
- ⚡ **Lightweight** — Single menu option for simplicity

---

## 📋 Requirements

| Requirement | Version | Installation |
|------------|---------|--------------|
| **GNOME Nautilus** | ≥ 3.0 | Pre-installed on most GNOME systems |
| **Python** | ≥ 3.6 | `sudo apt install python3` |
| **python3-nautilus** | Latest | `sudo apt install python3-nautilus` |
| **VS Code** | Latest | See [VS Code installation guide](https://code.visualstudio.com/docs/setup/linux) |

---

## 🚀 Installation

### Step 1: Install Dependencies

<details>
<summary><b>Ubuntu / Debian / Pop!_OS / Linux Mint</b></summary>
```bash
sudo apt update
sudo apt install python3-nautilus python3-gi -y
```

</details>

<details>
<summary><b>Fedora / RHEL / CentOS</b></summary>
```bash
sudo dnf install nautilus-python python3-gobject -y
```

</details>

<details>
<summary><b>Arch Linux / Manjaro</b></summary>
```bash
sudo pacman -S python-nautilus python-gobject
```

</details>

<details>
<summary><b>openSUSE</b></summary>
```bash
sudo zypper install python3-nautilus python3-gobject
```

</details>

### Step 2: Download the Extension

Clone this repository or download `open-vscode.py`:
```bash
# Create extensions directory if it doesn't exist
sudo mkdir -p /usr/share/nautilus-python/extensions

# Download the extension file
sudo curl -o /usr/share/nautilus-python/extensions/open-vscode.py \
  https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/open-vscode/open-vscode.py

# OR if you have the file locally:
sudo cp open-vscode.py /usr/share/nautilus-python/extensions/
```

<details>
<summary><b>Or create the file manually</b></summary>

Create the extension file:
```bash
sudo nano /usr/share/nautilus-python/extensions/open-vscode.py
```

Paste the following content:

```python
import os
import subprocess

import gi

gi.require_version("Nautilus", "3.0")
from gi.repository import Gio, GObject, Nautilus


def find_vscode():
    """Find VS Code executable in common locations"""
    import shutil

    # Common VS Code command names
    vscode_commands = ["code", "code-insiders", "codium", "vscode"]

    # Check if any VS Code variant is in PATH
    for cmd in vscode_commands:
        if shutil.which(cmd):
            return cmd

    # Check specific paths for different VS Code installations
    possible_paths = [
        "/usr/bin/code",
        "/usr/local/bin/code",
        "/snap/bin/code",
        "/usr/bin/codium",
        "/usr/bin/code-insiders",
        os.path.expanduser("~/.local/bin/code"),
    ]

    for path in possible_paths:
        if os.path.isfile(path) and os.access(path, os.X_OK):
            return path

    # Fallback
    return "code"


VSCODE_PATH = find_vscode()

# Check if VS Code is actually available at startup
VSCODE_AVAILABLE = (
    VSCODE_PATH.startswith("/")
    and os.path.isfile(VSCODE_PATH)
    or bool(__import__("shutil").which(VSCODE_PATH))
)

if not VSCODE_AVAILABLE:
    print(f"open-vscode: Warning - VS Code not found at {VSCODE_PATH}")


class OpenVSCodeExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        super(OpenVSCodeExtension, self).__init__()

    def open_in_vscode(self, path):
        """Open VS Code at the specified path"""
        if not VSCODE_AVAILABLE:
            print(f"open-vscode: Cannot open VS Code - executable not found at {VSCODE_PATH}")
            return

        try:
            cmd = [VSCODE_PATH, path]
            subprocess.Popen(
                cmd,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True,
            )
        except FileNotFoundError:
            print(f"open-vscode: VS Code not found at {VSCODE_PATH}")
        except PermissionError:
            print(f"open-vscode: Permission denied when trying to execute {VSCODE_PATH}")
        except Exception as e:
            print(f"open-vscode: Error opening VS Code: {e}")

    def menu_activate_cb(self, menu, file):
        path = file.get_location().get_path()
        if path:
            self.open_in_vscode(path)

    def background_activate_cb(self, menu, file):
        path = file.get_location().get_path()
        if path:
            self.open_in_vscode(path)

    def get_file_items(self, window, files):
        if not VSCODE_AVAILABLE:
            return []
        if len(files) != 1:
            return []

        file = files[0]
        if not file.is_directory():
            return []

        try:
            filename = file.get_name()
            if isinstance(filename, bytes):
                filename = filename.decode("utf-8")
        except Exception:
            filename = "folder"

        display_name = filename[:30] + "..." if len(filename) > 30 else filename

        item = Nautilus.MenuItem(
            name="OpenVSCodeExtension::Open_VSCode",
            label=f"Open in VS Code: {display_name}",
            tip=f"Open {filename} in VS Code",
        )
        item.connect("activate", self.menu_activate_cb, file)

        return [item]

    def get_background_items(self, window, file):
        if not VSCODE_AVAILABLE:
            return []

        item = Nautilus.MenuItem(
            name="OpenVSCodeExtension::Open_VSCode_Background",
            label="Open in VS Code",
            tip="Open this directory in VS Code",
        )
        item.connect("activate", self.background_activate_cb, file)

        return [item]
```

Save the file and continue to Step 3.

</details>

### Step 3: Set Permissions
```bash
sudo chmod 644 /usr/share/nautilus-python/extensions/open-vscode.py
```

### Step 4: Restart Nautilus
```bash
nautilus -q && nautilus &
```

The extension is now installed.

> **Using Dolphin instead of Nautilus?** This extension is for GNOME's Nautilus file manager. If you use KDE's Dolphin, see the [Dolphin Service Menus guide](../dolphin-menus/README.md) for equivalent right-click "Open in VS Code" functionality. For help choosing a file manager, see the [File Manager Customization guide](../file-manager/README.md).

---

## 🎮 Usage

### Opening a Folder

1. **Right-click any folder** in Nautilus
2. Select **"Open in VS Code: [folder name]"**
3. VS Code opens with that folder as your workspace

### Opening Current Directory

1. **Right-click empty space** inside any folder
2. Select **"Open in VS Code"**
3. VS Code opens with the current directory as your workspace

### Why No File Support?

Files are intentionally not included in the context menu because:
- **Double-click** already opens files in your default editor
- **Set VS Code as default** for file types you want (`.py`, `.js`, `.html`, etc.)
- Keeps the context menu clean and focused on folder operations

---

## 🔧 Configuration

### Custom VS Code Installation Path

If VS Code is installed in a non-standard location, edit the extension:
```bash
sudo nano /usr/share/nautilus-python/extensions/open-vscode.py
```

Find the `find_vscode()` function and add your custom path:
```python
possible_paths = [
    "/usr/bin/code",
    "/usr/local/bin/code",
    "/snap/bin/code",
    "/your/custom/path/to/code",  # Add this line
]
```

Save and restart Nautilus:
```bash
nautilus -q && nautilus &
```

---

## ⚙️ Advanced Options (Optional)

The current extension provides a single **"Open in VS Code"** option for simplicity. If you need additional options like **"Open in New Window"** or **"Add to Workspace"**, you can customize the extension.

<details>
<summary><b>Adding "Open in New Window" Option</b></summary>

### Step 1: Edit the Extension
```bash
sudo nano /usr/share/nautilus-python/extensions/open-vscode.py
```

### Step 2: Add New Window Method

Add this method to the `OpenVSCodeExtension` class (after the `open_in_vscode` method):
```python
def open_vscode_new_window(self, path):
    """Open VS Code in a new window"""
    if not VSCODE_AVAILABLE:
        return

    try:
        cmd = [VSCODE_PATH, "--new-window", path]
        subprocess.Popen(
            cmd,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True,
        )
    except Exception as e:
        print(f"open-vscode: Error opening VS Code in new window: {e}")
```

### Step 3: Add Callback Methods
```python
def menu_new_window_cb(self, menu, file):
    """Handle opening in new window"""
    path = file.get_location().get_path()
    if path:
        self.open_vscode_new_window(path)

def background_new_window_cb(self, menu, file):
    """Handle opening background in new window"""
    path = file.get_location().get_path()
    if path:
        self.open_vscode_new_window(path)
```

### Step 4: Modify get_file_items Method

Replace the `get_file_items` method to return multiple items:
```python
def get_file_items(self, window, files):
    """Add context menu items for directories"""
    if not VSCODE_AVAILABLE or len(files) != 1:
        return []

    file = files[0]
    if not file.is_directory():
        return []

    try:
        filename = file.get_name()
        if isinstance(filename, bytes):
            filename = filename.decode("utf-8")
    except Exception:
        filename = "folder"

    display_name = filename[:30] + "..." if len(filename) > 30 else filename

    items = []

    # Primary option
    item = Nautilus.MenuItem(
        name="OpenVSCodeExtension::Open_VSCode",
        label=f"Open in VS Code: {display_name}",
        tip=f"Open {filename} in VS Code",
    )
    item.connect("activate", self.menu_activate_cb, file)
    items.append(item)

    # New window option
    item = Nautilus.MenuItem(
        name="OpenVSCodeExtension::Open_VSCode_New_Window",
        label=f"Open in New VS Code Window",
        tip=f"Open {filename} in a new VS Code window",
    )
    item.connect("activate", self.menu_new_window_cb, file)
    items.append(item)

    return items
```

### Step 5: Modify get_background_items Method
```python
def get_background_items(self, window, file):
    """Add context menu items for folder background"""
    if not VSCODE_AVAILABLE:
        return []

    items = []

    # Primary option
    item = Nautilus.MenuItem(
        name="OpenVSCodeExtension::Open_VSCode_Background",
        label="Open in VS Code",
        tip="Open this directory in VS Code",
    )
    item.connect("activate", self.background_activate_cb, file)
    items.append(item)

    # New window option
    item = Nautilus.MenuItem(
        name="OpenVSCodeExtension::Open_VSCode_Background_New_Window",
        label="Open in New VS Code Window",
        tip="Open this directory in a new VS Code window",
    )
    item.connect("activate", self.background_new_window_cb, file)
    items.append(item)

    return items
```

### Step 6: Save and Restart
```bash
nautilus -q && nautilus &
```

</details>

<details>
<summary><b>Adding "Add to Workspace" Option</b></summary>

Follow the same pattern as the "New Window" option above, but use this method instead:
```python
def open_vscode_add_to_workspace(self, path):
    """Add folder to current VS Code workspace"""
    if not VSCODE_AVAILABLE:
        return

    try:
        cmd = [VSCODE_PATH, "--add", path]
        subprocess.Popen(
            cmd,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True,
        )
    except Exception as e:
        print(f"open-vscode: Error adding to VS Code workspace: {e}")
```

Then add the corresponding callbacks and menu items following the same pattern as the "New Window" example above.

</details>

---

## 🧪 Troubleshooting

<details>
<summary><b>Menu item doesn't appear</b></summary>

**Solution 1:** Verify the extension is installed
```bash
ls -la /usr/share/nautilus-python/extensions/open-vscode.py
```

Expected output: `-rw-r--r-- 1 root root ... open-vscode.py`

**Solution 2:** Check Nautilus Python bindings
```bash
python3 -c "import gi; gi.require_version('Nautilus', '3.0'); from gi.repository import Nautilus; print('✅ Nautilus Python OK')"
```

**Solution 3:** Restart Nautilus with debug output
```bash
killall nautilus
nautilus --quit
nautilus 2>&1 | grep -i vscode
```

Look for error messages related to the extension.

</details>

<details>
<summary><b>VS Code doesn't open</b></summary>

**Check 1:** Verify VS Code is installed and accessible
```bash
which code
# OR
code --version
```

**Check 2:** Test manual launch
```bash
code /tmp
```

If this works but the extension doesn't, check the Nautilus logs:
```bash
journalctl --user -b | grep -i "open-vscode"
```

</details>

<details>
<summary><b>Extension shows on files</b></summary>

This shouldn't happen with the current code. If it does:

1. Ensure you're using the latest version of `open-vscode.py`
2. Restart Nautilus completely:
```bash
killall nautilus && sleep 2 && nautilus &
```

</details>

---

## 🗑️ Uninstallation
```bash
sudo rm /usr/share/nautilus-python/extensions/open-vscode.py
nautilus -q && nautilus &
```

---

## 📝 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [🖼️ Area Screenshot (Flameshot)](../area-screenshot/README.md) — Screenshot tool with annotation
- [📋 Clipboard History (CopyQ)](../clipboard-history/README.md) — Advanced clipboard manager
- [🐬 Dolphin Service Menus](../dolphin-menus/README.md) — Custom right-click actions for Dolphin
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🔍 OCR Clipboard](../ocr-clipboard/README.md) — Extract text from screenshots
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts

---

## 📚 Additional Resources

- [VS Code Documentation](https://code.visualstudio.com/docs)
- [VS Code Command Line Interface](https://code.visualstudio.com/docs/editor/command-line)
- [Nautilus Python Extension Documentation](https://wiki.gnome.org/Projects/NautilusPython)
