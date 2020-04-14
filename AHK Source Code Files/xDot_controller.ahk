/*
    Author: Viet Ho
*/
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance force
#NoEnv

Gui +hWndhMainWnd
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

Gui Add, GroupBox, xm+1 ym+3 w200 h160 vxdotPanel Section, xDot Panel
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

;Bad Xdot Panel
Gui Add, Button, xs+5 ys+15 w30 h30 vBadXDot01 hWndhXButton1 Hidden
Gui Add, Button, xs+37 ys+15 w30 h30 vBadXDot02 hWndhXButton2 Hidden
Gui Add, Button, xs+69 ys+15 w30 h30 vBadXDot03 hWndhXButton3 Hidden
Gui Add, Button, xs+101 ys+15 w30 h30 vBadXDot04 hWndhXButton4 Hidden
Gui Add, Button, xs+133 ys+15 w30 h30 vBadXDot05 hWndhXButton5 Hidden
Gui Add, Button, xs+165 ys+15 w30 h30 vBadXDot06 hWndhXButton6 Hidden

Gui Add, Button, xs+5 ys+50 w30 h30 vBadXDot07 hWndhXButton7 Hidden
Gui Add, Button, xs+37 ys+50 w30 h30 vBadXDot08 hWndhXButton8 Hidden
Gui Add, Button, xs+69 ys+50 w30 h30 vBadXDot09 hWndhXButton9 Hidden
Gui Add, Button, xs+101 ys+50 w30 h30 vBadXDot10 hWndhXButton10 Hidden
Gui Add, Button, xs+133 ys+50 w30 h30 vBadXDot11 hWndhXButton11 Hidden
Gui Add, Button, xs+165 ys+50 w30 h30 vBadXDot12 hWndhXButton12 Hidden

Gui Add, Button, xs+5 ys+85 w30 h30 vBadXDot13 hWndhXButton13 Hidden
Gui Add, Button, xs+37 ys+85 w30 h30 vBadXDot14 hWndhXButton14 Hidden
Gui Add, Button, xs+69 ys+85 w30 h30 vBadXDot15 hWndhXButton15 Hidden
Gui Add, Button, xs+101 ys+85 w30 h30 vBadXDot16 hWndhXButton16 Hidden
Gui Add, Button, xs+133 ys+85 w30 h30 vBadXDot17 hWndhXButton17 Hidden
Gui Add, Button, xs+165 ys+85 w30 h30 vBadXDot18 hWndhXButton18 Hidden

Gui Add, Button, xs+5 ys+120 w30 h30 vBadXDot19 hWndhXButton19 Hidden
Gui Add, Button, xs+37 ys+120 w30 h30 vBadXDot20 hWndhXButton20 Hidden
Gui Add, Button, xs+69 ys+120 w30 h30 vBadXDot21 hWndhXButton21 Hidden
Gui Add, Button, xs+101 ys+120 w30 h30 vBadXDot22 hWndhXButton22 Hidden
Gui Add, Button, xs+133 ys+120 w30 h30 vBadXDot23 hWndhXButton23 Hidden
Gui Add, Button, xs+165 ys+120 w30 h30 vBadXDot24 hWndhXButton24 Hidden

;;Add icon for each button above
Loop, 24
{
    buttonHandleName = hXButton%A_Index%
    GuiButtonIcon(%buttonHandleName%, "C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x-mark.png", 1, "s24")
}

;OnMessage(0x204, "xdotbttnRightClick") ;When right click button

posX := A_ScreenWidth - 600
Gui, Show, w550 h500 x%posX% y150, xDot Controller

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
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;;;
;;;;;;xdot GUIs
GetXDot:
    WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%
    Gui, xdot: Cancel
    RegExMatch(A_GuiControl, "\d+$", num) ;Get button number based on button variable
    
    global bttnParams := [{}]  ; Creates an array containing an object.
    bttnParams[1] := {mainPort: 100, breakPort: 10, portName: "PORT1", driveName: "XDRIVE-01", ttXPos: 5, ttYPos: 5}
    bttnParams[2] := {mainPort: 102, breakPort: 12, portName: "PORT2", driveName: "XDRIVE-02", ttXPos: 105, ttYPos: 5}  ;XDot02
    bttnParams[3] := {mainPort: 103, breakPort: 13, portName: "PORT3", driveName: "XDRIVE-03", ttXPos: 205, ttYPos: 5}  ;XDot03
    bttnParams[4] := {mainPort: 104, breakPort: 14, portName: "PORT4", driveName: "XDRIVE-04", ttXPos: 305, ttYPos: 5}  ;XDot04
    bttnParams[5] := {mainPort: 105, breakPort: 15, portName: "PORT5", driveName: "XDRIVE-05", ttXPos: 405, ttYPos: 5}  ;XDot05
    bttnParams[6] := {mainPort: 106, breakPort: 16, portName: "PORT6", driveName: "XDRIVE-06", ttXPos: 505, ttYPos: 5}
    bttnParams[7] := {mainPort: 107, breakPort: 17, portName: "PORT7", driveName: "XDRIVE-07", ttXPos: 5, ttYPos: 105}
    bttnParams[8] := {mainPort: 108, breakPort: 18, portName: "PORT8", driveName: "XDRIVE-08", ttXPos: 105, ttYPos: 105}
    bttnParams[9] := {mainPort: 109, breakPort: 19, portName: "PORT9", driveName: "XDRIVE-09", ttXPos: 205, ttYPos: 105}
    bttnParams[10] := {mainPort: 110, breakPort: 20, portName: "PORT10", driveName: "XDRIVE-10", ttXPos: 305, ttYPos: 105}
    bttnParams[11] := {mainPort: 111, breakPort: 21, portName: "PORT11", driveName: "XDRIVE-11", ttXPos: 405, ttYPos: 105}
    bttnParams[12] := {mainPort: 112, breakPort: 22, portName: "PORT12", driveName: "XDRIVE-12", ttXPos: 505, ttYPos: 105}
    bttnParams[13] := {mainPort: 113, breakPort: 23, portName: "PORT13", driveName: "XDRIVE-13", ttXPos: 5, ttYPos: 205}
    bttnParams[14] := {mainPort: 114, breakPort: 24, portName: "PORT14", driveName: "XDRIVE-14", ttXPos: 105, ttYPos: 205}
    bttnParams[15] := {mainPort: 115, breakPort: 25, portName: "PORT15", driveName: "XDRIVE-15", ttXPos: 205, ttYPos: 205}
    bttnParams[16] := {mainPort: 116, breakPort: 26, portName: "PORT16", driveName: "XDRIVE-16", ttXPos: 305, ttYPos: 205}
    bttnParams[17] := {mainPort: 117, breakPort: 27, portName: "PORT17", driveName: "XDRIVE-17", ttXPos: 405, ttYPos: 205}
    bttnParams[18] := {mainPort: 118, breakPort: 28, portName: "PORT18", driveName: "XDRIVE-18", ttXPos: 505, ttYPos: 205}
    bttnParams[19] := {mainPort: 119, breakPort: 29, portName: "PORT19", driveName: "XDRIVE-19", ttXPos: 5, ttYPos: 305}
    bttnParams[20] := {mainPort: 120, breakPort: 30, portName: "PORT20", driveName: "XDRIVE-20", ttXPos: 105, ttYPos: 305}
    bttnParams[21] := {mainPort: 121, breakPort: 31, portName: "PORT21", driveName: "XDRIVE-21", ttXPos: 205, ttYPos: 305}
    bttnParams[22] := {mainPort: 122, breakPort: 32, portName: "PORT22", driveName: "XDRIVE-22", ttXPos: 305, ttYPos: 305}
    bttnParams[23] := {mainPort: 123, breakPort: 33, portName: "PORT23", driveName: "XDRIVE-23", ttXPos: 405, ttYPos: 305}
    bttnParams[24] := {mainPort: 124, breakPort: 34, portName: "PORT24", driveName: "XDRIVE-24", ttXPos: 505, ttYPos: 305}  ;XDot24
                
    mainPort := bttnParams[num].mainPort
    breakPort := bttnParams[num].breakPort
    portName := bttnParams[num].portName
    driveName := bttnParams[num].driveName
    ttXPos := bttnParams[num].ttXPos    ;Position X for teraterm window
    ttYPos := bttnParams[num].ttYPos    ;Position Y for teraterm window
    
    ;;;GUI
    Gui, xdot: Default
    Gui -MinimizeBox -MaximizeBox +AlwaysOnTop
    Gui Font, Bold
    Gui xdot: Add, Text, x8 y8, COM PORT: %mainPort%
    Gui xdot: Add, Text, x120 y8, BREAK PORT: %breakPort%
    Gui Font
    Gui xdot: Add, Button, x8 y30 gFunctionalTestEach, Functional Test
    mainY := mainY + 210
    Gui xdot: Show, x%mainX% y%mainY%, XDot %num%
Return
    
    FunctionalTestEach:
        WinKill COM%mainPort%
        Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\Users\Administrator\Desktop\initest.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_test.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%"", ,Hide
    Return
    
xdotGuiEscape:
xdotGuiClose:
    Gui, xdot: Destroy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q:: ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
GuiContextMenu: ;Launched whenever the user right-clicks anywhere in the window except the title bar and menu bar
    GuiControlGet, hvar, Hwnd , A_GuiControl
    MsgBox %hvar%
Return

xdotbttnRightClick() {
    ToolTip %A_GuiControl%
    MouseGetPos,,,,ControlName
    buttonClassName := ""
    Loop, 30
    {
        if (A_Index > 6) {
            buttonClassName = Button%A_Index%
            if (ControlName = buttonClassName) {
                badXdotBttnName = Bad%A_GuiControl%
                changeXdotButtonIcon("Failed", A_GuiControl, badXdotBttnName)
                return
            }
        }
    }
    
}

changeXdotButtonIcon(icon, xdotBttnName, badXdotBttnName) {
    if (icon = "Failed") {
        ;ToolTip %xdotBttnName% %badXdotBttnName%
        GuiControl, Hide, %xdotBttnName%
        GuiControl, Show, %badXdotBttnName%
    } else {
        ;ToolTip %xdotBttnName% %badXdotBttnName%
        GuiControl, Show, %xdotBttnName%
        GuiControl, Hide, %badXdotBttnName%
    }
}

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

GuiButtonIcon(Handle, File, Index := 1, Options := "")
{
	RegExMatch(Options, "i)w\K\d+", W), (W="") ? W := 16 :
	RegExMatch(Options, "i)h\K\d+", H), (H="") ? H := 16 :
	RegExMatch(Options, "i)s\K\d+", S), S ? W := H := S :
	RegExMatch(Options, "i)l\K\d+", L), (L="") ? L := 0 :
	RegExMatch(Options, "i)t\K\d+", T), (T="") ? T := 0 :
	RegExMatch(Options, "i)r\K\d+", R), (R="") ? R := 0 :
	RegExMatch(Options, "i)b\K\d+", B), (B="") ? B := 0 :
	RegExMatch(Options, "i)a\K\d+", A), (A="") ? A := 4 :
	Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
	VarSetCapacity( button_il, 20 + Psz, 0 )
	NumPut( normal_il := DllCall( "ImageList_Create", DW, W, DW, H, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )	; Width & Height
	NumPut( L, button_il, 0 + Psz, DW )		; Left Margin
	NumPut( T, button_il, 4 + Psz, DW )		; Top Margin
	NumPut( R, button_il, 8 + Psz, DW )		; Right Margin
	NumPut( B, button_il, 12 + Psz, DW )	; Bottom Margin	
	NumPut( A, button_il, 16 + Psz, DW )	; Alignment
	SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
	return IL_Add( normal_il, File, Index )
}
