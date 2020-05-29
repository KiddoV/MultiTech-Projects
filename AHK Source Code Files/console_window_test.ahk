#Include <Class_RichEdit>

Gui, Add, Text,, Hello Reddit!
log := new RichEdit(1, "w500 h400")
log.SetBkgndColor(0x2C292D)
log.SetOptions([""], "Set")
log.SetDefaultFont({"Name": "Courier New", "Color": 0xFDF9F3, "Size": 12})
Gui, Add, Button, , Test Button
Gui, Show

palette := {"red": 0xFF6188, "orange": 0xFC9867, "yellow": 0xFFD866, "green": 0xA9DC76, "blue": 0x78DCE8, "purple": 0xAB9DF2}


AppendRE(log, "Hello ", [palette.orange, "World"], [palette.purple, "!"], " This is ", [palette.red, "a"], " test.")
;;MsgBox
AppendRE(log, [palette.orange, "Viet"], " ", [palette.purple, "Ho"])
warnings := [[palette.green, "Sucess!"], [palette.yellow, "Warning!"], [palette.red, "Error!"], [palette.purple, "Info:"]]

outputs := ["www.vietho.com", "Generic"
, "General system failure"
, "Task failed successfully"
, "nyan nyan nyan nyan nyan"
, "Λορεμ ιπσθμ δολορ σιτ αμετ"
, "Εοσ σολθμ λαορεετ αλιενθμ ιν"
, "詳原経体名録暮徴索民台付論能掲尚案連"]
while True
{
	Random, warning, 1, warnings.length()
	Random, error, 1, outputs.length()
    
	AppendRE(log
	, [palette.blue, Format("[{:04}] ", A_Index)]
	, warnings[warning]
	, " " outputs[error])
	
	sleep, 500
    ;if (A_Index = 5)
        ;Break
}
return

Test:
   log.AlignText(7)
Return


AppendRE(RE, texts*)
{
	static WM_VSCROLL := 0x115, SB_BOTTOM := 7, CP_UTF8 := 65001
	GuiControl, -Redraw, % RE.hWnd

	 ;Generate an RTF document based on the given input
	font := RE.GetFont(1)
	colors := {rgb := font.Color: max_color := 1}
 	colortbl := "\red" rgb>>16&0xFF "\green" rgb>>8&0xFF "\blue" rgb&0xFF ";"
	for i, v in texts
	{
		color := 1
		if IsObject(v)
		{
			rgb := v[1], v := v[2]
			if colors[rgb]
				color := colors[rgb]
			else
			{
				 ;Add a new color table entry
				color := colors[rgb] := ++max_color
				colortbl .= "\red" rgb>>16&0xFF "\green" rgb>>8&0xFF "\blue" rgb&0xFF ";"
			}
		}
		text .= "\cf" color " " RegExReplace(v, "[\\{}\r\n]", "\$0")
	}
	fonttbl := "{\fonttbl{\f0\fmodern\fcharset0 " font.Name ";}}"
	rtf := "{\rtf{\colortbl;" colortbl "}" fonttbl "\fs" Round(font.Size)*2 " " text "\`n}"

	 ;;Move cursor to end of document and paste
	sel := RE.GetSel()
	len := RE.GetTextLen()
	RE.SetSel(len, len)
	
	 ;;Replace selection with rtf
    VarSetCapacity(bRTF, StrPut(rtf, "CP" CP_UTF8))
	StrPut(rtf, &bRTF, "CP" CP_UTF8)
    VarSetCapacity(SETTEXTEX, 8, 0)
    NumPut(2      , SETTEXTEX, 0, "UInt") ; DWORD flags
    NumPut(CP_UTF8, SETTEXTEX, 4, "UInt") ; UINT  codepage
    SendMessage, 0x461, &SETTEXTEX, &bRTF,, % "ahk_id " . RE.hWnd

	 ;;Restore selection or scroll appropriately
	if (Sel.S == Len)
	{
		GuiControl, +Redraw, % RE.hWnd
		SendMessage, WM_VSCROLL, SB_BOTTOM, 0,, % "ahk_id" RE.hWnd
	}
	else
	{
		RE.SetSel(Sel.S, Sel.E)
		GuiControl, +Redraw, % RE.hWnd
	}
}