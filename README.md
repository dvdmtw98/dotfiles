# Dotfiles
This repository stores config files (settings) for various application (Windows & Linux)

## Common

- **uBlock Origin**
  - My custom filters for blocking/allowing certain elements
  - Load filters: `Settings -> My Filters -> Import and Append`

## Linux

- **Zsh**
  - Zsh theme and config
  - `.zshenv` has to be present at `$HOME` to use custom location to store the config
  - Zsh Config: `~/.zshenv`, `~/.config/zsh/.zshrc`, `~/.config/zsh/.zprofile`
  - Powerlevel10k Config: `~/.config/zsh/.p10k.zsh`
- **Tmux**
  - Terminal Multiplexer. Allows to have multiple panes inside the same window
  - Config: `~/.config/tmux/tmux.conf`
- **NeoVim**
  - Modern Vim with advanced features and plugin support
  - Config: `~/.config/nvim`
- **Fastfetch**
  - Modern replacement for Neofetch. Used to show system information
  - Config: `~/.config/fastfetch/.config.jsonc`
- **MPV**
  - A simple video player that can be used entirely from the command line
  - Config: `~/.config/mpv`
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
  - PowerShell Config: `C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`
  - Oh My Posh Theme: `C:\Users\<user>\AppData\Local\Programs\oh-my-posh\themes\zen.toml`
- **Windows Terminal**
  - Modern Windows Terminal Host
  - Config: `C:\Users\<user>\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
