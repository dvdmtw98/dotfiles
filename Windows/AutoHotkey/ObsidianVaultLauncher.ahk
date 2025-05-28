; Obsidian Vault Quick Launcher
; --------------------------------------------------
; Ctrl+Alt+1 = Launch Notes Vault
; Ctrl+Alt+2 = Launch Blog Vault
; Ctrl+Alt+3 = Launch Tracker Vault
; --------------------------------------------------

#Requires AutoHotkey v2.0
#NoTrayIcon

^!1:: LaunchVault("obsidian://open?vault=notes-vault")
^!2:: LaunchVault("obsidian://open?vault=blog-vault")
^!3:: LaunchVault("obsidian://open?vault=tracker-vault")

LaunchVault(uri) {
    Run uri
}
