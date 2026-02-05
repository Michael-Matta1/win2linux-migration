# 🐈 Open in Kitty — Nautilus Context Menu Extension

A professional Nautilus extension that adds **"Open in Kitty"** to the right-click context menu, allowing you to quickly open the [Kitty terminal](https://sw.kovidgoyal.net/kitty/) in any folder.

![Nautilus with Kitty context menu](https://img.shields.io/badge/Nautilus-Extension-blue) ![Python](https://img.shields.io/badge/Python-3.6+-green) ![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📑 Table of Contents

- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Usage](#-usage)
- [Configuration](#-configuration)
- [Troubleshooting](#-troubleshooting)
- [Uninstallation](#️-uninstallation)
- [License](#-license)
- [Additional Resources](#-additional-resources)

---

## ✨ Features

- 🎯 **Smart folder detection** — Only shows on folders, not files
- 🌐 **Remote filesystem support** — SSH into remote SFTP/FTP locations
- 🔐 **Root access support** — Open terminal with sudo in admin locations
- 🔍 **Auto-detection** — Automatically finds Kitty in common install locations
- 🛡️ **Robust error handling** — Graceful failures with helpful error messages
- 📝 **Clean tooltips** — Shows folder names in menu items
- 🚀 **Process isolation** — Terminal runs independently of Nautilus

---

## 📋 Requirements

| Requirement | Version | Installation |
|------------|---------|--------------|
| **GNOME Nautilus** | ≥ 3.0 | Pre-installed on most GNOME systems |
| **Python** | ≥ 3.6 | `sudo apt install python3` |
| **python3-nautilus** | Latest | `sudo apt install python3-nautilus` |
| **Kitty Terminal** | Latest | See [Kitty installation guide](https://sw.kovidgoyal.net/kitty/binary/) |

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

Clone this repository or download `open-kitty.py`:
```bash
# Create extensions directory if it doesn't exist
sudo mkdir -p /usr/share/nautilus-python/extensions

# Download the extension file
sudo curl -o /usr/share/nautilus-python/extensions/open-kitty.py \
  https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/open-kitty/open-kitty.py

# OR if you have the file locally:
sudo cp open-kitty.py /usr/share/nautilus-python/extensions/
```

<details>
<summary><b>Or create the file manually</b></summary>

Create the extension file:
```bash
sudo nano /usr/share/nautilus-python/extensions/open-kitty.py
```

Paste the following content:

```python
import os
import shlex
import subprocess
from urllib.parse import unquote, urlparse

import gi

gi.require_version("Nautilus", "3.0")
from gi.repository import Gio, GObject, Nautilus


def find_kitty():
    """Find kitty executable in common locations"""
    import shutil

    # Check if kitty is in PATH first (most efficient)
    if shutil.which("kitty"):
        return "kitty"

    # Check specific paths
    possible_paths = [
        os.path.expanduser("~/.local/kitty.app/bin/kitty"),
        "/usr/bin/kitty",
        "/usr/local/bin/kitty",
        "/opt/kitty/bin/kitty",
    ]

    for path in possible_paths:
        if os.path.isfile(path) and os.access(path, os.X_OK):
            return path

    # Fallback - will fail gracefully with error message if not found
    return "kitty"


KITTY_PATH = find_kitty()
REMOTE_URI_SCHEME = ["ftp", "sftp", "ssh", "smb", "dav", "davs"]

# Check if Kitty is actually available at startup
KITTY_AVAILABLE = (
    os.path.isfile(KITTY_PATH)
    if KITTY_PATH.startswith("/")
    else bool(__import__("shutil").which(KITTY_PATH))
)

if not KITTY_AVAILABLE:
    print(f"open-kitty: Warning - Kitty not found at {KITTY_PATH}")


class OpenKittyExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        super(OpenKittyExtension, self).__init__()

    def open_in_kitty(self, path, new_tab=False):
        """Open Kitty terminal at the specified path"""
        if not KITTY_AVAILABLE:
            print(f"open-kitty: Cannot open Kitty - executable not found at {KITTY_PATH}")
            return

        try:
            cmd = [KITTY_PATH]
            if new_tab:
                cmd.extend(["@", "launch", "--type=tab", "--cwd", path])
            else:
                cmd.extend(["--directory", path])

            subprocess.Popen(
                cmd,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True,
            )
        except FileNotFoundError:
            print(f"open-kitty: Kitty not found at {KITTY_PATH}")
        except PermissionError:
            print(f"open-kitty: Permission denied when trying to execute {KITTY_PATH}")
        except Exception as e:
            print(f"open-kitty: Error opening Kitty: {e}")

    def open_remote_kitty(self, uri):
        """Open Kitty with SSH connection to remote location"""
        if not KITTY_AVAILABLE:
            print(f"open-kitty: Cannot open Kitty - executable not found at {KITTY_PATH}")
            return

        result = urlparse(uri)
        ssh_cmd = ["ssh", "-t"]

        if result.username:
            ssh_cmd.append(f"{result.username}@{result.hostname}")
        else:
            ssh_cmd.append(result.hostname)

        if result.port:
            ssh_cmd.extend(["-p", str(result.port)])

        target_path = unquote(result.path) if result.path else "~"
        quoted_path = shlex.quote(target_path)
        ssh_cmd.extend(["cd", quoted_path, ";", "exec", "${SHELL:-/bin/sh}", "-l"])

        try:
            subprocess.Popen(
                [KITTY_PATH, "-e"] + ssh_cmd,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True,
            )
        except Exception as e:
            print(f"open-kitty: Error opening remote Kitty: {e}")

    def open_admin_kitty(self, path):
        """Open Kitty with sudo privileges"""
        if not KITTY_AVAILABLE:
            print(f"open-kitty: Cannot open Kitty - executable not found at {KITTY_PATH}")
            return

        try:
            subprocess.Popen(
                [KITTY_PATH, "--directory", path, "-e", "sudo", "-s"],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True,
            )
        except Exception as e:
            print(f"open-kitty: Error opening Kitty with sudo: {e}")

    def menu_activate_cb(self, menu, file):
        path = file.get_location().get_path()
        if path:
            self.open_in_kitty(path)

    def menu_remote_activate_cb(self, menu, file):
        uri = file.get_uri()
        self.open_remote_kitty(uri)

    def menu_admin_activate_cb(self, menu, file):
        path = file.get_location().get_path()
        if path:
            self.open_admin_kitty(path)

    def background_activate_cb(self, menu, file):
        path = file.get_location().get_path()
        if path:
            self.open_in_kitty(path)

    def background_remote_activate_cb(self, menu, file):
        uri = file.get_uri()
        self.open_remote_kitty(uri)

    def background_admin_activate_cb(self, menu, file):
        path = file.get_location().get_path()
        if path:
            self.open_admin_kitty(path)

    def get_file_items(self, window, files):
        if not KITTY_AVAILABLE:
            return []
        if len(files) != 1:
            return []

        file = files[0]
        if not file.is_directory():
            return []

        items = []

        try:
            filename = file.get_name()
            if isinstance(filename, bytes):
                filename = filename.decode("utf-8")
        except Exception:
            filename = "folder"

        display_name = filename[:30] + "..." if len(filename) > 30 else filename
        uri_scheme = file.get_uri_scheme()

        if uri_scheme in REMOTE_URI_SCHEME:
            uri = file.get_uri()
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Remote_Kitty",
                label=f"Open Remote Kitty: {display_name}",
                tip=f"Connect to {uri} via SSH in Kitty",
            )
            item.connect("activate", self.menu_remote_activate_cb, file)
            items.append(item)
        elif uri_scheme == "admin":
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Admin_Kitty",
                label=f"Open Kitty as Root: {display_name}",
                tip=f"Open Kitty with sudo in {filename}",
            )
            item.connect("activate", self.menu_admin_activate_cb, file)
            items.append(item)
        else:
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Kitty",
                label=f"Open in Kitty: {display_name}",
                tip=f"Open Kitty terminal in {filename}",
            )
            item.connect("activate", self.menu_activate_cb, file)
            items.append(item)

        return items

    def get_background_items(self, window, file):
        if not KITTY_AVAILABLE:
            return []

        items = []
        uri_scheme = file.get_uri_scheme()

        if uri_scheme in REMOTE_URI_SCHEME:
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Remote_Kitty_Background",
                label="Open Remote Kitty Here",
                tip="Connect to this remote directory via SSH in Kitty",
            )
            item.connect("activate", self.background_remote_activate_cb, file)
            items.append(item)
        elif uri_scheme == "admin":
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Admin_Kitty_Background",
                label="Open Kitty as Root Here",
                tip="Open Kitty with sudo in this directory",
            )
            item.connect("activate", self.background_admin_activate_cb, file)
            items.append(item)

        item = Nautilus.MenuItem(
            name="OpenKittyExtension::Open_Kitty_Background",
            label="Open Kitty Here",
            tip="Open Kitty terminal in this directory",
        )
        item.connect("activate", self.background_activate_cb, file)
        items.append(item)

        return items
```

Save the file and continue to Step 3.

</details>

### Step 3: Set Permissions
```bash
sudo chmod 644 /usr/share/nautilus-python/extensions/open-kitty.py
```

### Step 4: Restart Nautilus
```bash
nautilus -q && nautilus &
```

The extension is now installed.

> **Using Dolphin instead of Nautilus?** This extension is for GNOME's Nautilus file manager. If you use KDE's Dolphin, see the [Dolphin Service Menus guide](../dolphin-menus/README.md) for equivalent right-click "Open in Kitty" functionality. For help choosing a file manager, see the [File Manager Customization guide](../file-manager/README.md).

---

## 🎮 Usage

### Opening a Folder

1. **Right-click any folder** in Nautilus
2. Select **"Open in Kitty: [folder name]"**
3. Kitty opens in that directory

### Opening Current Directory

1. **Right-click empty space** inside any folder
2. Select **"Open Kitty Here"**
3. Kitty opens in the current directory

<details>
<summary><b>Remote Filesystems (SFTP/SSH)</b></summary>

1. In Nautilus, press `Ctrl+L` and enter: `sftp://username@server.com/path/to/folder`
2. Browse to a directory
3. Right-click → **"Open Remote Kitty Here"**
4. Kitty opens with SSH connection to that location

</details>

<details>
<summary><b>Root Access (Admin Mode)</b></summary>

1. Navigate to system folder (e.g., `/etc`)
2. Right-click → **"Open as Administrator"** (enter password)
3. Right-click empty space → **"Open Kitty as Root Here"**
4. Kitty opens with sudo privileges

</details>

---

## 🔧 Configuration

### Custom Kitty Installation Path

If Kitty is installed in a non-standard location, edit the extension:
```bash
sudo nano /usr/share/nautilus-python/extensions/open-kitty.py
```

Find the `find_kitty()` function and add your custom path:
```python
possible_paths = [
    os.path.expanduser("~/.local/kitty.app/bin/kitty"),
    "/usr/bin/kitty",
    "/usr/local/bin/kitty",
    "/your/custom/path/to/kitty",  # Add this line
]
```

Save and restart Nautilus:
```bash
nautilus -q && nautilus &
```

---

## 🧪 Troubleshooting

<details>
<summary><b>Menu item doesn't appear</b></summary>

**Solution 1:** Verify the extension is installed
```bash
ls -la /usr/share/nautilus-python/extensions/open-kitty.py
```

Expected output: `-rw-r--r-- 1 root root ... open-kitty.py`

**Solution 2:** Check Nautilus Python bindings
```bash
python3 -c "import gi; gi.require_version('Nautilus', '3.0'); from gi.repository import Nautilus; print('✅ Nautilus Python OK')"
```

**Solution 3:** Restart Nautilus with debug output
```bash
killall nautilus
nautilus --quit
nautilus 2>&1 | grep -i kitty
```

Look for error messages related to the extension.

</details>

<details>
<summary><b>Kitty doesn't open</b></summary>

**Check 1:** Verify Kitty is installed and accessible
```bash
which kitty
# OR
~/.local/kitty.app/bin/kitty --version
```

**Check 2:** Test manual launch
```bash
kitty --directory /tmp
```

If this works but the extension doesn't, check the Nautilus logs:
```bash
journalctl --user -b | grep -i "open-kitty"
```

</details>

<details>
<summary><b>Extension shows on files (not just folders)</b></summary>

This shouldn't happen with the current code. If it does:

1. Ensure you're using the latest version of `open-kitty.py`
2. Restart Nautilus completely:
```bash
killall nautilus && sleep 2 && nautilus &
```

</details>

---

## 🗑️ Uninstallation
```bash
sudo rm /usr/share/nautilus-python/extensions/open-kitty.py
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
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts

---

## 📚 Additional Resources

- [Nautilus Python Extension Documentation](https://wiki.gnome.org/Projects/NautilusPython)
- [Kitty Terminal Documentation](https://sw.kovidgoyal.net/kitty/)
- [GNOME Shell Extensions Guidelines](https://wiki.gnome.org/Projects/GnomeShell/Extensions)
