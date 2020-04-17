SetTitleMatchMode, RegEx

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Global index1 := 0
Global index2 := 0

Gui Add, Text, x46 y10, Main Thread:
Gui Add, Text, x200 y10 w50 vtmain, 0
Gui Add, Text, x46 y50, Thread 1: 
Gui Add, Text, x200 y50 w50 vt1, 0
Gui Add, Text, x46 y90, Thread 2: 
Gui Add, Text, x200 y90 w50 vt2, 0
Gui Add, Text, x46 y130, Thread 3: 
Gui Add, Text, x200 y130 w50 vt3, 0

Gui Add, Button, x147 y240 w80 h23 grun, RUN

Gui Show, w375 h297, Window
Return

GuiEscape:
GuiClose:
    ExitApp



run() {
    #Persistent
    SetTimer, MainThread, 200
    SetTimer, Thread1, 200
    SetTimer, Thread2, 200
    return
}

MainThread:
    ;index1++
    ;GuiControl, Text, tmain, %index1%
    ;if (index1 = 20) {
        ;SetTimer, MainThread, Off
    ;}
    WinWait MULTITECH
    If WinExist("MULTITECH") {
        MsgBox MULTITECH Exist!
        SetTimer, MainThread, Off
    }
Return


Thread1:
    ;index2++
    ;GuiControl, Text, t1, %index2%
    ;WinWait Notepad
    ;If WinExist("Notepad") {
        ;MsgBox Notepad Exist!
        SetTimer, Thread1, Off
    ;}
Return

Thread2:
    ;index2++
    ;GuiControl, Text, t1, %index2%
    ;WinWait Notepad
    If WinExist("Notepad") {
        MsgBox Notepad Exist!
        SetTimer, Thread2, Off
    }
Return

Thread3:
    ;index2++
    ;GuiControl, Text, t1, %index2%
    ;WinWait Notepad
    If WinExist("disable") {
        MsgBox disable Exist!
        SetTimer, Thread3, Off
    }
Return