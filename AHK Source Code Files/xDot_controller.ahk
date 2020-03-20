/*
    Author: Viet Ho
*/
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance force
#NoEnv

Gui Add, GroupBox, xm+205 ym+3 w324 h485 Section, xDot Node IDs
Gui, Add, Edit, xs+10 y31 w35 r34.3 -VScroll -HScroll -Border Disabled Right vlineNo
Gui, Add, Edit, xs+45 y31 r33 hwndEdit w270 +HScroll vedit , % text
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

GuiControlGet, edit, Pos, edit

SetTimer, timer, 1
return

timer:
pos := DllCall("GetScrollPos", "UInt", Edit, "Int", 1)
ifEqual, pos, % posPrev, return                       ; nothing new
posPrev := pos
drawLineNumbers(pos)                                  ; draw line numbers
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
    
