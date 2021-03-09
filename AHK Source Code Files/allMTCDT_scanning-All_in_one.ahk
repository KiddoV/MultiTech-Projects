/*
    Author: Viet Ho
*/

SetTitleMatchMode, RegEx
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\AMAuto-Scanner\TTL-Files
    FileCreateDir C:\V-Projects\AMAuto-Scanner\TTL-Files
IfNotExist C:\V-Projects\AMAuto-Scanner\Imgs-for-Search-Func
    FileCreateDir C:\V-Projects\AMAuto-Scanner\Imgs-for-Search-Func
IfNotExist C:\V-Projects\AMAuto-Scanner\caches
    FileCreateDir C:\V-Projects\AMAuto-Scanner\caches
    
IfNotExist C:\DEVICE_EEPROM_RECORDS
    FileCreateDir C:\DEVICE_EEPROM_RECORDS
    
FileInstall C:\MultiTech-Projects\TTL-Files\all_scan.ttl, C:\V-Projects\AMAuto-Scanner\TTL-Files\all_scan.ttl, 1

FileInstall C:\MultiTech-Projects\Imgs-for-Search-Func\version518.bmp, C:\V-Projects\AMAuto-Scanner\Imgs-for-Search-Func\version518.bmp, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global 240_SKUNums := ["94557670LF", "94557673LF", "94557700LF", "94557709LF", "94557716LF", "94557717LF"]
Global 246_SKUNums := ["94557252LF", "94557255LF", "94557540LF", "94557543LF", "94557574LF", "94557575LF", "94557576LF", "94557585LF", "94557589LF", "94557600LF", "94557601LF", "94557602LF", "94557605LF"]
Global 247_SKUNums := ["94557274LF", "94557291LF", "94557550LF", "94557593LF", "94557594LF", "94557598LF", "94557610LF", "94557616LF", "94557617LF"]
    
FormatTime, TimeString, %A_Now%, yyyy-MM-dd hh:mm

;;;Paths and Links
;240L
Global allScanPath := "C:\V-Projects\AMAuto-Scanner\TTL-Files\all_scan.ttl"
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

Gui Add, Button, x175 y5 w55 h20 vhistoryBttn gshowScanHist, HISTORY
Gui Add, Text, x17 y5 w136 h21 +0x200 vtopLabel, Select SKU Number

Gui Add, Tab3, x10 y27 w222 h65 vwhichTab gchangeTab +0x8, 240L|246L|247L
Gui Tab, 1
For each, item in 240_SKUNums
    skuNum1 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x25 y59 w190 vskuNum1 gchangeValueDropdown Choose1, %skuNum1%
Gui Tab, 2
For each, item in 246_SKUNums
    skuNum2 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x25 y59 w190 vskuNum2 gchangeValueDropdown Choose1, %skuNum2%
Gui Tab, 3
For each, item in 247_SKUNums
    skuNum3 .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x25 y59 w190 vskuNum3 gchangeValueDropdown Choose1, %skuNum3%
Gui Tab

Gui Add, GroupBox, x9 y101 w222 h190, Enter Values
Gui Add, Button, x180 y100 w40 h15 gclearCtrlVar, &Clear
Gui Font, s10
Gui Add, Text, x17 y125 w55 h21 vserialLabel, Serial #:
Gui Add, Text, x17 y150 w60 h21 vnodeidLabel, NodeID #:
Gui Add, Text, x17 y175 w55 h21 vimeiLabel, IMEI #:
Gui Add, Text, x17 y200 w55 h21 vuuidLabel, UUID #:
Gui Add, Text, x17 y235 w55 h21 vloraLabel, Lora #:
Gui Add, Text, x17 y261 w55 h21 vwifiLabel, WiFi #:
Gui Font

Gui Add, Text, x22 y227 w198 h2 +0x10 ;;--------------------------

Gui Add, Edit, x79 y123 w145 h21 vserialN hwndHED1 Number Limit32 ;Limit8
;SetEditCueBanner(HED1, "Ex: 12345678")
Gui Add, Edit, x79 y148 w145 h21 vnodeIdN hwndHED2 Limit32 ;Limit17
;SetEditCueBanner(HED2, "Ex: 00:00:00:00:00:00")
Gui Add, Edit, x79 y173 w145 h21 vimeiN hwndHED3 Number Limit32 ;Limit15
;SetEditCueBanner(HED3, "Ex: 123456789012345")
Gui Add, Edit, x79 y198 w145 h21 vuuidN hwndHED4 Limit32 ;Limit32
;SetEditCueBanner(HED4, "Ex: 123456789ABCDEF123456789ABCDEF12")
Gui Add, Edit, x79 y233 w145 h21 vloraN hwndHED5 Limit32 ;Limit23
;SetEditCueBanner(HED5, "Ex: 00:00:00:00:00:00:00:00")
Gui Add, Edit, x79 y259 w145 h21 vwifiN hwndHED6 Limit32 ;Limit23
;SetEditCueBanner(HED6, "Ex: 00:00:00:00:00:00:00:00")

Gui Add, Button, x80 y300 w80 h23 gmainStart, &START
Gui Add, StatusBar, ,...
;Functions must run when app first open
changeDisplayWithSKUNum()

Gui Show, , All MTCDT Auto-Scanner
Return

GuiClose:
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
~^s:: mainStart()
~Enter::    Send {Tab}
^q::    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;

mainStart() {
    GuiControlGet, skuNum1 ;Get value from DropDownList
    GuiControlGet, skuNum2 ;Get value from DropDownList
    GuiControlGet, skuNum3 ;Get value from DropDownList
    GuiControlGet, whichTab ;Get value from Tab Title
    allScanVar := "serialN,nodeIdN,imeiN,uuidN,loraN,wifiN"
    Loop, Parse, allScanVar, `,
    {
        GuiControlGet, isEnabled, Enabled, %A_LoopField%
        If (isEnabled)
            GuiControlGet, %A_LoopField%
    }
    
    Global skuNum
    If (whichTab = "240L")
        skuNum := skuNum1
    If (whichTab = "246L")
        skuNum := skuNum2
    If (whichTab = "247L")
        skuNum := skuNum3
    
    ;;Add value to check for MTAC present
    Global checkMtac := ""
    If (RegExMatch(skuNum, "94557585LF")) {
        checkMtac := "Check1_2"
    } Else If (RegExMatch(skuNum, "94557700LF|94557598LF|94557611LF|94557619LF|94557620LF|94557650LF|94557651LF|94557716LF|94557717LF|94557709LF")) {
        checkMtac := "Check1"
    } Else {
        checkMtac := "Check2"
    }
    
    ;Global skuNumPath := %skuNum%Path
    Global labelType := getLabelType()
    
    If !WinExist("COM.*") {
        SB_SetText("Connect to PORT before scanning!")
        MsgBox, 8240, Alert, Please connect to PORT first! ;Uses 48 + 8192
        return
    }
    OnMessage(0x44, "PlayInCircleIcon")
    MsgBox 0x81, Question, Begin Auto-Scanning for %skuNum%?
    OnMessage(0x44, "")
    IfMsgBox Cancel
        return
    
    If (checkInput(skuNum) = 0) {
        SB_SetText("Correct the values before scanning!")
        return
    }
    
    WinActivate COM.*
    Send ^c
    Sleep 100
    If (searchForFirmwareVersion(2, 500) = 0) {
        MsgBox 48, Not Ready or Wrong Port, MTCDT is not ready!`nPlease check PORT or reboot device first!
        return
    }
    
    ;Begin scan
    If WinExist("MACRO")
        WinKill MACRO
    WinActivate COM.*
    Send !om
    SB_SetText("Opening Teraterm Macro")
    WinWait MACRO.*
    ControlSetText, Edit1, %allScanPath%, MACRO.*
    ControlSend, Edit1, {Enter}, MACRO.*
    ControlClick, Button1, MACRO.*, , Left, 3
    
    ;Input datas
    SB_SetText("Sending datas to Teraterm Macro")
    WinWait ALL DATAS
    ControlSetText, Edit1, %labelType%`,%skuNum%`,%serialN%`,%nodeIdN%`,%imeiN%`,%uuidN%`,%loraN%`,%wifiN%`,%checkMtac%, ALL DATAS
    ControlSend, Edit1, {Enter}, ALL DATAS
    ControlClick, Button1, ALL DATAS, , Left, 3 ;Do this if ControlSend not working
    
    ;Wait for Teraterm
    WinKill SCAN COMPLETED|INVALID|FAILURE|ERROR|MISMATCH|RESCAN    ;;Fix bug 
    WaitForResponse:
    SB_SetText("Waiting for processes")
    WinWait SCAN COMPLETED|INVALID|FAILURE|ERROR|MISMATCH|RESCAN
    
    If WinExist("SCAN COMPLETED") {
        FormatTime, localTime, %A_Now%, hh:mm:ss tt
        SB_SetText("You just finished a scan at " localTime)
        WaitCompleteClose:
        WinWaitClose, SCAN COMPLETED
        IfWinNotExist
            clearCtrlVar()
        IfWinExist
            Goto WaitCompleteClose
        Return
    } Else If WinExist("MISMATCH|RESCAN") {
        SB_SetText("Scan value missmatched! Please rescan all values!")
        clearCtrlVar()
        Return
        ;WinWait RESCAN IMEI|RESCAN NODE LORA|RESCAN NODE WIFI
        ;If WinExist("RESCAN IMEI") {
            ;WinGetText, rescanImei, RESCAN IMEI
            ;Guicontrol, Text, imeiN, %rescanImei%
        ;} Else If WinExist("RESCAN NODE LORA") {
            ;WinGetText, rescanNodeLora, RESCAN NODE LORA
            ;Guicontrol, Text, loraN, %rescanNodeLora%
        ;} Else If WinExist("RESCAN NODE WIFI") {
            ;WinGetText, rescanNodeWifi, RESCAN NODE WIFI
            ;Guicontrol, Text, wifiN, %rescanNodeWifi%
        ;}
        
        ;Sleep 300
        ;Goto WaitForResponse
    } Else If WinExist("INVALID|FAILURE|ERROR"){
        SB_SetText("Failed to scan!")
        Return
    } Else {
        MsgBox, 16, ERROR, UNKNOWN ERROR!
        Return
    }
    Return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;Additional GUIs;;;;;;;;;;;;;;;;;;
showScanHist() {
    Global
    FormatTime, localToday,, yyyy/MM/dd
    itemList := {}
    totalToday := 0
    
    Gui, 2: Default
    Gui -MinimizeBox -MaximizeBox
    Gui, 2: Add, Text, x8 y11, Search:
    Gui, 2: Add, Edit, x50 y8 w250 vsearchTerm gSearch
    Gui, 2: Add, Listview, x8 w640 h500 vlistView gMoreDetail +Grid, Date|Time|SKU Number|Product ID|Hardware Version|Serial Number|Node ID|IMEI|Node Lora ID|UUID|Wifi Addr|Bluetooth Addr
    Gui, 2: Add, StatusBar
    SB_SetParts(200, 200)
    Loop Read, C:\DEVICE_EEPROM_RECORDS\all-scan-records.txt
    {
        If A_LoopReadLine =     ;Skip the blank lines
            Continue
        StringReplace, itemLine, A_LoopReadLine, `,`,, `,, All  ;Replace 2 commas to 1
        StringReplace, itemLine, itemLine, %localToday%, Today, All ;Replace today format to "Today"
        foundToday := InStr(itemLine, "Today")
        if (foundToday > 0)
            totalToday++
        StringSplit, item, itemLine, `,
        LV_Add("",item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12)
        itemList.Push({1:item1, 2:item2, 3:item3, 4:item4, 5:item5, 6:item6, 7:item7, 8:item8, 9:item9, 10:item10, 11:item11, 12:item12})
    }
    totalLine := LV_GetCount()
    LV_ModifyCol()
    LV_ModifyCol(2, "SortDesc")
    LV_ModifyCol(1, "SortDesc")
    
    SB_SetText("Total Today Passed-Scans: " totalToday, 1)
    SB_SetText("Total Passed-Scans: " totalLine, 2)
    Gui, 2: Show, , ALL MTCDT PASSED-SCAN RECORDS (LOCAL COMPUTER)
    Return
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Search:
    GuiControlGet, searchTerm
    GuiControl, -Redraw, listView
    LV_Delete()
    For each, item in itemList
    {
        If (searchTerm != "") {
            If (Instr(item.1, searchTerm) > 0 || Instr(item.2, searchTerm) > 0 || Instr(item.3, searchTerm) > 0 || Instr(item.4, searchTerm) > 0 || Instr(item.5, searchTerm) > 0 || Instr(item.6, searchTerm) > 0 || Instr(item.7, searchTerm) > 0 || Instr(item.8, searchTerm) > 0 || Instr(item.9, searchTerm) > 0 || Instr(item.10, searchTerm) > 0 || Instr(item.11, searchTerm) > 0 || Instr(item.12, searchTerm) > 0) {
                LV_Add("", item.1, item.2, item.3, item.4, item.5, item.6, item.7, item.8, item.9, item.10, item.11, item.12)
            }
        } Else {
            LV_Add("", item.1, item.2, item.3, item.4, item.5, item.6, item.7, item.8, item.9, item.10, item.11, item.12)
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
    LV_GetText(c12, rowNum, 12)
    
    If (rowNum != 0) {
        MsgBox 4160, More Details, 
        (LTrim
            Scan Date:`t`t%c1%
            Scan Time:`t%c2%
            SKU Number:`t%c3%
            Product ID:`t%c4%
            Hardware ID: `t%c5%
            Serial Number:`t%c6%
            Node ID (MAC ID):`t%c7%
            IMEI Number:`t%c8%
            Node Lora ID:`t%c9%
            UUID:`t`t%c10%
            Wifi Address:`t%c11%
            Bluetooth Address:`t%c12%
        )
    }
    
    Return ;MoreDetail label returned
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    2GuiEscape:
    2GuiClose:
        Gui, 2: Cancel
        Gui, 2: Destroy
    Return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
checkInput(skuNum := "") {
    GuiControlGet, serialN
    GuiControlGet, imeiN
    GuiControlGet, nodeIdN
    GuiControlGet, uuidN
    GuiControlGet, loraN
    GuiControlGet, wifiN
    
    GuiControlGet, isImeiEnabled, Enabled, imeiN
    GuiControlGet, isLoraEnabled, Enabled, loraN
    GuiControlGet, isWifiEnabled, Enabled, wifiN
    
    If (RegExMatch(serialN, "^([^0]){1}+([\d]){7}$") < 1) {
        MsgBox, 48, INVALID INPUT, Invalid SERIAL NUMBER! Rescan!`nSerial Number only have 8 digits.
        return 0
    } Else If (RegExMatch(nodeIdN, "^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$") < 1) {
        MsgBox, 48, INVALID INPUT, Invalid NODE ID! Rescan!
        return 0
    } Else If (RegExMatch(imeiN, "^([\d]){15}$") < 1 && isImeiEnabled = 1) {
        MsgBox, 48, INVALID INPUT, Invalid IMEI NUMBER! Rescan!
        return 0
    } Else If (RegExMatch(uuidN, "^([[:xdigit:]]){32}$") < 1) {
        MsgBox, 48, INVALID INPUT, Invalid UUID! Rescan!
        return 0
    } Else If (isLoraEnabled = 1) {
        if (RegExMatch(skuNum, "94557709LF|94557717LF") >= 1) {
            if (RegExMatch(loraN, "^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$") < 1) {
                MsgBox, 48, INVALID INPUT, Invalid Lora Number (!!Special Lora Number!!)! Rescan!
                return 0
            }
        } else {
            if (RegExMatch(loraN, "^([0-9A-F]{2}[:-]){7}([0-9A-F]{2})$") < 1) {
            MsgBox, 48, INVALID INPUT, Invalid Lora Number! Rescan!
            return 0
            }
        }
    } Else If (RegExMatch(wifiN, "^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$") < 1 && isWifiEnabled = 1) {
        MsgBox, 48, INVALID INPUT, Invalid Wifi ID Number! Rescan!
        return 0
    }
}

changeTab() {
    changeDisplayWithSKUNum()
}

changeValueDropdown() {
    changeDisplayWithSKUNum()
}

;LABELTYPE1 -- Serial, NodeID, UUID
;LABELTYPE2 -- Serial, NodeID, UUID, IMEI
;LABELTYPE3 -- Serial, NodeID, UUID, IMEI, LORA
;LABELTYPE4 -- Serial, NodeID, UUID, IMEI, LORA, WIFI
;LABELTYPE5 -- Serial, NodeID, UUID, LORA, WIFI
;LABELTYPE6 -- Serial, NodeID, UUID, IMEI, WIFI
;LABELTYPE7 -- Serial, NodeID, UUID, LORA
;LABELTYPE8 -- Serial, NodeID, UUID, WIFI
getLabelType() {
    LABELTYPE1 := ["94557252LF", "94557255LF"]
    LABELTYPE2 := ["94557574LF", "94557700LF", "94557716LF", "94557575LF", "94557601LF", "94557585LF", "94557600LF"]
    LABELTYPE3 := ["94557576LF", "94557670LF", "94557673LF", "94557605LF", "94557717LF", "94557709LF", "94557602LF", "94557589LF"]
    LABELTYPE4 := ["94557291LF", "94557594LF", "94557617LF", "94557598LF", "94557610LF"]
    LABELTYPE5 := ["94557550LF"]
    LABELTYPE6 := ["94557593LF", "94557616LF"]
    LABELTYPE7 := ["94557543LF", "94557540LF"]
    LABELTYPE8 := ["94557274LF"]
    
    allLabelType := "LABELTYPE1,LABELTYPE2,LABELTYPE3,LABELTYPE4,LABELTYPE5,LABELTYPE6,LABELTYPE7,LABELTYPE8"
    
    GuiControlGet, skuNum1 ;Get value from DropDownList
    GuiControlGet, skuNum2 ;Get value from DropDownList
    GuiControlGet, skuNum3 ;Get value from DropDownList
    GuiControlGet, whichTab ;Get value from Tab Title
    
    Global skuN
    If (whichTab = "240L")
        skuN := skuNum1
    If (whichTab = "246L")
        skuN := skuNum2
    If (whichTab = "247L")
        skuN := skuNum3
    
    getLabelTypeLoop:
    Loop Parse, allLabelType, `,
    {
        For key, value in %A_LoopField%
        If (value = skuN) 
            return %A_LoopField%
        Continue getLabelTypeLoop
    }
}

changeDisplayWithSKUNum() {
    Global labelType := getLabelType()
    Global allValueScan := "serialLabel,serialN,nodeidLabel,nodeIdN,imeiLabel,imeiN,uuidLabel,uuidN,loraLabel,loraN,wifiLabel,wifiN"
    
    Loop Parse, allValueScan, `,
        GuiControl Enable, %A_LoopField%
    
    if (labelType = "LABELTYPE1") {
        GuiControl Disable, imeiLabel
        GuiControl Disable, imeiN
        GuiControl Disable, loraLabel
        GuiControl Disable, loraN
        GuiControl Disable, wifiLabel
        GuiControl Disable, wifiN
    } else if (labelType = "LABELTYPE2") {
        GuiControl Disable, loraLabel
        GuiControl Disable, loraN
        GuiControl Disable, wifiLabel
        GuiControl Disable, wifiN
    } else if (labelType = "LABELTYPE3") {
        GuiControl Disable, wifiLabel
        GuiControl Disable, wifiN
    } else if (labelType = "LABELTYPE4") {
    
    } else if (labelType = "LABELTYPE5") {
        GuiControl Disable, imeiLabel
        GuiControl Disable, imeiN
    } else if (labelType = "LABELTYPE6") {
        GuiControl Disable, loraLabel
        GuiControl Disable, loraN
    } else if (labelType = "LABELTYPE7") {
        GuiControl Disable, imeiLabel
        GuiControl Disable, imeiN
        GuiControl Disable, wifiLabel
        GuiControl Disable, wifiN
    } else if (labelType = "LABELTYPE8") {
        GuiControl Disable, imeiLabel
        GuiControl Disable, imeiN
        GuiControl Disable, loraLabel
        GuiControl Disable, loraN
    } else {
        Loop Parse, allValueScan, `,
            GuiControl Disable, %A_LoopField%
    }
}
    
clearCtrlVar() {
    allScanVar := "serialN,nodeIdN,imeiN,uuidN,loraN,wifiN"
    Loop, Parse, allScanVar, `,
    {
        GuiControl, Text, %A_LoopField%, 
    }
}

SetEditCueBanner(HWND, Cue) {  ; requires AHL_L
   Static EM_SETCUEBANNER := (0x1500 + 1)
   Return DllCall("User32.dll\SendMessageW", "Ptr", HWND, "Uint", EM_SETCUEBANNER, "Ptr", True, "WStr", Cue)
}

;;;;Search Images Functions;;;;
searchForFirmwareVersion(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate ^COM
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AMAuto-Scanner\Imgs-for-Search-Func\version518.bmp
        If ErrorLevel = 0
            return 1 ;Return true if found
        Sleep, %sleepTime%
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