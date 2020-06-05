/*
    
*/
;=======================================================================================;
;;;Main Gui
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui, Add, Edit, xm+34 ym+24 w350 r35 Section +HScroll hWndheditField1 veditField1
Gui, Add, Edit, xs-34 ys+0 w35 r36.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField1

Gui, Add, Edit, xm+479 ym+24 w350 r35 Section +HScroll hWndheditField2 veditField2
Gui, Add, Edit, xs-34 ys+0 w35 r36.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField2

Gui, Add, Button, x30 gTest, Test Bttn

;;;Functions to run BEFORE main gui is started;;;

Gui Show, , YCD Auto Generator

;;;Functions to run AFTER main gui is started;;;

#Persistent
SetTimer, DrawLineNum1, 1
SetTimer, DrawLineNum2, 1
Return      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawLineNum1:
    pos1 := DllCall("GetScrollPos", "UInt", heditField1, "Int", 1)
    IfEqual, pos1, % posPrev1, return                       ;if nothing new
    posPrev1 := pos1
    drawLineNumbers(pos1, "lineNumEditField1")                     ;draw line numbers
Return

DrawLineNum2:
    pos2 := DllCall("GetScrollPos", "UInt", heditField2, "Int", 1)
    IfEqual, pos2, % posPrev2, return                       ;if nothing new
    posPrev2 := pos2
    drawLineNumbers(pos2, "lineNumEditField2")                     ;draw line numbers
Return

drawLineNumbers(firstLine = "", ctrlVar := "") {
    Local lines
    Static prevFirstLine
    prevFirstLine := firstLine != "" ? firstLine : prevFirstLine
    firstLine := prevFirstLine
    loop, 35
    {
        lines .= ++firstLine . "`n"
    }

    GuiControl,, %ctrlVar%, % lines
}

GuiEscape:
GuiClose:
    ExitApp
;=======================================================================================;    
;;;;;;;;;;;;;;;;;;MAIN FUNCTIONS;;;;;;;;;;;;;;;;;; 
Test() {
    GuiControlGet, editField1Content, , editField1
    Loop, Parse, editField1Content, `t`n
        MsgBox % "Index: "A_Index " is -----> " A_LoopField
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;HOT KEYS;;;;;;;;;;;;;;;;;;
^q::
    ExitApp
return