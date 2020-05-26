/*
    XDot Controller Function Library
    Contain all functions used by XDot Controller Scripts
*/
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
IfNotExist Z:\XDOT\Saved-Nodes
    FileCreateDir Z:\XDOT\Saved-Nodes

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\x_mark.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check_mark_brown.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark_brown.png, 1
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

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AS923_JAPAN-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AS923_JAPAN-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AS923-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AS923-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AU915-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AU915-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-EU868-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-EU868-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-IN865-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-IN865-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-KR920-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-KR920-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-RU864-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-RU864-mbed-os-5.11.1.bin, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1.bin, 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
;;;Global vars that used the same on 3 Apps
Global remotePath := "Z:\XDOT"
Global lotCodeList := []

Global allFregs := ["AS923", "AS923-JAPAN", "AU915", "EU868", "IN865", "KR920", "RU864", "US915"]

Global xImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\x_mark.png"
Global checkImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark.png"
Global check2Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark_brown.png"
Global play1Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_orange.png"
Global play2Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_brown.png"
Global play3Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_blue.png"
Global disImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png"
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
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
        Gui, Font, cblack Bold
        GuiControl, Font, portLabel%index%
        Gui, Font
        Gui, Font, cblack
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
    
    ;Recheck if load successfull
    Lbl_RecheckLoad:
    GuiControlGet readEditContent, , editNode    ;get text from edit field
    if (readEditContent = "") {
        FileRead, fileBakContent, %remotePath%\nodesToWrite.bak
        GuiControl Text, editNode, %fileBakContent%
        goto Lbl_RecheckLoad
    }
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
        FileAppend, %bakContent%, %fileLoc%     ;write backup text to main file
    FileAppend, %readEditContent%, %fileLoc%     ;write new text to main file
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
    
    ;Convert array back to string
    newListEditNodes := ""
    For key, var in listEditNodeArray
        newListEditNodes .= var "`n"
    newListEditNodes := RTrim(newListEditNodes, "`n")     ;remove last while space
    GuiControl Text, editNode, %newListEditNodes%
}

writeNodeLine(lineNum, writeStr) {
    GuiControlGet listEditNodes, , editNode
    listEditNodeArray := StrSplit(listEditNodes, "`n", "`t")    ;Convert string to array
    
    listEditNodeArray.InsertAt(lineNum, writeStr)   ;Append text to a specific index
    
    ;Convert array back to string
    newListEditNodes := ""
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
    hwndVar = h%origCtrlVar%
    
    if (option = "NORMAL") {
        
    } else if (option = "DISABLE") {            ;;;;=====================DISABLE ICON
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        GuiButtonIcon(%hwndVar%, disImg, 1, "s24")         ;Display icon
        xdotProperties[xIndex].status := "D"
        GuiControl, +vDis%origCtrlVar%,  %origCtrlVar%          ;Change var of control
        totalGoodPort--
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to debug mode
        GuiControl, Disable, portLabel%xIndex%
        GuiControl, Disable, nodeToWrite%xIndex%
    } else if (option = "BAD") {                ;;;;=====================BAD ICON
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        GuiButtonIcon(%hwndVar%, xImg, 1, "s24")         ;Display icon
        GuiControl, +vBad%origCtrlVar%,  Play%origCtrlVar%          ;Change var of control
    } else if (option = "GOOD") {               ;;;;=====================GOOD ICON
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        GuiButtonIcon(%hwndVar%, checkImg, 1, "s24")     ;Display icon
        if (mode = "PROGRAMMING")
            GuiButtonIcon(%hwndVar%, check2Img, 1, "s24")     ;Display icon
        GuiControl, +vGood%origCtrlVar%,  Play%origCtrlVar%         ;Change var of control
    } else if (option = "PLAY") {               ;;;;=====================PLAY ICON
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        if (mode = "TESTING") {
            GuiButtonIcon(%hwndVar%, play1Img, 1, "s24") ;Display icon
        }
        else if (mode = "PROGRAMMING") {
            GuiButtonIcon(%hwndVar%, play2Img, 1, "s24") ;Display icon
        }
        else if (mode = "WRITING") {
            GuiButtonIcon(%hwndVar%, play3Img, 1, "s24") ;Display icon
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