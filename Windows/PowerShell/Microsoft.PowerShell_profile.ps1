[Console]::OutputEncoding = [Text.Encoding]::UTF8
[Console]::InputEncoding = [Text.Encoding]::UTF8

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\zen.toml" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\amro.omp.json" | Invoke-Expression

# Clean history file by removing duplicates
$historyFile = (Get-PSReadLineOption).HistorySavePath
if (Test-Path $historyFile) {
    # Read all non-empty lines
    $lines = Get-Content $historyFile | Where-Object { $_ -ne "" }
    
    # Track last occurrence of each line (key=command, value=index)
    $lastOccurrence = @{}
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $lastOccurrence[$lines[$i]] = $i  # Later entries overwrite older ones
    }
    
    # Reconstruct history in original order, skipping duplicates
    $cleanedHistory = foreach ($line in $lines) {
        if ($lastOccurrence[$line] -ne -1) {
            # Check if this is the last occurrence
            $line
            $lastOccurrence[$line] = -1      # Mark as processed
        }
    }
    
    # Write back to file
    $cleanedHistory | Out-File $historyFile -Force
}

Import-Module -Name Terminal-Icons
Import-Module DockerCompletion

function Get-PublicIP { (Invoke-WebRequest http://ifconfig.me/ip).Content }
New-Variable -Name HISTORY -Value (Get-PSReadLineOption).HistorySavePath -Option AllScope -Force

# PSFzf Config
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

$env:FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
$env:FZF_DEFAULT_OPTS = '--layout=reverse --inline-info --ansi'

# Zoxide Config
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Alias
Set-Alias 'cd' 'z' -Option AllScope
Set-Alias 'cat' 'bat'
Set-Alias 'grep' 'rg'
Set-Alias 'vim' 'nvim'

Import-Module -Name Microsoft.WinGet.CommandNotFound

Import-Module posh-git
Import-Module posh-sshell
Start-SshAgent -Quiet

# Yazi Config
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

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
