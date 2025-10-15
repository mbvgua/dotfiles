from gettext import install
import logging
import subprocess
import platform
import os


apps = {
    "langs": [
        # "c",
        "gcc",
        "clang",
        "make",
        "cpp",
        # "rust",
        "cargo",
        "zig",
        "perl",
        "python",
        "pip",
        "lisp",
        "lua",
        "luajit",
        # "html",
        # "css"
        # "javascript",
        "tsc",  # typescript
    ],
    "dev_tools": [
        "node",
        "npm",
        "pnpm",
        "sqlite3",
        "mysql",
        "sqlcmd",  # "mssql server"
        "subl",  # "sublime text"
        "smerge",  # "sublime merge",
        "teams-for-linux",
        "firefox",
        "brave-browser",
        # "vlc",    # Sorry, but only played audio on my device, no video
        "mpv",
        "zathura",
        "zathura-pdf-poppler",
        "zathura-pdf-mupdf",
        "zathura-ps",
        "zathura-ps",
        "zathura-cb",
        "zathura-djvu",
        "nautilus",
    ],
    "cli_tools": [
        "wezterm",
        "ranger",
        "tmux",
        "git",
        "git-lfs",
        "nvim",  # "neovim",
        "vim",
        "bash",
        "fzf",
        "eza",
        "stow",
        "yt-dlp",
        "docker",
        "keyd",
        "wget",
        "curl",
        "htop",
    ],
    "wm_tools": [
        "qtile",
        "rofi",
        "dunst",
        "feh",
        "lxappearance",
        "network-manager-applet",
        "pavucontrol",
        "pulsemixer",
        "pamixer",
        "pipewire-pulse",
        "flameshot",
        # flameshot quality is teribble
        "deepin-screenshot",
        "xfce4-power-manager",
        "xfce4-screensaver",
        "xautolock",
        "picom",
        "polkit",
        "dmenu",
        "brightnessctl",
        "redshift",
        "unzip",
        "ImageMagick",
        "autoconf",
        "automake",
        "cairo-devel",
        "fontconfig",
        "libev-devel",
        "libjpeg-turbo-devel",
        "libXinerama",
        "libxkbcommon-devel",
        "libxkbcommon-x11-devel",
        "libXrandr",
        "libXrandr-devel",
        "imlib2-devel",
        "pam-devel",
        "pkgconf",
        "xcb-util-image-devel",
        "xcb-util-xrm-devel",
        "xset",
    ],
}

not_installed = []
package_manager = ""
# define the colours
red = "\033[0;31m"
green = "\033[0;32m"
cyan = "\033[0;36m"
normal = "\033[0m"


def get_environ():
    """
    use platform to get underlying system, hence the
    package manager to use.
    platform.system() will either return:
        - linux = 'Linux'
        - mac = 'Darwin'
        - window = 'Windows'
    """

    user_system = platform.system()
    if user_system == "Linux":
        distro = platform.freedesktop_os_release()
        print("Aha! A man of culture... ")
        print(f"Running on {distro["ID"].capitalize()}")
        check_installed()
    elif user_system == "Darwin":
        print("Running on a Mac system")
        print("Good for you!")
    elif user_system == "Windows":
        print(red)
        print("Massive L dude! This script will not run")
        print("Try something else... like changing your OS!")
        print(normal)
    else:
        print(red)
        print("Unable to get the host OS. Try again later?!")
        print(normal)


def check_installed():
    """
    check what the user already had installed in their system,
    eliminating it from installed list
    """
    print(f"Check if required applications are installed: ")
    for app in apps.values():
        i = 0
        while i < len(app):
            # shell=True allow concatenating a command
            is_installed = subprocess.run(
                [f"which {app[i]}"], shell=True, capture_output=True
            )
            if is_installed.returncode == 0:
                print(f"{green} ✓ {app[i].capitalize()} is installed{normal}")
            else:
                not_installed.append(app[i])
                print(f"{red} ✗ {app[i].capitalize()} is not installed{normal}")

            i += 1
    install_tools(not_installed)


def install_tools(install_this):
    """
    install the tools not currently on the system but in fedora repos
    for those not in the repos, e.g teams-for-linux, wezterms, sublime etc
    they be listed as not installed, and you can download them manually
            - teams-for-linux   - keyd
            - wezterm           - sqlcmd
            - lisp              - brave-browser
            - sublime-text      - sublime-merge
    """
    package_manager = "sudo dnf install -y --skip-unavailable"
    print("Now installing missing packages : ")
    for i in install_this:
        print(f"- {i}")

    choice = str(input("Continue with installation? [y/N]"))
    if choice.lower() == "y":
        for app in install_this:
            subprocess.run(
                [f"{package_manager} {app}"],
                shell=True,
            )
    else:
        print("")
        print(f"{red} Terminating script execution {normal}")


def main():
    print(
        f"""
        {green}
          888          888     .d888 d8b 888
          888          888    d88P"  Y8P 888
          888          888    888        888
      .d88888  .d88b.  888888 888888 888 888  .d88b.  .d8888b
     d88" 888 d88""88b 888    888    888 888 d8P  Y8b 88K
     888  888 888  888 888    888    888 888 88888888 "Y8888b.
     Y88b 888 Y88..88P Y88b.  888    888 888 Y8b.          X88
      "Y88888  "Y88P"   "Y888 888    888 888  "Y8888   88888P'
        {normal}
    """
    )
    get_environ()


if __name__ == "__main__":
    main()
