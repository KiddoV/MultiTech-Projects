﻿/*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx

;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\AMAuto-Tester\Imgs-for-GUI
    FileCreateDir C:\V-Projects\AMAuto-Tester\Imgs-for-GUI
IfNotExist C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func
    FileCreateDir C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func
IfNotExist C:\V-Projects\AMAuto-Tester\TTL-Files
    FileCreateDir C:\V-Projects\AMAuto-Tester\TTL-Files

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\check.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\time.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\time.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\arrow.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\arrow.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_test.ttl, C:\V-Projects\AMAuto-Tester\TTL-Files\all_test.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\all_config.ttl, C:\V-Projects\AMAuto-Tester\TTL-Files\all_config.ttl, 1

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\ffs.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\ffs.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\mli419.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\mli419.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\1111.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\1111.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\at-cpin.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\at-cpin.bmp, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

Global 240_ItemNums := ["70000041L", "70000049L"]
Global 246_ItemNums := ["70000005L", "70000033L", "70000043L", ""]
Global 247_ItemNums := ["", ""]

;;;Paths and Links
;GUI images
Global checkImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\check.png"
Global timeImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\time.png"
Global arrowImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\arrow.png"

FormatTime, TimeString, %A_Now%, yyyy-MM-dd hh:mm
Global localTime := TimeString

;Application Directories
Global TeraTerm := "C:\teraterm\ttermpro.exe"
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

;;;Menu bar
Menu FileMenu, Add, Quit, quitHandler
Menu MenuBar, Add, &File, :FileMenu
Menu EditMenu, Add, Change File Location, changeFileHandler
Menu MenuBar, Add, &Edit, :EditMenu
Menu HelpMenu, Add, Keyboard Shortcuts, keyShcutHandler
Menu HelpMenu, Add, About, aboutHandler
Menu MenuBar, Add, &Help, :HelpMenu
Gui Menu, MenuBar

Gui Add, Text, x17 y5 w136 h21 +0x200 vtopLabel, Select Item Number

Gui Add, Tab3, x9 y27 w202 h65 vwhichTab gchangeTab +0x8, 240L|246L|247L
Gui Tab, 1
For each, item in 240_ItemNums
    itmNum1 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x22 y59 w176 vitemNum1 Choose1, %itmNum1%
Gui Tab, 2
For each, item in 246_ItemNums
    itmNum2 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x22 y59 w176 vitemNum2 Choose1, %itmNum2%
Gui Tab, 3
For each, item in 247_ItemNums
    itmNum3 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x22 y59 w176 vitemNum3 Choose1, %itmNum3%
Gui Tab

Gui Add, CheckBox, x10 y101 w200 h23 +Checked vcheck gcheckBox, % "Included Configuration Step"

Gui Add, GroupBox, x9 y132 w202 h246 vprocessGbox, Processes
Gui Font,, Consolas
Gui Add, Text, x64 y148 w136 h21 +0x200 vloadConfig, Load Configuration
Gui Add, Text, x64 y170 w136 h21 +0x200 vrebootAfterConfig, Rebooted After Config
Gui Add, Text, x64 y192 w136 h21 +0x200 vrecheckConfig, Recheck Configuration
Gui Add, Text, x17 y215 w189 h2 +0x10 ;The line in between
Gui Add, Text, x64 y219 w136 h21 +0x200, Check Ethernet Port
Gui Add, Text, x64 y241 w136 h21 +0x200, Check LED
Gui Add, Text, x64 y263 w136 h21 +0x200, Check Temperature
Gui Add, Text, x64 y285 w136 h21 +0x200, Check Thumb Drive/SD
Gui Add, Text, x64 y307 w136 h21 +0x200, Check LORA/MTAC
Gui Add, Text, x64 y329 w136 h21 +0x200 vcheckSimCell, Check SIM/Cellular
Gui Add, Text, x64 y351 w136 h21 +0x200 vcheckOthSMC, Check Others/SMC
Gui Add, Text, x64 y372 w136 h21 +0x200 +Hidden vcheckGps, Check GPS
Gui Add, Text, x64 y393 w136 h21 +0x200 +Hidden vcheckWifi, Check WiFi/Bluetooth

Gui Font, c0x00FF00, Ms Shell Dlg 2

Gui Add, Picture, x30 y148 w21 h21 +BackgroundTrans vprocess1
Gui Add, Picture, x30 y170 w21 h21 +BackgroundTrans vprocess2
Gui Add, Picture, x30 y192 w21 h21 +BackgroundTrans vprocess3
;------------------------------------------
Gui Add, Picture, x30 y219 w21 h21 +BackgroundTrans vprocess4
Gui Add, Picture, x30 y241 w21 h21 +BackgroundTrans vprocess5
Gui Add, Picture, x30 y263 w21 h21 +BackgroundTrans vprocess6
Gui Add, Picture, x30 y285 w21 h21 +BackgroundTrans vprocess7
Gui Add, Picture, x30 y307 w21 h21 +BackgroundTrans vprocess8
Gui Add, Picture, x30 y329 w21 h21 +BackgroundTrans vprocess9
Gui Add, Picture, x30 y351 w21 h21 +BackgroundTrans vprocess10
Gui Add, Picture, x30 y373 w21 h21 +BackgroundTrans vprocess11
Gui Add, Picture, x30 y395 w21 h21 +BackgroundTrans vprocess12

Gui Add, Button, x70 y388 w80 h23 vstartBttn gmainStart, &START

Gui Show, x1269 y324 w220 h420, All MTCDT Auto-Tester
Return

;;;;;;;;;All menu handlers
quitHandler:
ExitApp
Return

changeFileHandler:
MsgBox 0, Message, This feature will be added in the future release!
Return

keyShcutHandler:
MsgBox 0, Keyboard Shortcuts, Ctrl + R to RUN`nCtrl + Q to Exit App`nCtrl + I  to Toggle Check Box
Return
aboutHandler:
MsgBox 0, Message, Created and Tested by Viet Ho
Return

GuiEscape:
GuiClose:
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q:: ExitApp
^t:: 
^r:: mainStart()
^i:: checkBoxToggle()
;;;;;;;;;;;;;;;;;;;;;;;;

mainStart() {
    GuiControlGet, itemNum1 ;Get value from DropDownList
    GuiControlGet, itemNum2 ;Get value from DropDownList
    GuiControlGet, itemNum3 ;Get value from DropDownList
    GuiControlGet, check ;Get value from CheckBox
    GuiControlGet, whichTab ;Get value from Tab Title
    
    Global itemNum
    Global mtcdtType := whichTab
    
    clearAllProcessImgs()
    
    If (whichTab = "240L")
        itemNum := itemNum1
    If (whichTab = "246L")
        itemNum := itemNum2
    If (whichTab = "247L")
        itemNum := itemNum3
    
    Global radioType := getRadioType(itemNum)
    
    if (radioType = "NONE") {
        GuiControl Disable, checkSimCell
        GuiControl Disable, checkOthSMC
    } else {
        GuiControl Enable, checkSimCell
        GuiControl Enable, checkOthSMC
    }
    
    if (check = 0) {
        MsgBox, 33, Question, Begin ONLY Auto-Functional Test for %itemNum%?
        IfMsgBox Cancel
            return
        IfMsgBox OK
        {
            If (functionalTestStep(itemNum, mtcdtType, radioType) = 0) {
                disableGuis("Enable")
                return
            }     
        }
    } 
    Else {
        If !WinExist("COM.*") {
            MsgBox, 8240, Alert, Please connect to PORT first!`nAnd make sure the device is booted. ;Uses 48 + 8192
            return
        }
        MsgBox, 33, Question, Begin Auto-Full Test for %itemNum%?
        IfMsgBox Cancel
            return
        IfMsgBox OK
        {
            If (configStep(whichTab, itemNum, mtcdtType, radioType) = 0) {
                disableGuis("Enable")
                return
            }
                
            If (functionalTestStep(itemNum, mtcdtType, radioType) = 0) {
                disableGuis("Enable")
                return
            }
        }
    }
    
    WinWait TEST DONE.*
    Sleep 1000
    ControlClick, Button1, TEST DONE.*, , Left, 2
    
    if WinExist("COM.*") {
        WinActivate COM.*
        Send !i
    }
    
    OnMessage(0x44, "CheckIcon") ;Add icon
    MsgBox 0x80, DONE, FINISHED Auto-Testing for %itemNum%!
    OnMessage(0x44, "") ;Clear icon
    disableGuis("Enable")
}

configStep(mtcdtType, itemN, mtcType, radType) {
    disableGuis("Disable")
    
    WinActivate COM.*
    GuiControl , , process1, %arrowImg%
    SendInput !om
    WinWait MACRO.*
    ControlSetText, Edit1, C:\V-Projects\AMAuto-Tester\TTL-Files\all_config.ttl, MACRO.*
    ControlSend, Edit1, {Enter}, MACRO.*
    ControlClick Button1, MACRO.*, , Left, 3 ;Additional if Enter not working
    
    WinWait MTCDT TYPE.*
    ControlSetText, Edit1, %mtcdtType%, MTCDT TYPE.*
    ControlSend, Edit1, {Enter}, MTCDT TYPE.*
    ControlClick Button1, MTCDT TYPE.*, , Left, 2
    
    WinWait RADIO TYPE.*
    ControlSetText, Edit1, %radType%, RADIO TYPE.*
    ControlSend, Edit1, {Enter}, RADIO TYPE.*
    ControlClick Button1, RADIO TYPE.*, , Left, 2
    WinWait DONE CONFIGURATION.*
    Sleep 1000
    ControlClick Button1, DONE CONFIGURATION.*, , Left, 2
    GuiControl , , process1, %checkImg%
    
    ;Recheck Config
    GuiControl , , process2, %arrowImg%
    Sleep 20000
    If (searchForFirmwareVersion(40, 2000) = 0) {
        GuiControl , , process2, %timeImg%
        MsgBox Could not Reboot device!
        return 0
    }
    GuiControl , , process2, %checkImg%
    
    ;Recheck config
    GuiControl , , process3, %arrowImg%
    WinActivate COM.*
    Loop 50
        Click WheelUp
    WinActivate COM.*
    Sleep 300
    if (searchForFFs() = 1) {
        Loop 50
        Click WheelDown
        GuiControl , , process3, %timeImg%
        MsgBox Failed to load configuration file!
        return 0
    }
    Loop 50
        Click WheelDown
    GuiControl , , process3, %checkImg%
}

functionalTestStep(itemN, mtcType, radType) {
    disableGuis("Disable")
    
    ;Connect to E-Net
    GuiControl , , process4, %arrowImg%
    Run, %ComSpec% /c cd C:\teraterm && TTPMACRO C:\V-Projects\AMAuto-Tester\TTL-Files\all_test.ttl %mtcType% %radType%, ,Hide
    WinWait SSH.*, , 4
    If !WinExist("SSH.*") {
        GuiControl , , process4, %timeImg%
        MsgBox Failed to connect to E-Net
        return 0
    }
    If WinExist(".*Error.*") {
        WinActivate .*Error.*
        Send {Enter}
    }
    ;WinWaitClose SSH.*
    WinWaitClose SSH.*
    GuiControl , , process4, %checkImg%
    GuiControl , , process5, %arrowImg%
    
    ;Check LED
    If (searchLed1111() = 0) {
        GuiControl , , process5, %timeImg%
        MsgBox LED TEST FAILED
        return 0
    }
    WinWaitClose CHECK LED
    GuiControl , , process5, %checkImg%
    
    ;Check Temparature
    GuiControl , , process6, %arrowImg%
    WinWait temp, , 5
    GuiControl , , process6, %checkImg%
    
    ;Check Thumb Drive
    GuiControl , , process7, %arrowImg%
    WinWait PASSED.*|THUMB DRIVE FAILURE.*|SD CARD FAILURE.*
    if WinExist("PASSED.*") {
        GuiControl , , process7, %checkImg%
    } else {
        GuiControl , , process7, %timeImg%
        return 0
    }
    
    ;Check Lora
    GuiControl , , process8, %arrowImg%
    WinWait LORA.*|PASSED1
    if WinExist("LORA.*") {
        GuiControl , , process8, %timeImg%
        return 0
    }
    WinWait PASSED2
    WinWaitClose PASSED2
    GuiControl , , process8, %checkImg%
    
    if (radType != "NONE") {
        ;Check Sim
        GuiControl , , process9, %arrowImg%
        WinWait SIM FAILURE.*|PASSED.*
        if WinExist("SIM FAILURE.*") {
            GuiControl , , process9, %timeImg%
            return 0
        }
        WinWaitClose PASSED.*
        GuiControl , , process9, %checkImg%
    
        ;Other checks/ SMC
        GuiControl , , process10, %arrowImg%
        WinWait RSSI.*
        WinWait Signal.*
        GuiControl , , process10, %checkImg%
    }
    
    ;Check GPS
    GuiControl , , process11, %arrowImg%
    WinWait GPS TEST FAILURE.*|PASSED.*
    if WinExist("GPS TEST FAILURE.*") {
        GuiControl , , process11, %timeImg%
        return 0
    }
    GuiControl , , process11, %checkImg%
    
    ;Check Wifi/BT
    
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
checkBox() {
    GuiControlGet, check ;Get value from CheckBox
    clearAllProcessImgs()
    
    If (check = 0) {
        GuiControl Disable, loadConfig
        GuiControl Disable, rebootAfterConfig
        GuiControl Disable, recheckConfig
    }
    Else {
        GuiControl Enable, loadConfig
        GuiControl Enable, rebootAfterConfig
        GuiControl Enable, recheckConfig
    }
}

checkBoxToggle() {
    GuiControlGet, check ;Get value from CheckBox
    If (check = 0) {
        GuiControl , , check, 1
        checkBox()
    } Else {
        GuiControl , , check, 0
        checkBox()
    }
}

changeTab() {
    GuiControlGet, whichTab ;Get value from Tab Title
    clearAllProcessImgs()
    
    If (whichTab = "246L") {
        Gui Show, w220 h441, All MTCDT Auto-Tester
        GuiControl Move, processGbox, h267
        GuiControl Move, startBttn, y409
        GuiControl Show, checkGps
        GuiControl Hide, checkWifi
    }
    Else If (whichTab = "247L") {
        Gui Show, w220 h462, All MTCDT Auto-Tester
        GuiControl Move, processGbox, h288
        GuiControl Move, startBttn, y430
        GuiControl Show, checkGps
        GuiControl Show, checkWifi
    }
   Else {
        Gui Show, w220 h420, All MTCDT Auto-Tester
        GuiControl Move, processGbox, h246
        GuiControl Move, startBttn, y388
        GuiControl Hide, checkGps
        GuiControl Hide, checkWifi
   }
}

clearAllProcessImgs() {
    index := 1
    While index < 20
    {
        GuiControl , , process%index%, ""
        index += 1
    }
    
    GuiControl Enable, checkSimCell
    GuiControl Enable, checkOthSMC
}

disableGuis(option) {
    GuiControl %option%, topLabel
    GuiControl %option%, whichTab
    GuiControl %option%, check
    GuiControl %option%, startBttn
}

getRadioType(itemN) {
    NONE := ["70000005L"]
    LAT1 := ["70000041L"]
    LAT3 := [""]
    LEU1 := ["70000033L", ""]
    L4E1 := ["70000043L", ""]
    LAP3 := ["70000045L"]
    L4N1 := ["70000049L"]
    
   allRadioType := "NONE,LAT1,LAT3,LEU1,L4E1,LAP3,L4N1"
    
    getRadioLoop:
    Loop Parse, allRadioType, `,
    {
        For key, value in %A_LoopField%
        If (value = itemN) 
            return %A_LoopField%
        Continue getRadioLoop
    }
}

;;;;;;Search Images Functions;;;;;;
searchForFFs(){
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\ffs.bmp
        If ErrorLevel
            return 0 ;Return false if NOT found
        If ErrorLevel = 0
            return 1 ;Return true if FOUND
}

searchForFirmwareVersion(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate COM.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\mli419.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep, %sleepTime%
    }
    If ErrorLevel
            return 0 ;Return false if NOT found
}

searchLed1111() {
    Loop, 3
    {
        WinActivate 192.168.2.1.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\1111.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep, 2000
    }
    If ErrorLevel
        return 0 ;Return false if NOT found
}

searchAtCpin() {
    Loop, 10
    {
        WinActivate 192.168.2.1.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\at-cpin.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep, 2000
    }
    If ErrorLevel
        return 0 ;Return false if NOT found
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