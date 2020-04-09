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

Gui Add, GroupBox, xm+305 ym+3 w225 h50 Section, Auto Generate NodeIDs
Gui, Add, Edit, xs+7 ys+22 w110 hwndHED1 vfirstNodeID Limit16
SetEditCueBanner(HED1, "First nodeIDs")
Gui, Add, Edit, xs+122 ys+22 w42 Limit4 +Number hwndHED2 vnodeAmout
SetEditCueBanner(HED2, "Amount")
Gui, Add, Button, xs+169 ys+21 w50 h22 ggenerateNode, Generate

Gui Add, GroupBox, xm+205 ym+3 w95 h50 Section, Browse NodeIDs
Gui, Add, Button, xs+13 ys+20 w70 gbrowseNode, Browse...

Gui Add, GroupBox, xm+1 ym+3 w200 h160 Section, xDot Pannel
Gui Font, Bold, Ms Shell Dlg 2
Gui Add, Button, xs+5 ys+15 w30 h30 vXDot01 gGetXDot, P01
Gui Add, Button, xs+37 ys+15 w30 h30 vXDot02 gGetXDot, P02
Gui Add, Button, xs+69 ys+15 w30 h30 vXDot03 gGetXDot, P03
Gui Add, Button, xs+101 ys+15 w30 h30 vXDot04 gGetXDot, P04
Gui Add, Button, xs+133 ys+15 w30 h30 vXDot05 gGetXDot, P05
Gui Add, Button, xs+165 ys+15 w30 h30 vXDot06 gGetXDot, P06

Gui Add, Button, xs+5 ys+50 w30 h30 vXDot07 gGetXDot, P07
Gui Add, Button, xs+37 ys+50 w30 h30 vXDot08 gGetXDot, P08
Gui Add, Button, xs+69 ys+50 w30 h30 vXDot09 gGetXDot, P09
Gui Add, Button, xs+101 ys+50 w30 h30 vXDot10 gGetXDot, P10
Gui Add, Button, xs+133 ys+50 w30 h30 vXDot11 gGetXDot, P11
Gui Add, Button, xs+165 ys+50 w30 h30 vXDot12 gGetXDot, P12

Gui Add, Button, xs+5 ys+85 w30 h30 vXDot13 gGetXDot, P13
Gui Add, Button, xs+37 ys+85 w30 h30 vXDot14 gGetXDot, P14
Gui Add, Button, xs+69 ys+85 w30 h30 vXDot15 gGetXDot, P15
Gui Add, Button, xs+101 ys+85 w30 h30 vXDot16 gGetXDot, P16
Gui Add, Button, xs+133 ys+85 w30 h30 vXDot17 gGetXDot, P17
Gui Add, Button, xs+165 ys+85 w30 h30 vXDot18 gGetXDot, P18

Gui Add, Button, xs+5 ys+120 w30 h30 vXDot19 gGetXDot, P19
Gui Add, Button, xs+37 ys+120 w30 h30 vXDot20 gGetXDot, P20
Gui Add, Button, xs+69 ys+120 w30 h30 vXDot21 gGetXDot, P21
Gui Add, Button, xs+101 ys+120 w30 h30 vXDot22 gGetXDot, P22
Gui Add, Button, xs+133 ys+120 w30 h30 vXDot23 gGetXDot, P23
Gui Add, Button, xs+165 ys+120 w30 h30 vXDot24 gGetXDot, P24
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

GuiClose:
    MsgBox 36, , Are you sure you want to quit?
    IfMsgBox Yes
        ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;;;
;;;;;;xdot GUIs
GetXDot:
    RegExMatch(A_GuiControl, "\d+$", num) ;Get button number based on button variable
    bttnParam := [ 
                + {mainPort: 101, breakPort: 11}    ;Variables on XDot01 and so on...
                , {mainPort: 102, breakPort: 12}    ;XDot02
                , {mainPort: 103, breakPort: 13}    ;XDot03
                , {mainPort: 104, breakPort: 14}    ;XDot04
                , {mainPort: 105, breakPort: 15}    ;XDot05
                , {mainPort: 106, breakPort: 16}
                , {mainPort: 107, breakPort: 17}
                , {mainPort: 108, breakPort: 18}
                , {mainPort: 109, breakPort: 19}
                , {mainPort: 110, breakPort: 20}
                , {mainPort: 111, breakPort: 21}
                , {mainPort: 112, breakPort: 22}
                , {mainPort: 113, breakPort: 23}
                , {mainPort: 114, breakPort: 24}
                , {mainPort: 115, breakPort: 25}
                , {mainPort: 116, breakPort: 26}
                , {mainPort: 117, breakPort: 27}
                , {mainPort: 118, breakPort: 28}
                , {mainPort: 119, breakPort: 29}
                , {mainPort: 120, breakPort: 30}
                , {mainPort: 121, breakPort: 31}
                , {mainPort: 122, breakPort: 32}
                , {mainPort: 123, breakPort: 33}
                , {mainPort: 124, breakPort: 34} ]  ;XDot24 ...
                
                global mainPort := bttnParam[num].mainPort
                global breakPort := bttnParam[num].breakPort
    
    ;;;GUI
    Gui, xdot: Default
    Gui -MinimizeBox -MaximizeBox +AlwaysOnTop
    Gui Font, Bold
    Gui xdot: Add, Text, x8 y8, COM PORT: %mainPort%
    Gui Font
    Gui xdot: Show, w222 h160, XDot %num%
    Return
    
    xdotGuiEscape:
    xdotGuiClose:
        Gui, xdot: Cancel
        Gui, xdot: Destroy
    
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

browseNode() {
    FileSelectFile, selectedFile, 3, , Select a NodeID text file..., Text Documents (*.txt; *.doc)
    if (selectedFile = "")
        return
    FileRead, outStr, %selectedFile%
    GuiControl Text, editNode, %outStr%
    
    ;xdotNodeArray := StrSplit(outStr, "`n", "`t", MaxParts := 25)
    ;MsgBox % xdotNodeArray.Length()
    ;MsgBox %  xdotNodeArray[24]
}

SetEditCueBanner(HWND, Cue) {  ; requires AHL_L
   Static EM_SETCUEBANNER := (0x1500 + 1)
   Return DllCall("User32.dll\SendMessageW", "Ptr", HWND, "Uint", EM_SETCUEBANNER, "Ptr", True, "WStr", Cue)
}

getCmdOut(command) {
    RunWait, PowerShell.exe -ExecutionPolicy Bypass -Command %command% | clip , , Hide
    return Clipboard
}
