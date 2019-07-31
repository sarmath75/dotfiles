#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

; SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

; #HotkeyInterval 12 ; This is the default value (milliseconds).
; #MaxHotkeysPerInterval 20000

global isAltMPressed := 0
global isCtrlUPressed := 0
global isCapsLockOn := GetKeyState("CapsLock", "T")

ClearAltM:
isAltMPressed := 0
return

ClearCtrlU:
isCtrlUPressed := 0
return

isPassthroughWin() {
    return WinActive("ahk_exe eclipse.exe")
        or WinActive("ahk_exe idea.exe")
        or WinActive("ahk_exe idea64.exe")
        or WinActive("ahk_exe webstorm.exe")
        or WinActive("ahk_exe webstorm64.exe")
}

; right alt to right control
RAlt::RCtrl

#If !WinActive("ahk_class Emacs")

^g::
isAltMPressed := 0
isCtrlUPressed := 0
Send {ESC}
return

!m::
isAltMPressed := 1
if isPassthroughWin() {
   Send {Alt down}{m}
}
SetTimer, ClearAltM, -3000
return

^m::
if (isAltMPressed > 0) {
    Send ^{m}
} else {
    Send {ENTER}
}
return

^u::
isCtrlUPressed := 1
if isPassthroughWin() {
   Send {Ctrl down}{u}
}
SetTimer, ClearCtrlU, -3000
return

^a::
if (isAltMPressed > 0) {
    Send ^{a}
} else {
    Send {HOME}
}
return

!b::
if (isAltMPressed > 0) {
    Send !{b}
} else {
    Send ^{LEFT}
}
return

^b::
if (isAltMPressed > 0) {
    Send ^{b}
} else {
    Send {LEFT}
}
return

!d::
if (isAltMPressed > 0) {
    Send !{d}
} else {
    Send ^{DEL}
}
return

^d::
if (WinActive("ahk_exe cmd.exe")) {
    Send ^{d}
} else if (isAltMPressed > 0) {
    Send ^{d}
} else {
    Send {DEL}
}
return

^e::
if (isAltMPressed > 0) {
    Send ^{e}
} else {
    Send {END}
}
return

!f::
if (isAltMPressed > 0) {
    Send !{f}
} else {
    Send ^{RIGHT}
}
return

^f::
if (isAltMPressed > 0) {
    Send ^{f}
} else {
    Send {RIGHT}
}
return

^i::
if (isAltMPressed > 0) {
    Send ^{i}
} else {
    Send {TAB}
}
return

^k::
if (isCtrlUPressed > 0)
    Send +{HOME}
else
    Send +{END}
Send ^x
return

^n::
if (isAltMPressed > 0) {
    Send ^{n}
} else {
    Send {DOWN}
}
return

^p::
if (isAltMPressed > 0) {
    Send ^{p}
} else {
    Send {UP}
}
return

^s::
if (isAltMPressed > 0) {
    Send ^{s}
} else {
    Send ^{f}
}
return

!BS::
Send ^{BS}
return

!+,::
Send ^{HOME}
return

!+.::
Send ^{END}
return

#If
