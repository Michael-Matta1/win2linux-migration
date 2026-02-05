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
        """Open Kitty terminal at the specified path

        Args:
            path: Directory path to open
            new_tab: If True, try to open in a new tab (requires running Kitty instance)
        """
        if not KITTY_AVAILABLE:
            print(
                f"open-kitty: Cannot open Kitty - executable not found at {KITTY_PATH}"
            )
            return

        try:
            cmd = [KITTY_PATH]

            # Add new tab flag if requested (requires Kitty to be already running)
            if new_tab:
                cmd.extend(["@", "launch", "--type=tab", "--cwd", path])
            else:
                cmd.extend(["--directory", path])

            subprocess.Popen(
                cmd,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True,  # Detach from parent process
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
            print(
                f"open-kitty: Cannot open Kitty - executable not found at {KITTY_PATH}"
            )
            return

        result = urlparse(uri)

        # Build SSH command
        ssh_cmd = ["ssh", "-t"]

        if result.username:
            ssh_cmd.append(f"{result.username}@{result.hostname}")
        else:
            ssh_cmd.append(result.hostname)

        if result.port:
            ssh_cmd.extend(["-p", str(result.port)])

        # Navigate to the directory and start shell
        target_path = unquote(result.path) if result.path else "~"
        # Properly quote the path to handle spaces and special characters
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
            print(
                f"open-kitty: Cannot open Kitty - executable not found at {KITTY_PATH}"
            )
            return

        try:
            # Use sudo -s to start shell with proper environment
            subprocess.Popen(
                [KITTY_PATH, "--directory", path, "-e", "sudo", "-s"],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True,
            )
        except Exception as e:
            print(f"open-kitty: Error opening Kitty with sudo: {e}")

    def menu_activate_cb(self, menu, file):
        """Handle menu activation for file items"""
        path = file.get_location().get_path()
        if path:
            self.open_in_kitty(path)

    def menu_remote_activate_cb(self, menu, file):
        """Handle menu activation for remote file items"""
        uri = file.get_uri()
        self.open_remote_kitty(uri)

    def menu_admin_activate_cb(self, menu, file):
        """Handle menu activation for admin/root access"""
        path = file.get_location().get_path()
        if path:
            self.open_admin_kitty(path)

    def background_activate_cb(self, menu, file):
        """Handle menu activation for background items"""
        path = file.get_location().get_path()
        if path:
            self.open_in_kitty(path)

    def background_remote_activate_cb(self, menu, file):
        """Handle menu activation for remote background items"""
        uri = file.get_uri()
        self.open_remote_kitty(uri)

    def background_admin_activate_cb(self, menu, file):
        """Handle menu activation for admin background items"""
        path = file.get_location().get_path()
        if path:
            self.open_admin_kitty(path)

    def get_file_items(self, window, files):
        """Add context menu item for directories"""
        if not KITTY_AVAILABLE:
            return []

        if len(files) != 1:
            return []

        file = files[0]

        # Only show menu item for directories
        if not file.is_directory():
            return []

        items = []

        # Get the directory name - decode it properly
        try:
            filename = file.get_name()
            if isinstance(filename, bytes):
                filename = filename.decode("utf-8")
        except Exception:
            filename = "folder"

        # Truncate long filenames for cleaner menu
        display_name = filename[:30] + "..." if len(filename) > 30 else filename

        uri_scheme = file.get_uri_scheme()

        # Check if it's a remote location
        if uri_scheme in REMOTE_URI_SCHEME:
            # Add remote option
            uri = file.get_uri()
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Remote_Kitty",
                label=f"Open Remote Kitty: {display_name}",
                tip=f"Connect to {uri} via SSH in Kitty",
            )
            item.connect("activate", self.menu_remote_activate_cb, file)
            items.append(item)
        elif uri_scheme == "admin":
            # Admin (root) location - add sudo option
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Admin_Kitty",
                label=f"Open Kitty as Root: {display_name}",
                tip=f"Open Kitty with sudo in {filename}",
            )
            item.connect("activate", self.menu_admin_activate_cb, file)
            items.append(item)
        else:
            # Regular local folder
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Kitty",
                label=f"Open in Kitty: {display_name}",
                tip=f"Open Kitty terminal in {filename}",
            )
            item.connect("activate", self.menu_activate_cb, file)
            items.append(item)

        return items

    def get_background_items(self, window, file):
        """Add context menu item for folder background"""
        if not KITTY_AVAILABLE:
            return []

        items = []
        uri_scheme = file.get_uri_scheme()

        # Check if it's a remote location
        if uri_scheme in REMOTE_URI_SCHEME:
            # Add remote option
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Remote_Kitty_Background",
                label="Open Remote Kitty Here",
                tip="Connect to this remote directory via SSH in Kitty",
            )
            item.connect("activate", self.background_remote_activate_cb, file)
            items.append(item)
        elif uri_scheme == "admin":
            # Admin location - add sudo option
            item = Nautilus.MenuItem(
                name="OpenKittyExtension::Open_Admin_Kitty_Background",
                label="Open Kitty as Root Here",
                tip="Open Kitty with sudo in this directory",
            )
            item.connect("activate", self.background_admin_activate_cb, file)
            items.append(item)

        # Always add regular local option
        item = Nautilus.MenuItem(
            name="OpenKittyExtension::Open_Kitty_Background",
            label="Open Kitty Here",
            tip="Open Kitty terminal in this directory",
        )
        item.connect("activate", self.background_activate_cb, file)
        items.append(item)

        return items
