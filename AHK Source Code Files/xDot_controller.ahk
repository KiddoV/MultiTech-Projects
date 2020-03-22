/*
    Author: Viet Ho
*/
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance force
#NoEnv

Gui Add, GroupBox, xm+205 ym+3 w324 h485 Section, xDot Node IDs
Gui, Add, Edit, xs+10 y31 w35 r34.3 -VScroll -HScroll -Border Disabled Right vlineNo
Gui Font, Bold q5, Consolas
Gui, Add, Edit, xs+45 y31 r33 hwndEdit w270 +HScroll veditNode
Gui Font
Gui, Show, w550 h500, xDot Controller

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
loop, 33
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
^g::
GuiControl Text, editNode, % autoGenerateNodeID(0x08000fafbbfff1, 500)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
/*
    Return a list of node in String
*/
autoGenerateNodeID(firstNode, amount) {
    amount -= 1
    listNode := [firstNode]     ;included first node
    listNodeStr := ""
    
    SetFormat Integer, Hex      ;convert value to Hex
    Loop, %amount%
    {
        firstNode += 1
        listNode.Push(firstNode)
    }
    
    For index, value In listNode
    {
        listNodeStr .= "`n" . value 
    }
    listNodeStr := LTrim(listNodeStr, "`n")     ;remove first while space
    
    StringReplace, listNodeStr, listNodeStr, 0x, 0, All
    return listNodeStr
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
