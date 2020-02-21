/*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx

;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\AMAuto-Tester\Imgs-for-GUI
    FileCreateDir C:\V-Projects\AMAuto-Tester\Imgs-for-GUI
IfNotExist C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func
    FileCreateDir C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\check.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\time.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\time.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\arrow.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\arrow.png, 1

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\ffs.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\ffs.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\mli419.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\mli419.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\1111.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\1111.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\at-cpin.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\at-cpin.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\cpin-ready.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\cpin-ready.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\cat-cant-open.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\cat-cant-open.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\test-complete.bmp, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\test-complete.bmp, 1
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

Gui Add, CheckBox, x10 y101 w200 h23 +Checked vcheck gcheckBoxToggle, % "Included Configuration Step"

Gui Add, GroupBox, x9 y132 w202 h225 vprocessGbox, Processes
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
Gui Add, Text, x64 y285 w136 h21 +0x200, Check LORA/MTAC
Gui Font,, Consolas
Gui Add, Text, x64 y307 w136 h21 +0x200, Check SIM/ Cellular
Gui Font,, Consolas
Gui Add, Text, x64 y329 w136 h21 +0x200, Check Others
Gui Font,, Consolas
Gui Add, Text, x64 y351 w136 h21 +0x200 +Hidden vcheckGps, Check GPS
Gui Font,, Consolas
Gui Add, Text, x64 y372 w136 h21 +0x200 +Hidden vcheckWifi, Check WiFi/ Bluetooth

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

Gui Add, Button, x70 y367 w80 h23 vstartBttn gmainStart, &START

Gui Show, x1269 y324 w220 h400, All MTCDT Auto-Tester
Return

;;;;;;;;;All menu handlers
quitHandler:
ExitApp
Return

changeFileHandler:
MsgBox 0, Message, This feature will be added in the future release!
Return

keyShcutHandler:
MsgBox 0, Keyboard Shortcuts, Ctrl + R to RUN`nCtrl + Q to Exit App
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
^r:: mainStart()
;;;;;;;;;;;;;;;;;;;;;;;;

mainStart() {
    GuiControlGet, itemNum1 ;Get value from DropDownList
    GuiControlGet, itemNum2 ;Get value from DropDownList
    GuiControlGet, itemNum3 ;Get value from DropDownList
    GuiControlGet, check ;Get value from CheckBox
    GuiControlGet, whichTab ;Get value from Tab Title
    
    Global itemNum
    
    clearAllProcessImgs()
    
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
        {
            If (functionalTestStep(itemNum) = 0) {
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
            If (configStep(itemNum) = 0) {
                disableGuis("Enable")
                return
            }
                
            If (functionalTestStep(itemNum) = 0) {
                disableGuis("Enable")
                return
            }
        }
    }
    WinWait PORT.*
    WinActivate PORT.*
    If (searchTestComplete() = 0) {
        MsgBox ALL TEST FAILED
        disableGuis("Enable")
        return
    }

    WinActivate PORT.*
    Send {Enter}
    GuiControl , , process9, %checkImg%
    
    WinActivate COM.*
    Send !i
    
    OnMessage(0x44, "CheckIcon") ;Add icon
    MsgBox 0x80, DONE, FINISHED Auto-Testing for %itemNum%!
    OnMessage(0x44, "") ;Clear icon
    disableGuis("Enable")
}

configStep(itemN) {
    disableGuis("Disable")
    Global configPath := %itemN%ConfigPath
    
    IfNotExist %configPath%
    {
        MsgBox 16, FILE NOT FOUND, File NOT FOUND in this location: `n%configPath%`nMake sure you have the CONFIG file, and put it in the exact location above!
        return = 0
    }
    
    WinActivate COM.*
    WinWaitActive COM.*
    Send !om
    GuiControl , , process1, %arrowImg%
    WinWait MACRO.*
    WinActivate MACRO.*
    SendInput %configPath% {Enter}
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

functionalTestStep(itemN) {
    disableGuis("Disable")
    Global testPath := %itemN%TestPath
    
    IfNotExist %testPath%
    {
        MsgBox 16, FILE NOT FOUND, File NOT FOUND in this location: `n%testPath%`nMake sure you have the TEST file, and put it in the exact location above!
        return = 0
    }
    
    GuiControl , , process4, %arrowImg%
    Run %TeraTerm%
    WinWait Tera Term: New.*
    WinActivate Tera Term: New.*
    Send {Esc}
    WinActivate .*disconnected.*
    Send !om
    WinWait MACRO.*
    WinActivate MACRO.*
    SendInput %testPath% {Enter}
    WinWait SECURITY.*|SSH.*
    WinWait SECURITY.*, , 3
    GuiControl , , process4, %checkImg%
    If WinExist("SECURITY.*") {
        WinActivate SECURITY.*
        Send {Tab} {Tab} {Tab} {Enter}
    }
    ;Check LED
    GuiControl , , process5, %arrowImg%
    WinWait Visual test
    WinActivate Visual test
    Send {Enter}
    
    If (searchLed1111() = 0) {
        GuiControl , , process5, %timeImg%
        WinWait LED TEST, , 6
        If WinExist("LED TEST") {
            WinActivate LED TEST
            Send {Right}{Enter}
        }
        return 0
    }
    GuiControl , , process5, %checkImg%
    GuiControl , , process6, %arrowImg%
    WinWait LED TEST, , 6
    If WinExist("LED TEST") {
        WinActivate LED TEST
        Send {Enter}
    }
    
    ;Check temparature
    ;GuiControl , , process6, %arrowImg%
    WinWait temp, ,6
    GuiControl , , process6, %checkImg%
    
    ;Check LORA/MTAC
    GuiControl , , process7, %arrowImg%
    If (searchCatCantOpen() = 1) {
        GuiControl , , process7, %timeImg%
        MsgBox LORA/MTAC failure!
        return 0
    }
    
    GuiControl , , process7, %checkImg%
    
    ;Check SIM/CELL
    GuiControl , , process8, %arrowImg%
    If (searchAtCpin() = 1) {
        If (searchCpinReady() = 1) {
            GuiControl , , process8, %checkImg%
        } Else {
            GuiControl , , process8, %timeImg%
            WinClose 192.168.*
            WinWaitActive Tera.*
            Send {Left} {Enter}
            WinWait PORT.*, , 1
            WinClose PORT.*
            WinWait MACRO.*, , 1
            If WinExist("MACRO.*")
                Send y
            MsgBox SIM/CELL Failue!
            return 0
        }
    } Else {
        GuiControl , , process8, %timeImg%
        MsgBox Can't find command for SIM TEST
        return 0
    }
    
    ;Other checks
    GuiControl , , process9, %arrowImg%
    WinWait RSSI.*
    WinWait Signal.*
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
checkBoxToggle() {
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

changeTab() {
    GuiControlGet, whichTab ;Get value from Tab Title
    clearAllProcessImgs()
    
    If (whichTab = "246L") {
        Gui Show, w220 h422, All MTCDT Auto-Tester
        GuiControl Move, processGbox, h247
        GuiControl Move, startBttn, y389
        GuiControl Show, checkGps
        GuiControl Hide, checkWifi
    }
    Else If (whichTab = "247L") {
        Gui Show, w220 h444, All MTCDT Auto-Tester
        GuiControl Move, processGbox, h269
        GuiControl Move, startBttn, y411
        GuiControl Show, checkGps
        GuiControl Show, checkWifi
    }
   Else {
        Gui Show, w220 h400, All MTCDT Auto-Tester
        GuiControl Move, processGbox, h225
        GuiControl Move, startBttn, y367
        GuiControl Hide, checkGps
        GuiControl Hide, checkWifi
   }
}

clearAllProcessImgs() {
    index := 1
    While index < 12
    {
        GuiControl , , process%index%, ""
        index += 1
        Sleep 5
    }
}

disableGuis(option) {
    GuiControl %option%, topLabel
    GuiControl %option%, whichTab
    GuiControl %option%, check
    GuiControl %option%, startBttn
}

;;;;Search Images Functions;;;;
searchForFFs(){
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\ffs.bmp
        If ErrorLevel
            return 0 ;Return false if NOT found
        If ErrorLevel = 0
            return 1 ;Return true if FOUND
}

searchForFirmwareVersion() {
    Loop, 40
    {
        WinActivate COM.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\mli419.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep, 2000
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

searchCpinReady() {
    WinActivate 192.168.2.1.*
    CoordMode, Pixel, Window
    ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\cpin-ready.bmp
    If ErrorLevel = 0
        return 1 ;Return true if found
    If ErrorLevel
        return 0 ;Return false if NOT found
}

searchCatCantOpen() {
    Loop, 6
    {
        WinActivate 192.168.2.1.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\cat-cant-open.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep, 2000
    }
    If ErrorLevel
        return 0 ;Return false if NOT found
}

searchTestComplete() {
    Loop, 2
    {
        WinActivate PORT.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\test-complete.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep 500
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
