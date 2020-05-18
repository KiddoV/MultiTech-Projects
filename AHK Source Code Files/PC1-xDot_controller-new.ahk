 /*
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
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_test.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_write_euid.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_euid.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_reprogram.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_xdot_reset.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reset.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\INI-Files\xdot-tt-settings.INI, C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\EXE-Files\xdot-winwaitEachPort.exe, C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe, 1

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\Toolbar.ahk, C:\V-Projects\XDot-Controller\AHK-Lib\Toolbar.ahk
, 1

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AS923_JAPAN-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AS923_JAPAN-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AS923-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AS923-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AU915-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AU915-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-EU868-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-EU868-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-IN865-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-IN865-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-KR920-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-KR920-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-RU864-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-RU864-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1.bin, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

;Global nodesToWritePath := "Z:\XDOT\nodesToWrite.txt"
Global remotePath := "Z:\XDOT"
Global lotCodeList := []

Global xdotProperties := [{}]  ; Creates an array containing an object.
xdotProperties[1] := {status: "G", mainPort: 101, breakPort: 11, portName: "PORT1", driveName: "D", ttXPos: 5, ttYPos: 5, ctrlVar: "XDot01"}
xdotProperties[2] := {status: "G", mainPort: 102, breakPort: 12, portName: "PORT2", driveName: "E", ttXPos: 105, ttYPos: 5, ctrlVar: "XDot02"}
xdotProperties[3] := {status: "G", mainPort: 103, breakPort: 13, portName: "PORT3", driveName: "F", ttXPos: 205, ttYPos: 5, ctrlVar: "XDot03"}
xdotProperties[4] := {status: "G", mainPort: 104, breakPort: 14, portName: "PORT4", driveName: "G", ttXPos: 305, ttYPos: 5, ctrlVar: "XDot04"}
xdotProperties[5] := {status: "G", mainPort: 105, breakPort: 15, portName: "PORT5", driveName: "H", ttXPos: 405, ttYPos: 5, ctrlVar: "XDot05"}
xdotProperties[6] := {status: "G", mainPort: 106, breakPort: 16, portName: "PORT6", driveName: "I", ttXPos: 505, ttYPos: 5, ctrlVar: "XDot06"}
xdotProperties[7] := {status: "G", mainPort: 107, breakPort: 17, portName: "PORT7", driveName: "J", ttXPos: 5, ttYPos: 105, ctrlVar: "XDot07"}
xdotProperties[8] := {status: "G", mainPort: 108, breakPort: 18, portName: "PORT8", driveName: "K", ttXPos: 105, ttYPos: 105, ctrlVar: "XDot08"}

Global totalGoodPort := 8
Global totalPort := 8
Global mainWndTitle := "XDot Controller (PC1)"
Global startedIndex := 1
Global allFregs := ["AS923", "AS923-JAPAN", "AU915", "EU868", "IN865", "KR920", "RU864", "US915"]

Global xImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\x_mark.png"
Global checkImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark.png"
Global play1Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_orange.png"
Global play2Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_brown.png"
Global play3Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_blue.png"
Global disImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png"

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
Gui Add, GroupBox, xm+0 ym+0 w200 h87 vxdotPanel Section, xDot Panel Group 1
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

Gui Add, GroupBox, xm+0 ym+90 w200 h110 Section, Functional Test
Gui Add, Text, xs+10 ys+20, Test firmware version: 3.0.2-debug
Gui Add, Radio, xs+15 ys+37 vtotalGPortRadio Group +Checked gradioToggle, Run tests on %totalGoodPort% ports
Gui Add, Radio, xs+15 ys+54 vreproGPortRadio gradioToggle, Reprogram %totalGoodPort% ports to debug mode
Gui Add, Button, xs+73 ys+75 w55 h28 grunAll, RUN

Gui Add, GroupBox, xm+0 ym+205 w200 h245 Section, EUID Write
Gui Add, Text, xs+10 ys+20, Select Frequency:
For each, item in allFregs
    freq .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, xs+110 ys+17 w80 vchosenFreq, %freq%
;index := startedIndex
;xVarStarted := 5
;yVarStarted := 50
;Loop, 8
;{
    ;mainPort := xdotProperties[index].mainPort
    ;Gui Font, Bold,
    ;Gui Add, Text, xs+5 ys+%yVarStarted% vportLabel%index%, P%mainPort%:
    ;Gui Font
    ;Gui Add, Edit, xs+45 ys+%yVarStarted% w150 h16 +ReadOnly vnodeToWrite%index%,
    ;
    ;index++
    ;yVarStarted += 20
;}
Gui, Font, c0c63ed Bold
Gui Add, ListView, xs+5 ys+43 w190 h164 vidListView +Grid +NoSortHdr, #|Node ID
Loop, 8
    LV_Add("", A_Index)
Gui, Font

Gui Add, Button, xs+73 ys+211 w55 h28 gwriteAll, START

;Gui Add, GroupBox, xm+205 ym+430 w290 h55 Section, All Records
;Gui Add, Button, xs+100 ys+20 w140 h25 ggetRecords, EUID Write History

;;;Functions to run before main gui is started;;;
OnMessage(0x100, "WM_KEYDOWN")
deleteOldCacheFiles()    ;Delete result port data before gui start (Ex: 101.dat)

posX := A_ScreenWidth - 600
Gui, Show, x%posX% y150, %mainWndTitle%

;;;Functions to run after main gui is started;;;
editnodeToolbar := CreateEditNodeToolbar()
;loadNodesToWrite()

GuiControlGet, editNode, Pos, editNode
IfNotExist C:\teraterm\ttermpro.exe
    MsgBox, 16, WARNING, This program only work with a secondary program.`nPlease install Teraterm to this location: C:\teraterm\
#Persistent
SetTimer, DrawLineNum, 1
SetTimer, CheckFileChange, 20
return

DrawLineNum:
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

CheckFileChange:
Fileread newFileContent, Z:\XDOT\nodesToWrite.txt
if(newFileContent != lastFileContent) {
    lastFileContent := newFileContent
    loadNodesToWrite()
}
return

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
    FileRead, data, C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
    
    WinActivate COM%mainPort%
    ;;;GUI
    Gui, xdot: Default
    Gui, xdot: +ToolWindow +AlwaysOnTop +hWndhXdotWnd
    Gui xdot: Add, GroupBox, xm+0 ym+0 w200 h70 Section, XDot-%num% Connecting Infomation
    Gui Font, Bold
    Gui xdot: Add, Text, xs+8 ys+20, • COM PORT: %mainPort%
    Gui xdot: Add, Link, xs+145 ys+20 gConnectMainPort, <a href="#">Connect</a>
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
    buttonLabel1 := (isBadXdot = 1 && RegExMatch(data, "TEST") > 0) ? "RE-RUN" : "RUN"
    Gui xdot: Add, Button, w50 h45 xs+10 ys+45 gFunctionalTestEach, %buttonLabel1%
    
    Gui xdot: Add, GroupBox, xm+0 ym+190 w200 h50 Section, Programming
    Gui xdot: Add, Button, w180 xs+10 ys+20 gToDebugEach, Program %ctrlVar% to debug mode
    
    Gui xdot: Add, GroupBox, xm+0 ym+240 w200 h130 Section, EUID Write
    Gui xdot: Add, Text, xs+5 ys+25, STAT:
    Gui xdot: Add, Text, xs+5 ys+45, FREQ:
    Gui xdot: Add, Text, xs+5 ys+65, EUID:
    Gui xdot: Add, Edit, xs+45 ys+23 w150 h16 vxStatus +ReadOnly, READY
    Gui xdot: Add, Edit, xs+45 ys+43 w150 h16 vxFreq,
    Gui xdot: Add, Edit, xs+45 ys+63 w150 h16 vxEUID,
    buttonLabel2 := (isBadXdot = 1 && RegExMatch(data, "WRITE") > 0) ? "RE-RUN" : "RUN"
    Gui xdot: Add, Button, xs+75 ys+90 w50 h30 vwriteBttnEach gWriteIDEach, %buttonLabel2%
    
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
    
    mainY := mainY + 120
    Gui xdot: Show, x%mainX% y%mainY%, XDot %num%
    Return

    xdotGuiEscape:
    xdotGuiClose:
        Gui, xdot: Destroy
    Return
    
    ;;;Functions and Labels for xdot GUI;;;
    FunctionalTestEach:        changeXdotBttnIcon(ctrlVar, "PLAY", "TESTING")
        
        WinKill COM%mainPort%
        ;Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%" "singleTest"", ,Hide
        Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl dummyParam %mainPort% %breakPort% %portName% %driveName% singleTest newTTVersion, ,Hide

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
    Gui, adNew: Add, Text, x10 y60, Add New From A File
    Gui, Font
    
    Gui, adNew: Add, Text, x15 y30, Enter LOT CODE:
    Gui, adNew: Add, Edit, x105 y27 w75 h20 vinLotCode +Number Limit10
    Gui, adNew: Add, Button, x190 y27 h20 gSaveLot1, Save
    Gui Add, Text, x20 y55 w200 h2 +0x10
    Gui, adNew: Add, Button, x15 y80 h20 gBrowseLot, Browse...
    Gui, adNew: Add, Text, x75 y83 w110 vfilePathLabel,
    Gui, adNew: Add, Button, x190 y80 h20 gSaveLot2, Save
    
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q::
    For process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-winwaitEachPort.exe' ")
    Process, close, % process.ProcessId
    ExitApp
^t::
    runAll()
#IfWinActive, PC1
^s::
    saveNodesToWrite()
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
runAll() {
    GuiControlGet, isRunTestChecked, , totalGPortRadio
    GuiControlGet, isRunReprogChecked, , reproGPortRadio
    if (isRunTestChecked = 1) {
        OnMessage(0x44, "PlayInCircleIcon") ;Add icon
        MsgBox 0x81, RUN FUNCTIONAL TEST, Begin FUNCTIONAL TESTS on all %totalGoodPort% ports?
        OnMessage(0x44, "") ;Clear icon
        index := startedIndex
        IfMsgBox OK
        {
            resetXdotBttns()
            deleteOldCacheFiles()
            Loop, %totalPort%
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
                    ;Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /F=C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI /X=%ttXPos% /Y=%ttYPos% /C=%mainPort% /M="C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl "dummyParam" "%mainPort%" "%breakPort%" "%portName%" "%driveName%"", , Hide
                    IfWinExist PROGRAMMING
                        Sleep 8000
                    changeXdotBttnIcon(ctrlVar, "PLAY", "TESTING")
                    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE /V C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
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
            Loop, %totalPort%
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
                    IfWinExist PROGRAMMING
                        Sleep 8000
                    changeXdotBttnIcon(ctrlVar, "PLAY", "PROGRAMMING")
                    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
                    Run, %ComSpec% /c start C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe %mainPort%, , Hide
                    Sleep 2500
                }
            }
        }
        IfMsgBox Cancel
            return
    }
    
}

writeAll() {
    GuiControlGet, chosenFreq   ;Get value from DropDownList
    if (chosenFreq = "") {
        MsgBox 16, ,Please select a FREQUENCY!
        return
    }
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, Start Writing, Begin EUID WRITE on all %totalGoodPort% ports?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        resetXdotBttns()
        deleteOldCacheFiles()
        resetNodesToWrite()
        index := startedIndex
        Loop, %totalPort%
        {
            ctrlVar := xdotProperties[index].ctrlVar
            xStatus := xdotProperties[index].status
            node := readNodeLine(index)
            if (RegExMatch(node, "[0-9a-fA-F]") = 0) && if (xStatus = "G"){
                changeXdotBttnIcon(ctrlVar, "DISABLE", , index)
            }
            
            xStatus := xdotProperties[index].status
            if (xStatus = "G") {
                GuiControl Text, nodeToWrite%index%, %node%
                replaceNodeLine(index, "----")
            }
            index++
        }
        saveNodesToWrite()
        
        ;Start writing
        Sleep 500
        index := startedIndex
        Loop, %totalPort%
        {
            ctrlVar := xdotProperties[index].ctrlVar
            xStatus := xdotProperties[index].status
            mainPort := xdotProperties[index].mainPort
            breakPort := xdotProperties[index].breakPort
            driveName := xdotProperties[index].driveName
            if (xStatus = "G") {
                WinKill COM%mainPort%
                IfWinExist PROGRAMMING
                        Sleep 8000
                changeXdotBttnIcon(ctrlVar, "PLAY", "WRITING")
                Gui, Font, c0c63ed Bold
                GuiControl, Font, portLabel%index%
                Gui, Font
                Gui, Font, c0c63ed
                GuiControl, Font, nodeToWrite%index%
                GuiControlGet, node, , nodeToWrite%index%
                StringReplace node, node, %A_Space%, , All  ;Delete all white space in variable
                
                Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_euid.ttl dummyParam2 %mainPort% %breakPort% %driveName% dummyParam6 %chosenFreq% %node% newTTVersion, ,Hide
                Run, %ComSpec% /c start C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe %mainPort%, , Hide
                Sleep 2500
            }
            
             if (index = 24) {
                FileRead, fileContent, %remotePath%\nodesToWrite.txt
                noNodeCount := 1
                Loop, Parse, fileContent, `n
                    if (A_Index < 24) 
                        if (RegExMatch(A_LoopField, "[0-9a-fA-F]") = 0) {
                            noNodeCount++
                            if (noNodeCount = 24) {
                                listNodeArray := StrSplit(fileContent, "`n", "`t")    ;Convert string to array
                                Loop, 24
                                    removedNode := listNodeArray.RemoveAt(1)  ;Remove the first 24 used nodes
                                newListNodes := ""              ;Convert array back to string
                                For key, var in listNodeArray
                                    newListNodes .= var "`n"
                                newListNodes := RTrim(newListNodes, "`n")       ;remove last while space
                                GuiControl Text, editNode, %newListNodes%       ;Return nodes to edit field
                                saveNodesToWrite()      ;Save new content
                            }
                        }
            }
            index++
        }
    }
    IfMsgBox Cancel
        return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
;Launched whenever the user right-clicks on gui controls
GuiContextMenu:
    Gui, 1: Default    
    GuiControlGet, hwndVar, Hwnd , %A_GuiControl%
    RegExMatch(A_GuiControl, "\d+$", num)
    numNo0 := StrReplace(num, 0, "")
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
        GuiControl, Disable, portLabel%numNo0%
        GuiControl, Disable, nodeToWrite%numNo0%
        xdotProperties[num].status := "D"
        GuiControl, +vDis%A_GuiControl%, %A_GuiControl%     ;Change var of control
        GuiControl, Text, %A_GuiControl%,    ;Delete text
        GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png", 1, "s24")   ;Display icon
    } else if (isDisXdot = 1 || isDisBadXdot = 1 || isDisGoodXdot = 1) {
        totalGoodPort++
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to debug mode
        GuiControl, Enable, portLabel%numNo0%
        GuiControl, Enable, nodeToWrite%numNo0%
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

resetNodesToWrite() {
    Gui, 1: Default
    index := startedIndex
    Loop, %totalPort%
    {
        GuiControl Text, nodeToWrite%index%,    ;Delete text
        Gui, Font, Bold
        GuiControl, Font, portLabel%index%
        Gui, Font,
        GuiControl, Font, nodeToWrite%index%
        index++
    }
}

deleteOldCacheFiles() {
    Loop, 24
    {
        mainPort := xdotProperties[A_Index].mainPort
        FileDelete, C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
    }
}

loadNodesToWrite() {
    FileRead, fileContent, %remotePath%\nodesToWrite.txt
    StringReplace, fileContent, fileContent, %A_Space%, , All
    StringReplace, fileContent, fileContent, %A_Tab%, , All
    GuiControl Text, editNode, %fileContent%
}

saveNodesToWrite() {
    fileLoc = %remotePath%\nodesToWrite.txt
    GuiControlGet readEditContent, , editNode    ;get new text
    FileRead mainContent, %remotePath%\nodesToWrite.txt
    
    if (mainContent != "")
        FileCopy %remotePath%\nodesToWrite.txt, %remotePath%\nodesToWrite.bak, 1
    FileRead bakContent, %remotePath%\nodesToWrite.bak
    
    file := FileOpen(fileLoc, "w")      ;delete all text
    file.Close()
    if (readEditContent = "")
        FileAppend, %bakContent%, %fileLoc%     ;write backup text to file
    FileAppend, %readEditContent%, %fileLoc%     ;write new text to file
}

readNodeLine(lineNum) {
    GuiControlGet listEditNodes, , editNode
    Loop, Parse, listEditNodes, `n
    {
        if (A_Index = lineNum)
            return A_LoopField
    }
}

replaceNodeLine(lineNum, replaceStr := "") {
    GuiControlGet listEditNodes, , editNode
    listEditNodeArray := StrSplit(listEditNodes, "`n", "`t")    ;Convert string to array
    listEditNodeArray[lineNum] := replaceStr    ;Replace text by index
    
    newListEditNodes := ""              ;Convert array back to string
    For key, var in listEditNodeArray
        newListEditNodes .= var "`n"
    newListEditNodes := RTrim(newListEditNodes, "`n")     ;remove last while space
    GuiControl Text, editNode, %newListEditNodes%
}

radioToggle() {
    resetXdotBttns()
    deleteOldCacheFiles()
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

getLotCodeList() {
    lotList := []
    Loop Files, %remotePath%\Saved-Nodes\*.txt, R ; Recurse into subfolders.
    {
        str := A_LoopFileName
        StringReplace, str, str, .txt, , All    ;Remove .txt
        lotList[A_Index] := str
    }
    reverseArray(lotList)
    
    return lotList
}

reverseArray(array)
{
	arrayC := array.Clone()
	tempObj := {}
	for vKey in array
		tempObj.Push(vKey)
	vIndex := tempObj.Length()
	for vKey in array
		array[vKey] := arrayC[tempObj[vIndex--]]
	arrayC := tempObj := ""
}

updateLotCodeList() {
    Gui, 1: Default
    newLotCodeList := getLotCodeList()     ;Reload lot code list var
    newLotCodeDrop := ""
    For each, item in newLotCodeList
    {
        if (each == 1)
            newLotCode := item
        newLotCodeDrop .= (each == 1 ? "" : "|") . item
    }
    GuiControl, , lotCodeSelected, |%newLotCodeDrop%
    GuiControl, Text, lotCodeSelected, %newLotCode%
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

changeXdotBttnIcon(guiControlVar, option, mode := "", xIndex := 0) {
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
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        Loop, 4
            GuiButtonIcon(hwndVar%A_Index%, disImg, 1, "s24")         ;Display icon
        xdotProperties[xIndex].status := "D"
        GuiControl, +vDis%origCtrlVar%,  %origCtrlVar%          ;Change var of control
        totalGoodPort--
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to debug mode
        GuiControl, Disable, portLabel%xIndex%
        GuiControl, Disable, nodeToWrite%xIndex%
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
;=======================================================================================;
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

SetEditCueBanner(HWND, Cue) {  ; requires AHL_L
   Static EM_SETCUEBANNER := (0x1500 + 1)
   Return DllCall("User32.dll\SendMessageW", "Ptr", HWND, "Uint", EM_SETCUEBANNER, "Ptr", True, "WStr", Cue)
}

getCmdOut(command) {
    RunWait, PowerShell.exe -ExecutionPolicy Bypass -Command %command% | clip , , Hide
    return Clipboard
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
#IfWinActive
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