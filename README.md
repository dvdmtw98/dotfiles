# Dotfiles
This repository stores config files (settings) for various application (Windows & Linux)

## Common

- **uBlock Origin**
  - Custom rules for blocking/allowing certain elements
  - Load Rules: `Settings -> My Filters -> Import and Append`
  - Additional Filters: [Actually Legitimate URL Shortener Tool](https://github.com/DandelionSprout/adfilt/blob/master/LegitimateURLShortener.txt)
- **MPV**
  - A simple video player that can be used entirely from the command line
  - Linux Config: `~/.config/mpv`
  - Windows Config: `%INSTALL_DIR%\portable_config`
  - MD5 module (https://github.com/kikito/md5.lua)
- **NeoVim**
  - Modern Vim with advanced features and plugin support
  - Linux Config: `~/.config/nvim`
  - Windows Config: `%LOCALAPPDATA%\nvim`

## Linux

- **Zsh**
  - Zsh theme and config
  - `.zshenv` has to be present at `$HOME` to use custom location to store the config
  - Zsh Config: `~/.zshenv`, `~/.config/zsh/.zshrc`, `~/.config/zsh/.zprofile`
  - Powerlevel10k Config: `~/.config/zsh/.p10k.zsh`
- **Tmux**
  - Terminal Multiplexer. Allows to have multiple panes inside the same window
  - Config: `~/.config/tmux/tmux.conf`
- **Fastfetch**
  - Modern replacement for Neofetch. Used to show system information
  - Config: `~/.config/fastfetch/.config.jsonc`
- **Conky**
  - Allows to create widgets to display system information
  - Widgets are written in `.conkyrc` files
  - Config: `~/.config/conky`
- **IMWheel**
  - Utility to tweak mouse scroll wheel settings
  - Config: `~/.imwheelrc` 
- **Xinput**
  - Tweak the settings for input devices (using it to make touchpad scroll slower)
  - Config: `~/.xprofile`
- **Libinput Gesture**
  - Utility to map commands to touchpad gestures
  - Config: `~/.config/libinput-gestures.conf`

## Windows

- **PowerShell**
  - PowerShell configuration and theme
  - PowerShell Config: `$PROFILE`
  - Oh My Posh Theme: `%LOCALAPPDATA%\Programs\oh-my-posh\themes\zen.toml`
  - Modules Installed
    - Docker Completion
    - Post-Git
    - Posh-SShell
    - PSFzf (Bug: [Text Alignment](https://github.com/kelleyma49/PSFzf/issues/274))
    - PSReadLine
    - Terminal-Icons
- **Windows Terminal**
  - Modern Windows Terminal Host
  - Config: `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
- **AutoHotkey**
  - Automation Scripting Language
  - Config: `%USERPROFILE%\Documents\AutoHotkey`
- **Command Line Tools**
  - `bat` (Dependency: `less`)
  - `fd`
  - `fxf`
  - `ripgrep`
  - `zoxide`
  - `ffmpeg`
  - `yazi` (Dependency: `jq`, `ImageMagick`, `poppler`, `resvg`)
