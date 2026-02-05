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
