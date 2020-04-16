/*
    Author: Viet Ho
*/
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\XDot-Controller\Imgs-for-GUI
    FileCreateDir C:\V-Projects\XDot-Controller\Imgs-for-GUI
IfNotExist C:\V-Projects\XDot-Controller\TTL-Files
    FileCreateDir C:\V-Projects\XDot-Controller\TTL-Files
IfNotExist C:\V-Projects\XDot-Controller\INI-Files
    FileCreateDir C:\V-Projects\XDot-Controller\INI-Files

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\disable.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_test.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\INI-Files\xdot-tt-settings.INI, C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

Global xdotProperties := [{}]  ; Creates an array containing an object.
xdotProperties[1] := {status: "G", mainPort: 100, breakPort: 10, portName: "PORT1", driveName: "XDRIVE-01", ttXPos: 5, ttYPos: 5, controlVar: "XDot01"}
xdotProperties[2] := {status: "G", mainPort: 102, breakPort: 12, portName: "PORT2", driveName: "XDRIVE-02", ttXPos: 105, ttYPos: 5}
xdotProperties[3] := {status: "G", mainPort: 103, breakPort: 13, portName: "PORT3", driveName: "XDRIVE-03", ttXPos: 205, ttYPos: 5}
xdotProperties[4] := {status: "G", mainPort: 104, breakPort: 14, portName: "PORT4", driveName: "XDRIVE-04", ttXPos: 305, ttYPos: 5}
xdotProperties[5] := {status: "G", mainPort: 105, breakPort: 15, portName: "PORT5", driveName: "XDRIVE-05", ttXPos: 405, ttYPos: 5}
xdotProperties[6] := {status: "G", mainPort: 106, breakPort: 16, portName: "PORT6", driveName: "XDRIVE-06", ttXPos: 505, ttYPos: 5}
xdotProperties[7] := {status: "G", mainPort: 107, breakPort: 17, portName: "PORT7", driveName: "XDRIVE-07", ttXPos: 5, ttYPos: 105}
xdotProperties[8] := {status: "G", mainPort: 108, breakPort: 18, portName: "PORT8", driveName: "XDRIVE-08", ttXPos: 105, ttYPos: 105}
xdotProperties[9] := {status: "G", mainPort: 109, breakPort: 19, portName: "PORT9", driveName: "XDRIVE-09", ttXPos: 205, ttYPos: 105}
xdotProperties[10] := {status: "G", mainPort: 110, breakPort: 20, portName: "PORT10", driveName: "XDRIVE-10", ttXPos: 305, ttYPos: 105}
xdotProperties[11] := {status: "G", mainPort: 111, breakPort: 21, portName: "PORT11", driveName: "XDRIVE-11", ttXPos: 405, ttYPos: 105}
xdotProperties[12] := {status: "G", mainPort: 112, breakPort: 22, portName: "PORT12", driveName: "XDRIVE-12", ttXPos: 505, ttYPos: 105}
xdotProperties[13] := {status: "G", mainPort: 113, breakPort: 23, portName: "PORT13", driveName: "XDRIVE-13", ttXPos: 5, ttYPos: 205}
xdotProperties[14] := {status: "G", mainPort: 114, breakPort: 24, portName: "PORT14", driveName: "XDRIVE-14", ttXPos: 105, ttYPos: 205}
xdotProperties[15] := {status: "G", mainPort: 115, breakPort: 25, portName: "PORT15", driveName: "XDRIVE-15", ttXPos: 205, ttYPos: 205}
xdotProperties[16] := {status: "G", mainPort: 116, breakPort: 26, portName: "PORT16", driveName: "XDRIVE-16", ttXPos: 305, ttYPos: 205}
xdotProperties[17] := {status: "G", mainPort: 117, breakPort: 27, portName: "PORT17", driveName: "XDRIVE-17", ttXPos: 405, ttYPos: 205}
xdotProperties[18] := {status: "G", mainPort: 118, breakPort: 28, portName: "PORT18", driveName: "XDRIVE-18", ttXPos: 505, ttYPos: 205}
xdotProperties[19] := {status: "G", mainPort: 119, breakPort: 29, portName: "PORT19", driveName: "XDRIVE-19", ttXPos: 5, ttYPos: 305}
xdotProperties[20] := {status: "G", mainPort: 120, breakPort: 30, portName: "PORT20", driveName: "XDRIVE-20", ttXPos: 105, ttYPos: 305}
xdotProperties[21] := {status: "G", mainPort: 121, breakPort: 31, portName: "PORT21", driveName: "XDRIVE-21", ttXPos: 205, ttYPos: 305}
xdotProperties[22] := {status: "G", mainPort: 122, breakPort: 32, portName: "PORT22", driveName: "XDRIVE-22", ttXPos: 305, ttYPos: 305}
xdotProperties[23] := {status: "G", mainPort: 123, breakPort: 33, portName: "PORT23", driveName: "XDRIVE-23", ttXPos: 405, ttYPos: 305}
xdotProperties[24] := {status: "G", mainPort: 124, breakPort: 34, portName: "PORT24", driveName: "XDRIVE-24", ttXPos: 505, ttYPos: 305}

Global totalGoodPort := 24

;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

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

Gui Add, GroupBox, xm+1 ym+170 w200 h95 Section, Functional Test
Gui Add, Text, xs+15 ys+20, • Test firmware version: 3.0.2-debug
Gui Add, Text, xs+15 ys+35 vtotalGPortLabel, • Run tests on %totalGoodPort% ports
Gui Add, Button, xs+73 ys+60 w55 h28 gtestAll, RUN

Gui Add, GroupBox, xm+1 ym+270 w200 h215 Section, EUID Write

Gui Add, GroupBox, xm+205 ym+430 w325 h55 Section, All Records
Gui Add, Button, xs+18 ys+20 w140 h25 ggetRecords, Functional Test History
Gui Add, Button, xs+169 ys+20 w140 h25 ggetRecords, EUID Write History

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
;;;;;;xdot GUI
GetXDot:
if (RegExMatch(A_GuiControl, "^XDot[0-9]{2}$") = 1) {
    WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%
    Gui, xdot: Cancel
    RegExMatch(A_GuiControl, "\d+$", num) ;Get button number based on button variable
                
    mainPort := xdotProperties[num].mainPort
    breakPort := xdotProperties[num].breakPort
    portName := xdotProperties[num].portName
    driveName := xdotProperties[num].driveName
    ttXPos := xdotProperties[num].ttXPos    ;Position X for teraterm window
    ttYPos := xdotProperties[num].ttYPos    ;Position Y for teraterm window
    
    ;;;GUI
    Gui, xdot: Default
    Gui -MinimizeBox -MaximizeBox +AlwaysOnTop
    Gui xdot: Add, GroupBox, xm+1 ym+3 w200 h70 Section, XDot-%num% Connecting Infomation
    Gui Font, Bold
    Gui xdot: Add, Text, xs+8 ys+20, • COM PORT: %mainPort%
    Gui xdot: Add, Text, xs+8 ys+35, • BREAK PORT: %breakPort%
    Gui xdot: Add, Text, xs+8 ys+50, • DRIVE NAME: %driveName%
    Gui Font
    Gui xdot: Add, GroupBox, xm+1 ym+75 w200 h50 Section, Functional Test
    Gui xdot: Add, Button, xs+73 ys+20 gFunctionalTestEach, Run Test
    mainY := mainY + 210
    Gui xdot: Show, x%mainX% y%mainY%, XDot %num%
    Return

    xdotGuiEscape:
    xdotGuiClose:
        Gui, xdot: Destroy
    Return
    
    ;;;Functions and Labels for xdot GUI;;;
    FunctionalTestEach:
        WinKill COM%mainPort%
        Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%"", ,Hide
    Return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q:: ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
testAll() {
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, Question, Begin funtional tests on all %totalGoodPort% ports?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
        Loop, 24
        {
            controlVar := xdotProperties[A_Index].controlVar
            xStatus := xdotProperties[A_Index].status
            mainPort := xdotProperties[A_Index].mainPort
            breakPort := xdotProperties[A_Index].breakPort
            portName := xdotProperties[A_Index].portName
            driveName := xdotProperties[A_Index].driveName
            ttXPos := xdotProperties[A_Index].ttXPos    ;Position X for teraterm window
            ttYPos := xdotProperties[A_Index].ttYPos    ;Position Y for teraterm window
            
            if (xStatus = "G") {
                WinKill COM%mainPort%
                Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%"", ,Hide
                GuiControl, Text, %controlVar%,
                GuiControlGet, hwndVar, Hwnd , %controlVar%
                GuiButtonIcon(hwndVar, "C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\play.png", 1, "s24")

                Sleep 1000
            }
        }
    IfMsgBox Cancel
        return
}

getRecords() {
    MsgBox Not yet implemented!
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
;Launched whenever the user right-clicks on gui controls
GuiContextMenu:
    GuiControlGet, hwndVar, Hwnd , %A_GuiControl%
    RegExMatch(A_GuiControl, "\d+$", num)
    if (RegExMatch(A_GuiControl, "^XDot[0-9]{2}$") = 1) {   ;Make it only works on Xdot Buttons
        totalGoodPort--
        GuiControl, Text, totalGPortLabel, • Run tests on %totalGoodPort% ports
        xdotProperties[num].status := "D"
        GuiControl, +vBad%A_GuiControl%, %A_GuiControl%     ;Change var of control
        GuiControl, Text, %A_GuiControl%,
        GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png", 1, "s24")
    } else if (RegExMatch(A_GuiControl, "^BadXDot[0-9]{2}$") = 1) {
        totalGoodPort++
        GuiControl, Text, totalGPortLabel, • Run tests on %totalGoodPort% ports
        xdotProperties[num].status := "G"
        newVar := SubStr(A_GuiControl, 4)
        GuiControl, +v%newVar%, %A_GuiControl%
        GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
        GuiControl, Text, %A_GuiControl%, P%num%
    }
Return

changeButtonIcon() {
    
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

;;;Icon for MsgBox
/*Usage Sample
OnMessage(0x44, "CheckIcon") ;Add icon
MsgBox 0x80, DONE, FINISHED Auto-reprogram %fw%!
OnMessage(0x44, "") ;Clear icon
*/
CheckIcon() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        hIcon := LoadPicture("ieframe.dll", "w32 Icon57", _)
        SendMessage 0x172, 1, %hIcon%, Static1 ; STM_SETIMAGE
    }
}
PlayInCircleIcon() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        hIcon := LoadPicture("shell32.dll", "w32 Icon138", _)
        SendMessage 0x172, 1, %hIcon%, Static1 ; STM_SETIMAGE
    }
}
