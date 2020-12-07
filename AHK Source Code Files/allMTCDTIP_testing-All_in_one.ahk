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

FileInstall C:\MultiTech-Projects\TTL-Files\all_mtcdtip_test.TTL, C:\V-Projects\AMIPAuto-Tester\TTL-Files\all_mtcdtip_test.ttl, 1

;===============================================;
;;;;;;;;;;;;;VARIABLEs DEFINITION
Global 266_ItemNums := ["63120927L", "63120928L"]
Global 267_ItemNums := ["63120925L", "63120926L"]

Global SMC_Items := ["L4E1"]

Global MainTestFilePath := "C:\V-Projects\AMIPAuto-Tester\TTL-Files\all_mtcdtip_test.ttl"
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
Gui, Add, GroupBox, x10 y185 Section w202 h150, Processes
Gui Font,, Consolas
Gui, Add, Text, xs+45 ys+15 vloadConfig, Load Configuration

Gui, Font

Gui Add, Button, x70 y340 w80 h23 gRunTest, S&TART

;;;;;;;
posX := A_ScreenWidth - 400
Gui, Show, x%posX% y100, All MTCDT Auto-Tester
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
    runFuncTest(mType, itemNum, isRunConfig, radioType)
}

runFuncTest(mtcdtipType, itemNumber, isRunConfig, radioType) {
    Run, %ComSpec% /c cd C:\teraterm && TTPMACRO %MainTestFilePath% %mtcdtipType% %itemNumber% %isRunConfig% %radioType%, ,Hide
    
}

;===============================================;
;;;;;;;;;;;;;;;;;;;ADDITIONAL FUNTIONs
ChangeTab() {
    
}

ConfigChecked() {
    
}

SCMTestChecked() {
    GuiControlGet, isCheck, , smcCheckBox
    If (isCheck)
        GuiControl, Enable, smcDrop
    Else
        GuiControl, Disable, smcDrop
}

;===============================================;
;;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs
ShowTestHist() {
    
}