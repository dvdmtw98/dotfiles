[Console]::OutputEncoding = [Text.Encoding]::UTF8
[Console]::InputEncoding = [Text.Encoding]::UTF8

oh-my-posh init pwsh --config "$HOME\Code\Dotfiles\PowerShell Theme\zen.toml" | Invoke-Expression

# Clean history file by removing duplicates
$HISTORY = (Get-PSReadLineOption).HistorySavePath
if (Test-Path $HISTORY) {
    # Read all nonempty lines
    $lines = Get-Content $HISTORY | Where-Object { $_ -ne "" }
    
    # Track last occurrence of each line (key=command, value=index)
    $lastOccurrence = @{}
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $lastOccurrence[$lines[$i]] = $i
    }
    
    $cleanedHistory = foreach ($line in $lines) {
        if ($lastOccurrence[$line] -ne -1) {
            $line
            $lastOccurrence[$line] = -1
        }
    }
    
    $cleanedHistory | Out-File $HISTORY -Force
}

Import-Module -Name Terminal-Icons
# Import-Module DockerCompletion

function Get-PublicIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }
New-Variable -Name HISTORY -Value (Get-PSReadLineOption).HistorySavePath -Option AllScope -Force

# PSFzf Config
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

$env:FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
$env:FZF_DEFAULT_OPTS = '--layout=reverse --inline-info --ansi'

$env:BAT_PAGER="less -RFK"

# Zoxide Config
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Alias
Set-Alias 'cd' 'z' -Option AllScope
Set-Alias 'cat' 'bat'
Set-Alias 'grep' 'rg'
Set-Alias 'vim' 'nvim'

Import-Module posh-git

# Vim Cursor Fix
function nvim {
    & nvim.exe $args
    Write-Host -NoNewline "`e[5 q"
}

# PSReadLine Config
$PSReadLineOptions = @{
    HistoryNoDuplicates = $true
    PredictionSource    = "HistoryAndPlugin"
    PredictionViewStyle = "ListView"
    MaximumHistoryCount = 4096
}
Set-PSReadLineOption @PSReadLineOptions

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
