#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

; Hotkey to show vault selector
#!x:: ShowVaultSelector()  ; Win+Alt+X

; Define your vaults here
vaults := [
    {name: "Notes Vault", uri: "obsidian://open?vault=notes-vault"},
    {name: "Blog Vault", uri: "obsidian://open?vault=blog-vault"},
    {name: "Tracker Vault", uri: "obsidian://open?vault=tracker-vault"}
]

ShowVaultSelector() {
    ; Create GUI
    vaultSelector := Gui("-Caption +AlwaysOnTop +Border", "Select Vault")
    vaultSelector.BackColor := "FFFFFF"
    vaultSelector.SetFont("s10", "Segoe UI")
    
    ; Header text
    vaultSelector.Add("Text", "w300 Center", "Select an Obsidian Vault")
    
    ; Vault list
    vaultList := vaultSelector.Add("ListBox", "w300 h150")
    
    ; Populate list with vault names
    for vault in vaults {
        vaultList.Add([vault.name])
    }
    
    ; Select first item by default
    if vaults.Length > 0 {
        vaultList.Choose(1)
    }
    
    ; Focus list
    vaultList.Focus()
    
    ; Position GUI at center of screen
    vaultSelector.Show("Center")
    
    ; Handle keyboard
    vaultSelector.OnEvent("Escape", (*) => vaultSelector.Destroy())
    vaultList.OnEvent("DoubleClick", SelectVault)
    
    ; Add hidden default button for Enter key support
    btnGo := vaultSelector.Add("Button", "Hidden Default", "Go")
    btnGo.OnEvent("Click", (*) => SelectVault())
    
    ; Selection function
    SelectVault(*) {
        selectedIndex := vaultList.Value
        if selectedIndex > 0 {
            selectedName := vaultList.Text
            for vault in vaults {
                if (vault.name = selectedName) {
                    Run(vault.uri)
                    vaultSelector.Destroy()
                    return
                }
            }
        }
    }
}

; Hotkeys for direct access
^!1:: Run("obsidian://open?vault=notes-vault")
^!2:: Run("obsidian://open?vault=blog-vault")
^!3:: Run("obsidian://open?vault=tracker-vault")
