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
