﻿ /*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\XDot-Controller\Imgs-for-GUI
    FileCreateDir C:\V-Projects\XDot-Controller\Imgs-for-GUI
IfNotExist C:\V-Projects\XDot-Controller\TTL-Files
    FileCreateDir C:\V-Projects\XDot-Controller\TTL-Files
IfNotExist C:\V-Projects\XDot-Controller\INI-Files
    FileCreateDir C:\V-Projects\XDot-Controller\INI-Files
IfNotExist C:\V-Projects\XDot-Controller\EXE-Files
    FileCreateDir C:\V-Projects\XDot-Controller\EXE-Files
IfNotExist C:\V-Projects\XDot-Controller\BIN-Files
    FileCreateDir C:\V-Projects\XDot-Controller\BIN-Files
IfNotExist C:\V-Projects\XDot-Controller\AHK-Lib
    FileCreateDir C:\V-Projects\XDot-Controller\AHK-Lib
IfNotExist Z:\XDOT\Saved-Nodes
    FileCreateDir Z:\XDOT\Saved-Nodes

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\x_mark.png, 1FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_orange.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\play_brown.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_brown.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\play_blue.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_blue.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\disable.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\folder-icon.ico, C:\V-Projects\XDot-Controller\Imgs-for-GUI\folder-icon.ico, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\save-icon.ico, C:\V-Projects\XDot-Controller\Imgs-for-GUI\save-icon.ico, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\pen_with_note-icon.ico, C:\V-Projects\XDot-Controller\Imgs-for-GUI\pen_with_note-icon.ico, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\add_file-icon.ico, C:\V-Projects\XDot-Controller\Imgs-for-GUI\add_file-icon.ico, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_test-2.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test-2.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_reprogram.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_reset.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reset.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\INI-Files\xdot-tt-settings.INI, C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\EXE-Files\xdot-winwaitEachPort.exe, C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe, 1

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\Toolbar.ahk, C:\V-Projects\XDot-Controller\AHK-Lib\Toolbar.ahk
, 1

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

;Global nodesToWritePath := "Z:\XDOT\nodesToWrite.txt"
Global remotePath := "Z:\XDOT"
Global lotCodeList := []

Global xdotProperties := [{}]  ; Creates an array containing an object.
xdotProperties[9] := {status: "G", mainPort: 109, breakPort: 9, portName: "PORT9", driveName: "D", ttXPos: 5, ttYPos: 5, ctrlVar: "XDot09"}
xdotProperties[10] := {status: "G", mainPort: 110, breakPort: 10, portName: "PORT10", driveName: "E", ttXPos: 105, ttYPos: 5, ctrlVar: "XDot10"}
xdotProperties[11] := {status: "G", mainPort: 111, breakPort: 11, portName: "PORT11", driveName: "F", ttXPos: 205, ttYPos: 5, ctrlVar: "XDot11"}
xdotProperties[12] := {status: "G", mainPort: 112, breakPort: 12, portName: "PORT12", driveName: "G", ttXPos: 305, ttYPos: 5, ctrlVar: "XDot12"}
xdotProperties[13] := {status: "G", mainPort: 113, breakPort: 13, portName: "PORT13", driveName: "H", ttXPos: 405, ttYPos: 5, ctrlVar: "XDot13"}
xdotProperties[14] := {status: "G", mainPort: 114, breakPort: 14, portName: "PORT14", driveName: "I", ttXPos: 505, ttYPos: 5, ctrlVar: "XDot14"}
xdotProperties[15] := {status: "G", mainPort: 115, breakPort: 15, portName: "PORT15", driveName: "J", ttXPos: 5, ttYPos: 105, ctrlVar: "XDot15"}
xdotProperties[16] := {status: "G", mainPort: 116, breakPort: 16, portName: "PORT16", driveName: "K", ttXPos: 105, ttYPos: 105, ctrlVar: "XDot16"}

Global totalGoodPort := 8
Global mainWndTitle := "XDot Controller (PC2)"
Global startedIndex := 9

Global xImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\x_mark.png"
Global checkImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark.png"
Global play1Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_orange.png"
Global play2Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_brown.png"
Global play3Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_blue.png"

;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;
#Include C:\V-Projects\XDot-Controller\AHK-Lib\Toolbar.ahk
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

Gui +hWndhMainWnd
Gui Add, GroupBox, xm+205 ym+0 w300 h420 Section, xDot NodeID Editor
Gui Add, Text, xs+10 ys+38 w285 h2 +0x10 ;;-----------------------------
Gui, Add, Edit, xs+5 ys+75 w35 r25.3 -VScroll -HScroll -Border Disabled Right vlineNo
Gui Font, Bold q5, Consolas
Gui, Add, Edit, xs+40 ys+75 r24 hwndEdit w255 +HScroll veditNode
Gui Font
Gui Font, Bold
Gui Add, Text, xs+10 ys+50 , Select LOT Code:
Gui Font
getLotCodeList()
For each, item in lotCodeList
    lotCode .= (each == 1 ? "" : "|") . item
Gui Add, ComboBox, xs+120 ys+45 vlotCodeSelected gCbAutoComplete, %lotCode%
Gui Add, Button, xs+250 ys+45 h21 gloadNodeFromLot, Load
Gui Add, GroupBox, xm+0 ym+0 w200 h87 vxdotPanel Section, xDot Panel Group 2
Gui Font, Bold, Ms Shell Dlg 2

Gui Add, Button, xs+69 ys+15 w30 h30 vXDot09 gGetXDot, P09
Gui Add, Button, xs+101 ys+15 w30 h30 vXDot10 gGetXDot, P10
Gui Add, Button, xs+133 ys+15 w30 h30 vXDot11 gGetXDot, P11
Gui Add, Button, xs+165 ys+15 w30 h30 vXDot12 gGetXDot, P12

Gui Add, Button, xs+5 ys+50 w30 h30 vXDot13 gGetXDot, P13
Gui Add, Button, xs+37 ys+50 w30 h30 vXDot14 gGetXDot, P14
Gui Add, Button, xs+69 ys+50 w30 h30 vXDot15 gGetXDot, P15
Gui Add, Button, xs+101 ys+50 w30 h30 vXDot16 gGetXDot, P16
Gui Font

Gui Add, GroupBox, xm+0 ym+90 w200 h110 Section, Functional Test
Gui Add, Text, xs+10 ys+20, Test firmware version: 3.0.2-debug
Gui Add, Radio, xs+15 ys+37 vtotalGPortRadio Group +Checked gradioToggle, Run tests on %totalGoodPort% ports
Gui Add, Radio, xs+15 ys+54 vreproGPortRadio gradioToggle, Reprogram %totalGoodPort% ports to debug mode
Gui Add, Button, xs+73 ys+75 w55 h28 grunAll, RUN

Gui Add, GroupBox, xm+0 ym+205 w200 h215 Section, EUID Write

;Gui Add, GroupBox, xm+205 ym+430 w290 h55 Section, All Records
;Gui Add, Button, xs+100 ys+20 w140 h25 ggetRecords, EUID Write History

;;;Functions to run before main gui is started;;;
OnMessage(0x100, "WM_KEYDOWN")
deleteOldCacheFiles()    ;Delete result port data before gui start (Ex: 101.dat)

posX := A_ScreenWidth - 600
Gui, Show, x%posX% y150, %mainWndTitle%

;;;Functions to run after main gui is started;;;
editnodeToolbar := CreateEditNodeToolbar()
getNodesToWrite()
GuiControlGet, editNode, Pos, editNode
IfNotExist C:\teraterm\ttermpro.exe
    MsgBox, 16, WARNING, This program only work with a secondary program.`nPlease install Teraterm to this location: C:\teraterm\

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
;;;;;;XDot GUI
GetXDot:
isXdot := RegExMatch(A_GuiControl, "^XDot[0-9]{2}$")
isBadXdot := RegExMatch(A_GuiControl, "^BadXDot[0-9]{2}$")
isGoodXdot := RegExMatch(A_GuiControl, "^GoodXDot[0-9]{2}$")

if (isXdot = 1 || isBadXdot = 1 || isGoodXdot = 1) {
    WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%
    Gui, xdot: Cancel
    Gui, xdot: Destroy
    RegExMatch(A_GuiControl, "\d+$", num) ;Get button number based on button variable
    
    ctrlVar := xdotProperties[num].ctrlVar
    mainPort := xdotProperties[num].mainPort
    breakPort := xdotProperties[num].breakPort
    portName := xdotProperties[num].portName
    driveName := xdotProperties[num].driveName
    ttXPos := xdotProperties[num].ttXPos    ;Position X for teraterm window
    ttYPos := xdotProperties[num].ttYPos    ;Position Y for teraterm window
    
    WinActivate COM%mainPort%
    ;;;GUI
    Gui, xdot: Default
    Gui, xdot: +ToolWindow +AlwaysOnTop +hWndhXdotWnd
    Gui xdot: Add, GroupBox, xm+0 ym+0 w200 h70 Section, XDot-%num% Connecting Infomation
    Gui Font, Bold
    Gui xdot: Add, Text, xs+8 ys+20, • COM PORT: %mainPort%
    Gui xdot: Add, Text, xs+8 ys+35, • BREAK PORT: %breakPort%
    Gui xdot: Add, Text, xs+8 ys+50, • DRIVE NAME: %driveName%
    Gui Font
    Gui xdot: Add, GroupBox, xm+0 ym+70 w200 h120 Section, Functional Test
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
    
    Gui xdot: Add, GroupBox, xm+0 ym+190 w200 h50 Section, Programming
    Gui xdot: Add, Button, w180 xs+10 ys+20 gToDebugEach, Program %ctrlVar% to debug mode
    
    ;;Labels or Functions to run before gui start
    FileRead, outStr, C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
    if (RegExMatch(outStr, "CONNECTION FAILED") > 0) {
        GuiControl, , process1, %xImg%
    } else if (RegExMatch(outStr, "FAILED TO PROGRAM") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %xImg%
    } else if (RegExMatch(outStr, "FAILED TO JOIN") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %checkImg%
        GuiControl, , process3, %xImg%
    } else if (RegExMatch(outStr, "PING.*FAILURE") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %checkImg%
        GuiControl, , process3, %checkImg%
        GuiControl, , process4, %xImg%
    } else if (RegExMatch(outStr, "RSSI LEVEL FAILURE") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %checkImg%
        GuiControl, , process3, %checkImg%
        GuiControl, , process4, %checkImg%
        GuiControl, , process5, %xImg%
    } else if (RegExMatch(outStr, "ALL PASSED") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %checkImg%
        GuiControl, , process3, %checkImg%
        GuiControl, , process4, %checkImg%
        GuiControl, , process5, %checkImg%
    }
    
    
    mainY := mainY + 130
    Gui xdot: Show, x%mainX% y%mainY%, XDot %num%
    Return

    xdotGuiEscape:
    xdotGuiClose:
        Gui, xdot: Destroy
    Return
    
    ;;;Functions and Labels for xdot GUI;;;
    FunctionalTestEach:
        changeXdotBttnIcon(ctrlVar, "PLAY", "TESTING")
        
        WinKill COM%mainPort%
        ;Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test-2.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%" "singleTest"", ,Hide
        Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test-2.ttl dummyParam %mainPort% %breakPort% %portName% %driveName% singleTest newTTVersion, ,Hide

        ;;;Track processes
        Gui xdot: Default
        ;Connecting
        GuiControl, , process1, %play1Img%
        WinWait PASSED1|%mainPort% FAILURE
        IfWinExist %mainPort% FAILURE
        {
            GuiControl, , process1, %xImg%
            goto XdotFailed
        }
        GuiControl, , process1, %checkImg%
        
        ;Programable
        GuiControl, , process2, %play1Img%
        WinWait PASSED2|%mainPort% FAILURE
        IfWinNotExist PASSED2
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process2, %xImg%
            goto XdotFailed
        }
        GuiControl, , process2, %checkImg%
        
        ;Joinning
        GuiControl, , process3, %play1Img%
        WinWait PASSED3|%mainPort% FAILURE
        IfWinNotExist PASSED3
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process3, %xImg%
            goto XdotFailed
        }
        GuiControl, , process3, %checkImg%
        
        ;Ping Test
        GuiControl, , process4, %play1Img%
        WinWait PASSED4|%mainPort% FAILURE
        IfWinNotExist PASSED4
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process4, %xImg%
            goto XdotFailed
        }
        GuiControl, , process4, %checkImg%
        ;RSSI Test
        GuiControl, , process5, %play1Img%
        WinWait PASSED5|%mainPort% FAILURE
        IfWinNotExist PASSED5
        {
            WinWait %mainPort% FAILURE
            GuiControl, , process5, %xImg%
            goto XdotFailed
        }
        GuiControl, , process5, %checkImg%
        
        changeXdotBttnIcon(ctrlVar, "GOOD")
    Return
    
    XdotFailed:
        changeXdotBttnIcon(ctrlVar, "BAD")
    Return
        
    ToDebugEach:
        IfNotExist %driveName%:\
        {
            msg = Drive (%driveName%:\) does not exist!
            addTipMsg(msg, "ERROR", 2000)
            Return
        }
        WinKill COM%mainPort%
        Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
        ;msg = Reprogramming on PORT %mainPort%...Please wait!
        ;title = PORT %mainPort% PROGRAMMING
        ;addTipMsg(msg, title, 17000)
        ;RunWait, %ComSpec% /c copy C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin %driveName%:\ , ,Hide
        ;Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reset.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
    Return
}
Return
;;;;;;User Prompt GUI
;;;auGen GUI
GetAutoGenerate:
    Gui, auGen: Cancel
    Gui, auGen: Destroy
    WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%

    Gui, auGen: Default
    Gui, auGen: +ToolWindow +AlwaysOnTop +hWndhauGenWnd
    Gui, auGen: Add, Edit, x10 y5 w110 h20 hwndHED1 vfirstNodeID Limit16
    SetEditCueBanner(HED1, "First nodeIDs")
    Gui, auGen: Add, Edit, x130 y5 w42 h20 Limit4 +Number hwndHED2 vnodeAmout
    SetEditCueBanner(HED2, "Amount")
    Gui, auGen: Add, Button, x180 y5 w50 h20 ggenerateNode, Generate
    
    mainY := mainY + 30
    Gui, auGen: Show, x%mainX% y%mainY%, Auto Generate Node IDs
    Return
    
    auGenGuiEscape:
    auGenGuiClose:
        Gui, auGen: Destroy
    Return
    ;;;Functions and Labels for auGen GUI;;;
    generateNode() {
    GuiControlGet, firstNodeID
    GuiControlGet, nodeAmout
    
    if (StrLen(firstNodeID) < 16) {
        MsgBox, 16, ,NodeID should have 16 digits!
        return
    } else if (RegExMatch(firstNodeID, "^[0-9A-Fa-f]+$") = 0) {
        MsgBox, 16, , Please enter only Hexadecimal for NodeID!
        return
    } else if (StrLen(nodeAmout) < 1) {
        MsgBox, 16, , Please enter an amount for NodeID!
        return
    }
    
    firstNodeID = 0x%firstNodeID%   ;convert value to Hex
    
    Gui, 1: Default
    GuiControl Text, editNode, % autoGenerateNodeID(firstNodeID, nodeAmout)
    Gui auGen: Destroy
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
Return

;;;adNew Gui
GetAddNew:
    Gui, adNew: Cancel
    Gui, adNew: Destroy
    WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%
    
    Gui, adNew: Default
    Gui, adNew: +ToolWindow +AlwaysOnTop +hWndhadNewWnd
    Gui Font, Bold
    Gui, adNew: Add, Text, x10 y10, Add New From Current Editor
    Gui, adNew: Add, Text, x10 y50, Add New From A File
    Gui, Font
    
    Gui, adNew: Add, Text, x15 y30, Enter LOT CODE:
    Gui, adNew: Add, Edit, x105 y27 w75 h20 +Number Limit10
    Gui, adNew: Add, Button, x190 y27 h20, Save
    
    Gui, adNew: Add, Button, x15 y70 h20, Browse...
    Gui, adNew: Add, Text, x75 y73, ...
    
    mainY := mainY + 30
    Gui, adNew: Show, x%mainX% y%mainY%, Add New Node List
    Return
    
    adNewGuiEscape:
    adNewGuiClose:
        Gui, adNew: Destroy
    Return
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q::
    For process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-winwaitEachPort.exe' ")
    Process, close, % process.ProcessId
    ExitApp
^t::
    runAll()
^s::
    saveNodesToWrite()
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
runAll() {
    GuiControlGet, isRunTestChecked, , totalGPortRadio
    GuiControlGet, isRunReprogChecked, , reproGPortRadio
    if (isRunTestChecked = 1) {
        OnMessage(0x44, "PlayInCircleIcon") ;Add icon
        MsgBox 0x81, Run, Begin funtional tests on all %totalGoodPort% ports?
        OnMessage(0x44, "") ;Clear icon
        index := startedIndex
        IfMsgBox OK
        {
            resetXdotBttns()
            deleteOldCacheFiles()
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
                    ;Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test-2.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%"", , Hide
                    IfWinExist PROGRAMMING
                        Sleep 8000
                    changeXdotBttnIcon(ctrlVar, "PLAY", "TESTING")
                    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE /V C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test-2.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
                    Run, %ComSpec% /c start C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe %mainPort%, , Hide
                    Sleep 3000
                }
            }
        }
        IfMsgBox Cancel
            return
    }
    
    if (isRunReprogChecked = 1) {
        OnMessage(0x44, "PlayInCircleIcon") ;Add icon
        MsgBox 0x81, Run, Begin re-program to debug mode on all %totalGoodPort% ports?
        OnMessage(0x44, "") ;Clear icon
        index := startedIndex
        IfMsgBox OK
        {
            resetXdotBttns()
            deleteOldCacheFiles()
            Loop, 8
            {
                StartReprogram:
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
                    ;IfWinExist PROGRAMMING
                    ;{
                        ;Loop
                        ;{
                            ;Sleep 2000
                            ;IfWinNotExist PROGRAMMING
                                ;Break
                        ;}
                    ;}
                    changeXdotBttnIcon(ctrlVar, "PLAY", "PROGRAMMING")
                    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
                    Run, %ComSpec% /c start C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe %mainPort%, , Hide
                    Sleep 1000
                }
            }
        }
        IfMsgBox Cancel
            return
    }
    
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
    isXdot := RegExMatch(A_GuiControl, "^XDot[0-9]{2}$")
    isBadXdot := RegExMatch(A_GuiControl, "^BadXDot[0-9]{2}$")
    isGoodXdot := RegExMatch(A_GuiControl, "^GoodXDot[0-9]{2}$")
    isDisXdot := RegExMatch(A_GuiControl, "^DisXDot[0-9]{2}$")
    isDisBadXdot := RegExMatch(A_GuiControl, "^DisBadXDot[0-9]{2}$")
    isDisGoodXdot := RegExMatch(A_GuiControl, "^DisGoodXDot[0-9]{2}$")
    if (isXdot = 1) {   ;Make it only works on Xdot Buttons
        totalGoodPort--
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to debug mode
        xdotProperties[num].status := "D"
        GuiControl, +vDis%A_GuiControl%, %A_GuiControl%     ;Change var of control
        GuiControl, Text, %A_GuiControl%,    ;Delete text
        GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png", 1, "s24")   ;Display icon
    } else if (isDisXdot = 1 || isDisBadXdot = 1 || isDisGoodXdot = 1) {
        totalGoodPort++
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to debug mode
        xdotProperties[num].status := "G"
        if (isDisXdot = 1) {
            newVar := SubStr(A_GuiControl, 4)
            GuiControl, +v%newVar%, %A_GuiControl%  ;Return to original var (XDot01)
            GuiControl, Text, %newVar%, P%num%   ;Return button text
            GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
        } else if (isDisBadXdot = 1) {
            newVar := SubStr(A_GuiControl, 4)
            GuiControl, +v%newVar%, %A_GuiControl%  ;Return to original var (BadXDot01)
            GuiButtonIcon(hwndVar, xImg, 1, "s24")
        } else if (isDisGoodXdot = 1) {
            newVar := SubStr(A_GuiControl, 4)
            GuiControl, +v%newVar%, %A_GuiControl%  ;Return to original var (GoodXDot01)
            GuiButtonIcon(hwndVar, checkImg, 1, "s24")
        }
        
    } else if (isBadXdot = 1 || isGoodXdot = 1) {
        totalGoodPort--
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to debug mode
        xdotProperties[num].status := "D"
        GuiControl, +vDis%A_GuiControl%, %A_GuiControl%     ;Change var of control
        GuiControl, Text, %A_GuiControl%,    ;Delete text
        GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png", 1, "s24")   ;Display icon
    }
Return

resetXdotBttns() {
    Loop, 24
    {
        ctrlVar := xdotProperties[A_Index].ctrlVar
        RegExMatch(ctrlVar, "\d+$", num)    ;Get button number based on button variable
        GuiControl, +v%ctrlVar%, Bad%ctrlVar%
        GuiControl, +v%ctrlVar%, Good%ctrlVar%
        GuiControl, +v%ctrlVar%, Play%ctrlVar%
        GuiControl, +gGetXDot, %ctrlVar%    ;Reset G-Label
        GuiControl, Text, %ctrlVar%, P%num%   ;Return button text
        GuiControlGet, hwndVar, Hwnd , %ctrlVar%
        GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
    }
}

deleteOldCacheFiles() {
    Loop, 24
    {
        mainPort := xdotProperties[A_Index].mainPort
        FileDelete, C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
    }
}

getNodesToWrite() {
    FileRead, outVar, %remotePath%\nodesToWrite.txt
    StringReplace, outVar, outVar, %A_Space%, , All
    StringReplace, outVar, outVar, %A_Tab%, , All
    GuiControl Text, editNode, %outVar%
}

saveNodesToWrite() {
    GuiControlGet outVar, , editNode
    fileLoc = %remotePath%\nodesToWrite.txt 
    file := FileOpen(fileLoc, "w")
    file.WriteLine(outVar)
    file.Close()
}

radioToggle() {
    resetXdotBttns()
}

browseNode() {
    FileSelectFile, selectedFile, , , Select a NodeID text file..., Text Documents (*.txt; *.doc)
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

getLotCodeList() {
    Loop Files, %remotePath%\Saved-Nodes\*.txt, R ; Recurse into subfolders.
    {
        str := A_LoopFileName
        StringReplace, str, str, .txt, , All
        lotCodeList[A_Index] := str
    }
}

loadNodeFromLot() {
    GuiControlGet outStr, , lotCodeSelected
    if (outStr != "") {
        outStr = %outStr%.txt
        FileRead outVar, %remotePath%\Saved-Nodes\%outStr%
        StringReplace, outVar, outVar, %A_Space%, , All
        StringReplace, outVar, outVar, %A_Tab%, , All
        GuiControl Text, editNode, %outVar%
    }
}

changeXdotBttnIcon(guiControlVar, option, mode := "") {
    Global                                                  ;Must set all var to global to use GuiControl
    Gui 1: Default
    RegExMatch(guiControlVar, "\d+$", num)                  ;Get the number from control var
    RegExMatch(guiControlVar, "XDot\d.", origCtrlVar)       ;Get the original controlvar Ex: XDot01, XDot02
    GuiControlGet, hwndVar1, Hwnd , %origCtrlVar%           ;Get the hwndVar from a control var
    GuiControlGet, hwndVar2, Hwnd , Play%origCtrlVar%       ;Get the hwndVar from a control var
    GuiControlGet, hwndVar3, Hwnd , Bad%origCtrlVar%        ;Get the hwndVar from a control var
    GuiControlGet, hwndVar4, Hwnd , Good%origCtrlVar%       ;Get the hwndVar from a control var
    GuiControlGet, hwndVar5, Hwnd , Dis%origCtrlVar%        ;Get the hwndVar from a control var
    if (option = "NORMAL") {
        
    } else if (option = "DISABLE") {
        
    } else if (option = "BAD") {
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        Loop, 4
            GuiButtonIcon(hwndVar%A_Index%, xImg, 1, "s24")         ;Display icon
        GuiControl, +vBad%origCtrlVar%,  Play%origCtrlVar%          ;Change var of control
    } else if (option = "GOOD") {
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        Loop, 4
            GuiButtonIcon(hwndVar%A_Index%, checkImg, 1, "s24")     ;Display icon
        GuiControl, +vGood%origCtrlVar%,  Play%origCtrlVar%         ;Change var of control
    } else if (option = "PLAY") {
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        if (mode = "TESTING") {
            Loop, 4
                GuiButtonIcon(hwndVar%A_Index%, play1Img, 1, "s24") ;Display icon
        }
        else if (mode = "PROGRAMMING") {
            Loop, 4
                GuiButtonIcon(hwndVar%A_Index%, play2Img, 1, "s24") ;Display icon
        }
        else if (mode = "WRITING") {
            Loop, 4
                GuiButtonIcon(hwndVar%A_Index%, play3Img, 1, "s24") ;Display icon
        }
        GuiControl, +vPlay%origCtrlVar%, %guiControlVar%            ;Change var of control
    }
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

addTipMsg(text, title, time) {
    SplashImage, C:\tempImg.gif, FS11, %text%, ,%title%
    
    SetTimer, RemoveTipMsg, %time%
    return
    
    RemoveTipMsg:
    SplashImage, Off
    return
}

;;OnMessage Functions
WM_KEYDOWN(lparam) {
    if (lparam = 13 && A_GuiControl = "lotCodeSelected") {  ;When press enter in Lot code select section
        loadNodeFromLot()
    }
}

;;;;;;;;;;;;;;;;TOOLBAR CREATIVITY AND FUNCTIONS;;;;;;;;;;;;;;;;
CreateEditNodeToolbar() {
    ImageList1 := IL_Create(3)
    IL_Add(ImageList1, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\folder-icon.ico")
    IL_Add(ImageList1, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\add_file-icon.ico")
    IL_Add(ImageList1, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\save-icon.ico")
    IL_Add(ImageList1, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\pen_with_note-icon.ico")

    Buttons = 
    (LTrim
        -
        Browse File
        Add New
        -
        Save Current Session
        Auto Generate Node ID
    )
    
    ToolbarCreate("OnEditNodeToolbar", Buttons, ImageList1, "Flat List Tooltips", , "x219 y20 w200 h23")
}

OnEditNodeToolbar(hWnd, Event, Text, Pos, Id) {
    If (Event != "Click") {
        Return
    } Else If (RegExMatch(Text, "Browse")) {
        IfWinNotExist, Select a NodeID text file...
            browseNode()
    } Else If (RegExMatch(Text, "Add")) {
        Gosub GetAddNew
    } Else If (RegExMatch(Text, "Save")) {
        saveNodesToWrite()
    } Else If (RegExMatch(Text, "Generate")) {
        Gosub GetAutoGenerate
    }
}

CbAutoComplete() {
	; CB_GETEDITSEL = 0x0140, CB_SETEDITSEL = 0x0142
	If ((GetKeyState("Delete", "P")) || (GetKeyState("Backspace", "P")))
		Return
	GuiControlGet, lHwnd, Hwnd, %A_GuiControl%
	SendMessage, 0x0140, 0, 0,, ahk_id %lHwnd%
	MakeShort(ErrorLevel, Start, End)
	GuiControlGet, CurContent,, %lHwnd%
	GuiControl, ChooseString, %A_GuiControl%, %CurContent%
	If (ErrorLevel) {
		ControlSetText,, %CurContent%, ahk_id %lHwnd%
		PostMessage, 0x0142, 0, MakeLong(Start, End),, ahk_id %lHwnd%
		Return
	}
	GuiControlGet, CurContent,, %lHwnd%
	PostMessage, 0x0142, 0, MakeLong(Start, StrLen(CurContent)),, ahk_id %lHwnd%
}

; Required for: CbAutoComplete()
MakeLong(LoWord, HiWord) {
	Return, (HiWord << 16) | (LoWord & 0xffff)
}

; Required for: CbAutoComplete()
MakeShort(Long, ByRef LoWord, ByRef HiWord) {
	LoWord := Long & 0xffff, HiWord := Long >> 16
}

;;;;;;;;;;;;;;;;NOT-FOR-USER HOT KEYS;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#^!+0::
    index := startedIndex
    Loop, 8
    {
        mainPort := xdotProperties[index].mainPort
        ctrlVar := xdotProperties[index].ctrlVar
        IfWinExist, PORT %mainPort% FAILURE
        {
            changeXdotBttnIcon(ctrlVar, "BAD")
        }
        index++
    }
Return

#^!+9::
    index := startedIndex
    Loop, 8
    {
        mainPort := xdotProperties[index].mainPort
        ctrlVar := xdotProperties[index].ctrlVar
        IfWinExist, PORT %mainPort% PASSED
        {
            changeXdotBttnIcon(ctrlVar, "GOOD")
        }
        index++
    }
Return