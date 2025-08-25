Cookie Clicker Endless Cycle Macro — README

This app is a compiled AutoHotkey v2 script that automates a fast ascend
→ reincarnate loop in the Steam version of Cookie Clicker.
It uses per‑monitor DPI awareness and absolute screen coordinates for
reliable clicking on mixed‑DPI multi‑monitor setups.

------------------------------------------------------------------------

What it does (per cycle)

1.  Sets Buy Amount (you should have it on Max/100/10/1 as desired).
2.  For ~1.8 seconds it loops: Grandma → Cursor → Buy All Upgrades.
3.  Scrolls down the store and buys You (once, maxed).
4.  Scrolls back up to the top of the store.
5.  Spams Buy All Upgrades for ~0.8 seconds.
6.  Clicks Legacy → Ascend → waits 5.5s → Reincarnate → Yes.
7.  Waits a short buffer and repeats for the number of cycles you enter.

  The exact timings, scroll step counts, and delays are configurable
  (see Config).

------------------------------------------------------------------------

Requirements

-   Windows 10/11.
-   Cookie Clicker (Steam) running windowed on the monitor you plan to
    use.
-   This compiled EXE (no AutoHotkey install required).
    If running the .ahk script instead of the EXE, install AutoHotkey
    v2.

------------------------------------------------------------------------

First run — Calibration

The app guides you through a simple calibration. For each prompt:

1.  Hover the requested UI element in Cookie Clicker.
2.  Press Enter to capture the point.

Calibration sequence:

-   BuyAmtBtn — Buy Amount (Max/100/10/1, at the top of the store).
-   Grandma — the Grandma building tile (icon area).
-   Cursor — the Cursor building tile (icon area).
-   BuyAllUpgrades — the button under the upgrade icons.
-   ScrollAnchor — any spot in the store/scrollbar area where the mouse
    wheel scrolls the store.
-   You — scroll manually so You is visible once, then capture it.
-   Legacy — top‑right “Legacy” button.
-   Ascend — the confirm button in the Ascend popup.
-   Reincarnate — the Reincarnate button after ascending.
-   ReincarnateYes — the final “Yes” confirmation for reincarnating.

  Tip: After calibration, do not resize or move the Cookie Clicker
  window. If you do, re‑run the EXE and recalibrate (it only takes a few
  seconds).

------------------------------------------------------------------------

Usage

1.  Run the EXE.
2.  Complete the calibration prompts.
3.  When asked, enter the number of ascensions to run (start with 1 to
    verify).
4.  Watch it go. If anything is misaligned, just close the EXE and rerun
    to recalibrate.

------------------------------------------------------------------------

Hotkeys

This build does not add global hotkeys by design (no background
interception).
Control is via the pop‑up prompts only.

  Want hotkeys (pause/resume, test calibration, dry‑run)? They can be
  added easily later, but this EXE sticks to the stable, prompt‑only
  flow you locked in.

------------------------------------------------------------------------

Config (edit only if you recompile)

You can tweak these values near the top of the script before compiling:

    global clickDelay := 100                 ; ms between clicks
    global grandmaCursorUpgradeDuration := 1800 ; ms, duration of the Grandma→Cursor→Upgrades loop
    global upgradesDuration := 800           ; ms, spam Buy All Upgrades after buying You
    global waitBeforeReincarnate := 5500     ; ms, delay after Ascend before clicking Reincarnate
    global loopGapMs := 2000                 ; ms, buffer between cycles
    global scrollStepsForYou := 6            ; how many WheelDown steps to reveal You
    global scrollDelayMs := 50               ; ms between scroll wheel events

Adjusting scroll:
If “You” isn’t visible, increase scrollStepsForYou (e.g., 8–12). If it
scrolls too far, decrease it. The script performs a double pass (two
scroll loops) down and back up for safety.

------------------------------------------------------------------------

Tips & Troubleshooting

-   Click misses slightly: Re‑run and recalibrate. Don’t resize/move the
    game window afterward.
-   Multi‑monitor drift: Run CC on the primary monitor or keep it on one
    monitor consistently during runs.
-   Protected clicks: If the EXE can’t move/click, try Run as
    Administrator.
-   Game updates/UI scale changes: recalibrate once and you’re good.

------------------------------------------------------------------------

Safety

This macro automates clicking inside Cookie Clicker only. Use at your
own risk.
Don’t use while typing in other apps—keep the CC window focused during
runs.

------------------------------------------------------------------------

Credits

-   Script logic: RenegadeChicken + ChatGPT (iterative build).
-   Tech: AutoHotkey v2; per‑monitor DPI awareness; absolute screen
    coordinates.

Enjoy your ascension grind. 🍪
