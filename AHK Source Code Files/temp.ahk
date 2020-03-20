#NoEnv
#SingleInstance force

loop 100
  text.="Line " a_index "`n"

Gui, +resize
Gui, Margin, 5, 5
Gui, Add, Edit, vlineNo +readOnly r10 -vscroll -hscroll -border w35 disabled
Gui, Add, Edit, vedit xp+35 yp hwndEdit ys r10 w200, % text
Gui, Show,, LineNumbers
GuiControlGet, edit, Pos, edit
LINE_HEIGHT:=editH/10           ; calc. line height
SetTimer, timer, 10
return

timer:
pos:=DllCall("GetScrollPos", "UInt", Edit, "Int", 1)
ifEqual, pos, % posPrev, return                       ; nothing new
posPrev:=pos
drawLineNumbers(pos)                                  ; draw line numbers
return

drawLineNumbers(firstLine="") {
local lines
static prevFirstLine
prevFirstLine:=firstLine!="" ? firstLine : prevFirstLine
firstLine:=prevFirstLine
loop % ceil(EDIT_HEIGHT/LINE_HEIGHT)+1
  lines.=++firstLine . "`n"
GuiControl,, lineNo, % lines
}

GuiSize:
GuiControlGet, lineNo, Pos, lineNo
GuiControl, Move, edit, % "w" a_guiwidth-15-lineNoW "h" a_guiheight-10
GuiControl, Move, lineNo, % "h" a_guiheight-10
EDIT_HEIGHT:=a_guiHeight-10
drawLineNumbers()
return

GuiClose:
exitApp