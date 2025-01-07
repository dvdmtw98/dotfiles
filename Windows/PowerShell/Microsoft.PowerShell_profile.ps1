oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\zen.toml" | Invoke-Expression

Import-Module -Name Terminal-Icons
Import-Module DockerCompletion

function Get-PublicIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }

# PSReadLine Config
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -HistoryNoDuplicates:$True

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# PSFzf Config
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# Zoxide Config
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Alias
Set-Alias 'sudo' 'gsudo'
Set-Alias 'cd' 'z' -Option AllScope

Import-Module -Name Microsoft.WinGet.CommandNotFound

Import-Module posh-git
Import-Module posh-sshell
Start-SshAgent -Quiet
