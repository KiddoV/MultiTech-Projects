
#Include <RichCode>

; Settings array for the RichCode control
RCSettings :=
(LTrim Join Comments
{
    "TabSize": 4,
	"Indent": "`t",
    "FGColor": 0x3F3F3F,
    "BGColor": 0xFFFFFF,
    "Font": {"Typeface": "Consolas", "Size": 10},
    "WordWrap": False
}
)


#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Add, Text, x10 y10, Rich Code Lib Test
Gui Add, GroupBox, xm+5 ym+20 w600 h620 Section, Edit Field
Gui Add, Edit, xs+5 ys+15 w39 r25.3 -VScroll -HScroll -Border Disabled Right vlineNum
;Gui, Add, Edit, xs+43 ys+15 r24 hwndhEditBox w255 +HScroll veditNode
;Add Rich Code
RichCode := new RichCode(RCSettings, "xs+43 ys+15 w550 h300 +HScroll")
Global hEditBox := RichCode.hWnd
Gui Add, Button, x545 y5 gtestFunc, Test Button

Gui Show, w620 h655, Window

#Persistent
SetTimer, DrawLineNum, 1
Return

DrawLineNum:
    pos := DllCall("GetScrollPos", "UInt", hEditBox, "Int", 1)
    ToolTip % pos
    IfEqual, pos, % posPrev, return                       ;if nothing new
    posPrev := pos
    drawLineNumbers(pos)                                  ;draw line numbers
Return

drawLineNumbers(firstLine = "") {
    Local lines
    Static prevFirstLine
    prevFirstLine := firstLine != "" ? firstLine : prevFirstLine
    firstLine := prevFirstLine
    loop, 24
    {
        lines .= ++firstLine . "`n"
    }

    GuiControl,, lineNum, % lines
}

GuiEscape:
GuiClose:
    ExitApp
    
    
testFunc() {
    GuiControlGet, Code,, %hEditBox%
    
    MsgBox % Code
}

SendMsg(Msg, wParam, lParam)
	{
		SendMessage, Msg, wParam, lParam,, % "ahk_id" this.hWnd
		return ErrorLevel
	}