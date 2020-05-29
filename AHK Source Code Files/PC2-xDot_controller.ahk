﻿ /*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
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
Global totalPort := 8
Global mainWndTitle := "XDot Controller (PC2)"
Global startedIndex := 9

;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\Toolbar.ahk
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\LIB_xDot_controller.ahk
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

Gui +hWndhMainWnd
Gui Add, GroupBox, xm+205 ym+0 w300 h420 Section, xDot NodeID Editor
;;;;;;Toolbar here
Gui Add, Text, xs+10 ys+38 w285 h2 +0x10 ;;-----------------------------
Gui, Add, Edit, xs+5 ys+75 w35 r25.3 -VScroll -HScroll -Border Disabled Right vlineNo
Gui Font, Bold q5, Consolas
Gui, Add, Edit, xs+40 ys+75 r24 hwndEdit w255 +HScroll veditNode
Gui Font
Gui Font, Bold
Gui Add, Text, xs+10 ys+50 , Select LOT Code:
Gui Font
lotCodeList := getLotCodeList()
For each, item in lotCodeList
    lotCode .= (each == 1 ? "" : "|") . item
Gui Add, ComboBox, xs+120 ys+45 vlotCodeSelected gCbAutoComplete, %lotCode%
Gui Add, Button, xs+250 ys+45 h21 gloadNodeFromLot, Load
Gui Add, GroupBox, xm+0 ym+0 w200 h87 vxdotPanel Section, xDot Panel Group 2
Gui Font, Bold, Ms Shell Dlg 2

Gui Add, Button, xs+69 ys+15 w30 h30 vXDot09 gGetXDot hWndhXDot09, P09
Gui Add, Button, xs+101 ys+15 w30 h30 vXDot10 gGetXDot hWndhXDot10, P10
Gui Add, Button, xs+133 ys+15 w30 h30 vXDot11 gGetXDot hWndhXDot11, P11
Gui Add, Button, xs+165 ys+15 w30 h30 vXDot12 gGetXDot hWndhXDot12, P12

Gui Add, Button, xs+5 ys+50 w30 h30 vXDot13 gGetXDot hWndhXDot13, P13
Gui Add, Button, xs+37 ys+50 w30 h30 vXDot14 gGetXDot hWndhXDot14, P14
Gui Add, Button, xs+69 ys+50 w30 h30 vXDot15 gGetXDot hWndhXDot15, P15
Gui Add, Button, xs+101 ys+50 w30 h30 vXDot16 gGetXDot hWndhXDot16, P16
Gui Font

Gui Add, GroupBox, xm+0 ym+90 w200 h110 Section, Functional Test
Gui Add, Text, cgray xs+10 ys+20, Test firmware version: 3.0.2-debug
Gui Add, Radio, xs+15 ys+37 vtotalGPortRadio Group +Checked gradioToggle, Run tests on %totalGoodPort% ports
Gui Add, Radio, xs+15 ys+54 vreproGPortRadio gradioToggle, Reprogram %totalGoodPort% ports to debug mode
Gui Add, Button, xs+73 ys+75 w55 h28 grunAll, RUN

Gui Add, GroupBox, xm+0 ym+205 w200 h245 Section, EUID Write
Gui Add, Text, xs+10 ys+20, Select Frequency:
For each, item in allFregs
    freq .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, xs+105 ys+17 w85 vchosenFreq, %freq%
index := startedIndex
xVarStarted := 5
yVarStarted := 50
Loop, 8
{
    mainPort := xdotProperties[index].mainPort
    Gui Font, Bold,
    Gui Add, Text, xs+5 ys+%yVarStarted% vportLabel%index%, P%mainPort%
    Gui Font
    Gui Add, Edit, xs+37 ys+%yVarStarted% w144 h16 +ReadOnly vnodeToWrite%index%,
    
    index++
    yVarStarted += 20
}
Gui Add, Button, xs+182 ys+50 w15 h155 ggiveBackToEdit, >
Gui Add, Text, cgray xs+5 ys+225, FW: v3.2.1
Gui Add, Button, xs+73 ys+211 w55 h28 gwriteAll, START

;Gui Add, GroupBox, xm+205 ym+430 w290 h55 Section, All Records
;Gui Add, Button, xs+100 ys+20 w140 h25 ggetRecords, EUID Write History

;;;Functions to run BEFORE main gui is started;;;
OnMessage(0x100, "WM_KEYDOWN")
OnMessage(0x200, "WM_MOUSEMOVE")
deleteOldCacheFiles()    ;Delete result port data before gui start (Ex: 101.dat)

;;Add Menu Bar
AddMainMenuBar()

posX := A_ScreenWidth - 600
Gui, Show, x%posX% y150, %mainWndTitle%

;;;Functions to run AFTER main gui is started;;;
editnodeToolbar := CreateEditNodeToolbar()
;loadNodesToWrite()

GuiControlGet, editNode, Pos, editNode
IfNotExist C:\teraterm\ttermpro.exe
    MsgBox, 16, WARNING, This program only work with a secondary program.`nPlease install Teraterm to this location: C:\teraterm\
#Persistent
SetTimer, DrawLineNum, 1
SetTimer, CheckFileChange, 20
SetTimer, CheckLotChange, 200
Return      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawLineNum:
pos := DllCall("GetScrollPos", "UInt", Edit, "Int", 1)
ifEqual, pos, % posPrev, return                       ;if nothing new
posPrev := pos
drawLineNumbers(pos)                                  ;draw line numbers
Return

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

CheckFileChange:
IfExist %remotePath%
{
    Fileread newFileContent, Z:\XDOT\nodesToWrite.txt
    if(newFileContent != lastFileContent) {
        lastFileContent := newFileContent
        loadNodesToWrite()
    }
}
Return

CheckLotChange:
IfExist %remotePath%\Saved-Nodes
{
    newLotList := []
    Loop Files, %remotePath%\Saved-Nodes\*.txt, R
    {
        newLotList[A_Index] := A_LoopFileName
        reverseArray(newLotList)
        newLot := newLotList[1]
    }
    if(newLot != oldLot) {
        oldLot := newLotList[1]
        updateLotCodeList()
    }
}
Return

GuiClose:
    MsgBox 36, , Are you sure you want to quit?
    IfMsgBox Yes
    {
        for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-winwaitEachPort.exe' ")
        Process, close, % process.ProcessId
        
        ExitApp
     }
Return
;=======================================================================================;
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
    FileRead, data, C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
    
    WinActivate COM%mainPort%
    ;;;GUI
    Gui, xdot: Default
    Gui, xdot: +ToolWindow +AlwaysOnTop +hWndhXdotWnd
    Gui xdot: Add, GroupBox, xm+0 ym+0 w200 h70 Section, XDot-%num% Connecting Infomation
    Gui Font, Bold
    Gui xdot: Add, Text, xs+8 ys+20, • COM PORT: %mainPort%
    Gui xdot: Add, Link, xs+145 ys+19 gConnectMainPort, <a href="#">Connect</a>
    Gui xdot: Add, Text, xs+8 ys+35, • BREAK PORT: %breakPort%
    Gui xdot: Add, Text, xs+8 ys+50, • DRIVE NAME: %driveName%
    Gui xdot: Add, Link, xs+145 ys+49 gOpenXdotFolder, <a href="#">Open</a>
    Gui Font
    
    ;Gui xdot: Add, GroupBox, xm+0 ym+70 w200 h120 Section, Functional Test
    ;Gui xdot: Add, GroupBox, xm+0 ym+240 w200 h130 Section, EUID Write
    
    Gui xdot: Add, Tab3, xm+0 ym+75 w200 h130 +Theme -Background Section, Functional Test|EUID Write
    Gui xdot: Tab, 1
    Gui xdot: Add, Text, xs+110 ys+30, Connecting
    Gui xdot: Add, Text, xs+110 ys+50, Programmable
    Gui xdot: Add, Text, xs+110 ys+70, Joinning
    Gui xdot: Add, Text, xs+110 ys+90, Ping
    Gui xdot: Add, Text, xs+110 ys+110, RSSI
    
    ;Image indicators
    Gui xdot: Add, Picture, xs+80 ys+28 w17 h17 +BackgroundTrans vprocess1, 
    Gui xdot: Add, Picture, xs+80 ys+48 w17 h17 +BackgroundTrans vprocess2, 
    Gui xdot: Add, Picture, xs+80 ys+68 w17 h17 +BackgroundTrans vprocess3, 
    Gui xdot: Add, Picture, xs+80 ys+88 w17 h17 +BackgroundTrans vprocess4, 
    Gui xdot: Add, Picture, xs+80 ys+108 w17 h17 +BackgroundTrans vprocess5, 
    buttonLabel1 := (isBadXdot = 1 && RegExMatch(data, "TEST") > 0) ? "RE-RUN" : "RUN"
    Gui xdot: Add, Button, w50 h45 xs+10 ys+50 gFunctionalTestEach, %buttonLabel1%
    Gui xdot: Tab
    
    Gui xdot: Tab, 2
    Gui xdot: Add, Text, xs+5 ys+35, STAT:
    Gui xdot: Add, Text, xs+5 ys+55, FREQ:
    Gui xdot: Add, Text, xs+5 ys+75, EUID:
    Gui xdot: Add, Edit, xs+45 ys+33 w148 h16 vxStatus +ReadOnly, READY
    Gui xdot: Add, Edit, xs+45 ys+53 w148 h16 vxFreq,
    Gui xdot: Add, Edit, xs+45 ys+73 w148 h16 vxEUID,
    buttonLabel2 := (isBadXdot = 1 && RegExMatch(data, "WRITE") > 0) ? "RE-RUN" : "RUN"
    Gui xdot: Add, Button, xs+75 ys+95 w50 h30 vwriteBttnEach gWriteIDEach, %buttonLabel2%
    Gui xdot: Tab
    
    Gui xdot: Add, GroupBox, xm+0 ym+205 w200 h55 Section, Programming
    Gui xdot: Add, Button, w180 xs+10 ys+20 gToDebugEach, Program %ctrlVar% to debug mode
    
    if (RegExMatch(data, "WRITE") > 0)
        GuiControl, xdot: Choose, SysTabControl321, 2    ;Focus on tab 2
    
    ;;Labels or Functions to run before gui start
    if (RegExMatch(data, "CONNECTION FAILED") > 0) {
        GuiControl, , process1, %xImg%
    } else if (RegExMatch(data, "FAILED TO PROGRAM") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %xImg%
    } else if (RegExMatch(data, "FAILED TO JOIN") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %checkImg%
        GuiControl, , process3, %xImg%
    } else if (RegExMatch(data, "PING.*FAILURE") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %checkImg%
        GuiControl, , process3, %checkImg%
        GuiControl, , process4, %xImg%
    } else if (RegExMatch(data, "RSSI LEVEL FAILURE") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %checkImg%
        GuiControl, , process3, %checkImg%
        GuiControl, , process4, %checkImg%
        GuiControl, , process5, %xImg%
    } else if (RegExMatch(data, "ALL PASSED") > 0) {
        GuiControl, , process1, %checkImg%
        GuiControl, , process2, %checkImg%
        GuiControl, , process3, %checkImg%
        GuiControl, , process4, %checkImg%
        GuiControl, , process5, %checkImg%
    }
    IfNotExist C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
    {
        Gui 1: Default
        GuiControlGet, chosenFreq   ;Get value from DropDownList
        RegExMatch(A_GuiControl, "\d+$", num)
        node := readNodeLine(num)
        
        Gui xdot: Default
        GuiControl, Text, xFreq, %chosenFreq%   ;Change text
        GuiControl, Text, xEUID, %node%   ;Change text
    }
    
    if (isBadXdot = 1 || isGoodXdot = 1) && if (RegExMatch(data, "WRITE") > 0) {
        Loop, Parse, data, `,
        {
            if (A_Index = 3)
                GuiControl, Text, xEUID, %A_LoopField%   ;Change text
            if (A_Index = 4) {
                if (RegExMatch(A_LoopField, "FAIL|WRONG|INVALID"))
                    Gui, Font, cf24b3f
                else if (RegExMatch(A_LoopField, "PASS"))
                    Gui, Font, c41e81c
                GuiControl, Font, xStatus
                GuiControl, Text, xStatus, %A_LoopField%   ;Change text
            }
            if (A_Index = 5)
                GuiControl, Text, xFreq, %A_LoopField%   ;Change text
        }
    }
    
    mainY := mainY + 145
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
        ;Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="%xdotTestFilePath% "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%" "singleTest"", ,Hide
        Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE %xdotTestFilePath% dummyParam %mainPort% %breakPort% %portName% %driveName% singleTest newTTVersion, ,Hide

        ;;;Track processes
        Gui xdot: Default
        Loop, 5
        {
           GuiControl, , process%A_Index%, %play1Img%
           WinWait PASSED%A_Index%|%mainPort% FAILURE
           IfWinExist %mainPort% FAILURE
           {
               GuiControl, , process%A_Index%, %xImg%
               goto XdotFailed
           }
           GuiControl, , process%A_Index%, %checkImg%
        }
        
        changeXdotBttnIcon(ctrlVar, "GOOD")
    Return
    
    XdotFailed:
        changeXdotBttnIcon(ctrlVar, "BAD")
    Return
        
    ToDebugEach:
        IfNotExist %driveName%:\
        {
            MsgBox 16, ERROR, Drive (%driveName%:\) does not exist!
            Return
        }
        
        changeXdotBttnIcon(ctrlVar, "PLAY", "PROGRAMMING")
        WinKill COM%mainPort%
        Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
        ;msg = Reprogramming on PORT %mainPort%...Please wait!
        ;title = PORT %mainPort% PROGRAMMING
        ;addTipMsg(msg, title, 17000)
        ;RunWait, %ComSpec% /c copy C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin %driveName%:\ , ,Hide
        ;Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reset.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
        WinWait %mainPort% FAILURE|%mainPort% PASSED
        ifWinExist, %mainPort% FAILURE
            changeXdotBttnIcon(ctrlVar, "BAD")
        ifWinExist, %mainPort% PASSED
            changeXdotBttnIcon(ctrlVar, "GOOD", "PROGRAMMING")
    Return
    
    WriteIDEach:
        WinKill COM%mainPort%
        GuiControlGet, inFreq, , xFreq
        GuiControlGet, inId, , xEUID
        GuiControlGet, writeBttnLabel, , writeBttnEach
        if (inFreq = "" || inId = "") {
            MsgBox 16 , ,Please enter all requires fields!
            return
        }
        
        if (RegExMatch(inFreq, "[A-Z]+([0-9]{3})") = 0) {
            MsgBox 16 , ERROR ,INPUT INVALID FREQUENCY. RETRY!
            return
        }
        
        if (RegExMatch(inId, "[g-zG-Z]") > 0) {
            MsgBox 16 , ERROR ,INPUT INVALID UUID. RETRY!
            return
        }
        
        if (writeBttnLabel = "RUN") {
            OnMessage(0x44, "PlayInCircleIcon") ;Add icon
            MsgBox 0x81, RUN WRITE EUID, Begin EUID WRITE on PORT %mainPort%?
            OnMessage(0x44, "") ;Clear icon
            IfMsgBox Cancel
                return
        }
        changeXdotBttnIcon(ctrlVar, "PLAY", "WRITING")
        Gui xdot: Default
        Gui, Font, c0c63ed
        GuiControl, Font, xStatus
        GuiControl, Text, xStatus, RUNNING   ;Change text
        Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_euid.ttl dummyParam2 %mainPort% %breakPort% %driveName% dummyParam6 %inFreq% %inId% newTTVersion, ,Hide
        
        WinWait %mainPort% FAILURE|%mainPort% PASSED
        ifWinExist, %mainPort% FAILURE
        {
            WinGetText textOnWin, %mainPort% FAILURE
            Gui, Font, cf24b3f
            GuiControl, Font, xStatus
            GuiControl, Text, xStatus, %textOnWin%   ;Change text
            changeXdotBttnIcon(ctrlVar, "BAD")
        }
        ifWinExist, %mainPort% PASSED
        {
            Gui, Font, c41e81c
            GuiControl, Font, xStatus
            GuiControl, Text, xStatus, PASSED   ;Change text
            changeXdotBttnIcon(ctrlVar, "GOOD")
        }
    Return
    
    ConnectMainPort:
        IfWinNotExist COM%mainPort%
            Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /C=%mainPort%, , Hide
        WinActivate COM%mainPort%
    Return
    
    OpenXdotFolder:
        IfNotExist %driveName%:\
        {
            MsgBox 16, ERROR, Drive (%driveName%:\) does not exist!
            Return
        }
        Run, %driveName%:\
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
    Gui, adNew: Add, GroupBox, xm+0 ym+0 w230 h60 Section, Option 1
    Gui Font, Bold
    Gui, adNew: Add, Text, xs+10 ys+15, Add New From Current Editor
    Gui, Font
    Gui, adNew: Add, Text, xs+10 ys+35, Enter LOT CODE:
    Gui, adNew: Add, Edit, xs+100 ys+32 w75 h20 vinLotCode +Number Limit10
    Gui, adNew: Add, Button, xs+185 ys+32 h20 gSaveLot1, Save
    
    Gui, adNew: Add, GroupBox, xm+0 ym+65 w230 h60 Section, Option 2
    Gui Font, Bold
    Gui, adNew: Add, Text, xs+10 ys+15, Add New From A File
    Gui, Font
    
    Gui, adNew: Add, Button, xs+10 ys+35 h20 gBrowseLot, Browse...
    Gui, adNew: Add, Text, xs+70 ys+40 w110 vfilePathLabel,
    Gui, adNew: Add, Button, xs+185 ys+35 h20 gSaveLot2, Save
    
    mainY := mainY + 30
    Gui, adNew: Show, x%mainX% y%mainY%, Add New Node List
    Return
    
    SaveLot1:
        GuiControlGet newLotCode, , inLotCode
        lotCodeArray := getLotCodeList()
        
        if (newLotCode = "") {
            MsgBox 16, ,Please enter lot code!
            return
        }
        
        Loop % lotCodeArray.Length()
        {
            if (lotCodeArray[A_Index] = newLotCode) {
                MsgBox 16, , Duplicate Lot Code`nPlease Enter a different one!
                return
            }
        }
        
        Gui, 1: Default
        GuiControlGet editContent, , editNode    ;get new text in edit field
        
        FileAppend, %editContent%, %remotePath%\Saved-Nodes\%newLotCode%.txt
        Gui, adNew: Destroy
        updateLotCodeList()
    Return
    
    BrowseLot:
        FileSelectFile, selectedFile, , , Select a NodeID text file..., Text Documents (*.txt; *.doc)
        if (selectedFile = "")
            return
        GuiControl, Text, filePathLabel, %selectedFile%
    Return
        
    SaveLot2:
        lotCodeArray := getLotCodeList()
        
        if (selectedFile = "") {
            MsgBox 16, , Please select a text file!
            return
        }
        
        SplitPath selectedFile, fileName    ;Get the filename
        Loop % lotCodeArray.Length()
        {
            if (RegExMatch(fileName, lotCodeArray[A_Index]) > 0) {
                MsgBox 16, , Duplicate Lot Code`nPlease choose a different file!
                return
            }
        }
        
        fileNameNoEx := StrReplace(fileName, ".txt", "")
        if(RegExMatch(fileNameNoEx, "^(\d){10}$") = 0) {
            MsgBox 16, ERROR, Wrong Node File!`nPlease pick a file with this format: ##########.txt! (EX: 1234567890.txt)
            return
        }
        
        FileCopy, %selectedFile%, %remotePath%\Saved-Nodes\%fileName%
        Gui, 1: Default
        FileRead, fileContent, %selectedFile%
        GuiControl Text, editNode, %fileContent%
        Gui, adNew: Destroy
        updateLotCodeList()
    Return
    
    adNewGuiEscape:
    adNewGuiClose:
        Gui, adNew: Destroy
    Return
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q::
    For process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-winwaitEachPort.exe' ")
    Process, close, % process.ProcessId
    ExitApp
^t::
    runAll()
return
^w::
    Gui, xdot: Destroy
    writeAll()
return
#IfWinActive, PC2
^s::
    saveNodesToWrite()
#IfWinActive
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;Additional Label Functions;;;;;;;;;;;;;;;;;
;Launched whenever the user right-clicks on gui controls
GuiContextMenu:
    OnRightClick()
Return

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
    Loop, %totalPort%
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
    GuiControlGet, isRunReprogChecked, , reproGPortRadio
    index := startedIndex
    Loop, %totalPort%
    {
        mainPort := xdotProperties[index].mainPort
        ctrlVar := xdotProperties[index].ctrlVar
        IfWinExist, PORT %mainPort% PASSED
        {
            changeXdotBttnIcon(ctrlVar, "GOOD")
            if (isRunReprogChecked = 1)
                changeXdotBttnIcon(ctrlVar, "GOOD", "PROGRAMMING")
        }
        index++
    }
Return