/*
    Author: Viet Ho
*/

IfNotExist C:\V-Projects\AMAuto-Tester\Imgs-for-GUI
    FileCreateDir C:\V-Projects\AMAuto-Tester\Imgs-for-GUI

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\check.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\time.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\time.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\arrow.png, C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\arrow.png, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

Global 240_ItemNums := ["70000041L", ""]
Global 246_ItemNums := ["70000054L", ""]
Global 247_ItemNums := ["70000053L", ""]

;;;Paths and Links
;240L
Global 70000041LConfigPath := "c"
Global 70000041LTestPath := "C:\MTCDT_REFRESH\240L\70000041L\70000041L-MLINUX-LAT3-tst_002.ttl"
;246L
Global 70000054LConfigPath := "C:\MTCDT_REFRESH\246L\70000054L\70000054L-MLINUX_4_1_9_eeprom_test_config.ttl"
Global 70000054LTestPath := "C:\MTCDT_REFRESH\246L\70000054L\70000054L-MLINUX_4_1_9_Functional_Test.ttl"


;GUI images
Global checkImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\check.png"
Global timeImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\time.png"
Global arrowImg := "C:\V-Projects\AMAuto-Tester\Imgs-for-GUI\arrow.png"

;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

;Gui +hWndhMainWnd
;For each, item in allItemNum
;    itemNum .= (each == 1 ? "" : "|") . item
;Gui Add, DropDownList, x22 y32 w176 vitmNum Choose1, %itemNum%
;Gui Add, GroupBox, x9 y8 w300 h70, Select Item Number
Gui Add, Text, x17 y5 w136 h21 +0x200 , Select Item Number

Gui Add, Tab3, x9 y27 w202 h65 vwhichTab, 240L|246L|247L
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
Gui Add, GroupBox, x9 y132 w202 h188, Processes
Gui Add, Button, x70 y328 w80 h23 gmainStart, &START
Gui Font,, Consolas
Gui Add, Text, x64 y148 w136 h21 +0x200 vloadConfig, Load Configuration
Gui Font
Gui Font,, Consolas
Gui Add, Text, x64 y170 w136 h21 +0x200 vreAfterConfig, Rebooted After Config
Gui Font
Gui Add, Text, x17 y193 w189 h2 +0x10
Gui Font, c0x000000, Consolas
Gui Add, Text, hWndhTxtCheckEthernetPort3 x64 y197 w136 h21 +0x200, Check Ethernet Port
Gui Font
Gui Font,, Consolas
Gui Add, Text, x64 y241 w136 h21 +0x200, Check Temperature
Gui Font
Gui Font,, Consolas
Gui Add, Text, x64 y263 w136 h21 +0x200, Check SIM/ Cellular
Gui Font
Gui Font,, Consolas
Gui Add, Text, x64 y285 w136 h21 +0x200, Check WiFi/ Bluetooth
Gui Font
Gui Font,, Consolas
Gui Add, Text, x64 y219 w136 h21 +0x200, Check LED
Gui Font
Gui Font, c0x00FF00, Ms Shell Dlg 2

Gui Add, Picture, x30 y148 w21 h21 vprocess1 ;GuiControl , , process1, %arrowImg%
Gui Add, Picture, x30 y170 w21 h21 vprocess2
Gui Add, Picture, x30 y285 w21 h21 vprocess3
Gui Add, Picture, x30 y241 w21 h21 vprocess4
Gui Add, Picture, x30 y197 w21 h21 vprocess5
Gui Add, Picture, x30 y219 w21 h21 vprocess6
Gui Add, Picture, x30 y263 w21 h21 vprocess7

Gui Show, x1269 y324 w220 h360, All MTCDT Auto-Tester
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
    
    If (whichTab = "240L")
        itemNum := itemNum1
    If (whichTab = "246L")
        itemNum := itemNum2
    If (whichTab = "247L")
        itemNum := itemNum3
    
    if (check = 0) {
        MsgBox, 33, Question, Begin ONLY Auto-Functional Test for %itemNum%?
    } 
    Else {
        MsgBox, 33, Question, Begin Auto-Full Test for %itemNum%?
        IfMsgBox Cancel
            return
        IfMsgBox OK
        addConfigFile(itemNum)
    }

}

addConfigFile(itemN) {
    SetTitleMatchMode, RegEx
    Global configPath := %itemN%ConfigPath
    
    If FileExist ("%configPath%") {
            MsgBox 16, FILE NOT FOUND, File NOT FOUND in this location: `n%configPath%`nMake sure you have the CONFIG file, and put it in the exact location above!
            return
        }
        
    WinActivate COM.*
    Send !om
    
    ;if (itemN = "70000054L")
        
}

;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
checkBoxToggle() {
    GuiControlGet, check ;Get value from CheckBox
    If (check = 0) {
        GuiControl Disable, loadConfig
        GuiControl Disable, reAfterConfig
    }
    Else {
        GuiControl Enable, loadConfig
        GuiControl Enable, reAfterConfig
    }
}
