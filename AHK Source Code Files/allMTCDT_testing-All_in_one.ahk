 /*
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
IfNotExist C:\DEVICE_TEST_RECORDS
    FileCreateDir C:\DEVICE_TEST_RECORDS

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

Global 240_ItemNums := ["70000037L", "70000041L", "70000049L"]
Global 246_ItemNums := ["70000005L", "70000006L", "70000007L", "70000009L", "70000026L", "70000043L", "70000054L"]
Global 247_ItemNums := ["70000044L", "70000053L", "70001174L"]

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

Gui Add, Button, x155 y5 w55 h20 vhistoryBttn gshowTestHist, HISTORY

Gui Add, Text, x17 y5 w100 h21 +0x200 vtopLabel, Select Item Number

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
Gui Add, Text, x64 y351 w136 h21 +0x200 vcheckOthSMC, Check SMC/Others
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

Gui Add, Button, x70 y388 w80 h23 vstartBttn gmainStart, S&TART

posX := A_ScreenWidth - 320
Gui Show, w220 h420 x%posX% y100, All MTCDT Auto-Tester
Return

;;;;;;;;;All menu handlers
quitHandler:
ExitApp
Return

changeFileHandler:
MsgBox 0, Message, This feature will be added in the future release!
Return

keyShcutHandler:
MsgBox 0, Keyboard Shortcuts, Ctrl + T to RUN`nCtrl + Q to Exit App`nCtrl + I  to Toggle Check Box
Return
aboutHandler:
MsgBox 0, Message, Created and Tested by Viet Ho
Return

GuiClose:
    ExitApp
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q:: ExitApp 
^t:: mainStart()
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
        OnMessage(0x44, "PlayInCircleIcon")
        MsgBox 0x81, Question, Begin ONLY Auto-Functional Test for %itemNum%?
        OnMessage(0x44, "")
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
        If !WinExist("^COM.*") {
            MsgBox, 8240, Alert, Please connect to PORT first!`nAnd make sure the device is booted. ;Uses 48 + 8192
            return
        }
        OnMessage(0x44, "PlayInCircleIcon")
        MsgBox 0x81, Question, Begin Auto-Full Test for %itemNum%?
        OnMessage(0x44, "")
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
    
    if WinExist("^COM") {
        WinActivate ^COM
        Send !i
    }
    
    OnMessage(0x44, "CheckIcon") ;Add icon
    MsgBox 0x80, DONE, FINISHED Auto-Testing for %itemNum%!
    OnMessage(0x44, "") ;Clear icon
    disableGuis("Enable")
}

configStep(mtcdtType, itemN, mtcType, radType) {
    disableGuis("Disable")
    
    if WinExist("MACRO") {
        WinKill MACRO
    }
    
    ;Check if device rebooted
    WinActivate ^COM
    SendInput !es
    WinActivate ^COM
    SendInput ^c
    If (searchForFirmwareVersion(2, 500) = 0) {
        MsgBox 48, Not Ready or Wrong Port, MTCDT is not ready!`nPlease check PORT or reboot device first!
        return 0
    }
    
    ;Begin Test
    WinActivate ^COM
    GuiControl , , process1, %arrowImg%
    SendInput !om
    WinWait MACRO.*
    ControlSetText, Edit1, C:\V-Projects\AMAuto-Tester\TTL-Files\all_config.ttl, MACRO.*
    ControlSend, Edit1, {Enter}, MACRO.*
    ControlClick Button1, MACRO.*, , Left, 3 ;Additional if Enter not working
    
    WinWait ALL DATAS
    ControlSetText, Edit1, %mtcdtType%`,%radType%, ALL DATAS
    ControlSend, Edit1, {Enter}, ALL DATAS
    ControlClick Button1, ALL DATAS, , Left, 2
    
    WinWait FINISHED CONFIGURATION
    Sleep 700
    ControlClick Button1, FINISHED CONFIGURATION, , Left, 2
    GuiControl , , process1, %checkImg%
    
    ;Recheck Config
    GuiControl , , process2, %arrowImg%
    Sleep 30000
    If (searchForFirmwareVersion(40, 2000) = 0) {
        GuiControl , , process2, %timeImg%
        MsgBox Could not Reboot device!
        return 0
    }
    GuiControl , , process2, %checkImg%
    
    ;Recheck config
    GuiControl , , process3, %arrowImg%
    WinActivate ^COM
    Loop 50
        Click WheelUp
    WinActivate ^COM
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
    
    if WinExist("MACRO") {
        WinKill MACRO
    }
    if WinExist("192.168.*") {
        WinKill 192.168.*
    }
    
    if WinExist("wifimacinfo") {
        WinKill wifimacinfo
    }
    
    ;Connect to E-Net
    GuiControl , , process4, %arrowImg%
    Run, %ComSpec% /c cd C:\teraterm && TTPMACRO C:\V-Projects\AMAuto-Tester\TTL-Files\all_test.ttl %mtcType% %radType% %itemN%, ,Hide
    WinWait SSH.*, , 4
    If !WinExist("SSH.*") {
        GuiControl , , process4, %timeImg%
        MsgBox 16, E-Net Connection Failed, Failed to connect to E-Net!`nReboot Device!
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
        WinKill MACRO
        MsgBox LED TEST FAILED
        return 0
    }
    WinWaitClose CHECK LED
    GuiControl , , process5, %checkImg%
    
    ;Check Temparature
    GuiControl , , process6, %arrowImg%
    WinWait temp
    WinWait FAILURE, , 7
    if WinExist("FAILURE") {
        GuiControl , , process6, %timeImg%
        return 0
    }
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
    WinWait .*FAILURE|PASSED1
    if WinExist(".*FAILURE") {
        GuiControl , , process8, %timeImg%
        return 0
    }
    WinWaitClose PASSED1
    WinWait .*FAILURE|PASSED2
    if WinExist(".*FAILURE") {
        GuiControl , , process8, %timeImg%
        return 0
    }
    WinWaitClose PASSED2
    GuiControl , , process8, %checkImg%
    
    ;SMC check
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
        ;WinWait RSSI.*
        ;WinWait Signal.*
        WinWait .*FAILURE|PASSED
        if WinExist(".*FAILURE") {
            GuiControl , , process10, %timeImg%
            return 0
        }
        GuiControl , , process10, %checkImg%
    }
    
    ;Check GPS
    if (mtcType != "240L") {
        GuiControl , , process11, %arrowImg%
        Sleep 600
        WinWait GPS TEST FAILURE.*|PASSED.*
        if WinExist("GPS TEST FAILURE.*") {
            GuiControl , , process11, %timeImg%
            return 0
        }
        GuiControl , , process11, %checkImg%
    }
    
    ;Check Wifi/BT
    if (mtcType = "247L") {
        GuiControl , , process12, %arrowImg%
        Sleep 1000
        WinWait FAILURE|PASSED2
        if WinExist("FAILURE") {
            GuiControl , , process12, %timeImg%
            return 0
        }
        GuiControl , , process12, %checkImg%
        
        WinWait VERIFICATION
        Sleep 1000
        ControlClick, Button1, VERIFICATION.*, , Left, 2
        WinWait Notepad
    }
    
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;Additional GUIs;;;;;;;;;;;;;;;;;;
showTestHist() {
    Global
    FormatTime, localToday,, yyyy/MM/dd
    itemList := {}
    totalToday := 0
    
    Gui, 2: Default
    Gui -MinimizeBox -MaximizeBox
    Gui, 2: Add, Text, x8 y11, Search:
    Gui, 2: Add, Edit, x50 y8 w250 vsearchTerm gSearch
    Gui, 2: Add, Listview, x8 w640 h500 vlistView gMoreDetail +Grid -Multi, Date|Time|Item Number|Product ID|Temp|IMEI|Radio Version|Module Version|Firmware Build|Wifi Address|Bluetooth Address
    Gui, 2: Add, StatusBar
    SB_SetParts(200, 200)
    Loop Read, C:\DEVICE_TEST_RECORDS\all-mtcdt-test-records.txt
    {
        If A_LoopReadLine =     ;Skip the blank lines
            Continue
        StringReplace, itemLine, A_LoopReadLine, `,`,, `,, All  ;Replace 2 commas to 1
        StringReplace, itemLine, itemLine, %localToday%, Today, All ;Replace today format to "Today"
        foundToday := InStr(itemLine, "Today")
        if (foundToday > 0)
            totalToday++
        StringSplit, item, itemLine, `,
        LV_Add("",item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11)
        itemList.Push({1:item1, 2:item2, 3:item3, 4:item4, 5:item5, 6:item6, 7:item7, 8:item8, 9:item9, 10:item10, 11:item11})
    }
    totalLine := LV_GetCount()
    LV_ModifyCol()
    LV_ModifyCol(2, "SortDesc")
    LV_ModifyCol(1, "SortDesc")
    
    SB_SetText("Total Today Passed-Tests: " totalToday, 1)
    SB_SetText("Total Passed-Tests: " totalLine, 2)
    Gui, 2: Show, , ALL MTCDT PASSED-TEST RECORDS (LOCAL COMPUTER)
    Return
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Search:
    GuiControlGet, searchTerm
    GuiControl, -Redraw, listView
    LV_Delete()
    For each, item in itemList
    {
        If (searchTerm != "") {
            If (Instr(item.1, searchTerm) > 0 || Instr(item.2, searchTerm) > 0 || Instr(item.3, searchTerm) > 0 || Instr(item.4, searchTerm) > 0 || Instr(item.5, searchTerm) > 0 || Instr(item.6, searchTerm) > 0 || Instr(item.7, searchTerm) > 0 || Instr(item.8, searchTerm) > 0 || Instr(item.9, searchTerm) > 0 || Instr(item.10, searchTerm) > 0 || Instr(item.11, searchTerm) > 0) {
                LV_Add("", item.1, item.2, item.3, item.4, item.5, item.6, item.7, item.8, item.9, item.10, item.11)
            }
        } Else {
            LV_Add("", item.1, item.2, item.3, item.4, item.5, item.6, item.7, item.8, item.9, item.10, item.11)
        }
    }
    totalFound := LV_GetCount()
    SB_SetText("Total Found: " totalFound " of " totalLine, 3)
    GuiControl, +Redraw, listView
    LV_ModifyCol()
    LV_ModifyCol(2, "SortDesc")
    LV_ModifyCol(1, "SortDesc")
    Return ;Search label returned
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MoreDetail:
    rowNum := LV_GetNext("C")
    
    LV_GetText(c1, rowNum, 1)
    LV_GetText(c2, rowNum, 2)
    LV_GetText(c3, rowNum, 3)
    LV_GetText(c4, rowNum, 4)
    LV_GetText(c5, rowNum, 5)
    LV_GetText(c6, rowNum, 6)
    LV_GetText(c7, rowNum, 7)
    LV_GetText(c8, rowNum, 8)
    LV_GetText(c9, rowNum, 9)
    LV_GetText(c10, rowNum, 10)
    LV_GetText(c11, rowNum, 11)
    
    If (rowNum != 0) {
        MsgBox 4160, More Details, 
        (LTrim
            Test Date:`t`t%c1%
            Test Time:`t`t%c2%
            Item Number:`t%c3%
            Product ID:`t%c4%
            Tested Temperature:`t%c5% (mCelsius)
            IMEI Number:`t%c6%
            SMC Radio Vers:`t%c7%
            Telit Module Vers:`t%c8%
            Firmware Build:`t%c9%
            Wifi Address:`t%c10%
            Bluetooth Address:`t%c11%
        )
    }
    Return ;MoreDetail label returned
    
    2GuiEscape:
    2GuiClose:
        Gui, 2: Cancel
        Gui, 2: Destroy
    Return
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
    NONE := ["70000005L", "70001174L"]
    H5 := ["70000006L"]
    LAT1 := ["70000037L", "70000007L"]
    LAT3 := ["70000041L"]
    LEU1 := ["70000033L", ""]
    L4E1 := ["70000043L", "70000044L"]
    LAP3 := ["70000045L"]
    L4N1 := ["70000049L", "70000054L", "70000053L"]
    LVW2 := ["70000009L"]
    LSB3 := ["70000026L"]
    
   allRadioType := "NONE,H5,LAT1,LAT3,LEU1,L4E1,LAP3,L4N1,LVW2,LSB3"
    
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
        WinActivate ^COM
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
