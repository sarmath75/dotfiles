#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

; #HotkeyInterval 12 ; This is the default value (milliseconds).
; #MaxHotkeysPerInterval 20000

global isAltMPressed := 0
global isCtrlUPressed := 0
global isCapsLockOn := GetKeyState("CapsLock", "T")

SetTimer, ClearPrefixKeys, 2500
return

ClearPrefixKeys:
;OutputDebug, "executing ClearPrefixKeys..."
isAltMPressed := 0
isCtrlUPressed := 0
return

; right alt to right control
RAlt::RCtrl

ForwardWord() {
    Send ^{RIGHT}
}

BackwardWord() {
    Send ^{LEFT}
}

#If WinActive("ahk_exe eclipse.exe")
    b::
    if (isAltMPressed > 0) {
        Send !m
    }
    isCapsLockOn := GetKeyState("CapsLock", "T")
    if (isCapsLockOn > 0) {
       Send B
    } else {
       Send b
    }
    return

    !f::
    if (isAltMPressed > 0) {
        Send !m
        Send !f
    } else
        ForwardWord()
    return

    m::
    if (isAltMPressed > 0) {
        Send !m
    }
    isCapsLockOn := GetKeyState("CapsLock", "T")
    if (isCapsLockOn > 0) {
       Send M
    } else {
       Send m
    }
    return
#If

#If WinActive("ahk_exe cmd.exe")
    ^a::
    Send {HOME}
    return

    ^e::
    Send {END}
    return

    ^m::
    Send {ENTER}
    return
#If

#If WinActive("ahk_exe mintty.exe")
    ^a::
    Send {HOME}
    return
#If

#If !WinActive("ahk_exe cmd.exe") and !WinActive("ahk_exe mintty.exe") and !WinActive("ahk_class Emacs")
    !+,::
    Send ^{HOME}
    return

    !+.::
    Send ^{END}
    return

    !m::
    isAltMPressed := 1
    return

    ^u::
    isCtrlUPressed := 1
    return

    ^g::
    isAltMPressed := 0
    isCtrlUPressed := 0
    Send {ESC}
    return

    ^a::
    Send {HOME}
    return

    ^e::
    Send {END}
    return

    ^b::
    Send {LEFT}
    return

    ^f::
    Send {RIGHT}
    return

    ^p::
    Send {UP}
    return

    ^n::
    Send {DOWN}
    return

    !b::
    BackwardWord()
    return

    !f::
    ForwardWord()
    return

    !BS::
    Send ^{BS}
    return

    ^d::
    Send {DEL}
    return

    !d::
    Send ^{DEL}
    return

    ^k::
    if (isCtrlUPressed > 0)
        Send +{HOME}
    else
        Send +{END}
    Send ^x
    return

    ^m::
    Send {ENTER}
    return

    s::
    if (isAltMPressed > 0) {
        Send ^+s
    } else {
        isCapsLockOn := GetKeyState("CapsLock", "T")
        if (isCapsLockOn > 0) {
            Send S
        } else {
            Send s
        }
    }
    return

    ^s::
    if (isAltMPressed > 0)
        Send ^s
    else
        Send ^f
    return
#If
