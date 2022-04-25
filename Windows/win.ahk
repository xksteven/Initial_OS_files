#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

+^Up::
Send, {PgUp}
return

+^Down::
Send, {PgDn}
return

+^Left::
Send, {Home}
return

+^Right::
Send, {End}
return
