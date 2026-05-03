# 🐧 Windows to Linux Migration Toolkit

A collection of practical guides and scripts to help Windows users transition to Linux without losing the workflows they rely on every day.

This repository covers the gaps you'll encounter when switching — from missing keyboard shortcuts and clipboard history to file manager limitations and desktop layout differences. Each guide provides step-by-step instructions, ready-to-use scripts, and configuration files to recreate familiar Windows functionality on Linux.

---

## 📑 Table of Contents

- [About This Repository](#-about-this-repository)
- [Guides Overview](#-guides-overview)
  - [🖼️ Area Screenshot (Flameshot)](#️-area-screenshot-flameshot)
  - [📋 Clipboard History (CopyQ)](#-clipboard-history-copyq)
  - [🐬 Dolphin Service Menus](#-dolphin-service-menus)
  - [🐚 Editor-Like Shell (zsh-edit-select)](#-editor-like-shell-zsh-edit-select)
  - [📁 File Manager Customization](#-file-manager-customization)
  - [🐧 GNOME Desktop Extensions](#-gnome-desktop-extensions)
  - [🔍 OCR Clipboard](#-ocr-clipboard)
  - [🐈 Open in Kitty (Nautilus)](#-open-in-kitty-nautilus)
  - [💻 Open in VS Code (Nautilus)](#-open-in-vs-code-nautilus)
  - [📌 Pin Applications to Dock](#-pin-applications-to-dock)
  - [⌨️ Shortcuts Mapping (AutoKey)](#️-shortcuts-mapping-autokey)
- [Quick Reference Table](#-quick-reference-table)
- [Distro Compatibility](#-distro-compatibility)
- [Getting Started](#-getting-started)
- [Repository Structure](#-repository-structure)
- [License](#-license)

---

## 📖 About This Repository

After switching from Windows to **Pop!_OS** for machine learning and data science work, I found myself repeatedly solving the same set of problems — missing shortcuts, a bare-bones file manager, no clipboard history, and a desktop that didn't feel productive out of the box.

This repository documents every solution I've found and configured, packaged into standalone guides that anyone can follow. While my daily driver is Pop!_OS, I've included installation commands and instructions for other major distributions so these guides are useful regardless of which Linux distro you're running.

**What you'll find here:**
- Step-by-step guides with screenshots and explanations
- Ready-to-use scripts and configuration files (downloadable via `curl` or copy-pasteable)
- Collapsible installation sections for multiple distributions
- Troubleshooting sections for common issues
- Cross-references between related guides

---

## 📚 Guides Overview

### 🖼️ Area Screenshot (Flameshot)

**[→ Open Guide](area-screenshot/README.md)**

Recreate the Windows **Win+Shift+S** screenshot workflow on Linux using Flameshot. This guide covers installation, keyboard shortcut configuration (**Super+Shift+S**), annotation tools, and auto-start setup.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- Flameshot installation across multiple distros
- Custom keyboard shortcut setup (Super+Shift+S)
- Screenshot modes: area capture, full screen, delayed capture
- Built-in annotation tools (arrows, text, shapes, blur, pixelate)
- Auto-start configuration so Flameshot is always ready
- Flameshot desktop file for autostart

**Files:**
- `flameshot.desktop` — Autostart entry for Flameshot

</details>

---

### 📋 Clipboard History (CopyQ)

**[→ Open Guide](clipboard-history/README.md)**

Bring back the Windows **Win+V** clipboard history experience using CopyQ. This guide sets up **Super+V** for quick clipboard access and **Super+Shift+V** for the full history window, with search, filtering, and multi-format support.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- CopyQ installation and configuration
- Keyboard shortcuts that mirror Windows (Super+V / Super+Shift+V)
- Clipboard history with search and filtering
- Support for text, images, HTML, and files
- Tabs and organization for different clipboard categories
- Custom commands and scripting
- Auto-start setup

</details>

---

### 🐬 Dolphin Service Menus

**[→ Open Guide](dolphin-menus/README.md)**

Add **"Open in Kitty"** and **"Open in VS Code"** to Dolphin's right-click context menu. This is the KDE Dolphin equivalent of the Nautilus extensions (open-kitty and open-vscode), using KDE Service Menus with bash wrapper scripts.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- Automated installer script that handles everything
- Manual installation with step-by-step instructions
- Kitty wrapper with context detection (local, remote/SFTP, admin)
- VS Code wrapper with support for code, code-insiders, and VSCodium
- Automatic icon detection and installation
- KDE cache rebuilding

**Files:**
- `install-dolphin-menus.sh` — Automated installer
- `dolphin-open-kitty.sh` — Kitty wrapper script
- `dolphin-open-vscode.sh` — VS Code wrapper script
- `open-in-kitty.desktop` — KDE service menu for Kitty
- `open-in-vscode.desktop` — KDE service menu for VS Code

</details>

---

### 🐚 Editor-Like Shell (zsh-edit-select)

**[→ Open Guide](editor-like-shell/README.md)**

Get the Linux equivalent of PowerShell behavior, but more powerful and with more options. Make your Zsh command line behave like a full text editor: select text with **Shift+Arrow keys** or your **mouse**, type or paste to instantly replace selections, and use familiar text-editor-like shortcuts for (copy, cut, paste, undo, redo, select all) — all in the terminal. It features seamless mouse integration and multi-line command support. Every keybinding is customizable through an interactive wizard.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- Introduction to zsh-edit-select and its Windows-like shortcuts
- Quick-start with the auto-installer (single command, handles everything)
- Manual installation instructions for all major plugin managers
- Terminal configuration overview (Kitty, Alacritty, WezTerm, VS Code, Windows Terminal)
- Configuration wizard reference
- Link to the full plugin documentation

</details>

---

### 📁 File Manager Customization

**[→ Open Guide](file-manager/README.md)**

A guide to choosing and configuring a file manager that feels like Windows Explorer. Covers Dolphin (recommended) and Nemo, including installation on GNOME, Qt theming, dark mode stylesheet, shell aliases, and keyboard shortcuts.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- Comparison of file manager options (Dolphin, Nemo, Thunar, etc.)
- Dolphin installation on GNOME-based systems with KDE dependency setup
- Qt theming configuration so Dolphin looks native on GNOME
- Custom dark mode stylesheet
- Shell aliases for quick access
- Setting Dolphin/Nemo as default file manager
- Keyboard shortcut reference

**Files:**
- `dolphin-dark.qss` — Custom dark theme stylesheet for Dolphin

</details>

---

### 🐧 GNOME Desktop Extensions

**[→ Open Guide](gnome-desktop-extensions/README.md)**

Transform the GNOME desktop to closely match the Windows experience. This guide covers essential extensions like Dash to Panel (Windows-style taskbar), Blur my Shell, ArcMenu (Start menu), and more — with detailed configuration instructions for each.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- GNOME Tweaks and Extension Manager installation
- **Dash to Panel** — Windows-style taskbar with window previews and grouping
- **Blur my Shell** — Visual polish with blur effects
- **ArcMenu** — Windows-style Start menu
- **GNOME Fuzzy App Search** — Search apps like Windows
- **Desktop Icons NG** — Desktop icon support
- Detailed configuration walkthrough for each extension
- Troubleshooting for common extension issues

</details>

---

### 🔍 OCR Clipboard

**[→ Open Guide](ocr-clipboard/README.md)**

A Linux alternative to Windows **PowerToys Text Extractor**. Take a screenshot of any area on your screen, extract text using OCR (Tesseract), and copy it directly to your clipboard — all with a single keyboard shortcut. The script auto-detects X11 or Wayland and uses the appropriate clipboard command.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- OCR script with automatic X11/Wayland detection
- Dependency installation (Flameshot, Tesseract, xclip/wl-clipboard)
- Keyboard shortcut setup for multiple desktop environments
- Multi-language OCR support
- Customization ideas (dual clipboard, word count, history file)
- Flameshot auto-start configuration
- Troubleshooting

**Files:**
- `ocr-screenshot.sh` — OCR script (descriptive name)
- `ocr_clipboard.sh` — OCR script (alternative name, identical functionality)

</details>

---

### 🐈 Open in Kitty (Nautilus)

**[→ Open Guide](open-kitty/README.md)**

A Nautilus (GNOME Files) extension that adds **"Open in Kitty"** to the right-click context menu. Quickly open any folder in the Kitty terminal directly from your file manager.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- Python Nautilus extension with automatic Kitty detection
- Installation via download or manual creation
- Support for Kitty installed via package manager, binary, or custom path
- Distro-specific installation for nautilus-python dependency
- Troubleshooting

**Files:**
- `open-kitty.py` — Nautilus extension (Python)

</details>

---

### 💻 Open in VS Code (Nautilus)

**[→ Open Guide](open-vscode/README.md)**

A Nautilus (GNOME Files) extension that adds **"Open in VS Code"** to the right-click context menu for folders. Open any directory in Visual Studio Code directly from your file manager.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- Python Nautilus extension with automatic VS Code detection
- Supports code, code-insiders, and VSCodium
- Installation via download or manual creation
- Distro-specific installation for nautilus-python dependency
- Troubleshooting

**Files:**
- `open-vscode.py` — Nautilus extension (Python)

</details>

---

### 📌 Pin Applications to Dock

**[→ Open Guide](pin-to-dock/README.md)**

Create desktop entries to pin any application to your dock when the "Pin to Dock" option is missing. This guide covers manual desktop entry creation for AppImages, custom installations, and applications without automatic integration.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- Understanding desktop entries and why "Pin to Dock" is missing
- Quick template for creating desktop entries
- Step-by-step manual creation process
- Finding application paths and icons
- Real-world examples (Kitty, VS Code, AppImages, scripts, Flatpak, Snap)
- Advanced desktop entry options (actions, environment variables, web app launchers)
- Troubleshooting common issues
- Complete workflow reference

**Files:**
- `kitty.desktop` — Desktop entry for Kitty terminal
- `code.desktop` — Desktop entry for Visual Studio Code

</details>

---

### ⌨️ Shortcuts Mapping (AutoKey)

**[→ Open Guide](shortcuts-mapping/README.md)**

Remap Linux keyboard shortcuts to match your Windows muscle memory using AutoKey. This guide shows how to map shortcuts like **Alt+D** (address bar), **F2** (rename), and other Windows conventions to their Linux equivalents — scoped to specific applications using window filters.

<details>
<summary><b>What's included (Click to Expand)</b></summary>

- AutoKey installation and accessibility setup
- Window filter configuration (WM_CLASS detection for Nautilus, Dolphin, etc.)
- Creating custom keyboard shortcut scripts
- Example scripts for common Windows shortcuts
- Auto-start configuration
- Troubleshooting

</details>

---

## 📊 Quick Reference Table

| Guide | Windows Equivalent | Linux Tool | Shortcut |
|-------|-------------------|------------|----------|
| [🖼️ Area Screenshot](area-screenshot/README.md) | Win+Shift+S | Flameshot | Super+Shift+S |
| [📋 Clipboard History](clipboard-history/README.md) | Win+V | CopyQ | Super+V |
| [🐬 Dolphin Service Menus](dolphin-menus/README.md) | Explorer right-click | KDE Service Menus | Right-click menu |
| [🐚 Editor-Like Shell](editor-like-shell/README.md) | PowerShell behavior (but more powerful with more options: Shift+Arrow, mouse selection, copy/cut/paste/undo) | zsh-edit-select | Shift+Arrow / Ctrl+C/V/X/Z |
| [📁 File Manager](file-manager/README.md) | Windows Explorer | Dolphin / Nemo | — |
| [🐧 GNOME Extensions](gnome-desktop-extensions/README.md) | Windows desktop layout | GNOME Extensions | — |
| [🔍 OCR Clipboard](ocr-clipboard/README.md) | PowerToys Text Extractor | Flameshot + Tesseract | Super+Shift+T |
| [🐈 Open in Kitty](open-kitty/README.md) | "Open in Terminal" | Nautilus extension | Right-click menu |
| [💻 Open in VS Code](open-vscode/README.md) | "Open with Code" | Nautilus extension | Right-click menu |
| [📌 Pin to Dock](pin-to-dock/README.md) | Pin to taskbar | Desktop entries | Right-click menu |
| [⌨️ Shortcuts Mapping](shortcuts-mapping/README.md) | Native shortcuts | AutoKey | Custom |

---

## 🖥️ Distro Compatibility

These guides were developed on **Pop!_OS** (Ubuntu-based) for a machine learning and data science workflow, but each guide includes installation commands for multiple distributions:

| Distribution | Support Level |
|-------------|--------------|
| **Ubuntu / Pop!_OS / Linux Mint** | Full — primary development platform |
| **Debian** | Full |
| **Fedora / RHEL / CentOS** | Full |
| **Arch Linux / Manjaro** | Full |
| **openSUSE** | Full |
| **Void Linux** | Partial (included where applicable) |

> **Note:** The GNOME-specific guides (Nautilus extensions, GNOME Extensions) require a GNOME desktop environment. The Dolphin/KDE guides require KDE Plasma. The remaining guides (Flameshot, CopyQ, OCR, AutoKey) work across all desktop environments.

---

## 🚀 Getting Started

**New to Linux?** Here's a suggested order for setting up your environment:

1. **[GNOME Desktop Extensions](gnome-desktop-extensions/README.md)** — Transform the desktop layout first so it feels familiar
2. **[File Manager Customization](file-manager/README.md)** — Set up a file manager with Windows Explorer-like features
3. **[Area Screenshot](area-screenshot/README.md)** — Get your screenshot shortcut working (Win+Shift+S → Super+Shift+S)
4. **[Clipboard History](clipboard-history/README.md)** — Enable clipboard history (Win+V → Super+V)
5. **[Shortcuts Mapping](shortcuts-mapping/README.md)** — Remap any remaining keyboard shortcuts
6. **[Editor-Like Shell](editor-like-shell/README.md)** — The Linux equivalent of PowerShell, but more powerful and with more options: Shift+Arrow/mouse selection, copy/cut/paste/undo, and more.
7. **[Open in Kitty](open-kitty/README.md)** / **[Open in VS Code](open-vscode/README.md)** — Add terminal and editor context menu entries
8. **[Dolphin Service Menus](dolphin-menus/README.md)** — If using Dolphin instead of Nautilus, add context menu entries
9. **[OCR Clipboard](ocr-clipboard/README.md)** — Add text extraction from screenshots

Each guide is self-contained — you can follow them in any order or pick only the ones you need.

---

## 📂 Repository Structure

```text
win2linux-migration/
├── README.md                          ← You are here
├── LICENSE                            ← MIT License
│
├── area-screenshot/                   ← 🖼️ Flameshot screenshot setup
│   ├── README.md
│   └── flameshot.desktop
│
├── clipboard-history/                 ← 📋 CopyQ clipboard manager
│   └── README.md
│
├── dolphin-menus/                     ← 🐬 KDE Dolphin context menus
│   ├── README.md
│   ├── install-dolphin-menus.sh
│   ├── dolphin-open-kitty.sh
│   ├── dolphin-open-vscode.sh
│   ├── open-in-kitty.desktop
│   └── open-in-vscode.desktop
│
├── editor-like-shell/                 ← 🐚 zsh-edit-select (editor-like command line)
│   └── README.md
│
├── file-manager/                      ← 📁 File manager selection & config
│   ├── README.md
│   └── dolphin-dark.qss
│
├── gnome-desktop-extensions/          ← 🐧 GNOME → Windows-like desktop
│   └── README.md
│
├── ocr-clipboard/                     ← 🔍 OCR text extraction
│   ├── README.md
│   ├── ocr-screenshot.sh
│   └── ocr_clipboard.sh
│
├── open-kitty/                        ← 🐈 Nautilus "Open in Kitty"
│   ├── README.md
│   └── open-kitty.py
│
├── open-vscode/                       ← 💻 Nautilus "Open in VS Code"
│   ├── README.md
│   └── open-vscode.py
│
├── pin-to-dock/                       ← 📌 Pin apps to dock
│   ├── README.md
│   ├── kitty.desktop
│   └── code.desktop
│
└── shortcuts-mapping/                 ← ⌨️ Keyboard shortcut remapping
    └── README.md
```


---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.
