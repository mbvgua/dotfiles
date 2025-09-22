# Rasi App Launcher Configuration

This repository contains my configuration files for the Rasi app launcher. These configurations are directly derived from the excellent work done by [Aditya Shakya](https://github.com/adi1090x) in his [rofi themes repository](https://github.com/adi1090x/rofi).

## Using these Configuration Files

These configuration files are intended for use with the Rasi app launcher. To use them:

1.  Clone this repository: 
2.  Place the contents of this repository into your Rasi configuration directory. This is typically located at `~/.config/rasi/`. Make sure to preserve the directory structure. For example, the `theme.rasi` file should be placed in `~/.config/rasi/theme/theme.rasi`.
3.  **Run Rasi:** After placing the files and installing the font, run Rasi. The launcher should now use the configuration from this repository.
```bash
    rofi -show drun
```

## Configuration Overview

The configuration is split into several files:

* **`/shared/colors.rasi`**: Imports the color scheme.
* **`/shared/onedark.rasi`**: Defines the base colors (background, foreground, etc.).
* **`/shared/fonts.rasi`**: Sets the font.
* **`/theme/theme.rasi`**: Contains the main theme definitions for all Rasi elements.
* **`config.rasi`**: Configures the launcher modes, display formats, and other settings.

