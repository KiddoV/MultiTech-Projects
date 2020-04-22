num = 1000
Gui, 2:Font, s10, Verdana
Gui, 2:Color, EEAA99
Gui, 2:Add, Text  , vNum     , "%num%"
Gui, 2:Add, Button, vBtn x+10, %num%
Gui, 2:Add, Button,      x+10, Go
num=1
Gui, 2:Default
 GuiControl,,Num, "%num%"
 GuiControl,,Btn, %num%
Gui, 1:Default
Gui, 2:Show,,Chunk Displayed
return
2GuiClose:
 ExitApp

2ButtonGo:
 num++
 GuiControl,,Num, "%num%"
 GuiControl,,Btn, %num%
return