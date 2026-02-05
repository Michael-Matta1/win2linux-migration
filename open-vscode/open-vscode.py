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
        """Open VS Code at the specified path

        Args:
            path: Directory path to open
        """
        if not VSCODE_AVAILABLE:
            print(
                f"open-vscode: Cannot open VS Code - executable not found at {VSCODE_PATH}"
            )
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
            print(
                f"open-vscode: Permission denied when trying to execute {VSCODE_PATH}"
            )
        except Exception as e:
            print(f"open-vscode: Error opening VS Code: {e}")

    def menu_activate_cb(self, menu, file):
        """Handle menu activation for folder items"""
        path = file.get_location().get_path()
        if path:
            self.open_in_vscode(path)

    def background_activate_cb(self, menu, file):
        """Handle menu activation for background items"""
        path = file.get_location().get_path()
        if path:
            self.open_in_vscode(path)

    def get_file_items(self, window, files):
        """Add context menu item for directories only"""
        if not VSCODE_AVAILABLE:
            return []

        if len(files) != 1:
            return []

        file = files[0]

        # Only show menu item for directories
        if not file.is_directory():
            return []

        # Get the folder name
        try:
            filename = file.get_name()
            if isinstance(filename, bytes):
                filename = filename.decode("utf-8")
        except Exception:
            filename = "folder"

        # Truncate long filenames for cleaner menu
        display_name = filename[:30] + "..." if len(filename) > 30 else filename

        item = Nautilus.MenuItem(
            name="OpenVSCodeExtension::Open_VSCode",
            label=f"Open in VS Code: {display_name}",
            tip=f"Open {filename} in VS Code",
        )
        item.connect("activate", self.menu_activate_cb, file)

        return [item]

    def get_background_items(self, window, file):
        """Add context menu item for folder background"""
        if not VSCODE_AVAILABLE:
            return []

        item = Nautilus.MenuItem(
            name="OpenVSCodeExtension::Open_VSCode_Background",
            label="Open in VS Code",
            tip="Open this directory in VS Code",
        )
        item.connect("activate", self.background_activate_cb, file)

        return [item]
