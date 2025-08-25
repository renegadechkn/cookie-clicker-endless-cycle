; --- DPI-aware (mixed scaling/monitors safe) ---
try {
    DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")  ; PER_MONITOR_AWARE_V2
} catch {
    try {
        DllCall("Shcore\SetProcessDpiAwareness", "int", 2)
    } catch {
        DllCall("user32\SetProcessDPIAware")
    }
}

; Always use SCREEN coordinates
CoordMode "Mouse", "Screen"
SetMouseDelay 30

; -------- CONFIG --------
global clickDelay := 100                 ; ms between clicks
global grandmaCursorUpgradeDuration := 1800 ; 1.8 sec total loop
global upgradesDuration := 800          ; later upgrades (after You)
global waitBeforeReincarnate := 5500     ; after AscendConfirm
global loopGapMs := 2000
global scrollStepsForYou := 6            ; adjust if needed
global scrollDelayMs := 50

global P := Map()

; ---------- MAIN ----------
Calibrate()
cycles := AskCycles()
RunCycles(cycles)

; ---------- FUNCTIONS ----------
Calibrate(){
    global P
    MsgBox "Calibration starting.`nHover each target and press ENTER."

    P["BuyAmtBtn"]       := Capture("Hover **Buy Amount (Max/100/10/1)** and press ENTER.")
    P["Grandma"]         := Capture("Hover **Grandma** and press ENTER.")
    P["Cursor"]          := Capture("Hover **Cursor** and press ENTER.")
    P["BuyAllUpgrades"]  := Capture("Hover **Buy all upgrades** button and press ENTER.")
    P["ScrollAnchor"]    := Capture("Hover the **store/scrollbar area** (where wheel scroll works) and press ENTER.")
    P["You"]             := Capture("Hover **You** building (after scrolling) and press ENTER.")
    P["Legacy"]          := Capture("Hover **Legacy** (top-right) and press ENTER.")
    P["AscendConfirm"]   := Capture("Open Ascend once, hover **Ascend** and press ENTER.")
    P["Reincarnate"]     := Capture("Hover **Reincarnate** button and press ENTER.")
    P["ReincarnateYes"]  := Capture("Hover the **Yes** confirmation and press ENTER.")

    MsgBox "Calibration done."
}

AskCycles(){
    result := InputBox("How many ascensions to run?", "Endless Cycle", "w220 h130", "1")
    if (result.Result != "OK")
        ExitApp()
    if (!RegExMatch(result.Value,"^\d+$")) {
        MsgBox "Please enter a number."
        ExitApp()
    }
    return Integer(result.Value)
}

RunCycles(cycles){
    global P, clickDelay, grandmaCursorUpgradeDuration, upgradesDuration
    global waitBeforeReincarnate, loopGapMs
    global scrollStepsForYou, scrollDelayMs

    TrayTip "Starting " cycles " ascension cycle(s)…"

    Loop cycles {
        ; 1) Set Buy Amount
        ClickPoint(P["BuyAmtBtn"], 1)

        ; 2) Loop Grandma → Cursor → Upgrades over 1.8 seconds
        endTime := A_TickCount + grandmaCursorUpgradeDuration
        while (A_TickCount < endTime) {
            ClickPoint(P["Grandma"], 1)
            ClickPoint(P["Cursor"], 1)
            ClickPoint(P["BuyAllUpgrades"], 1)
            Sleep clickDelay
        }

        ; 3) Scroll down to reveal You (double scroll for safety)
        MouseMove P["ScrollAnchor"].x, P["ScrollAnchor"].y, 0
        Loop scrollStepsForYou {
            Send "{WheelDown}"
            Sleep scrollDelayMs
        }
        Sleep 200
        Loop scrollStepsForYou {
            Send "{WheelDown}"
            Sleep scrollDelayMs
        }

        ; 4) Buy You (once, maxed)
        ClickPoint(P["You"], 1)

        ; 4.5) Scroll back UP to top of store (double pass for safety)
        MouseMove P["ScrollAnchor"].x, P["ScrollAnchor"].y, 0
        Loop scrollStepsForYou {
            Send "{WheelUp}"
            Sleep scrollDelayMs
        }
        Sleep 200
        Loop scrollStepsForYou {
            Send "{WheelUp}"
            Sleep scrollDelayMs
        }
        ; 5) Buy All Upgrades again (3s spam)
        endTime := A_TickCount + upgradesDuration
        while (A_TickCount < endTime) {
            ClickPoint(P["BuyAllUpgrades"], 1)
            Sleep clickDelay
        }

        ; 6) Ascend flow
        ClickPoint(P["Legacy"], 1)         ; only once
        Sleep 800
        ClickPoint(P["AscendConfirm"], 1)

        ; 7) Wait for reincarnate to unlock
        Sleep waitBeforeReincarnate
        ClickPoint(P["Reincarnate"], 1)
        Sleep 500
        ClickPoint(P["ReincarnateYes"], 1)

        ; 8) buffer before next loop
        Sleep loopGapMs
    }

    TrayTip "All cycles complete!"
    MsgBox "Done. Ran " cycles " ascension cycle(s)."
}

ClickPoint(pt, times:=1){
    global clickDelay
    Loop times {
        MouseMove pt.x, pt.y, 0
        Click
        Sleep clickDelay
    }
}

Capture(prompt){
    MsgBox prompt
    KeyWait "Enter","D"
    KeyWait "Enter"
    MouseGetPos &x,&y
    return {x:x,y:y}
}
