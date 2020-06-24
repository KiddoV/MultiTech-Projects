 /*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global xdotProperties := [{}]  ; Creates an array containing an object.
xdotProperties[17] := {status: "G", mainPort: 117, breakPort: 17, portName: "PORT17", driveName: "D", ttXPos: 5, ttYPos: 5, ctrlVar: "XDot17"}
xdotProperties[18] := {status: "G", mainPort: 118, breakPort: 18, portName: "PORT18", driveName: "E", ttXPos: 105, ttYPos: 5, ctrlVar: "XDot18"}
xdotProperties[19] := {status: "G", mainPort: 119, breakPort: 19, portName: "PORT19", driveName: "F", ttXPos: 205, ttYPos: 5, ctrlVar: "XDot19"}
xdotProperties[20] := {status: "G", mainPort: 120, breakPort: 20, portName: "PORT20", driveName: "G", ttXPos: 305, ttYPos: 5, ctrlVar: "XDot20"}
xdotProperties[21] := {status: "G", mainPort: 121, breakPort: 21, portName: "PORT21", driveName: "H", ttXPos: 405, ttYPos: 5, ctrlVar: "XDot21"}
xdotProperties[22] := {status: "G", mainPort: 122, breakPort: 22, portName: "PORT22", driveName: "I", ttXPos: 505, ttYPos: 5, ctrlVar: "XDot22"}
xdotProperties[23] := {status: "G", mainPort: 123, breakPort: 23, portName: "PORT23", driveName: "J", ttXPos: 5, ttYPos: 105, ctrlVar: "XDot23"}
xdotProperties[24] := {status: "G", mainPort: 124, breakPort: 24, portName: "PORT24", driveName: "K", ttXPos: 105, ttYPos: 105, ctrlVar: "XDot24"}

Global totalGoodPort := 8
Global totalPort := 8
Global mainWndTitle := "XDot Controller (PC3)"
Global startedIndex := 17

;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\LIB_xDot_controller.ahk
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

Gui +hWndhMainWnd
Gui Add, GroupBox, xm+205 ym+0 w300 h420 Section, xDot NodeID Editor
;;;;;;Toolbar here
Gui Add, Text, xs+10 ys+38 w285 h2 +0x10 ;;-----------------------------
Gui, Add, Edit, xs+5 ys+75 w35 r25.3 -VScroll -HScroll -Border Disabled Right vlineNo
Gui Font, Bold q5, Consolas
Gui, Add, Edit, xs+40 ys+75 r24 hwndEdit w255 +HScroll veditNode
Gui Font
Gui Font, Bold
Gui Add, Text, xs+10 ys+50 , Select LOT Code:
Gui Font
lotCodeList := getLotCodeList()
For each, item in lotCodeList
    lotCode .= (each == 1 ? "" : "|") . item
Gui Add, ComboBox, xs+120 ys+45 vlotCodeSelected gCbAutoComplete, %lotCode%
Gui Add, Button, xs+250 ys+45 h21 gloadNodeFromLot, Load
Gui Add, GroupBox, xm+0 ym+0 w200 h87 vxdotPanel Section, xDot Panel Group 3
Gui Font, Bold, Ms Shell Dlg 2

Gui Add, Button, xs+133 ys+15 w30 h30 vXDot17 gGetXDot hWndhXDot17, P17
Gui Add, Button, xs+165 ys+15 w30 h30 vXDot18 gGetXDot hWndhXDot18, P18

Gui Add, Button, xs+5 ys+50 w30 h30 vXDot19 gGetXDot hWndhXDot19, P19
Gui Add, Button, xs+37 ys+50 w30 h30 vXDot20 gGetXDot hWndhXDot20, P20
Gui Add, Button, xs+69 ys+50 w30 h30 vXDot21 gGetXDot hWndhXDot21, P21
Gui Add, Button, xs+101 ys+50 w30 h30 vXDot22 gGetXDot hWndhXDot22, P22
Gui Add, Button, xs+133 ys+50 w30 h30 vXDot23 gGetXDot hWndhXDot23, P23
Gui Add, Button, xs+165 ys+50 w30 h30 vXDot24 gGetXDot hWndhXDot24, P24
Gui Font

Gui Add, GroupBox, xm+0 ym+90 w200 h110 Section, Functional Test
Gui Add, Text, cgray xs+10 ys+20, Test firmware version: v3.0.2-debug
Gui Add, Radio, xs+15 ys+37 vtotalGPortRadio Group +Checked gradioToggle, Run tests on %totalGoodPort% ports
Gui Add, Radio, xs+15 ys+54 vreproGPortRadio gradioToggle, Reprogram %totalGoodPort% ports to debug mode
Gui Add, Button, xs+73 ys+75 w55 h28 grunAll, RUN

Gui Add, GroupBox, xm+0 ym+205 w200 h245 Section, EUID Write
Gui Add, Text, xs+10 ys+20 vselectFreqLabel, Select Frequency:
For each, item in allFregs
    freq .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, xs+105 ys+17 w85 vchosenFreq, %freq%
index := startedIndex
xVarStarted := 5
yVarStarted := 50
Loop, 8
{
    mainPort := xdotProperties[index].mainPort
    Gui Font, Bold,
    Gui Add, Text, xs+5 ys+%yVarStarted% vportLabel%index%, P%mainPort%
    Gui Font
    Gui Add, Edit, xs+37 ys+%yVarStarted% w144 h16 +ReadOnly vnodeToWrite%index%,
    
    index++
    yVarStarted += 20
}

Gui Add, Button, xs+182 ys+50 w15 h155 vgiveBackBttn ggiveBackToEdit, >
Gui Add, Text, cgray xs+5 ys+225 vfwLabel, FW: v3.2.1
Gui Add, Button, xs+73 ys+211 w55 h28 vwriteAllBttn gwriteAll, START

;;For Eco Lab
Gui Add, ListView, xs+5 ys+20 r9 w190 vidListView hWndhIdListView +Grid +NoSortHdr Hidden, P#|Node ID|Serial Number|App Key|UUID
index := startedIndex
Loop, 8
{
    mainPort := xdotProperties[index].mainPort
    LV_Add("", mainPort)
    
    index++
}
;Create instance to use LV_Color
LVInstance := New LV_Colors(hIdListView)

;Gui Add, GroupBox, xm+205 ym+430 w290 h55 Section, All Records
;Gui Add, Button, xs+100 ys+20 w140 h25 ggetRecords, EUID Write History

;;;Functions to run BEFORE main gui is started;;;
OnMessage(0x100, "WM_KEYDOWN")
OnMessage(0x200, "WM_MOUSEMOVE")
deleteOldCacheFiles()    ;Delete result port data before gui start (Ex: 101.dat)

;;Add Menu Bar
AddMainMenuBar()

posX := A_ScreenWidth - 540
posY := A_ScreenHeight - 560
Gui, Show, x%posX% y%posY%, %mainWndTitle%

;;;Functions to run AFTER main gui is started;;;
editnodeToolbar := CreateEditNodeToolbar()
;loadNodesToWrite()

GuiControlGet, editNode, Pos, editNode
IfNotExist C:\teraterm\ttermpro.exe
    MsgBox, 16, WARNING, This program only work with a secondary program.`nPlease install Teraterm to this location: C:\teraterm\
#Persistent
SetTimer, DrawLineNum, 1
SetTimer, CheckFileChange, 20
SetTimer, CheckLotChange, 200
Return      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawLineNum:
    pos := DllCall("GetScrollPos", "UInt", Edit, "Int", 1)
    ifEqual, pos, % posPrev, return                       ;if nothing new
    posPrev := pos
    drawLineNumbers(pos)                                  ;draw line numbers
Return

drawLineNumbers(firstLine = "") {
    Local lines
    Static prevFirstLine
    prevFirstLine := firstLine != "" ? firstLine : prevFirstLine
    firstLine := prevFirstLine
    loop, 24
    {
        lines .= ++firstLine . "`n"
    }

    GuiControl,, lineNo, % lines
}

CheckFileChange:
IfExist %remotePath%
{
    Fileread newFileContent, Z:\XDOT\nodesToWrite.txt
    if(newFileContent != lastFileContent) {
        lastFileContent := newFileContent
        loadNodesToWrite()
    }
}
Return

CheckLotChange:
IfExist %remotePath%\Saved-Nodes
{
    newLotList := []
    Loop Files, %remotePath%\Saved-Nodes\*.txt, R
    {
        newLotList[A_Index] := A_LoopFileName
        reverseArray(newLotList)
        newLot := newLotList[1]
    }
    if(newLot != oldLot) {
        oldLot := newLotList[1]
        updateLotCodeList()
    }
}
Return

GuiClose:
    MsgBox 36, , Are you sure you want to quit?
    IfMsgBox Yes
    {
        For process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-winwaitEachPort.exe' ")
        Process, close, % process.ProcessId
        
        ExitApp
     }
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;;;

;;;;;;User Prompt GUI
;;;auGen GUI
GetAutoGenerate:
    Gui, auGen: Cancel
    Gui, auGen: Destroy
    WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%

    Gui, auGen: Default
    Gui, auGen: +ToolWindow +AlwaysOnTop +hWndhauGenWnd
    Gui, auGen: Add, Edit, x10 y5 w110 h20 hwndHED1 vfirstNodeID Limit16
    SetEditCueBanner(HED1, "First nodeIDs")
    Gui, auGen: Add, Edit, x130 y5 w42 h20 Limit4 +Number hwndHED2 vnodeAmout
    SetEditCueBanner(HED2, "Amount")
    Gui, auGen: Add, Button, x180 y5 w50 h20 ggenerateNode, Generate
    
    mainY := mainY + 30
    Gui, auGen: Show, x%mainX% y%mainY%, Auto Generate Node IDs
    Return
    
    auGenGuiEscape:
    auGenGuiClose:
        Gui, auGen: Destroy
    Return
    ;;;Functions and Labels for auGen GUI;;;
    generateNode() {
    GuiControlGet, firstNodeID
    GuiControlGet, nodeAmout
    
    if (StrLen(firstNodeID) < 16) {
        MsgBox, 16, ,NodeID should have 16 digits!
        return
    } else if (RegExMatch(firstNodeID, "^[0-9A-Fa-f]+$") = 0) {
        MsgBox, 16, , Please enter only Hexadecimal for NodeID!
        return
    } else if (StrLen(nodeAmout) < 1) {
        MsgBox, 16, , Please enter an amount for NodeID!
        return
    }
    
    firstNodeID = 0x%firstNodeID%   ;convert value to Hex
    
    Gui, 1: Default
    GuiControl Text, editNode, % autoGenerateNodeID(firstNodeID, nodeAmout)
    Gui auGen: Destroy
}

    /*
        Return a list of node in String
    */
    autoGenerateNodeID(firstNode, amount) {
        listNode := []
        listNodeStr := ""
        SetFormat Integer, Hex      ;convert value to Hex
        index := 0
        Loop, %amount%
        {
            firstNode += index
            listNode.Push(firstNode)
            index++
        }
        ;00800FAFAFAFAFAF
        For index, value In listNode
        {
            listNodeStr .= "`n" . value
        }
        listNodeStr := LTrim(listNodeStr, "`n")     ;remove first while space
        
        SetFormat Integer, D
        nodelength := StrLen(firstNode)
        if (nodelength = 16)
            StringReplace, listNodeStr, listNodeStr, 0x, 00, All
        else if (nodelength = 17)
            StringReplace, listNodeStr, listNodeStr, 0x, 0, All
        else if (nodelength = 18)
            StringReplace, listNodeStr, listNodeStr, 0x, , All
            
        return listNodeStr
    }
Return

;;;adNew Gui
GetAddNew:
    Gui, adNew: Cancel
    Gui, adNew: Destroy
    WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%
    
    Gui, adNew: Default
    
    Gui, adNew: +ToolWindow +AlwaysOnTop +hWndhadNewWnd
    Gui, adNew: Add, GroupBox, xm+0 ym+0 w230 h60 Section, Option 1
    Gui Font, Bold
    Gui, adNew: Add, Text, xs+10 ys+15, Add New From Current Editor
    Gui, Font
    Gui, adNew: Add, Text, xs+10 ys+35, Enter LOT CODE:
    Gui, adNew: Add, Edit, xs+100 ys+32 w75 h20 vinLotCode +Number Limit10
    Gui, adNew: Add, Button, xs+185 ys+32 h20 gSaveLot1, Save
    
    Gui, adNew: Add, GroupBox, xm+0 ym+65 w230 h60 Section, Option 2
    Gui Font, Bold
    Gui, adNew: Add, Text, xs+10 ys+15, Add New From A File
    Gui, Font
    
    Gui, adNew: Add, Button, xs+10 ys+35 h20 gBrowseLot, Browse...
    Gui, adNew: Add, Text, xs+70 ys+40 w110 vfilePathLabel,
    Gui, adNew: Add, Button, xs+185 ys+35 h20 gSaveLot2, Save
    
    mainY := mainY + 30
    Gui, adNew: Show, x%mainX% y%mainY%, Add New Node List
    Return
    
    SaveLot1:
        GuiControlGet newLotCode, , inLotCode
        lotCodeArray := getLotCodeList()
        
        if (newLotCode = "") {
            MsgBox 16, ,Please enter lot code!
            return
        }
        
        Loop % lotCodeArray.Length()
        {
            if (lotCodeArray[A_Index] = newLotCode) {
                MsgBox 16, , Duplicate Lot Code`nPlease Enter a different one!
                return
            }
        }
        
        Gui, 1: Default
        GuiControlGet editContent, , editNode    ;get new text in edit field
        
        FileAppend, %editContent%, %remotePath%\Saved-Nodes\%newLotCode%.txt
        Gui, adNew: Destroy
        updateLotCodeList()
    Return
    
    BrowseLot:
        FileSelectFile, selectedFile, , , Select a NodeID text file..., Text Documents (*.txt; *.doc)
        if (selectedFile = "")
            return
        GuiControl, Text, filePathLabel, %selectedFile%
    Return
        
    SaveLot2:
        lotCodeArray := getLotCodeList()
        
        if (selectedFile = "") {
            MsgBox 16, , Please select a text file!
            return
        }
        
        SplitPath selectedFile, fileName    ;Get the filename
        Loop % lotCodeArray.Length()
        {
            if (RegExMatch(fileName, lotCodeArray[A_Index]) > 0) {
                MsgBox 16, , Duplicate Lot Code`nPlease choose a different file!
                return
            }
        }
        
        fileNameNoEx := StrReplace(fileName, ".txt", "")
        if(RegExMatch(fileNameNoEx, "^(\d){10}$") = 0) {
            MsgBox 16, ERROR, Wrong Node File!`nPlease pick a file with this format: ##########.txt! (EX: 1234567890.txt)
            return
        }
        
        FileCopy, %selectedFile%, %remotePath%\Saved-Nodes\%fileName%
        Gui, 1: Default
        FileRead, fileContent, %selectedFile%
        GuiControl Text, editNode, %fileContent%
        Gui, adNew: Destroy
        updateLotCodeList()
    Return 
    
    adNewGuiEscape:
    adNewGuiClose:
        Gui, adNew: Destroy
    Return
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^q::
    For process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-winwaitEachPort.exe' ")
    Process, close, % process.ProcessId
    ExitApp
^t::
    runAll()
return
^w::
    Gui, xdot: Destroy
    writeAll()
return
#IfWinActive, PC3
^s::
    saveNodesToWrite()
#IfWinActive
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;Additional Label Functions;;;;;;;;;;;;;;;;;
;Launched whenever the user right-clicks on gui controls
GuiContextMenu:
    OnRightClick()
Return

;;;;;;;;;;;;;;;;TOOLBAR CREATIVITY AND FUNCTIONS;;;;;;;;;;;;;;;;
CreateEditNodeToolbar() {
    ImageList1 := IL_Create(3)
    IL_Add(ImageList1, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\folder-icon.ico")
    IL_Add(ImageList1, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\add_file-icon.ico")
    IL_Add(ImageList1, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\save-icon.ico")
    IL_Add(ImageList1, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\pen_with_note-icon.ico")

    Buttons = 
    (LTrim
        -
        Browse File
        Add New
        -
        Save Current Session
        Auto Generate Node ID
    )
    
    ToolbarCreate("OnEditNodeToolbar", Buttons, ImageList1, "Flat List Tooltips", , "x219 y20 w200 h23")
}

OnEditNodeToolbar(hWnd, Event, Text, Pos, Id) {
    If (Event != "Click") {
        Return
    } Else If (RegExMatch(Text, "Browse")) {
        IfWinNotExist, Select a NodeID text file...
            browseNode()
    } Else If (RegExMatch(Text, "Add")) {
        Gosub GetAddNew
    } Else If (RegExMatch(Text, "Save")) {
        saveNodesToWrite()
    } Else If (RegExMatch(Text, "Generate")) {
        Gosub GetAutoGenerate
    }
}

CbAutoComplete() {
	; CB_GETEDITSEL = 0x0140, CB_SETEDITSEL = 0x0142
	If ((GetKeyState("Delete", "P")) || (GetKeyState("Backspace", "P")))
		Return
	GuiControlGet, lHwnd, Hwnd, %A_GuiControl%
	SendMessage, 0x0140, 0, 0,, ahk_id %lHwnd%
	MakeShort(ErrorLevel, Start, End)
	GuiControlGet, CurContent,, %lHwnd%
	GuiControl, ChooseString, %A_GuiControl%, %CurContent%
	If (ErrorLevel) {
		ControlSetText,, %CurContent%, ahk_id %lHwnd%
		PostMessage, 0x0142, 0, MakeLong(Start, End),, ahk_id %lHwnd%
		Return
	}
	GuiControlGet, CurContent,, %lHwnd%
	PostMessage, 0x0142, 0, MakeLong(Start, StrLen(CurContent)),, ahk_id %lHwnd%
}

; Required for: CbAutoComplete()
MakeLong(LoWord, HiWord) {
	Return, (HiWord << 16) | (LoWord & 0xffff)
}

; Required for: CbAutoComplete()
MakeShort(Long, ByRef LoWord, ByRef HiWord) {
	LoWord := Long & 0xffff, HiWord := Long >> 16
}

;;;;;;;;;;;;;;;;NOT-FOR-USER HOT KEYS;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#^!+0::
    index := startedIndex
    Loop, %totalPort%
    {
        mainPort := xdotProperties[index].mainPort
        ctrlVar := xdotProperties[index].ctrlVar
        IfWinExist, PORT %mainPort% FAILURE
        {
            changeXdotBttnIcon(ctrlVar, "BAD")
        }
        index++
    }
Return

#^!+9::
    GuiControlGet, isRunReprogChecked, , reproGPortRadio
    index := startedIndex
    Loop, %totalPort%
    {
        mainPort := xdotProperties[index].mainPort
        ctrlVar := xdotProperties[index].ctrlVar
        IfWinExist, PORT %mainPort% PASSED
        {
            if (isRunReprogChecked = 1 && isReprogram) {
                changeXdotBttnIcon(ctrlVar, "GOOD", "PROGRAMMING")
            } else {
                changeXdotBttnIcon(ctrlVar, "GOOD")
            }
        }
        index++
    }
Return

#^!+8::
    index := startedIndex
    Loop, %totalPort%
    {
        mainPort := xdotProperties[index].mainPort
        ctrlVar := xdotProperties[index].ctrlVar
        IfWinExist, PORT %mainPort% ERROR
        {
            changeXdotBttnIcon(ctrlVar, "ERROR")
        }
        index++
    }
Return