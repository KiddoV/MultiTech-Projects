/*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx

;;;;Installs files for app to run
IfNotExist C:\V-Projects\AMAuto-Tester\Imgs-for-GUI
    FileCreateDir C:\V-Projects\AMAuto-Tester\Imgs-for-GUI

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\check.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\time.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\time.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\arrow.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\arrow.png, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

Global 240_ItemNums := ["70000041L", ""]
Global 246_ItemNums := ["70000007L","70000054L", ""]
Global 247_ItemNums := ["70000053L", ""]

;;;Paths and Links
;240L
Global 70000041LConfigPath := "C:\MTCDT_REFRESH\240L\70000041L\70000041L-MLINUX-REFRESH-test-config.ttl"
Global 70000041LTestPath := "C:\MTCDT_REFRESH\240L\70000041L\70000041L-MLINUX-LAT3-tst_002.ttl"
;246L
Global 70000054LConfigPath := "C:\MTCDT_REFRESH\246L\70000054L\70000054L-MLINUX_4_1_9_eeprom_test_config.ttl"
Global 70000054LTestPath := "C:\MTCDT_REFRESH\246L\70000054L\70000054L-MLINUX_4_1_9_Functional_Test.ttl"
Global 70000007LConfigPath := "C:\MTCDT_REFRESH\246L\70000007L\70000007L_eeprom_test_config.TTL"
Global 70000007LTestPath := "C:\MTCDT_REFRESH\246L\70000007L\70000007L-MLINUX_4_1_9_Functional_test.TTL"


;GUI images
Global checkImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\check.png"
Global timeImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\time.png"
Global arrowImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\arrow.png"

;Application Directories
Global TeraTerm := "C:\teraterm\ttermpro.exe"
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

Gui Add, Text, x17 y5 w136 h21 +0x200 , Select Item Number

Gui Add, Tab3, x9 y27 w202 h65 vwhichTab gchangeTab, 240L|246L|247L
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

Gui Add, CheckBox, x10 y101 w200 h23 +Checked vcheck gcheckBoxToggle, % "Included Configuration Step"

Gui Add, GroupBox, x9 y132 w202 h230, Processes
Gui Font,, Consolas
Gui Add, Text, x64 y148 w136 h21 +0x200 vloadConfig, Load Configuration
Gui Font,, Consolas
Gui Add, Text, x64 y170 w136 h21 +0x200 vrebootAfterConfig, Rebooted After Config
Gui Font,, Consolas
Gui Add, Text, x64 y192 w136 h21 +0x200 vrecheckConfig, Recheck Configuration
Gui Add, Text, x17 y215 w189 h2 +0x10 ;The line in between
Gui Font,, Consolas
Gui Add, Text, x64 y219 w136 h21 +0x200, Check Ethernet Port
Gui Font,, Consolas
Gui Add, Text, x64 y241 w136 h21 +0x200, Check LED
Gui Font,, Consolas
Gui Add, Text, x64 y263 w136 h21 +0x200, Check Temperature
Gui Font,, Consolas
Gui Add, Text, x64 y285 w136 h21 +0x200, Check SIM/ Cellular
Gui Font,, Consolas
Gui Add, Text, x64 y307 w136 h21 +0x200 +Disabled vcheckGps, Check GPS
Gui Font,, Consolas
Gui Add, Text, x64 y329 w136 h21 +0x200 +Disabled vcheckWifi, Check WiFi/ Bluetooth

Gui Font, c0x00FF00, Ms Shell Dlg 2

Gui Add, Picture, x30 y148 w21 h21 vprocess1 ;GuiControl , , process1, %arrowImg%
Gui Add, Picture, x30 y170 w21 h21 vprocess2
Gui Add, Picture, x30 y192 w21 h21 vprocess3
;------------------------------------------
Gui Add, Picture, x30 y219 w21 h21 vprocess4
Gui Add, Picture, x30 y241 w21 h21 vprocess5
Gui Add, Picture, x30 y263 w21 h21 vprocess6
Gui Add, Picture, x30 y285 w21 h21 vprocess7
Gui Add, Picture, x30 y307 w21 h21 vprocess8
Gui Add, Picture, x30 y329 w21 h21 vprocess9

Gui Add, Button, x70 y372 w80 h23 gmainStart, &START

Gui Show, x1269 y324 w220 h404, All MTCDT Auto-Tester
Return

GuiEscape:
GuiClose:
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mainStart() {
    GuiControlGet, itemNum1 ;Get value from DropDownList
    GuiControlGet, itemNum2 ;Get value from DropDownList
    GuiControlGet, itemNum3 ;Get value from DropDownList
    GuiControlGet, check ;Get value from CheckBox
    GuiControlGet, whichTab ;Get value from Tab Title
    
    Global itemNum
    
    clearAllProcessImgs()
    
    If !WinExist("COM.*") {
        MsgBox, 8240, Alert, Please connect to PORT first!`nAnd make sure the device is booted. ;Uses 48 + 8192
        return
    }
    
    If (whichTab = "240L")
        itemNum := itemNum1
    If (whichTab = "246L")
        itemNum := itemNum2
    If (whichTab = "247L")
        itemNum := itemNum3
    
    if (check = 0) {
        MsgBox, 33, Question, Begin ONLY Auto-Functional Test for %itemNum%?
        IfMsgBox Cancel
            return
        IfMsgBox OK
        functionalTestStep(itemNum)
    } 
    Else {
        MsgBox, 33, Question, Begin Auto-Full Test for %itemNum%?
        IfMsgBox Cancel
            return
        IfMsgBox OK
        configStep(itemNum)
        functionalTestStep(itemNum)
    }

}

configStep(itemN) {
    Global configPath := %itemN%ConfigPath
    
    IfNotExist %configPath%
    {
        MsgBox 16, FILE NOT FOUND, File NOT FOUND in this location: `n%configPath%`nMake sure you have the CONFIG file, and put it in the exact location above!
        return
    }
    
    WinActivate COM.*
    WinWaitActive COM.*
    Send !om
    GuiControl , , process1, %arrowImg%
    WinWait MACRO.*
    WinActivate MACRO.*
    Send %configPath% {Enter}
    WinWait PORT STATUS|DEBUG PORT
    ;WinActivate COM.*
    ;Sleep 300
    ;If (searchForZeros() = 0) {
        ;GuiControl , , process1, %timeImg%
        ;MsgBox Failed to load config file!
        ;return
    ;}
    GuiControl , , process1, %checkImg%
    WinActivate PORT STATUS|DEBUG PORT
    Send {Enter}
    GuiControl , , process2, %arrowImg%
    Sleep 20000
    If (searchForFirmwareVersion() = 0) {
        GuiControl , , process2, %timeImg%
        MsgBox Could not Reboot device!
        return
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
        return
    }
    Loop 50
        Click WheelDown
    GuiControl , , process3, %checkImg%
}

functionalTestStep(itemN) {
    Global testPath := %itemN%TestPath
    
    GuiControl , , process4, %arrowImg%
    Run %TeraTerm%
    WinWait Tera Term: New.*
    WinActivate Tera Term: New.*
    Send {Esc}
    WinActivate .*disconnected.*
    Send !om
    WinWait MACRO.*
    Send %testPath% {Enter}
    WinWait SECURITY WARNING|SSH.*
    GuiControl , , process4, %checkImg%
    If WinExist(SECURITY WARNING) {
        WinActivate SECURITY WARNING
        Send {Tab} {Tab} {Tab} {Enter}
    }
    
    ;Check LED
    GuiControl , , process5, %arrowImg%
    WinWait Visual test
    WinActivate Visual test
    Send {Enter}
    
    If (searchLed1111() = 0) {
        GuiControl , , process5, %timeImg%
        MsgBox Failed LED test!
        return
    }
    GuiControl , , process5, %checkImg%
    
    ;WinWait LED, ,6 ;Wait for 6 secs
    GuiControl , , process6, %arrowImg%
    WinWait temp, ,6
    GuiControl , , process6, %checkImg%
    GuiControl , , process7, %arrowImg%
}

;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
checkBoxToggle() {
    GuiControlGet, check ;Get value from CheckBox
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

changeTab() {
    GuiControlGet, whichTab ;Get value from Tab Title
    
    If (whichTab = "246L") {
        GuiControl Enabled, checkGps
        GuiControl Disable, checkWifi
    }
    Else If (whichTab = "247L") {
        GuiControl Enabled, checkGps
        GuiControl Enabled, checkWifi
    }
   Else {
        GuiControl Disable, checkGps
        GuiControl Disable, checkWifi
   }
}

clearAllProcessImgs() {
    GuiControl , , process1, ""
    GuiControl , , process2, ""
    GuiControl , , process3, ""
    GuiControl , , process4, ""
    GuiControl , , process5, ""
    GuiControl , , process6, ""
    GuiControl , , process7, ""
    GuiControl , , process8, ""
    GuiControl , , process9, ""
}
;;;Search Images Functions
searchForZeros() {
    Loop, 2 ;Search the image 2 times
    {
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, %WorkingDir%\Imgs-for-Search-Func\zeros.bmp
        If ErrorLevel
        {
            return 0 ;Return false if not found
        }     
    }
}

searchForFFs(){
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, %WorkingDir%\Imgs-for-Search-Func\ffs.bmp
        If ErrorLevel
            return 0 ;Return false if NOT found
        If ErrorLevel = 0
            return 1 ;Return true if FOUND
}

searchForFirmwareVersion() {
    Loop, 25
    {
        WinActivate COM.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, %WorkingDir%\Imgs-for-Search-Func\mli419.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep, 3000
    }
    If ErrorLevel
            return 0 ;Return false if NOT found
}

searchLed1111() {
    Loop, 5
    {
        WinActivate 192.168.2.1.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, %WorkingDir%\Imgs-for-Search-Func\1111.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep, 2000
    }
    If ErrorLevel
            return 0 ;Return false if NOT found
}
