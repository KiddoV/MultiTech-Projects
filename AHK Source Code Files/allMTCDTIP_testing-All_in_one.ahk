/*
    Author: Viet Ho
*/

#SingleInstance Force
#NoEnv
SetBatchLines -1
SetTitleMatchMode, RegEx

;===============================================;
;;;;;;;;;;INSTALL REQUIRE FILES
IfNotExist C:\V-Projects\AMIPAuto-Tester\TTL-Files
    FileCreateDir C:\V-Projects\AMIPAuto-Tester\TTL-Files
IfNotExist C:\V-Projects\AMIPAuto-Tester\imgs-for-gui
    FileCreateDir C:\V-Projects\AMIPAuto-Tester\imgs-for-gui
IfNotExist C:\DEVICE_TEST_RECORDS
    FileCreateDir C:\DEVICE_TEST_RECORDS

FileInstall C:\MultiTech-Projects\TTL-Files\all_mtcdtip_test.TTL, C:\V-Projects\AMIPAuto-Tester\TTL-Files\all_mtcdtip_test.ttl, 1

FileInstall C:\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\AMIPAuto-Tester\imgs-for-gui\check_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\AMIPAuto-Tester\imgs-for-gui\x_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\AMIPAuto-Tester\imgs-for-gui\play_orange.png, 1
;===============================================;
;;;;;;;;;;;;;VARIABLEs DEFINITION
Global 266_ItemNums := ["63120927L", "63120928L"]
Global 267_ItemNums := ["63120925L", "63120926L"]

Global SMC_Items := ["L4E1"]

Global MainTestFilePath := "C:\V-Projects\AMIPAuto-Tester\TTL-Files\all_mtcdtip_test.ttl"

Global checkImg := "C:\V-Projects\AMIPAuto-Tester\imgs-for-gui\check_mark.png"
Global xImg := "C:\V-Projects\AMIPAuto-Tester\imgs-for-gui\x_mark.png"
Global playImg := "C:\V-Projects\AMIPAuto-Tester\imgs-for-gui\play_orange.png" 
;===============================================;
;;;;;;;;;;;;;;;;;;;MAIN GUI
;;;Menu bar
Menu, FileMenu, Add, Quit, quitHandler
Menu, MenuBar, Add, &File, :FileMenu
Menu, ToolMenu, Add, Test History, getTestHistoryHandler
Menu, MenuBar, Add, &Tools, :ToolMenu
Menu, HelpMenu, Add, Keyboard Shortcuts, keyShcutHandler
Menu, HelpMenu, Add, About, aboutHandler
Menu, MenuBar, Add, &Help, :HelpMenu
Gui Menu, MenuBar

Gui, Add, Text, x10 y5, Select Item Number
Gui, Add, Tab3, x10 y25 w202 h60 vwhichTab gChangeTab, 266L|267L
Gui, Tab, 1
For each, item in 266_ItemNums
    itmNum1 .= (each == 1 ? "" : "|") . item
Gui, Add, DropDownList, x23 y54 w176 vitemNum1 Choose1, %itmNum1%
Gui, Tab, 2
For each, item in 267_ItemNums
    itmNum2 .= (each == 1 ? "" : "|") . item
Gui, Add, DropDownList, x23 y54 w176 vitemNum2 Choose1, %itmNum2%
Gui, Tab

Gui, Add, Checkbox, x10 y95 +Checked vconfigCheckBox gConfigChecked, Included Configuration Step
Gui, Add, Checkbox, x10 y115 vsmcCheckBox gSCMTestChecked, Included SMC Test
Gui, Add, GroupBox, x10 y125 w202 h45 Section,
For each, item in SMC_Items
    smcItem .= (each == 1 ? "" : "|") . item
Gui, Add, DropDownList, xs+14 ys+15 w176 +Disabled vsmcDrop, %smcItem%

Gui Add, Text, x40 y180 w150 h2 +0x10
Gui, Add, GroupBox, x10 y185 Section w202 h185, Processes
Gui Font, s9 Bold, Consolas
Gui, Add, Text, xs+40 ys+20 v1LoadConfig, Load Configuration
Gui, Add, Text, xs+40 ys+40 v2CheckLeds, Check LEDs
Gui, Add, Text, xs+40 ys+60 v3CheckTemp, Check Temperature
Gui, Add, Text, xs+40 ys+80 v4CheckSdCard, Check SD Card
Gui, Add, Text, xs+40 ys+100 v5CheckLorMta, Check LORA/MTAC
Gui, Add, Text, xs+40 ys+120 v6CheckSmc +Disabled, Check SMC/SIM Card
Gui, Add, Text, xs+40 ys+140 v7CheckGps, Check GPS
Gui, Add, Text, xs+40 ys+160 v8CheckWfBt +Disabled, Check WIFI/BLUETOOTH
Gui, Font

Gui Add, Picture, xs+10 ys+17 w20 h20 +BackgroundTrans vprocess1,
Gui Add, Picture, xs+10 ys+37 w20 h20 +BackgroundTrans vprocess2,
Gui Add, Picture, xs+10 ys+57 w20 h20 +BackgroundTrans vprocess3,
Gui Add, Picture, xs+10 ys+77 w20 h20 +BackgroundTrans vprocess4,
Gui Add, Picture, xs+10 ys+97 w20 h20 +BackgroundTrans vprocess5,
Gui Add, Picture, xs+10 ys+117 w20 h20 +BackgroundTrans vprocess6,
Gui Add, Picture, xs+10 ys+137 w20 h20 +BackgroundTrans vprocess7,
Gui Add, Picture, xs+10 ys+157 w20 h20 +BackgroundTrans vprocess8,

Gui Add, Button, x70 y375 w80 h23 gRunTest, S&TART

;;;;;;;
posX := A_ScreenWidth - 400
Gui, Show, x%posX% y100, All MTCDTIP Auto-Tester
Return

;;;;;;;;;All menu handlers
quitHandler:
    ExitApp
Return

keyShcutHandler:
    MsgBox 0, Keyboard Shortcuts, Ctrl + Q to Exit App
Return

getTestHistoryHandler:
    ShowTestHist()
Return

aboutHandler:
    MsgBox 0, Message, Created and Tested by Viet Ho
Return

GuiClose:
    ExitApp
;===============================================;
;;;;;;;;HOT KEYs;;;;;;;;
^q:: ExitApp

;===============================================;
;;;;;;;;;;;;;;;;;;;MAIN FUNTIONs
RunTest() {
    ;;;Get vars
    GuiControlGet, mType, , whichTab
    GuiControlGet, itemNum1
    GuiControlGet, itemNum2
    GuiControlGet, isRunConfig, , configCheckBox
    GuiControlGet, isRunSMCTest, , smcCheckBox
    GuiControlGet, smcDrop
    
    If (mType = "266L")
        itemNum := itemNum1
    If (mType = "267L")
        itemNum := itemNum2
    
    If (isRunSMCTest)
        radioType := smcDrop
    
    If (isRunSMCTest && radioType = "") {
        MsgBox, 48, INVALID, PLEASE PICK A RADIO TYPE!
        Return
    }
    
    ;;Start running
    OnMessage(0x44, "PlayInCircleIcon")
    If (isRunSMCTest)
        MsgBox 0x81, Functional Test, Begin Auto-Full Test for %itemNum% with Radio: %radioType%?
    Else
        MsgBox 0x81, Functional Test, Begin Auto-Full Test for %itemNum%?
    OnMessage(0x44, "")
    IfMsgBox Cancel
        return
    IfMsgBox OK
    {
        If (runFuncTest(mType, itemNum, isRunConfig, radioType) = 0) {
            return
        }
    }
    
    WinWait TEST FINISED
    OnMessage(0x44, "CheckIcon") ;Add icon
    MsgBox 0x80, DONE, FINISHED Auto-Testing for MTCDTIP - Item Number: %itemNum%!
    OnMessage(0x44, "") ;Clear icon
}

runFuncTest(mtcdtipType, itemNumber, isRunConfig, radioType) {
    WinKill, 192.168.2.1
    ControlClick, Button1, Tera Term, , Left, 1
    resetProcessStatus()
    Run, %ComSpec% /c cd C:\teraterm && TTPMACRO %MainTestFilePath% %mtcdtipType% %itemNumber% %isRunConfig% %radioType%, ,Hide
    
    WinWaitClose, SSH
    
    ;;;Config Step
    If (isRunConfig) {
        WinWait, CONFIGURATION CONDUIT
        changeProcessStatus("1LoadConfig", "PLAY")
        WinWait, CONFIGURATION FAILURE|CONFIGURATION FINISHED
        IfWinExist, CONFIGURATION FAILURE
        {
            changeProcessStatus("1LoadConfig", "FAIL")
            return 0
        }
        IfWinExist, CONFIGURATION FINISHED
            changeProcessStatus("1LoadConfig", "DONE")
    }
    
    ;;;Functional Step
    ;;Check LED
    WinWait, CHECK LED
    changeProcessStatus("2CheckLeds", "PLAY")
    WinWait, LED PASSED
    IfWinExist, LED PASSED
        changeProcessStatus("2CheckLeds", "DONE")
    
    ;;Check Temp
    WinWait, CHECK TEMP
    changeProcessStatus("3CheckTemp", "PLAY")
    WinWait, TEMPARETURE FAILURE|TEMPERATURE PASSED
    IfWinExist, TEMPARETURE FAILURE
    {
        changeProcessStatus("3CheckTemp", "FAIL")
        return 0
    }
    IfWinExist, TEMPERATURE PASSED
        changeProcessStatus("3CheckTemp", "DONE")
    
    ;;Check Drive
    WinWait, SD CARD CHECK
    changeProcessStatus("4CheckSdCard", "PLAY")
    WinWait, SD CARD FAILURE|SD CARD PASSED
    IfWinExist, SD CARD FAILURE
    {
        changeProcessStatus("4CheckSdCard", "FAIL")
        return 0
    }
    IfWinExist, SD CARD PASSED
        changeProcessStatus("4CheckSdCard", "DONE")
        
    ;;Check Lora/Mtac
    WinWait, LORA CHECK
    changeProcessStatus("5CheckLorMta", "PLAY")
    WinWait, LORA AP1 FAILURE|LORA AP2 FAILURE|LORA AP2 PASSED
    IfWinExist, LORA AP1 FAILURE|LORA AP2 FAILURE
    {
        changeProcessStatus("5CheckLorMta", "FAIL")
        return 0
    }
    IfWinExist, LORA AP2 PASSED
        changeProcessStatus("5CheckLorMta", "DONE")
    
    ;;Check SMC/SIM Card
    If (radioType != "") {
        WinWait, SIM CHECK|SMC CHECK
        changeProcessStatus("6CheckSmc", "PLAY")
        WinWait, FAILURE|SMC PASSED
        IfWinExist, FAILURE
        {
            changeProcessStatus("6CheckSmc", "FAIL")
            return 0
        }
        IfWinExist, SMC PASSED
        changeProcessStatus("6CheckSmc", "DONE")
    }
    
    ;;Check GPS
    If (mtcdtipType == "266L" || mtcdtipType == "267L") {
        WinWait, GPS CHECK
        changeProcessStatus("7CheckGps", "PLAY")
        WinWait, GPS FAILURE|GPS PASSED
        IfWinExist, GPS FAILURE
        {
            changeProcessStatus("7CheckGps", "FAIL")
            return 0
        }
        IfWinExist, GPS PASSED
            changeProcessStatus("7CheckGps", "DONE")
    }
    
    ;;Check WIFI/BT
    If (mtcdtipType == "267L") {
        WinWait, CHECK
        changeProcessStatus("8CheckWfBt", "PLAY")
        WinWait, FAILURE|BT PASSED
        IfWinExist, FAILURE
        {
            changeProcessStatus("8CheckWfBt", "FAIL")
            return 0
        }
        IfWinExist, BT PASSED
        changeProcessStatus("8CheckWfBt", "DONE")
    }
}

;===============================================;
;;;;;;;;;;;;;;;;;;;ADDITIONAL FUNTIONs
ChangeTab() {
    GuiControlGet, mType, , whichTab
    resetProcessStatus()
    
    If (mType = "266L") {
        GuiControl, Enable, 7CheckGps
        GuiControl, Disable, 8CheckWfBt
    } Else If (mType = "267L") {
        GuiControl, Enable, 7CheckGps
        GuiControl, Enable, 8CheckWfBt
    }
}

ConfigChecked() {
    GuiControlGet, isCheck, , configCheckBox
    If (isCheck) {
        GuiControl, Enable, 1LoadConfig    
    } Else {
        GuiControl, Disable, 1LoadConfig
    }
}

SCMTestChecked() {
    GuiControlGet, isCheck, , smcCheckBox
    If (isCheck) {
        GuiControl, Enable, smcDrop
        GuiControl, Enable, 6CheckSmc
        
    } Else {
        GuiControl, Disable, smcDrop
        GuiControl, Disable, 6CheckSmc
    }
}

changeProcessStatus(ctrlID = "", status := "") {
    Gui, 1: Default
    RegExMatch(ctrlID, "\d", num)    ;Get button number in variable
    
    if (status = "PLAY") {
        GuiControl, , process%num%, %playImg%
    } else if (status = "FAIL") {
        GuiControl, , process%num%, %xImg%
    } else if (status = "DONE") {
        GuiControl, , process%num%, %checkImg%
    } else {
        GuiControl, , process%num%,
    }
}

resetProcessStatus() {
    Gui, 1: Default
    index := 0
    Loop, 9
    {
        GuiControl, , process%index%,
        GuiControl, Move, process%index%, w18 h18
        index++
    }
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

;===============================================;
;;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs
ShowTestHist() {
    Global
    FormatTime, localToday,, yyyy/MM/dd
    itemList := {}
    totalToday := 0
    
    Gui, 2: Default
    Gui -MinimizeBox -MaximizeBox
    Gui, 2: Add, Text, x8 y11, Search:
    Gui, 2: Add, Edit, x50 y8 w250 vsearchTerm gSearch
    Gui, 2: Add, Listview, x8 w640 h500 vlistView gMoreDetail +Grid -Multi, Date|Time|Item Number|Temp|IMEI|Radio Version|Module Version|Firmware Build|Wifi Address|Bluetooth Address
    Gui, 2: Add, StatusBar
    SB_SetParts(200, 200)
    Loop Read, C:\DEVICE_TEST_RECORDS\all-mtcdtip-test-records.txt
    {
        If A_LoopReadLine =     ;Skip the blank lines
            Continue
        StringReplace, itemLine, A_LoopReadLine, `,`,, `,, All  ;Replace 2 commas to 1
        StringReplace, itemLine, itemLine, %localToday%, Today, All ;Replace today format to "Today"
        foundToday := InStr(itemLine, "Today")
        if (foundToday > 0)
            totalToday++
        StringSplit, item, itemLine, `,
        LV_Add("",item1,item2,item3,item4,item5,item6,item7,item8,item9,item10)
        itemList.Push({1:item1, 2:item2, 3:item3, 4:item4, 5:item5, 6:item6, 7:item7, 8:item8, 9:item9, 10:item10})
    }
    totalLine := LV_GetCount()
    LV_ModifyCol()
    LV_ModifyCol(2, "SortDesc")
    LV_ModifyCol(1, "SortDesc")
    
    SB_SetText("Total Today Passed-Tests: " totalToday, 1)
    SB_SetText("Total Passed-Tests: " totalLine, 2)
    Gui, 2: Show, , ALL MTCDTIP PASSED-TEST RECORDS (LOCAL COMPUTER)
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
    
    If (rowNum != 0) {
        MsgBox 4160, More Details, 
        (LTrim
            Test Date:`t`t%c1%
            Test Time:`t`t%c2%
            Item Number:`t%c3%
            Tested Temperature:`t%c4% (mCelsius)
            IMEI Number:`t%c5%
            SMC Radio Vers:`t%c6%
            Telit Module Vers:`t%c7%
            Firmware Build:`t%c8%
            Wifi Address:`t%c9%
            Bluetooth Address:`t%c10%
        )
    }
    Return ;MoreDetail label returned
    
    2GuiEscape:
    2GuiClose:
        Gui, 2: Cancel
        Gui, 2: Destroy
    Return
}