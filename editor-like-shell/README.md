# 🐚 Powerful Editor-Like Shell — zsh-edit-select

**[zsh-edit-select](https://github.com/Michael-Matta1/zsh-edit-select)** is a Zsh plugin that transforms your command line into a fully-featured text editor. Select text with **Shift+Arrow keys** or your **mouse**, type or paste to instantly replace selections, copy/cut/paste/undo/redo just like in any editor — and go beyond what even PowerShell offers with seamless mouse integration and multi-line selection support.

If you've ever been frustrated that your terminal doesn't let you select text or edit commands the way a text editor does, this plugin solves exactly that.


[demo video](https://github.com/user-attachments/assets/a024e609-1de1-4608-a7c3-e17264162904)

---

## What It Does

`zsh-edit-select` makes your Zsh command line behave like a text editor:

- **Select text** with `Shift + Arrow keys` (just like PowerShell / any text editor)
- **Copy** with `Ctrl+C` / **Cut** with `Ctrl+X` / **Paste** with `Ctrl+V`
- **Type or paste to replace** selected text — selections are not just visual
- **Mouse selection integration** — copy, cut, or replace text selected with your mouse
- **Undo / Redo** with `Ctrl+Z` / `Ctrl+Shift+Z`
- **Select all** with `Ctrl+A` (including multi-line commands)
- **Word-by-word navigation** with `Ctrl + Arrow keys`
- **Customize every keybinding** through an interactive wizard

> **Note:** The plugin uses `Ctrl+Shift+C` for copy by default (the traditional Linux terminal convention, where `Ctrl+C` sends an interrupt). You can switch to the reversed mode — `Ctrl+C` for copy and `Ctrl+Shift+C` for interrupt — through the configuration wizard or terminal config. See the [plugin's README](https://github.com/Michael-Matta1/zsh-edit-select) for details.

---

## Keyboard Shortcuts Reference

| Shortcut | Action |
| --- | --- |
| `Shift + ←/→` | Select character by character |
| `Shift + ↑/↓` | Select line by line |
| `Shift + Home/End` | Select to line start/end |
| `Ctrl + Shift + ←/→` | Select word by word |
| `Ctrl + A` | Select all text including multi-line commands|
| `Ctrl+C` / `Ctrl+Shift+C` | Copy (configurable which one) |
| `Ctrl + X` | Cut selected text |
| `Ctrl + V` | Paste (replaces selection if any) |
| `Ctrl + Z` | Undo |
| `Ctrl + Shift + Z` | Redo |

> Full key bindings and platform-specific notes are in the [plugin repository](https://github.com/Michael-Matta1/zsh-edit-select#default-key-bindings-reference).

---

## Installation

For full installation instructions — including the auto-installer, and terminal configuration and bindings customization, and more — see the **[zsh-edit-select repository](https://github.com/Michael-Matta1/zsh-edit-select#installation)**.


---

## Zsh — A Powerful Shell Worth Exploring

`zsh-edit-select` is a plugin for **Zsh** (Z shell) — a powerful, highly extensible shell that is a drop-in replacement for Bash, with a rich plugin ecosystem and community.

> **Note:** To easily install and manage Zsh plugins and themes, you will need a plugin manager. If you don't already have one, I recommend using **[Oh My Zsh](https://ohmyz.sh/)**.

If you're new to Zsh, here are a few other plugins I'd recommend alongside `zsh-edit-select`:

| Plugin | What it does |
|--------|--------------|
| **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** | Shows ghost-text suggestions as you type, based on your history — press `→` to accept |
| **[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)** | Highlights commands in real-time — valid commands in green, invalid in red |
| **[zsh-completions](https://github.com/zsh-users/zsh-completions)** | Additional completion definitions for Zsh |
| **[powerlevel10k](https://github.com/romkatv/powerlevel10k)** | Extremely fast and highly customizable Zsh theme |
| **[atuin](https://github.com/atuinsh/atuin)** | Replaces shell history with a searchable, synced, stats-aware database (think `Ctrl+R` but supercharged) |
| **[zoxide](https://github.com/ajeetdsouza/zoxide)** | A smarter `cd` command that learns your habits and lets you jump directories quickly |
| **[fzf](https://github.com/junegunn/fzf)** | Fuzzy finder for the terminal — search files, history, and more with a live interactive filter |

### Modern CLI Aliases

Along with plugins, I also highly recommend using modern Rust-based alternatives to classic Linux commands. Here are some aliases I use to replace the defaults:

```bash
alias cat='batcat'             # bat binary is named batcat on Ubuntu/Debian
alias bat='batcat'
alias ls='eza -la'             # modern ls
alias ll='eza -la'             # explicit long listing
alias la='eza -la'             # list all
alias lt='eza -la --tree --level=2'  # tree view
alias fd='fdfind'              # Use fd as alias instead of replacing find
alias grep='rg'                # ripgrep
alias top='htop'               # better top
alias du='dust'                # better du
```

For more ideas on Zsh customization — plugins, aliases, functions, and settings — you can browse [my `.zshrc`](https://github.com/Michael-Matta1/dev-dotfiles/blob/main/.zshrc).

---

## Full Documentation

For complete documentation — including platform-specific notes (macOS, WSL), SSH support, troubleshooting, and advanced configuration — see the **[zsh-edit-select repository](https://github.com/Michael-Matta1/zsh-edit-select)**.

---

## 📚 **Related Guides**

Explore other tools in this repository:

- [🖼️ Area Screenshot (Flameshot)](../area-screenshot/README.md) — Screenshot tool with annotation
- [📋 Clipboard History (CopyQ)](../clipboard-history/README.md) — Advanced clipboard manager (integrates seamlessly with zsh-edit-select)
- [🐬 Dolphin Service Menus](../dolphin-menus/README.md) — Custom right-click actions for Dolphin
- [📁 File Manager Customization](../file-manager/README.md) — Dolphin/Nautilus themes and settings
- [🐧 GNOME Desktop Extensions](../gnome-desktop-extensions/README.md) — Windows-like GNOME experience
- [🔍 OCR Clipboard](../ocr-clipboard/README.md) — Extract text from screenshots
- [🐈 Open in Kitty (Nautilus)](../open-kitty/README.md) — Right-click "Open in Kitty" for Nautilus
- [💻 Open in VS Code (Nautilus)](../open-vscode/README.md) — Right-click "Open in VS Code" for Nautilus
- [📌 Pin Applications to Dock](../pin-to-dock/README.md) — Pin any app to your dock
- [⌨️ Shortcuts Mapping (AutoKey)](../shortcuts-mapping/README.md) — Custom keyboard shortcuts
