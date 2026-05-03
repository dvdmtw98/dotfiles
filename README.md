# Dotfiles
This repository stores my config files (settings) from various application (Windows & Linux)

## Linux

- **Zsh**
  - Zsh theme and config
  - `.zshenv` has to be present at `$HOME` to use custom location to store the config
  - Zsh Config: `~/.zshenv`, `~/.config/zsh/.zshrc`, `~/.config/zsh/.zprofile`
  - Powerlevel10k Theme Config: `~/.config/zsh/.p10k.zsh`
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
- **Libinput Gesture**
  - Utility to map commands to touchpad gestures
  - Config: `~/.config/libinput-gestures.conf`

## Windows

- **Windows Terminal**
  - Modern Windows Terminal Host
  - Config: `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
  - Fonts: `Cascadia Code NF`, `Fira Code` and `Inter` (Static)
- **Command Line Tools**
  - `bat` (`winget install sharkdp.bat`)
    - `less` (`winget install -e --id jftuga.less`)
  - `fd` (`winget install sharkdp.fd`)
  - `fzf` (`winget install fzf`)
  - `ripgrep` (`winget install BurntSushi.ripgrep.MSVC`)
  - `zoxide` (`winget install ajeetdsouza.zoxide`)
  - `ffmpeg` (`winget install -e --id Gyan.FFmpeg`)
- **PowerShell**
  - Download MSI version (Store version does not work with Task Scheduler)
  - PowerShell Config Location: `$PROFILE` (Won't exist on new systems)
  - OMP Install: `winget install JanDeDobbeleer.OhMyPosh --source winget`
  - Trust PSGallery `Set-PSRepository -Name PSGallery -InstallationPolicy Trusted`
  - Modules Used
    - Terminal-Icons (`Install-Module -Name Terminal-Icons`)
    - PSFzf (`Install-Module -Name PSFzf`)
    - Post-Git (`Install-Module -Name posh-git`)
    - Docker Completion
- **ShareX**
  - A free, open-source Windows tool for capturing, recording, and sharing screenshots and screen activity.
  - Config: `%USERPROFILE%\Documents\ShareX`
  - Does not support Symlinks.
- **Everything**
  - Config: `%APPDATA%\Everything\`
- **AutoHotkey**
  - Automation Scripting Language
  - Config: `%USERPROFILE%\Documents\AutoHotkey`

## Common

- **Firefox & Brave**
  - Config Changes: https://www.privacyguides.org/en/desktop-browsers
- **uBlock Origin**
  - Custom rules for blocking/allowing certain elements
  - Load Rules: `Settings -> My Filters -> Import and Append`
  - Additional Filters: [Actually Legitimate URL Shortener Tool](https://github.com/DandelionSprout/adfilt/blob/master/LegitimateURLShortener.txt)
- **MPV**
  - A free, open-source, cross-platform media player focused on high-quality playback and wide format support.
  - Download Link: https://github.com/zhongfly/mpv-winbuild/releases
  - Linux Config: `~/.config/mpv`
  - Windows Config: `%INSTALL_DIR%\portable_config`
  - MD5 module (https://github.com/kikito/md5.lua) place at `%INSTALL_DIR%\lua`
- **NeoVim**
  - Modern Vim with advanced features and plugin support
  - Linux Config: `~/.config/nvim`
  - Windows Config: `%LOCALAPPDATA%\nvim`
- **qBittorrent**
  - A free, open-source, cross-platform BitTorrent client used to download and share files over peer-to-peer networks.
  - Windows Config: `%APPDATA%\qBittorrent`
  - Themes: https://github.com/jagannatharjun/qbt-theme

## Symbolic Link

```cmd
mklink "D:\link.txt" "E:\target.txt"
mklink /D "D:\link_folder" "E:\real_folder"
```
