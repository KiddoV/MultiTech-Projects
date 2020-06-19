/*
    
*/
;=======================================================================================;
SetTitleMatchMode, RegEx
FileEncoding, UTF-8
;;;;;;;;;;Installs necessary files;;;;;;;;;;
IfNotExist C:\V-Projects\YCD-Auto-Generator\Templates
    FileCreateDir C:\V-Projects\YCD-Auto-Generator\Templates
IfNotExist C:\V-Projects\YCD-Auto-Generator\Data
    FileCreateDir C:\V-Projects\YCD-Auto-Generator\Data
    
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TXT-Files\TemplateYCD.txt, C:\V-Projects\YCD-Auto-Generator\Templates\TemplateYCD.txt, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TXT-Files\omit_list.dat, C:\V-Projects\YCD-Auto-Generator\Data\omit_list.dat, 1
;=======================================================================================;
;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\tf.ahk
;=======================================================================================;
;;;Main Gui
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global ignoreOmitRefID := "SPJ"
Global ignoreRefID := "FID"
Global ignorePN := "01020155L|01050200L|01051366L|01051372L|01053695L|01053700L|01054101L|01055309L|01055720L|01055730L|01056392L|01058017L|01058018L|01058023L|01058024L|01058047L|01058248L|01059010L|01059015L|01059115L"

;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, MainG: Add, GroupBox, hWndhGrpbox xm+0 ym+0 w440 h460 Section,
Gui, MainG: Add, Button, xs+10 ys+15 gGetAddDataGui, Add Data
Gui, MainG: Add, Tab3, hWndhTab xs+10 ys+40 w425 h405 vDataTab -Wrap,
Gui, MainG: Tab

Gui, MainG: Add, GroupBox, xm+0 ym+460 w440 h70 Section,
Gui, MainG: Add, Text, xs+10 ys+20, Blank Board ID:
Gui, MainG: Add, Text, xs+10 ys+40, ECO:

Gui, MainG: Add, Edit, xs+100 ys+16 h18 vBBoardID
Gui, MainG: Add, Edit, xs+100 ys+36 h18 vEcoNum

Gui, MainG: Add, Button, x195 y540 h30 gGenerateYCD, GENERATE
;;;Functions to run BEFORE main gui is started;;;
getOmitListData()
Gui, MainG: Show, , YCD Auto Generator

;;;Functions to run AFTER main gui is started;;;


;;Fix bug where Groupbox lay over Tabs
SendMessage 0xB, 0, 0,, ahk_id %hGrpbox% ; WM_SETREDRAW
WinSet Redraw,, ahk_id %hTab%
DllCall("SetWindowPos", "Ptr", hTab, "Ptr", 0, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "UInt", 0x3)

Return      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MainGGuiClose:
    ExitApp
Return
;=======================================================================================;    
;;;;;;;;;;;;;;;;;;MAIN FUNCTIONs;;;;;;;;;;;;;;;;;; 
GetAddDataGui() {
    ShowAddDataGui()
}

GenerateYCD() {
    Global      ;Access global vars

    justCreatedFilesArr := []
    blankLine := ""
    
    GuiControlGet, bBoardID, , BBoardID
    GuiControlGet, ecoNum, , EcoNum
    
    FileSelectFolder, selectedFolder, , 3
    if (selectedFolder = "")
        return
    
    ;Create YCD files based on how many 7 level PCB
    Loop, % listTabArr.Length()
    {
        RegExMatch(listTabArr[A_Index], "^([0-9]){8}+L", 7LPcb)
        RegExMatch(listTabArr[A_Index], "([A-Z]|[0-9]){3}$", eclNum)
        ycdTopFilePath = %selectedFolder%\%7LPcb%_%eclNum%_TOP.ycd
        ycdBotFilePath = %selectedFolder%\%7LPcb%_%eclNum%_BOT.ycd
        FileCopy, C:\V-Projects\YCD-Auto-Generator\Templates\TemplateYCD.txt, %ycdTopFilePath%, 1
        FileCopy, C:\V-Projects\YCD-Auto-Generator\Templates\TemplateYCD.txt, %ycdBotFilePath%, 1
        justCreatedFilesArr.Push(ycdTopFilePath)
        justCreatedFilesArr.Push(ycdBotFilePath)
    }
    
    ;Modify YCD files (Loop each file just created)
    Loop, 110
        blankLine .= A_Space
    tabCountIndexTop := 1
    tabCountIndexBot := 1
    Loop, % justCreatedFilesArr.Length()
    {
        ycdFilePath := "!" . justCreatedFilesArr[A_Index]
        ;Modify TOP files
        if (RegExMatch(ycdFilePath, "TOP") > 0) {
            TF_Replace(ycdFilePath, "ycdRecipeName", BBoardID . "_" . EclNum . "_INS_" EcoNum)
            TF_Replace(ycdFilePath, "ycdIsXInvert", "0")
            TF_Replace(ycdFilePath, "ycdIsTopSide", "1")
            ;Add parts
            startedLine := 19
            Loop, %mainPartTotal%
            {
                if ((tabArray%tabCountIndexTop%[A_Index].layer = "TopLayer") && (tabArray%tabCountIndexTop%[A_Index].partNum != "0") && (RegExMatch(tabArray%tabCountIndexTop%[A_Index].refID, ignoreRefID) = 0) && (RegExMatch(tabArray%tabCountIndexTop%[A_Index].partNum, ignorePN) = 0)) {
                    if (tabArray%tabCountIndexTop%[A_Index].status = "OMIT" && RegExMatch(tabArray%tabCountIndexTop%[A_Index].refID, ignoreOmitRefID) = 0) {
                        TF_InsertLine(ycdFilePath, startedLine, startedLine, tabArray%tabCountIndexTop%[A_Index].refID . "_OMIT" . blankLine)
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 19, tabArray%tabCountIndexTop%[A_Index].omitPN, 1)
                    }
                    else {
                        TF_InsertLine(ycdFilePath, startedLine, startedLine, tabArray%tabCountIndexTop%[A_Index].refID . blankLine)
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 19, tabArray%tabCountIndexTop%[A_Index].partNum, 1)
                        
                    }
                    TF_ColPut(ycdFilePath, startedLine, startedLine, 61, RemoveTrailingZeros(tabArray%tabCountIndexTop%[A_Index].xPos), 1)
                    TF_ColPut(ycdFilePath, startedLine, startedLine, 75, RemoveTrailingZeros(tabArray%tabCountIndexTop%[A_Index].yPos), 1)
                    if (tabArray%tabCountIndexTop%[A_Index].rotation = "360")
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 86, "0", 1)
                    else
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 86, tabArray%tabCountIndexTop%[A_Index].rotation, 1)
                    if (tabArray%tabCountIndexTop%[A_Index].status = "OMIT" && RegExMatch(tabArray%tabCountIndexTop%[A_Index].refID, ignoreOmitRefID) = 0)
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 96, tabArray%tabCountIndexTop%[A_Index].omitPkg, 1)
                    else
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 96, tabArray%tabCountIndexTop%[A_Index].package, 1)
                    TF_ColPut(ycdFilePath, startedLine, startedLine, 138, "----", 1)
                    startedLine++
                }
            }
            tabCountIndexTop++
        }
        
        ;Modify BOT files
        if (RegExMatch(ycdFilePath, "BOT") > 0) {
            TF_Replace(ycdFilePath, "ycdRecipeName", BBoardID . "_" . EclNum . "_INS_" EcoNum)
            TF_Replace(ycdFilePath, "ycdIsXInvert", "1")
            TF_Replace(ycdFilePath, "ycdIsTopSide", "0")
            ;Add parts
            startedLine := 19
            Loop, %mainPartTotal%
            {
                if ((tabArray%tabCountIndexBot%[A_Index].layer = "BottomLayer") && (tabArray%tabCountIndexBot%[A_Index].partNum != "0") && (RegExMatch(tabArray%tabCountIndexTop%[A_Index].refID, ignoreRefID) = 0) && (RegExMatch(tabArray%tabCountIndexTop%[A_Index].partNum, ignorePN) = 0)) {
                    if (tabArray%tabCountIndexBot%[A_Index].status = "OMIT" && RegExMatch(tabArray%tabCountIndexBot%[A_Index].refID, ignoreOmitRefID) = 0) {
                        TF_InsertLine(ycdFilePath, startedLine, startedLine, tabArray%tabCountIndexBot%[A_Index].refID . "_OMIT" . blankLine)
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 19, tabArray%tabCountIndexBot%[A_Index].omitPN, 1)
                    }
                    else {
                        TF_InsertLine(ycdFilePath, startedLine, startedLine, tabArray%tabCountIndexBot%[A_Index].refID . blankLine)
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 19, tabArray%tabCountIndexBot%[A_Index].partNum, 1)
                        
                    }
                    TF_ColPut(ycdFilePath, startedLine, startedLine, 61, RemoveTrailingZeros(tabArray%tabCountIndexBot%[A_Index].xPos), 1)
                    TF_ColPut(ycdFilePath, startedLine, startedLine, 75, RemoveTrailingZeros(tabArray%tabCountIndexBot%[A_Index].yPos), 1)
                    if (tabArray%tabCountIndexBot%[A_Index].rotation = "360")
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 86, "0", 1)
                    else
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 86, tabArray%tabCountIndexBot%[A_Index].rotation, 1)
                    if (tabArray%tabCountIndexBot%[A_Index].status = "OMIT" && RegExMatch(tabArray%tabCountIndexBot%[A_Index].refID, ignoreOmitRefID) = 0)
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 96, tabArray%tabCountIndexBot%[A_Index].omitPkg, 1)
                    else
                        TF_ColPut(ycdFilePath, startedLine, startedLine, 96, tabArray%tabCountIndexBot%[A_Index].package, 1)
                    TF_ColPut(ycdFilePath, startedLine, startedLine, 138, "----", 1)
                    startedLine++
                }
            }
            tabCountIndexBot++
        }
        ;endedLine := TF_Find(ycdFilePath, 20, "", "PartListEnd", ReturnFirst = 1, ReturnText = 0)
        endedLine:=TF_CountLines(ycdFilePath)
        ;Sort lines
        TF_Sort(ycdFilePath, "F SortStrCmpLogical", 19, endedLine - 1)
    }
    
    ;;DONE!
    OnMessage(0x44, "CheckIcon") ;Add icon
    MsgBox 0x80, DONE, Finished auto generate *.ycd files!!!
    OnMessage(0x44, "") ;Clear icon
}

;=======================================================================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;;;
ShowAddDataGui() {
    Global
    Gui, AddDataG: Destroy
    posPrev1 := 1    ;just for not-showing line number bug
    posPrev2 := 1    ;just for not-showing line number bug
    
    Gui, AddDataG: Default
    Gui, AddDataG: +ToolWindow +hWndhAddDataGWnd
    Gui, AddDataG: Add, Text, x10 y10, Paste EBOM data here!
    Gui, AddDataG: Add, Edit, xm+34 ym+25 w350 r30 Section +HScroll hWndheditField1 veditField1
    Gui, AddDataG: Add, Edit, xs-34 ys+0 w35 r31.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField1
    Gui, AddDataG: Add, Text, x455 y10, Paste INS data here!
    Gui, AddDataG: Add, Edit, xm+479 ym+25 w350 r30 Section +HScroll hWndheditField2 veditField2
    Gui, AddDataG: Add, Edit, xs-34 ys+0 w35 r31.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField2
    
    Gui, AddDataG: Add, Button, x400 y415 w50 h30 gMergeData, Merge
    
    Gui, AddDataG: Add, Checkbox, x10 vskipDataCheckBox, Skip showing data 
    
    Gui, AddDataG: Show, , Get Part Data
    
    #Persistent
    SetTimer, DrawLineNum1, 1
    SetTimer, DrawLineNum2, 1
    Return      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    DrawLineNum1:
        pos1 := DllCall("GetScrollPos", "UInt", heditField1, "Int", 1)
        IfEqual, pos1, % posPrev1, return                         ;if nothing new
        posPrev1 := pos1
        drawLineNumbers(pos1, "lineNumEditField1", "AddDataG")    ;draw line numbers
    Return
    
    DrawLineNum2:
    pos2 := DllCall("GetScrollPos", "UInt", heditField2, "Int", 1)
    IfEqual, pos2, % posPrev2, return                             ;if nothing new
    posPrev2 := pos2
    drawLineNumbers(pos2, "lineNumEditField2", "AddDataG")        ;draw line numbers
    Return
    
    AddDataGGuiEscape:
    AddDataGGuiClose:   
        Gui, AddDataG: Destroy
    Return
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MergeData:
        GuiControlGet, editFieldVar1, , editField1
        GuiControlGet, editFieldVar2, , editField2
        GuiControlGet, isSkipShowData, , skipDataCheckBox
        
        if (editFieldVar1 = "" || editFieldVar2 = "") {
            MsgBox 4112, ERROR, Field 1 or Field 2 is empty!
            return
        }
        if (!validateEBOMData(editFieldVar1)) {
            MsgBox 4112, ERROR, Invalid EBOM data! Please retry!
            return
        }
        if (!validateINSData(editFieldVar2)) {
            MsgBox 4112, ERROR, Invalid INS data! Please retry!
            return
        }
        
        Gui, AddDataG: Destroy
        generateDataToView(editFieldVar1, editFieldVar2, isSkipShowData)
        OnMessage(0x44, "CheckIcon") ;Add icon
        MsgBox 0x80, DONE, Finished merging data!!!!
        OnMessage(0x44, "") ;Clear icon
    Return
}

;=======================================================================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL FUNCTIONs;;;;;;;;;;;;;;;;;;
drawLineNumbers(firstLine = "", ctrlVar := "", guiName := "") {
    Local lines
    Static prevFirstLine
    prevFirstLine := firstLine != "" ? firstLine : prevFirstLine
    firstLine := prevFirstLine
    loop, 30
    {
        lines .= ++firstLine . "`n"
    }
    
    Gui, %guiName%: Default
    GuiControl,, %ctrlVar%, % lines
}

validateEBOMData(data) {
    Loop, Parse, data, `t`n
    {
        if (A_Index = 3) {
            if (RegExMatch(A_LoopField, "^([0-9]){8}+L+([A-Z]|[0-9]){3}$") > 0 && A_LoopField != "")
                return True
        }
    }
    
    return False
}

validateINSData(data) {
    Loop, Parse, data, `t`n
    {
        if (A_Index = 14) {
            if (RegExMatch(A_LoopField, "^([A-Z]){1,}+\d{1,}") > 0)
                return True
        }
    }
    
    return False
}

generateDataToView(dataField1, dataField2, isSkipShowData) {
    Global
    Gui, MainG: Default
    
    ;Create tabs based on EBOM field
    listTabArr := []
    listTabNames := ""
    totalEBOMLines := 0
    Loop, Parse, dataField1, `n
        totalEBOMLines++
    progrStrView := "...."
    Loop, Parse, dataField1, `n
    {
        ;progressCount := A_Index * 100 / totalEBOMLines
        ;Progress, %progressCount%, %progrStrView%, Collecting EBOM data..., YCD Auto Generator
        partTotal++
        if (A_Index = 1) {
            Loop, Parse, A_LoopField, `t`n
            {
                progrStrView := A_LoopField
                if (RegExMatch(A_LoopField, "^([0-9]){8}+L+([A-Z]|[0-9]){3}$") > 0) {
                    tabCount++
                    listTabNames .= "|" . A_LoopField       ;Format: 70006750L000
                    listTabArr.Push(A_LoopField)
                }
            }
        }
    }
    ;Progress, Off
    GuiControl, , DataTab, %listTabNames%
    Sleep 100
    
    ;;;;Create array data for ListView(s)
    ;;Create arrays and get data from INS field
    tabCountIndex := 1
    Loop, Parse, dataField2, `t`n
        totalINSLines++
    totalINSLinesAllBuild := 0
    DefineArray:
    tabArray%tabCountIndex% := [{}]
    Loop, Parse, dataField2, `t`n
    {
        totalINSLinesAllBuild++
        if (A_LoopField = "")   ;Skip blank line
            Continue
        if (A_Index >= 14) {     ;Skip all the intro, go from line 14 (usually is) which has data...
            mainPartCount := A_Index - 13    ;Count how many line in Info data
            tabArray%tabCountIndex%[mainPartCount] := {}    ;Create object inside array
            strLine := RegExReplace(A_LoopField, "\s+", "`,")
            Loop, Parse, strLine, `,`n
            {
                ;progressCount := totalINSLinesAllBuild * 100 / (totalINSLines * tabCount)
                ;Progress, %progressCount%, Build: %tabCountIndex% -- Part: %mainPartCount% -- RefID: %refID%, Collecting INS data..., YCD Auto Generator
                if (A_Index = 1)
                    refID := A_LoopField
                    tabArray%tabCountIndex%[mainPartCount].refID := A_LoopField
                if (A_Index = 2) {
                    pn := A_LoopField
                    tabArray%tabCountIndex%[mainPartCount].partNum := A_LoopField
                }
                if (A_Index = 3)
                    tabArray%tabCountIndex%[mainPartCount].layer := A_LoopField
                if (A_Index = 4) {
                    pkg := A_LoopField
                    tabArray%tabCountIndex%[mainPartCount].package := A_LoopField
                }
                if (A_Index = 5)
                    tabArray%tabCountIndex%[mainPartCount].xPos := A_LoopField
                if (A_Index = 6)
                    tabArray%tabCountIndex%[mainPartCount].yPos := A_LoopField
                if (A_Index = 7)
                    tabArray%tabCountIndex%[mainPartCount].rotation := A_LoopField
                
                ;Add omit data
                Loop, % omitListDatArr.Length()
                {
                    if (omitListDatArr[A_Index].origPkg = pkg || omitListDatArr[A_Index].origPN = pn) {
                        tabArray%tabCountIndex%[mainPartCount].omitPN := omitListDatArr[A_Index].omitPN
                        tabArray%tabCountIndex%[mainPartCount].omitPkg := omitListDatArr[A_Index].omitPkg
                        Break
                    } 
                    else {
                        tabArray%tabCountIndex%[mainPartCount].omitPN := "OMIT_CATCH"
                        tabArray%tabCountIndex%[mainPartCount].omitPkg := pkg
                    }
                }
            }
        }
    }
    if (tabCountIndex < tabCount) {
        tabCountIndex++
        goto DefineArray
    }
    ;Progress, Off
    mainPartTotal := mainPartCount  ; At this point after loop, mainPartCount is the total of line count
    
    ;;After arrays are defined and data from Info field are stored in arrays, get data from EBOM field
    Loop, Parse, dataField1, `n
    {
        if (A_LoopField = "")
            Continue
        if (A_Index > 1)
            ebomPartTotal++
    }
    
    tabCountIndex := 1
    totalEBOMLineAllBuild := 0
    NextArray:
    statusIndex := tabCountIndex + 2    ; + 2 to skip refID and P/N
    Loop, Parse, dataField1, `n
    {
        if (A_Index > 1) {      ;Skip the first line cuz it's the titles
            partCount := A_Index - 1
            Loop, Parse, A_LoopField, `t`n
            {
                if (A_Index = 1)
                    comparedPartID := A_LoopField
                if (A_Index = statusIndex)
                    partStatus := A_LoopField        
            }
            Loop, %ebomPartTotal%
            {
                ;totalEBOMLineAllBuild++
                ;progressCount := totalEBOMLineAllBuild * 100 / (ebomPartTotal * (totalEBOMLines * tabCount))
                ;Progress, %progressCount%, Build: %tabCountIndex% -- RefID: %comparedPartID% -- Status: %partStatus%, Merging EBOM & INS data..., YCD Auto Generator
                if (tabArray%tabCountIndex%[A_Index].refID = comparedPartID) {
                    tabArray%tabCountIndex%[A_Index].status := partStatus
                    Break
                }
            }

        }
    }
    if (tabCountIndex < tabCount) {
        tabCountIndex++
        goto NextArray
    }
    ;Progress, Off
    
    ;Create ListView(s) based on how many tabs had created
    mainPartTotalAllBuild := 0
    Loop, %tabCount%
    {
        tabCountIndex := A_Index    ;Count how many tabs (How many parts)
        Gui, MainG: Tab, %A_Index%
        GuiControl, Choose, DataTab, |%A_Index%
        if (isSkipShowData)
            Continue
        tabName := listTabArr[A_Index]
        Gui, MainG: Add, ListView, r20 w400 Grid vPartDataListView%A_Index%, RefID|Part Number|Status|Layer|X-Pos|Y-Pos|Rotation|Package|Omit Package|Omit Part Number
        Loop, %mainPartTotal%
        {
            ;mainPartTotalAllBuild++
            ;progressCount := mainPartTotalAllBuild * 100 / (mainPartTotal * tabCount)
            ;Progress, %progressCount%, BuildID: %tabName% -- Row#: %A_Index%, Displaying Data..., YCD Auto Generator
            ;Add data to each ListView
            LV_Add("", tabArray%tabCountIndex%[A_Index].refID, tabArray%tabCountIndex%[A_Index].partNum, tabArray%tabCountIndex%[A_Index].status, tabArray%tabCountIndex%[A_Index].layer, tabArray%tabCountIndex%[A_Index].xPos, tabArray%tabCountIndex%[A_Index].yPos, tabArray%tabCountIndex%[A_Index].rotation, tabArray%tabCountIndex%[A_Index].package,tabArray%tabCountIndex%[A_Index].omitPkg, tabArray%tabCountIndex%[A_Index].omitPN)
            LV_ModifyCol( , Auto)
        }
    }
    ;Progress, Off
}

getOmitListData() {
    Global
    omitListDatArr := [{}]
    Local omitPartNum := 1
    Loop, Read, C:\V-Projects\YCD-Auto-Generator\Data\omit_list.dat
    {
        if (A_LoopReadLine = "" || RegExMatch(A_LoopReadLine, "##") > 0)
            Continue
            
        omitListDatArr[omitPartNum] := {}
        Loop, Parse, A_LoopReadLine, `,
        {
            if (A_Index = 1)
                omitListDatArr[omitPartNum].omitPN := A_LoopField
            if (A_Index = 2)
                omitListDatArr[omitPartNum].omitPkg := A_LoopField
            if (A_Index = 3)
                omitListDatArr[omitPartNum].origPkg := A_LoopField
            if (A_Index = 4)
                omitListDatArr[omitPartNum].origPN := A_LoopField
        }
        omitPartNum++
    }
}

;;;;;;;;;;;;;;;;;;;;;;;
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

RemoveTrailingZeros(number) {
   Loop % StrLen(number) {
      StringTrimRight n, number, 1
      IfNotEqual n,%number%, Return number
      number = %n%
   }
}

;;Function for Sort
SortStrCmpLogical(vTextA, vTextB, vOffset) ;for use with AHK's Sort command
{
	local
	vRet := DllCall("shlwapi\StrCmpLogicalW", "WStr",vTextA, "WStr",vTextB)
	return vRet ? vRet : -vOffset
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;HOT KEYs;;;;;;;;;;;;;;;;;;
^q::
    ExitApp
return
