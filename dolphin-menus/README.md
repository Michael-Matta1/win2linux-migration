# 🐬 Dolphin Service Menus — Kitty & VS Code Context Menu Integration

Add **"Open in Kitty"** and **"Open in VS Code"** to Dolphin's right-click context menu, providing the same functionality as the [Nautilus extensions](../README.md) but for KDE's Dolphin file manager.

![Dolphin](https://img.shields.io/badge/Dolphin-File_Manager-blue) ![KDE](https://img.shields.io/badge/KDE-Plasma-1d99f3) ![Bash](https://img.shields.io/badge/Bash-Script-green) ![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📑 **Table of Contents**

- [What This Does](#what-this-does)
- [Features](#-features)
- [Requirements](#-requirements)
- [Quick Installation (Automated)](#-quick-installation-automated)
- [Manual Installation](#-manual-installation)
- [Usage](#-usage)
- [Customization](#-customization)
- [Troubleshooting](#-troubleshooting)
- [Uninstallation](#️-uninstallation)

---

## **What This Does**

This provides **KDE Dolphin** equivalents of the [open-kitty](../open-kitty/README.md) and [open-vscode](../open-vscode/README.md) Nautilus extensions. Instead of Python-based Nautilus extensions, Dolphin uses **KDE Service Menus** (`.desktop` files) with bash wrapper scripts.

**Same functionality, different implementation:**
- **Nautilus**: Python extensions that hook into GNOME Files
- **Dolphin**: Service menus that hook into KDE's file manager

Both achieve the same goal: quick access to Kitty terminal and VS Code from your file manager's context menu!

---

## ✨ **Features**

### 🐈 **Kitty Terminal Integration**

- ✅ **Smart context detection** — Adapts based on folder type (local/remote/admin)
- ✅ **Local directories** — Opens Kitty terminal in the selected folder
- ✅ **Remote filesystems** — SSH into SFTP/FTP/SSH locations automatically
- ✅ **Admin/root access** — Opens Kitty with sudo in admin:// locations
- ✅ **Auto-detection** — Finds Kitty in common installation paths
- ✅ **Single menu item** — One option that intelligently handles all scenarios

### 💻 **VS Code Integration**

- ✅ **Folder workspace** — Opens directories as VS Code workspaces
- ✅ **Multi-variant support** — Works with code, code-insiders, and VSCodium
- ✅ **Auto-detection** — Finds VS Code in common installation paths
- ✅ **Clean integration** — Simple, focused menu option

### 🎨 **Polish & Reliability**

- ✅ **Icon detection** — Automatically finds and uses Kitty/VS Code icons
- ✅ **Fallback icons** — Uses system icons if app icons aren't found
- ✅ **Error notifications** — Desktop notifications if apps aren't installed
- ✅ **Cache rebuilding** — Automatically updates KDE service menu cache

---

## 📋 **Requirements**

### **Required**

| Component | Purpose | Check |
|-----------|---------|-------|
| **Dolphin** | KDE file manager | Pre-installed on KDE Plasma |
| **Bash** | Shell scripting | Pre-installed on Linux |
| **KDE Frameworks** | Service menu support | Pre-installed on KDE |

### **Optional (choose what you need)**

| Application | Installation |
|-------------|--------------|
| **Kitty Terminal** | See [Kitty installation guide](https://sw.kovidgoyal.net/kitty/binary/) |
| **VS Code** | See [VS Code installation guide](https://code.visualstudio.com/docs/setup/linux) |

> **Note:** You can install just Kitty, just VS Code, or both. The script will set up only what's available.

---

## 🚀 **Quick Installation (Automated)**

The easiest way to install is using the provided automated script:

### **Step 1: Download the Script**

```bash
# Download from GitHub
curl -O https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/dolphin-menus/install-dolphin-menus.sh

# Make it executable
chmod +x install-dolphin-menus.sh
```

<details>
<summary><b>Or create the script manually</b></summary>

Create the file:
```bash
nano install-dolphin-menus.sh
```

Copy this content:
```bash
#!/bin/bash

echo "🐬 Installing Dolphin Service Menus for Kitty & VS Code..."
echo ""

# Remove old files first (clean installation)
echo "🧹 Cleaning up old installations..."
rm -f ~/.local/bin/dolphin-open-kitty.sh 2>/dev/null
rm -f ~/.local/bin/dolphin-open-vscode.sh 2>/dev/null
rm -f ~/.local/share/kio/servicemenus/open-in-kitty.desktop 2>/dev/null
rm -f ~/.local/share/kio/servicemenus/open-in-vscode.desktop 2>/dev/null
echo "✓ Old files removed"
echo ""

# Create directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/kio/servicemenus
mkdir -p ~/.local/share/icons/hicolor/scalable/apps/

# Download/copy Kitty wrapper with smart detection
cat >~/.local/bin/dolphin-open-kitty.sh <<'EOF'
#!/bin/bash

# Find kitty in common locations
if command -v kitty &>/dev/null; then
    KITTY_CMD="kitty"
elif [ -f "$HOME/.local/kitty.app/bin/kitty" ]; then
    KITTY_CMD="$HOME/.local/kitty.app/bin/kitty"
elif [ -f "/usr/bin/kitty" ]; then
    KITTY_CMD="/usr/bin/kitty"
elif [ -f "/usr/local/bin/kitty" ]; then
    KITTY_CMD="/usr/local/bin/kitty"
elif [ -f "/opt/kitty/bin/kitty" ]; then
    KITTY_CMD="/opt/kitty/bin/kitty"
else
    notify-send "Kitty Not Found" "Please install Kitty terminal" --icon=dialog-error
    exit 1
fi

TARGET="$1"

# Detect URI scheme and handle accordingly
if [[ "$TARGET" == sftp://* ]] || [[ "$TARGET" == ftp://* ]] || [[ "$TARGET" == ssh://* ]]; then
    # REMOTE: Parse URI and open SSH connection
    URI="$TARGET"
    USERHOST=$(echo "$URI" | sed -n 's|.*://\\([^/]*\\).*|\\1|p')
    PATH=$(echo "$URI" | sed 's|.*://[^/]*/||')

    if [[ "$USERHOST" == *"@"* ]]; then
        USER=$(echo "$USERHOST" | cut -d@ -f1)
        HOST=$(echo "$USERHOST" | cut -d@ -f2 | cut -d: -f1)
    else
        USER=""
        HOST=$(echo "$USERHOST" | cut -d: -f1)
    fi

    if [[ "$USERHOST" == *":"* ]]; then
        PORT=$(echo "$USERHOST" | sed -n 's|.*:\\([0-9]*\\)|\\1|p')
    else
        PORT=""
    fi

    SSH_CMD="ssh -t"

    if [ -n "$USER" ]; then
        SSH_CMD="$SSH_CMD $USER@$HOST"
    else
        SSH_CMD="$SSH_CMD $HOST"
    fi

    if [ -n "$PORT" ]; then
        SSH_CMD="$SSH_CMD -p $PORT"
    fi

    if [ -n "$PATH" ]; then
        QUOTED_PATH=$(printf '%q' "$PATH")
        SSH_CMD="$SSH_CMD 'cd $QUOTED_PATH ; exec \\${SHELL:-/bin/sh} -l'"
    else
        SSH_CMD="$SSH_CMD 'exec \\${SHELL:-/bin/sh} -l'"
    fi

    eval "$KITTY_CMD" -e bash -c \\"$SSH_CMD\\" &

elif [[ "$TARGET" == admin://* ]]; then
    # ADMIN: Open with sudo
    # Extract real path from admin:// URI
    REAL_PATH=$(echo "$TARGET" | sed 's|^admin://||')
    if [ -d "$REAL_PATH" ]; then
        "$KITTY_CMD" --directory "$REAL_PATH" -e sudo -s &
    else
        DIR=$(dirname "$REAL_PATH")
        "$KITTY_CMD" --directory "$DIR" -e sudo -s &
    fi

else
    # LOCAL: Regular local directory
    if [ -d "$TARGET" ]; then
        "$KITTY_CMD" --directory "$TARGET" &
    else
        DIR=$(dirname "$TARGET")
        "$KITTY_CMD" --directory "$DIR" &
    fi
fi
EOF

echo "✓ Created Kitty wrapper script"
chmod +x ~/.local/bin/dolphin-open-kitty.sh

# Download/copy VS Code wrapper
cat >~/.local/bin/dolphin-open-vscode.sh <<'EOF'
#!/bin/bash

# Find VS Code in common locations
if command -v code &> /dev/null; then
    VSCODE_CMD="code"
elif command -v code-insiders &> /dev/null; then
    VSCODE_CMD="code-insiders"
elif command -v codium &> /dev/null; then
    VSCODE_CMD="codium"
elif [ -f "/usr/bin/code" ]; then
    VSCODE_CMD="/usr/bin/code"
elif [ -f "/usr/local/bin/code" ]; then
    VSCODE_CMD="/usr/local/bin/code"
elif [ -f "/snap/bin/code" ]; then
    VSCODE_CMD="/snap/bin/code"
elif [ -f "$HOME/.local/bin/code" ]; then
    VSCODE_CMD="$HOME/.local/bin/code"
else
    notify-send "VS Code Not Found" "Please install Visual Studio Code" --icon=dialog-error
    exit 1
fi

TARGET="$1"

# Open directory in VS Code
if [ -d "$TARGET" ]; then
    "$VSCODE_CMD" "$TARGET" &
else
    # Fallback: open parent directory if somehow a file was passed
    DIR=$(dirname "$TARGET")
    "$VSCODE_CMD" "$DIR" &
fi
EOF

echo "✓ Created VS Code wrapper script"
chmod +x ~/.local/bin/dolphin-open-vscode.sh

# Find and copy Kitty icon
echo ""
echo "🎨 Setting up Kitty icon..."
KITTY_ICON=""

# Try to find Kitty icon in common locations
if [ -f "/usr/share/pixmaps/kitty.png" ]; then
    cp "/usr/share/pixmaps/kitty.png" ~/.local/share/icons/hicolor/scalable/apps/kitty.png
    KITTY_ICON="kitty"
    echo "✓ Copied Kitty icon from /usr/share/pixmaps/kitty.png"
elif [ -f "/usr/share/icons/hicolor/256x256/apps/kitty.png" ]; then
    cp "/usr/share/icons/hicolor/256x256/apps/kitty.png" ~/.local/share/icons/hicolor/scalable/apps/kitty.png
    KITTY_ICON="kitty"
    echo "✓ Copied Kitty icon from /usr/share/icons/hicolor/256x256/apps/kitty.png"
elif [ -f "$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png" ]; then
    cp "$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png" ~/.local/share/icons/hicolor/scalable/apps/kitty.png
    KITTY_ICON="kitty"
    echo "✓ Copied Kitty icon from local Kitty installation"
elif [ -f "/usr/share/icons/hicolor/scalable/apps/kitty.svg" ]; then
    cp "/usr/share/icons/hicolor/scalable/apps/kitty.svg" ~/.local/share/icons/hicolor/scalable/apps/kitty.svg
    KITTY_ICON="kitty"
    echo "✓ Copied Kitty icon from /usr/share/icons/hicolor/scalable/apps/kitty.svg"
else
    # Use fallback icon
    KITTY_ICON="utilities-terminal"
    echo "⚠ Kitty icon not found, using fallback icon 'utilities-terminal'"
    echo "  You can manually copy a Kitty icon to:"
    echo "  ~/.local/share/icons/hicolor/scalable/apps/kitty.png"
fi

# Create Kitty service menu with detected icon
cat >~/.local/share/kio/servicemenus/open-in-kitty.desktop <<EOF
[Desktop Entry]
Type=Service
Icon=$KITTY_ICON
X-KDE-ServiceTypes=KonqPopupMenu/Plugin,inode/directory
Actions=OpenInKitty;

[Desktop Action OpenInKitty]
Name=Open in Kitty
Icon=$KITTY_ICON
Exec=~/.local/bin/dolphin-open-kitty.sh %u
EOF

echo "✓ Created Kitty service menu"
chmod +x ~/.local/share/kio/servicemenus/open-in-kitty.desktop

# Find and copy VS Code icon
echo ""
echo "🎨 Setting up VS Code icon..."
VSCODE_ICON=""

# Try to find VS Code icon in common locations
if [ -f "/usr/share/pixmaps/vscode.png" ]; then
    cp "/usr/share/pixmaps/vscode.png" ~/.local/share/icons/hicolor/scalable/apps/vscode.png
    VSCODE_ICON="vscode"
    echo "✓ Copied VS Code icon from /usr/share/pixmaps/vscode.png"
elif [ -f "/usr/share/pixmaps/code.png" ]; then
    cp "/usr/share/pixmaps/code.png" ~/.local/share/icons/hicolor/scalable/apps/vscode.png
    VSCODE_ICON="vscode"
    echo "✓ Copied VS Code icon from /usr/share/pixmaps/code.png"
elif [ -f "/usr/share/icons/hicolor/scalable/apps/code.svg" ]; then
    cp "/usr/share/icons/hicolor/scalable/apps/code.svg" ~/.local/share/icons/hicolor/scalable/apps/vscode.svg
    VSCODE_ICON="vscode"
    echo "✓ Copied VS Code icon from /usr/share/icons/hicolor/scalable/apps/code.svg"
elif [ -f "/usr/share/icons/hicolor/256x256/apps/code.png" ]; then
    cp "/usr/share/icons/hicolor/256x256/apps/code.png" ~/.local/share/icons/hicolor/scalable/apps/vscode.png
    VSCODE_ICON="vscode"
    echo "✓ Copied VS Code icon from /usr/share/icons/hicolor/256x256/apps/code.png"
elif [ -f "/var/lib/snapd/desktop/applications/code_code.desktop" ] && [ -f "/snap/code/current/usr/share/pixmaps/com.visualstudio.code.png" ]; then
    cp "/snap/code/current/usr/share/pixmaps/com.visualstudio.code.png" ~/.local/share/icons/hicolor/scalable/apps/vscode.png
    VSCODE_ICON="vscode"
    echo "✓ Copied VS Code icon from Snap installation"
else
    # Use fallback icon
    VSCODE_ICON="text-x-script"
    echo "⚠ VS Code icon not found, using fallback icon 'text-x-script'"
    echo "  You can manually copy a VS Code icon to:"
    echo "  ~/.local/share/icons/hicolor/scalable/apps/vscode.png"
fi

# Create VS Code service menu with detected icon
cat >~/.local/share/kio/servicemenus/open-in-vscode.desktop <<EOF
[Desktop Entry]
Type=Service
Icon=$VSCODE_ICON
X-KDE-ServiceTypes=KonqPopupMenu/Plugin,inode/directory
X-KDE-Protocols=file
Actions=OpenInVSCode;

[Desktop Action OpenInVSCode]
Name=Open in VS Code
Icon=$VSCODE_ICON
Exec=~/.local/bin/dolphin-open-vscode.sh %f
EOF

echo "✓ Created VS Code service menu"
chmod +x ~/.local/share/kio/servicemenus/open-in-vscode.desktop

# Update icon cache
echo ""
echo "🔄 Updating icon cache..."
if command -v gtk-update-icon-cache &>/dev/null; then
    gtk-update-icon-cache ~/.local/share/icons/hicolor/ 2>/dev/null || true
    echo "✓ Icon cache updated"
fi

# Rebuild KDE service menu cache
echo ""
echo "🔄 Rebuilding KDE cache..."
if command -v kbuildsycoca6 &>/dev/null; then
    kbuildsycoca6 --noincremental &>/dev/null
    echo "✓ Cache rebuilt (KDE 6)"
elif command -v kbuildsycoca5 &>/dev/null; then
    kbuildsycoca5 --noincremental &>/dev/null
    echo "✓ Cache rebuilt (KDE 5)"
else
    echo "⚠ Could not find kbuildsycoca - you may need to log out/in for changes to take effect"
fi

# Restart Dolphin to apply changes immediately
echo ""
echo "🔄 Restarting Dolphin..."
if pgrep -x "dolphin" >/dev/null; then
    killall dolphin 2>/dev/null
    sleep 1
    dolphin &>/dev/null &
    echo "✓ Dolphin restarted"
else
    echo "ℹ Dolphin was not running"
fi

# Verify installation
echo ""
echo "🔍 Verifying installation..."

if [ -x ~/.local/bin/dolphin-open-kitty.sh ]; then
    echo "✓ Kitty wrapper is executable"
else
    echo "✗ Kitty wrapper is NOT executable"
fi

if [ -x ~/.local/bin/dolphin-open-vscode.sh ]; then
    echo "✓ VS Code wrapper is executable"
else
    echo "✗ VS Code wrapper is NOT executable"
fi

if [ -x ~/.local/share/kio/servicemenus/open-in-kitty.desktop ]; then
    echo "✓ Kitty service menu is executable"
else
    echo "✗ Kitty service menu is NOT executable"
fi

if [ -x ~/.local/share/kio/servicemenus/open-in-vscode.desktop ]; then
    echo "✓ VS Code service menu is executable"
else
    echo "✗ VS Code service menu is NOT executable"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "📋 Features installed:"
echo "  🐈 Kitty Terminal:"
echo "     • Intelligently detects context (local/remote/admin)"
echo "     • Single menu item that adapts based on folder type"
echo "     • Supports SFTP, FTP, SSH remote connections"
echo "     • Supports admin:// (root) locations"
if [ "$KITTY_ICON" = "kitty" ]; then
    echo "     • ✓ Kitty icon installed"
else
    echo "     • ⚠ Using fallback icon (Kitty icon not found)"
fi
echo ""
echo "  💻 VS Code:"
echo "     • Opens folders in VS Code"
echo "     • Works with code, code-insiders, and VSCodium"
if [ "$VSCODE_ICON" = "vscode" ]; then
    echo "     • ✓ VS Code icon installed"
else
    echo "     • ⚠ Using fallback icon (VS Code icon not found)"
fi
echo ""
echo "🎯 Usage:"
echo "  • Right-click any folder → 'Open in Kitty'"
echo "  • Right-click any folder → 'Open in VS Code'"
echo "  • The Kitty option adapts based on whether it's local, remote, or admin"
echo ""
echo "Enjoy! 🎉"
```

Then make it executable:
```bash
chmod +x install-dolphin-menus.sh
```

</details>

### **Step 2: Run the Script**

```bash
./install-dolphin-menus.sh
```

### **What the Script Does**

The automated installer:

1. ✅ **Cleans up** any previous installations
2. ✅ **Creates directories** (`~/.local/bin`, `~/.local/share/kio/servicemenus`, etc.)
3. ✅ **Generates wrapper scripts** for Kitty and VS Code
4. ✅ **Detects and copies icons** from system locations
5. ✅ **Creates service menu files** (`.desktop` files)
6. ✅ **Sets proper permissions** on all files
7. ✅ **Rebuilds KDE cache** (using `kbuildsycoca5` or `kbuildsycoca6`)
8. ✅ **Restarts Dolphin** to apply changes immediately
9. ✅ **Verifies installation** and shows status

### **Expected Output**

```text
🐬 Installing Dolphin Service Menus for Kitty & VS Code...

🧹 Cleaning up old installations...
✓ Old files removed

✓ Created Kitty wrapper script
✓ Created VS Code wrapper script

🎨 Setting up Kitty icon...
✓ Copied Kitty icon from /usr/share/pixmaps/kitty.png

🎨 Setting up VS Code icon...
✓ Copied VS Code icon from /usr/share/pixmaps/code.png

✓ Created Kitty service menu
✓ Created VS Code service menu

🔄 Updating icon cache...
✓ Icon cache updated

🔄 Rebuilding KDE cache...
✓ Cache rebuilt (KDE 5)

🔄 Restarting Dolphin...
✓ Dolphin restarted

🔍 Verifying installation...
✓ Kitty wrapper is executable
✓ VS Code wrapper is executable
✓ Kitty service menu is executable
✓ VS Code service menu is executable

✅ Installation complete!
```

---

## 🛠️ **Manual Installation**

If you prefer to create the files manually (or if the automated script doesn't work for you), follow these detailed steps:

### **Quick Download (All Files)**

Download all needed files directly from the repository:

```bash
# Create directories
mkdir -p ~/.local/bin ~/.local/share/kio/servicemenus

# Download wrapper scripts
curl -o ~/.local/bin/dolphin-open-kitty.sh https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/dolphin-menus/dolphin-open-kitty.sh
curl -o ~/.local/bin/dolphin-open-vscode.sh https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/dolphin-menus/dolphin-open-vscode.sh

# Download service menu files
curl -o ~/.local/share/kio/servicemenus/open-in-kitty.desktop https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/dolphin-menus/open-in-kitty.desktop
curl -o ~/.local/share/kio/servicemenus/open-in-vscode.desktop https://raw.githubusercontent.com/Michael-Matta1/win2linux-migration/main/dolphin-menus/open-in-vscode.desktop

# Make scripts executable
chmod +x ~/.local/bin/dolphin-open-kitty.sh ~/.local/bin/dolphin-open-vscode.sh

# Rebuild KDE cache and restart Dolphin
kbuildsycoca5 --noincremental  # or kbuildsycoca6
killall dolphin && dolphin &
```

> **Prefer manual creation?** Scroll down for step-by-step instructions to create each file yourself.

---

### **Step 1: Create Required Directories**

```bash
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/kio/servicemenus
mkdir -p ~/.local/share/icons/hicolor/scalable/apps/
```

---

### **Step 2: Create Kitty Wrapper Script (Manual)**

<details>
<summary><b>Create ~/.local/bin/dolphin-open-kitty.sh</b></summary>

```bash
nano ~/.local/bin/dolphin-open-kitty.sh
```

**Paste this content:**

```bash
#!/bin/bash

# Find kitty in common locations
if command -v kitty &>/dev/null; then
    KITTY_CMD="kitty"
elif [ -f "$HOME/.local/kitty.app/bin/kitty" ]; then
    KITTY_CMD="$HOME/.local/kitty.app/bin/kitty"
elif [ -f "/usr/bin/kitty" ]; then
    KITTY_CMD="/usr/bin/kitty"
elif [ -f "/usr/local/bin/kitty" ]; then
    KITTY_CMD="/usr/local/bin/kitty"
elif [ -f "/opt/kitty/bin/kitty" ]; then
    KITTY_CMD="/opt/kitty/bin/kitty"
else
    notify-send "Kitty Not Found" "Please install Kitty terminal" --icon=dialog-error
    exit 1
fi

TARGET="$1"

# Detect URI scheme and handle accordingly
if [[ "$TARGET" == sftp://* ]] || [[ "$TARGET" == ftp://* ]] || [[ "$TARGET" == ssh://* ]]; then
    # REMOTE: Parse URI and open SSH connection
    URI="$TARGET"
    USERHOST=$(echo "$URI" | sed -n 's|.*://\([^/]*\).*|\1|p')
    PATH=$(echo "$URI" | sed 's|.*://[^/]*/||')

    if [[ "$USERHOST" == *"@"* ]]; then
        USER=$(echo "$USERHOST" | cut -d@ -f1)
        HOST=$(echo "$USERHOST" | cut -d@ -f2 | cut -d: -f1)
    else
        USER=""
        HOST=$(echo "$USERHOST" | cut -d: -f1)
    fi

    if [[ "$USERHOST" == *":"* ]]; then
        PORT=$(echo "$USERHOST" | sed -n 's|.*:\([0-9]*\)|\1|p')
    else
        PORT=""
    fi

    SSH_CMD="ssh -t"

    if [ -n "$USER" ]; then
        SSH_CMD="$SSH_CMD $USER@$HOST"
    else
        SSH_CMD="$SSH_CMD $HOST"
    fi

    if [ -n "$PORT" ]; then
        SSH_CMD="$SSH_CMD -p $PORT"
    fi

    if [ -n "$PATH" ]; then
        QUOTED_PATH=$(printf '%q' "$PATH")
        SSH_CMD="$SSH_CMD 'cd $QUOTED_PATH ; exec \${SHELL:-/bin/sh} -l'"
    else
        SSH_CMD="$SSH_CMD 'exec \${SHELL:-/bin/sh} -l'"
    fi

    eval "$KITTY_CMD" -e bash -c \""$SSH_CMD"\" &

elif [[ "$TARGET" == admin://* ]]; then
    # ADMIN: Open with sudo
    REAL_PATH=$(echo "$TARGET" | sed 's|^admin://||')
    if [ -d "$REAL_PATH" ]; then
        "$KITTY_CMD" --directory "$REAL_PATH" -e sudo -s &
    else
        DIR=$(dirname "$REAL_PATH")
        "$KITTY_CMD" --directory "$DIR" -e sudo -s &
    fi

else
    # LOCAL: Regular local directory
    if [ -d "$TARGET" ]; then
        "$KITTY_CMD" --directory "$TARGET" &
    else
        DIR=$(dirname "$TARGET")
        "$KITTY_CMD" --directory "$DIR" &
    fi
fi
```

**Save and make executable:**

```bash
chmod +x ~/.local/bin/dolphin-open-kitty.sh
```

</details>

---

### **Step 3: Create VS Code Wrapper Script**

<details>
<summary><b>Create ~/.local/bin/dolphin-open-vscode.sh</b></summary>

```bash
nano ~/.local/bin/dolphin-open-vscode.sh
```

**Paste this content:**

```bash
#!/bin/bash

# Find VS Code in common locations
if command -v code &> /dev/null; then
    VSCODE_CMD="code"
elif command -v code-insiders &> /dev/null; then
    VSCODE_CMD="code-insiders"
elif command -v codium &> /dev/null; then
    VSCODE_CMD="codium"
elif [ -f "/usr/bin/code" ]; then
    VSCODE_CMD="/usr/bin/code"
elif [ -f "/usr/local/bin/code" ]; then
    VSCODE_CMD="/usr/local/bin/code"
elif [ -f "/snap/bin/code" ]; then
    VSCODE_CMD="/snap/bin/code"
elif [ -f "$HOME/.local/bin/code" ]; then
    VSCODE_CMD="$HOME/.local/bin/code"
else
    notify-send "VS Code Not Found" "Please install Visual Studio Code" --icon=dialog-error
    exit 1
fi

TARGET="$1"

# Open directory in VS Code
if [ -d "$TARGET" ]; then
    "$VSCODE_CMD" "$TARGET" &
else
    DIR=$(dirname "$TARGET")
    "$VSCODE_CMD" "$DIR" &
fi
```

**Save and make executable:**

```bash
chmod +x ~/.local/bin/dolphin-open-vscode.sh
```

</details>

---

### **Step 4: Create Kitty Service Menu**

<details>
<summary><b>Create ~/.local/share/kio/servicemenus/open-in-kitty.desktop</b></summary>

```bash
nano ~/.local/share/kio/servicemenus/open-in-kitty.desktop
```

**Paste this content:**

```ini
[Desktop Entry]
Type=Service
Icon=kitty
X-KDE-ServiceTypes=KonqPopupMenu/Plugin,inode/directory
Actions=OpenInKitty;

[Desktop Action OpenInKitty]
Name=Open in Kitty
Icon=kitty
Exec=~/.local/bin/dolphin-open-kitty.sh %u
```

**Save and make executable:**

```bash
chmod +x ~/.local/share/kio/servicemenus/open-in-kitty.desktop
```

> **Note:** If Kitty icon isn't found, replace `Icon=kitty` with `Icon=utilities-terminal`

</details>

---

### **Step 5: Create VS Code Service Menu**

<details>
<summary><b>Create ~/.local/share/kio/servicemenus/open-in-vscode.desktop</b></summary>

```bash
nano ~/.local/share/kio/servicemenus/open-in-vscode.desktop
```

**Paste this content:**

```ini
[Desktop Entry]
Type=Service
Icon=vscode
X-KDE-ServiceTypes=KonqPopupMenu/Plugin,inode/directory
X-KDE-Protocols=file
Actions=OpenInVSCode;

[Desktop Action OpenInVSCode]
Name=Open in VS Code
Icon=vscode
Exec=~/.local/bin/dolphin-open-vscode.sh %f
```

**Save and make executable:**

```bash
chmod +x ~/.local/share/kio/servicemenus/open-in-vscode.desktop
```

> **Note:** If VS Code icon isn't found, replace `Icon=vscode` with `Icon=text-x-script`

</details>

---

### **Step 6: Optional — Copy Icons**

<details>
<summary><b>Manually Copy Application Icons (Optional)</b></summary>

If you want proper application icons instead of fallback system icons:

**For Kitty:**

```bash
# Find your Kitty icon (check these locations):
ls /usr/share/pixmaps/kitty.png
ls /usr/share/icons/hicolor/256x256/apps/kitty.png
ls ~/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png

# Copy to user icons directory (replace SOURCE with actual path):
cp SOURCE ~/.local/share/icons/hicolor/scalable/apps/kitty.png
```

**For VS Code:**

```bash
# Find your VS Code icon (check these locations):
ls /usr/share/pixmaps/code.png
ls /usr/share/icons/hicolor/256x256/apps/code.png
ls /snap/code/current/usr/share/pixmaps/com.visualstudio.code.png

# Copy to user icons directory (replace SOURCE with actual path):
cp SOURCE ~/.local/share/icons/hicolor/scalable/apps/vscode.png
```

</details>

---

### **Step 7: Rebuild KDE Cache**

```bash
# For KDE Plasma 6:
kbuildsycoca6 --noincremental

# For KDE Plasma 5:
kbuildsycoca5 --noincremental
```

---

### **Step 8: Restart Dolphin**

```bash
killall dolphin
dolphin &
```

---

## 🎮 **Usage**

### **Opening Folders in Kitty**

<details>
<summary><b>Local Directories</b></summary>

1. **Right-click any folder** in Dolphin
2. Select **"Open in Kitty"**
3. Kitty opens in that directory

</details>

<details>
<summary><b>Remote Filesystems (SFTP/SSH)</b></summary>

1. In Dolphin, navigate to a remote location:
   - Press `Ctrl+L` and enter: `sftp://username@server.com/path/to/folder`
   - Or use the Network sidebar
2. Browse to a directory
3. Right-click → **"Open in Kitty"**
4. Kitty opens with SSH connection to that location

**The script automatically:**
- Parses the SFTP/FTP/SSH URI
- Extracts username, hostname, port, and path
- Opens Kitty with an SSH connection
- Navigates to the remote directory

</details>

<details>
<summary><b>Admin/Root Locations</b></summary>

1. Navigate to a system folder (e.g., `/etc`)
2. Right-click → **"Open as Administrator"** (Dolphin will ask for password)
3. Right-click folder → **"Open in Kitty"**
4. Kitty opens with sudo privileges in that directory

</details>

---

### **Opening Folders in VS Code**

1. **Right-click any folder** in Dolphin
2. Select **"Open in VS Code"**
3. VS Code opens with that folder as your workspace

---

## 🎨 **Customization**

### **Changing Icons**

<details>
<summary><b>Use Different Icons</b></summary>

Edit the `.desktop` files to use different icons:

```bash
nano ~/.local/share/kio/servicemenus/open-in-kitty.desktop
```

Change the `Icon=` lines to any icon name from your system:

```ini
Icon=utilities-terminal  # For Kitty
Icon=text-editor         # For VS Code
Icon=folder-development  # Alternative
```

You can browse available icons in **System Settings → Icons** or use:

```bash
ls /usr/share/icons/breeze/apps/48/
```

</details>

---

### **Adding Custom Paths**

<details>
<summary><b>Add Custom Installation Paths</b></summary>

If Kitty or VS Code is installed in a non-standard location:

**Edit Kitty wrapper:**

```bash
nano ~/.local/bin/dolphin-open-kitty.sh
```

Add your custom path to the detection logic:

```bash
elif [ -f "/your/custom/path/to/kitty" ]; then
    KITTY_CMD="/your/custom/path/to/kitty"
```

**Edit VS Code wrapper:**

```bash
nano ~/.local/bin/dolphin-open-vscode.sh
```

Add your custom path:

```bash
elif [ -f "/your/custom/path/to/code" ]; then
    VSCODE_CMD="/your/custom/path/to/code"
```

Then rebuild the cache:

```bash
kbuildsycoca5 --noincremental  # or kbuildsycoca6
```

</details>

---

### **Adding More Actions**

<details>
<summary><b>Add Additional Menu Options</b></summary>

You can add more actions to the service menus. For example, adding "Open in New VS Code Window":

Edit the VS Code service menu:

```bash
nano ~/.local/share/kio/servicemenus/open-in-vscode.desktop
```

Modify to include multiple actions:

```ini
[Desktop Entry]
Type=Service
Icon=vscode
X-KDE-ServiceTypes=KonqPopupMenu/Plugin,inode/directory
X-KDE-Protocols=file
Actions=OpenInVSCode;OpenInVSCodeNewWindow;

[Desktop Action OpenInVSCode]
Name=Open in VS Code
Icon=vscode
Exec=~/.local/bin/dolphin-open-vscode.sh %f

[Desktop Action OpenInVSCodeNewWindow]
Name=Open in New VS Code Window
Icon=vscode
Exec=code --new-window %f
```

Rebuild cache after changes:

```bash
kbuildsycoca5 --noincremental
```

</details>

---

## 🧪 **Troubleshooting**

<details>
<summary><b>Menu items don't appear in Dolphin</b></summary>

**Solution 1:** Rebuild KDE cache

```bash
# For KDE 6:
kbuildsycoca6 --noincremental

# For KDE 5:
kbuildsycoca5 --noincremental
```

**Solution 2:** Check file permissions

```bash
ls -la ~/.local/share/kio/servicemenus/
```

All `.desktop` files should be executable (`-rwxr-xr-x`)

If not:

```bash
chmod +x ~/.local/share/kio/servicemenus/*.desktop
```

**Solution 3:** Verify directory structure

```bash
ls -la ~/.local/bin/dolphin-open-*.sh
ls -la ~/.local/share/kio/servicemenus/*.desktop
```

All files should exist and be executable.

**Solution 4:** Restart Dolphin

```bash
killall dolphin
dolphin &
```

</details>

<details>
<summary><b>Kitty doesn't open / shows error notification</b></summary>

**Check if Kitty is installed:**

```bash
which kitty
# OR
~/.local/kitty.app/bin/kitty --version
```

**Test the wrapper script directly:**

```bash
~/.local/bin/dolphin-open-kitty.sh /tmp
```

This should open Kitty in `/tmp`. If it doesn't, check the script for syntax errors.

**View script errors:**

```bash
bash -x ~/.local/bin/dolphin-open-kitty.sh /tmp
```

This runs the script in debug mode.

</details>

<details>
<summary><b>VS Code doesn't open / shows error notification</b></summary>

**Check if VS Code is installed:**

```bash
which code
# OR
code --version
```

**Test the wrapper script directly:**

```bash
~/.local/bin/dolphin-open-vscode.sh /tmp
```

**Check for typos in the script:**

```bash
nano ~/.local/bin/dolphin-open-vscode.sh
```

</details>

<details>
<summary><b>Icons don't show / show wrong icons</b></summary>

**Update icon cache:**

```bash
gtk-update-icon-cache ~/.local/share/icons/hicolor/
```

**Use fallback system icons:**

Edit the `.desktop` files:

```bash
nano ~/.local/share/kio/servicemenus/open-in-kitty.desktop
```

Change `Icon=kitty` to `Icon=utilities-terminal`

```bash
nano ~/.local/share/kio/servicemenus/open-in-vscode.desktop
```

Change `Icon=vscode` to `Icon=text-x-script`

Then rebuild cache:

```bash
kbuildsycoca5 --noincremental
```

</details>

<details>
<summary><b>Remote connections don't work</b></summary>

**Verify SSH is working:**

```bash
ssh username@hostname
```

**Test the Kitty wrapper with a remote URI:**

```bash
~/.local/bin/dolphin-open-kitty.sh "sftp://user@example.com/home/user"
```

**Check script logic:**

```bash
bash -x ~/.local/bin/dolphin-open-kitty.sh "sftp://user@example.com/test"
```

This shows each command being executed.

</details>

<details>
<summary><b>Changes don't apply after editing scripts</b></summary>

After editing any file, you must:

1. **Rebuild KDE cache:**
   ```bash
   kbuildsycoca5 --noincremental
   ```

2. **Restart Dolphin:**
   ```bash
   killall dolphin
   dolphin &
   ```

</details>

---

## 🗑️ **Uninstallation**

To completely remove the Dolphin service menus:

```bash
# Remove wrapper scripts
rm ~/.local/bin/dolphin-open-kitty.sh
rm ~/.local/bin/dolphin-open-vscode.sh

# Remove service menu files
rm ~/.local/share/kio/servicemenus/open-in-kitty.desktop
rm ~/.local/share/kio/servicemenus/open-in-vscode.desktop

# Remove copied icons (optional)
rm ~/.local/share/icons/hicolor/scalable/apps/kitty.png
rm ~/.local/share/icons/hicolor/scalable/apps/vscode.png

# Rebuild KDE cache
kbuildsycoca5 --noincremental  # or kbuildsycoca6

# Restart Dolphin
killall dolphin
dolphin &
```

---

## 📝 **License**

This project is licensed under the **MIT License** — see the [LICENSE](../LICENSE) file for details.

---

## 📚 **Additional Resources**

- [KDE Service Menu Tutorial](https://develop.kde.org/docs/apps/dolphin/service-menus/)
- [Dolphin Handbook](https://docs.kde.org/stable5/en/dolphin/dolphin/)
- [Kitty Terminal Documentation](https://sw.kovidgoyal.net/kitty/)
- [VS Code Documentation](https://code.visualstudio.com/docs)
- [Parent Repository — Windows to Linux Migration Guides](../README.md)

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [🖼️ Area Screenshot (Flameshot)](../area-screenshot/README.md) — Screenshot tool with annotation
- [📋 Clipboard History (CopyQ)](../clipboard-history/README.md) — Advanced clipboard manager
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🔍 OCR Clipboard](../ocr-clipboard/README.md) — Extract text from screenshots
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts
