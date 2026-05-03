#Requires AutoHotkey v2.0
#SingleInstance Force

; Launch both scripts without showing their tray icons
Run('"' A_AhkPath '" /restart "' A_ScriptDir '\ObsidianVaultLauncher.ahk"')
Run('"' A_AhkPath '" /restart "' A_ScriptDir '\TemperatureConverter.ahk"')

; Configure the master tray menu
A_TrayMenu.Delete()  ; Clear default menu
A_TrayMenu.Add("Obsidian Shortcuts", ShowObsidianHelp)
A_TrayMenu.Add("Open Temperature Converter", OpenTempConverter)
A_TrayMenu.Add()  ; Separator
A_TrayMenu.Add("Reload All", ReloadScripts)
A_TrayMenu.Add("Exit All", ExitAllScripts)

; Function to show Obsidian shortcut help
ShowObsidianHelp(*) {
    MsgBox "Obsidian Vault Shortcuts:`n`n"
        . "Ctrl+Alt+1: Notes Vault`n"
        . "Ctrl+Alt+2: Blog Vault`n"
        . "Ctrl+Alt+3: Tracker Vault", "Obsidian Launcher", "Iconi"
}

; Function to open temperature converter
OpenTempConverter(*) {
    ; Use a more reliable method to trigger the converter
    DetectHiddenWindows true
    if WinExist("Temperature Converter ahk_class AutoHotkeyGUI") {
        WinActivate
    } else {
        ; Send a signal to the TemperatureConverter script
        try {
            PostMessage(0x1001, 0, 0, , "ahk_pid " . GetScriptPID("TemperatureConverter.ahk"))
        } catch {
            ; Fallback to running a new instance
            Run('"' A_AhkPath '" "' A_ScriptDir '\TemperatureConverter.ahk"')
        }
    }
}

; Helper function to get PID of a running script
GetScriptPID(ScriptName) {
    for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
        if (process.Name = "AutoHotkey64.exe" || process.Name = "AutoHotkey.exe")
            if InStr(process.CommandLine, ScriptName)
                return process.ProcessId
    return 0
}

; Function to reload all scripts
ReloadScripts(*) {
    Run('"' A_AhkPath '" /restart "' A_ScriptFullPath '"')
    ExitApp
}

; Function to exit all scripts
ExitAllScripts(*) {
    ProcessClose("ObsidianVaultLauncher.ahk")
    ProcessClose("TemperatureConverter.ahk")
    ExitApp
}

; Keep script running
Persistent
