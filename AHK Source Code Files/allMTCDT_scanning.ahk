/*
    Author: Viet Ho
*/

SetTitleMatchMode, RegEx

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global 240_SKUNums := ["94557700LF", ""]
Global 246_SKUNums := ["", ""]
Global 247_SKUNums := ["", ""]

;;;Paths and Links
;240L
Global 94557700LFPath := "C:\MTCDT_REFRESH\240L\94557700LF\94557700LF-eepromSCAN.ttl"
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
    
Gui Add, Text, x17 y5 w136 h21 +0x200 vtopLabel, Select SKU Number

Gui Add, Tab3, x10 y27 w222 h65 vwhichTab +0x8, 240L|246L|247L
Gui Tab, 1
For each, item in 240_SKUNums
    skuNum1 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x25 y59 w190 vskuNum1 Choose1, %skuNum1%
Gui Tab, 2
For each, item in 246_SKUNums
    skuNum2 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x25 y59 w190 vskuNum2 Choose1, %skuNum2%
Gui Tab, 3
For each, item in 247_SKUNums
    skuNum3 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x25 y59 w190 vskuNum3 Choose1, %skuNum3%
Gui Tab

Gui Add, GroupBox, x9 y101 w222 h190, Enter Values
Gui Font, s10
Gui Add, Text, x17 y125 w55 h21, Serial #:
Gui Add, Text, x17 y150 w60 h21, NodeID #:
Gui Add, Text, x17 y175 w55 h21, IMEI #:
Gui Add, Text, x17 y200 w55 h21, UUID #:
Gui Add, Text, x17 y235 w55 h21 +Disabled, LORA #:
Gui Add, Text, x17 y261 w55 h21 +Disabled, WiFi #:
Gui Font

Gui Add, Text, x22 y227 w198 h2 +0x10 ;;--------------------------

Gui Add, Edit, x79 y123 w145 h21 vserialN Limit8 Number
Gui Add, Edit, x79 y148 w145 h21 vnodeIdN Limit17
Gui Add, Edit, x79 y173 w145 h21 vimeiN Limit15
Gui Add, Edit, x79 y198 w145 h21 vuuidN Limit32
Gui Add, Edit, x79 y233 w145 h21 vloraN +Disabled
Gui Add, Edit, x79 y259 w145 h21 vwifiN +Disabled

Gui Add, Button, x80 y300 w80 h23 gmainStart, &START

Gui Show, , All MTCDT Auto-Scanner
Return

GuiEscape:
GuiClose:
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
~Enter::
Send {Tab}
;;;;;;;;;;;;;;;;;;;;;;;;

mainStart() {
    GuiControlGet, skuNum1 ;Get value from DropDownList
    GuiControlGet, skuNum2 ;Get value from DropDownList
    GuiControlGet, skuNum3 ;Get value from DropDownList
    GuiControlGet, whichTab ;Get value from Tab Title
    GuiControlGet, serialN
    GuiControlGet, nodeIdN
    GuiControlGet, imeiN
    GuiControlGet, uuidN
    GuiControlGet, loraN
    GuiControlGet, wifiN
    
    Global skuNum
    If (whichTab = "240L")
        skuNum := skuNum1
    If (whichTab = "246L")
        skuNum := skuNum2
    If (whichTab = "247L")
        skuNum := skuNum3
    
    Global skuNumPath := %skuNum%Path
    
    If !WinExist("COM.*") {
        MsgBox, 8240, Alert, Please connect to PORT first! ;Uses 48 + 8192
        return
    }
    
    If (checkInput() = 0) {
        return
    }
    
    WinActivate COM.*
    Send ^c
    Sleep 100
    If (searchForFirmwareVersion() = 0) {
        MsgBox  Please reboot device first
        return
    }
    
    Send !om
    WinWait MACRO.*
    WinActivate MACRO.*
    Send %skuNumPath% {Enter}
        
    WinWait PORT.*
    WinActivate PORT.*
    Send {Enter}
        
    WinWait PORT.*
    WinActivate PORT.*
    Send {Enter}
    
    SERIAL_SCAN:
    WinWait .*Serial.*
    WinActivate .*Serial.*
    Send %serialN% {Enter}
    
    NODEID_SCAN:
    WinWait .*NODE.*
    WinActivate .*NODE.*
    Send %nodeIdN% {Enter}
    
    IMEI_SCAN:
    WinWait .*IMEI.*
    WinActivate .*IMEI.*
    Send %imeiN% {Enter}
    
    UUID_SCAN:
    WinWait .*UUID.*
    WinActivate .*UUID.*
    Send %uuidN% {Enter}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
checkInput() {
    GuiControlGet, serialN
    GuiControlGet, imeiN
    GuiControlGet, nodeIdN
    GuiControlGet, uuidN
    GuiControlGet, loraN
    GuiControlGet, wifiN
    
    If (serialN = null) {
        MsgBox Serial Number cannot be blank!
        return 0
    } Else If (imeiN = null) {
        MsgBox IMEI Number cannot be blank!
        return 0
    } Else If (nodeIdN = null) {
        MsgBox Node ID Number cannot be blank!
        return 0
    } Else If (uuidN = null) {
        MsgBox UUID Number cannot be blank!
        return 0
    }
}

;;;;Search Images Functions;;;;
searchForFirmwareVersion() {
        WinActivate COM.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Tester\Imgs-for-Search-Func\mli419.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        If ErrorLevel
            return 0 ;Return false if NOT found
}