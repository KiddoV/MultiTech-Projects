/*
    Author: Viet Ho
*/
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance force
#NoEnv

Gui Add, GroupBox, xm+205 ym+55 w325 h370 Section, xDot NodeIDs
Gui, Add, Edit, xs+10 ys+22 w35 r25.3 -VScroll -HScroll -Border Disabled Right vlineNo
Gui Font, Bold q5, Consolas
Gui, Add, Edit, xs+45 ys+22 r24 hwndEdit w270 +HScroll veditNode
Gui Font

Gui Add, GroupBox, xm+300 ym+3 w230 h50 Section, Auto Generate NodeIDs
Gui, Add, Edit, xs+10 ys+22 w110 hwndHED1 vfirstNodeID Limit16
SetEditCueBanner(HED1, "First nodeIDs")
Gui, Add, Edit, xs+124 ys+22 w42 Limit4 +Number hwndHED2 vnodeAmout
SetEditCueBanner(HED2, "Amount")
Gui, Add, Button, xs+170 ys+22 w50 h21 ggenerateNode, Generate

Gui Add, GroupBox, xm+1 ym+3 w200 h160 Section, xDot Pannel
Gui Font, Bold, Ms Shell Dlg 2
Gui Add, Button, xs+5 ys+15 w30 h30, P01
Gui Add, Button, xs+37 ys+15 w30 h30, P02
Gui Add, Button, xs+69 ys+15 w30 h30, P03
Gui Add, Button, xs+101 ys+15 w30 h30, P04
Gui Add, Button, xs+133 ys+15 w30 h30, P05
Gui Add, Button, xs+165 ys+15 w30 h30, P06

Gui Add, Button, xs+5 ys+50 w30 h30, P07
Gui Add, Button, xs+37 ys+50 w30 h30, P08
Gui Add, Button, xs+69 ys+50 w30 h30, P09
Gui Add, Button, xs+101 ys+50 w30 h30, P10
Gui Add, Button, xs+133 ys+50 w30 h30, P11
Gui Add, Button, xs+165 ys+50 w30 h30, P12

Gui Add, Button, xs+5 ys+85 w30 h30, P13
Gui Add, Button, xs+37 ys+85 w30 h30, P14
Gui Add, Button, xs+69 ys+85 w30 h30, P15
Gui Add, Button, xs+101 ys+85 w30 h30, P16
Gui Add, Button, xs+133 ys+85 w30 h30, P17
Gui Add, Button, xs+165 ys+85 w30 h30, P18

Gui Add, Button, xs+5 ys+120 w30 h30, P19
Gui Add, Button, xs+37 ys+120 w30 h30, P20
Gui Add, Button, xs+69 ys+120 w30 h30, P21
Gui Add, Button, xs+101 ys+120 w30 h30, P22
Gui Add, Button, xs+133 ys+120 w30 h30, P23
Gui Add, Button, xs+165 ys+120 w30 h30, P24
Gui Font


Gui, Show, w550 h500, xDot Controller

GuiControlGet, editNode, Pos, editNode

SetTimer, timer, 1
return

timer:
pos := DllCall("GetScrollPos", "UInt", Edit, "Int", 1)
ifEqual, pos, % posPrev, return                       ;if nothing new
posPrev := pos
drawLineNumbers(pos)                                  ;draw line numbers
return

drawLineNumbers(firstLine = "") {
local lines
static prevFirstLine
prevFirstLine := firstLine != "" ? firstLine : prevFirstLine
firstLine := prevFirstLine
loop, 24
{
    lines .= ++firstLine . "`n"
}

GuiControl,, lineNo, % lines
}

GuiEscape:
GuiClose:
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
generateNode() {
    GuiControlGet, firstNodeID
    GuiControlGet, nodeAmout
    
    if (StrLen(firstNodeID) < 16) {
        MsgBox NodeID should have 16 digits!
        return
    } else if (RegExMatch(firstNodeID, "^[0-9A-Fa-f]+$") = 0) {
        MsgBox Please enter only Hexadecimal for NodeID!
        return
    } else if (StrLen(nodeAmout) < 1) {
        MsgBox Please enter an amount for NodeID!
        return
    }
    
    firstNodeID = 0x%firstNodeID%   ;convert value to Hex
    
    GuiControl Text, editNode, % autoGenerateNodeID(firstNodeID, nodeAmout)
}

/*
    Return a list of node in String
*/
autoGenerateNodeID(firstNode, amount) {
    listNode := []
    listNodeStr := ""
    SetFormat Integer, Hex      ;convert value to Hex
    index := 0
    Loop, %amount%
    {
        firstNode += index
        listNode.Push(firstNode)
        index++
    }
    ;00800FAFAFAFAFAF
    For index, value In listNode
    {
        listNodeStr .= "`n" . value
    }
    listNodeStr := LTrim(listNodeStr, "`n")     ;remove first while space
    
    SetFormat Integer, D
    nodelength := StrLen(firstNode)
    if (nodelength = 16)
        StringReplace, listNodeStr, listNodeStr, 0x, 00, All
    else if (nodelength = 17)
        StringReplace, listNodeStr, listNodeStr, 0x, 0, All
    else if (nodelength = 18)
        StringReplace, listNodeStr, listNodeStr, 0x, , All
        
    return listNodeStr
}

SetEditCueBanner(HWND, Cue) {  ; requires AHL_L
   Static EM_SETCUEBANNER := (0x1500 + 1)
   Return DllCall("User32.dll\SendMessageW", "Ptr", HWND, "Uint", EM_SETCUEBANNER, "Ptr", True, "WStr", Cue)
}
/*
;Open file location
Gui, Add, Button, gBrowse x316 y60 w90 h20 v1, Browse
Gui, Add, Button,gBrowse x316 y80 w90 h20 v2, Browse
Gui, Add, Button,gBrowse x316 y100 w90 h20 v3, Browse
Gui, Add, Edit, x106 y80 w190 h20 vSelect1, Select1
Gui, Add, Edit, x106 y100 w190 h20 vSelect2, Select2
; Generated using SmartGUI Creator 4.0
Gui, Show, x171 y142 h458 w645, New GUI Window
Return


Browse:
FileSelectFile, SelectedFile, 3, , Open a file
GuiControl,,Select%A_GuiControl%,%SelectedFile%
Return
*/
