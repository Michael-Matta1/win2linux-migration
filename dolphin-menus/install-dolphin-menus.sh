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
