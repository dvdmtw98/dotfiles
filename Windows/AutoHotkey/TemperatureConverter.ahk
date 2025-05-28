#Requires AutoHotkey v2.0
#NoTrayIcon

; Handle messages from loader
OnMessage(0x1001, ShowTempConverter)

; Hotkey to launch the converter
#+t:: ShowTempConverter()

; Create global variables
global TempConverterGui := ""
global StatusText := ""

; Main GUI function for converter
ShowTempConverter(*) {
    global TempConverterGui, StatusText

    ; Close previous instance if exists
    if IsObject(TempConverterGui) {
        try TempConverterGui.Destroy()
    }

    ; Create new GUI
    TempConverterGui := Gui(, "Temperature Converter")
    TempConverterGui.OnEvent("Close", GuiClose)
    TempConverterGui.SetFont("s10", "Arial")

    ; Input section
    TempConverterGui.Add("Text", "w120", "Enter temperature:")
    TempInput := TempConverterGui.Add("Edit", "w120 vTempInput Number")
    TempInput.Focus()
    TempInput.OnEvent("Change", InputChanged)

    ; Unit selection
    TempConverterGui.Add("Text", "x+10 yp w30", "Unit:")
    UnitDDL := TempConverterGui.Add("DropDownList", "x+5 yp-4 w70 vSelectedUnit", ["°C", "°F"])
    UnitDDL.Text := "°C"

    ; Status text
    StatusText := TempConverterGui.Add("Text", "x10 y+10 w290", "Press Enter to convert")

    ; Handle Enter key
    TempConverterGui.OnEvent("Escape", GuiClose)
    ConvertBtn := TempConverterGui.Add("Button", "Hidden Default")
    ConvertBtn.OnEvent("Click", ConvertTemp)

    TempConverterGui.Show("w310 h120")
}

; Input validation
InputChanged(Ctrl, *) {
    global StatusText
    try {
        value := Ctrl.Value
        if value != ""
            value += 0
    } catch {
        Ctrl.Value := ""
        StatusText.Text := "Invalid number!"
    }
}

; Conversion function with FIXED notification
ConvertTemp(*) {
    global TempConverterGui, StatusText

    ; Get values from GUI
    Saved := TempConverterGui.Submit(false)
    TempValue := Saved.TempInput
    SelectedUnit := Saved.SelectedUnit

    ; Validate input
    if !IsNumber(TempValue) {
        StatusText.Text := "Please enter a valid number!"
        return
    }

    ; Perform conversion
    result := ""
    if (SelectedUnit = "°C") {
        f := (TempValue * 9 / 5) + 32
        result := TempValue " °C = " CleanNumber(f) " °F"
    }
    else if (SelectedUnit = "°F") {
        c := (TempValue - 32) * 5 / 9
        result := TempValue " °F = " CleanNumber(c) " °C"
    }

    ; FIXED: Use a GUI notification instead of TrayTip
    ShowNotification(result)
    TempConverterGui.Destroy()
}

; Create a GUI-based notification
ShowNotification(message) {
    ; Create the notification GUI
    notificationGui := Gui("-Caption +AlwaysOnTop +ToolWindow +E0x80000 +Border", "Conversion Result")
    
    notificationGui.BackColor := "EEEEEE"
    notificationGui.SetFont("s12", "Inter")
    notificationGui.Add("Text", "w200 Center", message)

    ; Calculate position - top right corner
    notificationGui.Show("Hide")
    notificationGui.GetPos(, , &width, &height)

    ; Position at top-right corner, no right margin
    xPos := A_ScreenWidth - width
    yPos := 50  ; 50px from top

    ; Create notification
    WinSetTransparent(0, notificationGui.Hwnd)
    notificationGui.Show("x" xPos " y" yPos " NoActivate")

    ; Animate fade-in (15 loops x 30ms = 0.45sec)
    loop 15 {
        ; Set transparency (0 - 255)
        WinSetTransparent(17 * A_Index, notificationGui.Hwnd)
        Sleep 30
    }

    ; Auto-close after 5 seconds
    SetTimer FadeOutAndDestroy, -5000

    ; Fade-out animation
    FadeOutAndDestroy() {
        ; Fade-out animation
        loop 15 {
            WinSetTransparent(255 - (17 * A_Index), notificationGui.Hwnd)
            Sleep 30
        }
        notificationGui.Destroy()

        ; Clear the timer
        SetTimer , 0
    }
}

; Helper function to clean number formatting
CleanNumber(num) {
    rounded := Round(num, 2)
    if (Mod(rounded, 1) = 0)
        return Round(rounded)
    else if (Mod(rounded * 10, 1) = 0)
        return Round(rounded, 1)
    else
        return rounded
}

; GUI close handler
GuiClose(*) {
    global TempConverterGui
    TempConverterGui.Destroy()
}
