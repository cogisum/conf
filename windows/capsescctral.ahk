; Author: fwompner gmail com
#InstallKeybdHook
SetCapsLockState, alwaysoff
Capslock::
Send {LControl Down}
KeyWait, CapsLock
Send {LControl Up}
if ( A_PriorKey = "CapsLock" )
{
	Send {Esc}
}
return

; Note that this doesn't deal with shift pressed before ctrl, e.g. shift+ctrl+T won't work, while ctrl+shift+T do.
; [1] http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_Windows
; [2] https://gist.github.com/sedm0784/4443120
; [3] http://superuser.com/questions/381296/mapping-caps-lock-to-escape-and-control-on-windows-7