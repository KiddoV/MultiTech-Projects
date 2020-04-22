 /*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI
    FileCreateDir C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI
IfNotExist C:\V-Projects\XDot-Controller-PC1\TTL-Files
    FileCreateDir C:\V-Projects\XDot-Controller-PC1\TTL-Files
IfNotExist C:\V-Projects\XDot-Controller-PC1\INI-Files
    FileCreateDir C:\V-Projects\XDot-Controller-PC1\INI-Files
IfNotExist C:\V-Projects\XDot-Controller-PC1\EXE-Files
    FileCreateDir C:\V-Projects\XDot-Controller-PC1\EXE-Files

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x-mark.png, C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\x-mark.png, 1FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check-mark.png, C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\check-mark.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\play.png, C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\play.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\disable.png, C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\disable.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_test.ttl, C:\V-Projects\XDot-Controller-PC1\TTL-Files\all_xdot_test.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\INI-Files\xdot-tt-settings.INI, C:\V-Projects\XDot-Controller-PC1\INI-Files\xdot-tt-settings.INI, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\EXE-Files\xdot-winwaitEachPort.exe, C:\V-Projects\XDot-Controller-PC1\EXE-Files\xdot-winwaitEachPort.exe, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

Global nodesToWritePath := "C:\XDOT\nodesToWrite.txt"

Global xdotProperties := [{}]  ; Creates an array containing an object.
xdotProperties[1] := {status: "G", mainPort: 100, breakPort: 10, portName: "PORT1", driveName: "XDRIVE-00", ttXPos: 5, ttYPos: 5, ctrlVar: "XDot01"}
xdotProperties[2] := {status: "G", mainPort: 102, breakPort: 12, portName: "PORT2", driveName: "XDRIVE-02", ttXPos: 105, ttYPos: 5, ctrlVar: "XDot02"}
xdotProperties[3] := {status: "G", mainPort: 103, breakPort: 13, portName: "PORT3", driveName: "XDRIVE-03", ttXPos: 205, ttYPos: 5, ctrlVar: "XDot03"}
xdotProperties[4] := {status: "G", mainPort: 104, breakPort: 14, portName: "PORT4", driveName: "XDRIVE-04", ttXPos: 305, ttYPos: 5, ctrlVar: "XDot04"}
xdotProperties[5] := {status: "G", mainPort: 105, breakPort: 15, portName: "PORT5", driveName: "XDRIVE-05", ttXPos: 405, ttYPos: 5, ctrlVar: "XDot05"}
xdotProperties[6] := {status: "G", mainPort: 106, breakPort: 16, portName: "PORT6", driveName: "XDRIVE-06", ttXPos: 505, ttYPos: 5, ctrlVar: "XDot06"}
xdotProperties[7] := {status: "G", mainPort: 107, breakPort: 17, portName: "PORT7", driveName: "XDRIVE-07", ttXPos: 5, ttYPos: 105, ctrlVar: "XDot07"}
xdotProperties[8] := {status: "G", mainPort: 108, breakPort: 18, portName: "PORT8", driveName: "XDRIVE-08", ttXPos: 105, ttYPos: 105, ctrlVar: "XDot08"}

Global totalGoodPort := 8

Global xImg := "C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\x-mark.png"
Global checkImg := "C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\check-mark.png"
Global playImg := "C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\play.png"
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
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

Gui Add, GroupBox, xm+1 ym+3 w200 h87 vxdotPanel Section, xDot Panel Group 1
Gui Font, Bold, Ms Shell Dlg 2
Gui Add, Button, xs+5 ys+15 w30 h30 vXDot01 gGetXDot, P01
Gui Add, Button, xs+37 ys+15 w30 h30 vXDot02 gGetXDot, P02
Gui Add, Button, xs+69 ys+15 w30 h30 vXDot03 gGetXDot, P03
Gui Add, Button, xs+101 ys+15 w30 h30 vXDot04 gGetXDot, P04
Gui Add, Button, xs+133 ys+15 w30 h30 vXDot05 gGetXDot, P05
Gui Add, Button, xs+165 ys+15 w30 h30 vXDot06 gGetXDot, P06

Gui Add, Button, xs+5 ys+50 w30 h30 vXDot07 gGetXDot, P07
Gui Add, Button, xs+37 ys+50 w30 h30 vXDot08 gGetXDot, P08
Gui Font

Gui Add, GroupBox, xm+1 ym+95 w200 h95 Section, Functional Test
Gui Add, Text, xs+15 ys+20, • Test firmware version: 3.0.2-debug
Gui Add, Text, xs+15 ys+35 vtotalGPortLabel, • Run tests on %totalGoodPort% ports
Gui Add, Button, xs+73 ys+60 w55 h28 gtestAll, RUN

Gui Add, GroupBox, xm+1 ym+270 w200 h215 Section, EUID Write

Gui Add, GroupBox, xm+205 ym+430 w325 h55 Section, All Records
Gui Add, Button, xs+18 ys+20 w140 h25 ggetRecords, Functional Test History
Gui Add, Button, xs+169 ys+20 w140 h25 ggetRecords, EUID Write History

;;;Functions to run before main gui is started;;;
;getNodesToWrite()
;OnMessage(0x207, "WM_MBUTTONDBLCLK")

posX := A_ScreenWidth - 600
Gui, Show, w550 h500 x%posX% y150, xDot Controller (PC1)

;;;Functions to run after main gui is started;;;
getNodesToWrite()
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
    {
        for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-winwaitEachPort.exe' ")
        Process, close, % process.ProcessId
        
        ExitApp
     }
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;;;
;;;;;;xdot GUI
GetXDot:
isXdot := RegExMatch(A_GuiControl, "^XDot[0-9]{2}$")
isBadXdot := RegExMatch(A_GuiControl, "^BadXDot[0-9]{2}$")

if (isXdot = 1 || isBadXdot = 1) {
    WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%
    Gui, xdot: Cancel
    Gui, xdot: Destroy
    RegExMatch(A_GuiControl, "\d+$", num) ;Get button number based on button variable
                
    mainPort := xdotProperties[num].mainPort
    breakPort := xdotProperties[num].breakPort
    portName := xdotProperties[num].portName
    driveName := xdotProperties[num].driveName
    ttXPos := xdotProperties[num].ttXPos    ;Position X for teraterm window
    ttYPos := xdotProperties[num].ttYPos    ;Position Y for teraterm window
    
    ;;;GUI
    Gui, xdot: Default
    Gui, xdot: +AlwaysOnTop +ToolWindow +Owner
    Gui xdot: Add, GroupBox, xm+1 ym+3 w200 h70 Section, XDot-%num% Connecting Infomation
    Gui Font, Bold
    Gui xdot: Add, Text, xs+8 ys+20, • COM PORT: %mainPort%
    Gui xdot: Add, Text, xs+8 ys+35, • BREAK PORT: %breakPort%
    Gui xdot: Add, Text, xs+8 ys+50, • DRIVE NAME: %driveName%
    Gui Font
    Gui xdot: Add, GroupBox, xm+1 ym+75 w200 h120 Section, Functional Test
    Gui xdot: Add, Text, xs+110 ys+20, Connecting
    Gui xdot: Add, Text, xs+110 ys+40, Programmable
    Gui xdot: Add, Text, xs+110 ys+60, Joinning
    Gui xdot: Add, Text, xs+110 ys+80, Ping
    Gui xdot: Add, Text, xs+110 ys+100, RSSI
    
    ;Image indicators
    Gui xdot: Add, Picture, xs+80 ys+18 w17 h17 +BackgroundTrans vprocess1, 
    Gui xdot: Add, Picture, xs+80 ys+38 w17 h17 +BackgroundTrans vprocess2, 
    Gui xdot: Add, Picture, xs+80 ys+58 w17 h17 +BackgroundTrans vprocess3, 
    Gui xdot: Add, Picture, xs+80 ys+78 w17 h17 +BackgroundTrans vprocess4, 
    Gui xdot: Add, Picture, xs+80 ys+98 w17 h17 +BackgroundTrans vprocess5, 
    buttonLabel := isBadXdot = 1 ? "Re-run" : "Run"
    Gui xdot: Add, Button, w40 h40 xs+10 ys+45 gFunctionalTestEach, %buttonLabel%
    
    mainY := mainY + 130
    Gui xdot: Show, x%mainX% y%mainY%, XDot %num%
    Return

    xdotGuiEscape:
    xdotGuiClose:
        WinKill COM%mainPort%
        Gui, xdot: Destroy
    Return
    
    ;;;Functions and Labels for xdot GUI;;;
    FunctionalTestEach:
        WinKill COM%mainPort%
        Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller-PC1\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\V-Projects\XDot-Controller-PC1\TTL-Files\all_xdot_test.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%" "singleTest"", ,Hide

        ;;;Track processes
        ;Connecting
        GuiControl, , process1, %playImg%
        WinWait COM%mainPort%|disconnected
        IfWinNotExist COM%mainPort%
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process1, %xImg%
            return
        }
        GuiControl, , process1, %checkImg%
        
        ;Programable
        GuiControl, , process2, %playImg%
        WinWait PASSED1|%mainPort% FAILURE
        IfWinNotExist PASSED1
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process2, %xImg%
            return
        }
        GuiControl, , process2, %checkImg%
        
        ;Joinning
        GuiControl, , process3, %playImg%
        WinWait PASSED2|%mainPort% FAILURE
        IfWinNotExist PASSED2
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process3, %xImg%
            return
        }
        GuiControl, , process3, %checkImg%
        
        ;Ping Test
        GuiControl, , process4, %playImg%
        WinWait PASSED3|%mainPort% FAILURE
        IfWinNotExist PASSED3
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process4, %xImg%
            return
        }
        GuiControl, , process4, %checkImg%
        ;RSSI Test
        GuiControl, , process5, %playImg%
        WinWait PASSED4|%mainPort% FAILURE
        IfWinNotExist PASSED4
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process5, %xImg%
            return
        }
        GuiControl, , process5, %checkImg%
        
    Return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q::
    For process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-winwaitEachPort.exe' ")
    Process, close, % process.ProcessId
    
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
testAll() {
    resetXdotBttns()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, Run, Begin funtional tests on all %totalGoodPort% ports?
    OnMessage(0x44, "") ;Clear icon
    index := 1
    IfMsgBox OK
        Loop, 8
        {
            ctrlVar := xdotProperties[index].ctrlVar
            xStatus := xdotProperties[index].status
            mainPort := xdotProperties[index].mainPort
            breakPort := xdotProperties[index].breakPort
            portName := xdotProperties[index].portName
            driveName := xdotProperties[index].driveName
            ttXPos := xdotProperties[index].ttXPos    ;Position X for teraterm window
            ttYPos := xdotProperties[index].ttYPos    ;Position Y for teraterm window
            
            index++
            
            if (xStatus = "G") {
                WinKill COM%mainPort%
                Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller-PC1\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\V-Projects\XDot-Controller-PC1\TTL-Files\all_xdot_test.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%"", , Hide
                Run, %ComSpec% /c start C:\V-Projects\XDot-Controller-PC1\EXE-Files\xdot-winwaitEachPort.exe %mainPort%, , Hide
                GuiControl, Text, %ctrlVar%,
                GuiControlGet, hwndVar, Hwnd , %ctrlVar%
                GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\play.png", 1, "s24")   ;Display icon
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
        GuiControl, +vDis%A_GuiControl%, %A_GuiControl%     ;Change var of control
        GuiControl, Text, %A_GuiControl%,    ;Delete text
        GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller-PC1\Imgs-for-GUI\disable.png", 1, "s24")   ;Display icon
    } else if (RegExMatch(A_GuiControl, "^DisXDot[0-9]{2}$") = 1) {
        totalGoodPort++
        GuiControl, Text, totalGPortLabel, • Run tests on %totalGoodPort% ports
        xdotProperties[num].status := "G"
        newVar := SubStr(A_GuiControl, 4)
        GuiControl, +v%newVar%, %A_GuiControl%
        GuiControl, Text, %newVar%, P%num%   ;Return button text
        GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
    }
Return

resetXdotBttns() {
    Loop, 24
    {
        ctrlVar := xdotProperties[A_Index].ctrlVar
        RegExMatch(ctrlVar, "\d+$", num)    ;Get button number based on button variable
        GuiControl, +v%ctrlVar%, Bad%ctrlVar%
        GuiControl, +v%ctrlVar%, Good%ctrlVar%
        GuiControl, +gGetXDot, %ctrlVar%    ;Reset G-Label
        GuiControl, Text, %ctrlVar%, P%num%   ;Return button text
        GuiControlGet, hwndVar, Hwnd , %ctrlVar%
        GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
    }
}

getNodesToWrite() {
    FileRead, outVar, %nodesToWritePath%
    GuiControl Text, editNode, %outVar%
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

;;Add an icon to a button with external image file
;;;GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
;;;GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png", 1, "s24")   ;Display icon
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

;;Add an icon to a button with system icon
;netshell.dll --- 94 => X-mark
;urlmon.dll --- 1 => Check-mark
;wmploc.dll --- 107 => Play icon
;Gui, Add, Button, hWndhButton3 x255 y8 w23 h23 gCloseGUI,
;GuiButtonSysIcon(hButton3, "imageres.dll", 207, 16, 0)
;GuiButtonSysIcon(hwndVar, "imageres.dll", 207, 24, 25) ;Add 25 to make icon invisible
GuiButtonSysIcon(Handle, File, Index := 0, Size := 12, Margin := 1, Align := 5)
{
    Size -= Margin
    Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
    VarSetCapacity( button_il, 20 + Psz, 0 )
    NumPut( normal_il := DllCall( "ImageList_Create", DW, Size, DW, Size, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )
    NumPut( Align, button_il, 16 + Psz, DW )
    SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
    return IL_Add( normal_il, File, Index )
}

;Gui, Add, Button, hWndhButton2 x130 y8 w100 h23 gButton02, %A_Space%Button02
;SetButtonSysIcon(hButton2, "shell32.dll", 22)
SetButtonSysIcon(hButton, File, Index, Size := 16) {
    hIcon := LoadPicture(File, "h" . Size . " Icon" . Index, _)
    SendMessage 0xF7, 1, %hIcon%,, ahk_id %hButton% ; BM_SETIMAGE
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

;;;;;;;;;;;;;;;;NOT-FOR-USER HOT KEYS;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#^!+0::
    index := 1
    Loop, 8
    {
        mainPort := xdotProperties[index].mainPort
        ctrlVar := xdotProperties[index].ctrlVar
        
        IfWinExist, PORT %mainPort% FAILURE
        {
            GuiControlGet, hwndVar, Hwnd , %ctrlVar%
            ;GuiButtonSysIcon(hwndVar, "netshell.dll", 94, 24, 0)
            GuiControl, Text, %ctrlVar%,    ;Delete text
            GuiButtonIcon(hwndVar, xImg, 1, "s24")   ;Display icon
            GuiControl, +vBad%ctrlVar%, %ctrlVar%     ;Change var of control
        }
        index++
    }
Return

#^!+9::
    index := 1
    Loop, 8
    {
        mainPort := xdotProperties[index].mainPort
        ctrlVar := xdotProperties[index].ctrlVar
        
        IfWinExist, PORT %mainPort% PASSED
        {
            GuiControlGet, hwndVar, Hwnd , %ctrlVar%
            ;GuiButtonSysIcon(hwndVar, "urlmon.dll", 1, 24, 0)
            GuiControl, Text, %ctrlVar%,    ;Delete text
            GuiButtonIcon(hwndVar, checkImg, 1, "s24")   ;Display icon
            GuiControl, +vGood%ctrlVar%, %ctrlVar%     ;Change var of control
        }
        index++
    }
Return