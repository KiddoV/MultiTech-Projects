; Viet Ho

SetTitleMatchMode, RegEx

;;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Add, Edit, x8 y8 w295 h227 vdisplayStr +ReadOnly
Gui Add, Edit, x8 y243 w295 vcommandIn,

;Run cmd in background
DetectHiddenWindows, On
Run %ComSpec%,, Hide, pid
WinWait ahk_pid %pid%
DllCall("AttachConsole", "UInt", pid)
Global objShell := ComObjCreate("WScript.Shell")

Gui Show, , CMD WINDOWs
displayOutput()

Return

GuiEscape:
GuiClose:
    Process Close, %pid%
    WScript.Quit()
    DllCall("FreeConsole")
    ExitApp
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

displayOutput() {
    output := ""
    objExec := pushCommand()
    while, !objExec.StdOut.AtEndOfStream
    {
        output .= objExec.StdOut.Read(10)
        ControlSetText, Edit1, %output%, CMD WINDOWs
    }
}
pushCommand() {
    ;GuiControlGet, command, ,commandIn
    command = ping 8.8.8.8
    objExec := objShell.Exec(command)
    ;ControlSetText, Edit2, ,CMD WINDOWs
    return objExec 
}
