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
    
FileInstall C:\MultiTech-Projects\TXT-Files\TemplateYCD.txt, C:\V-Projects\YCD-Auto-Generator\Templates\TemplateYCD.txt, 1
FileInstall C:\MultiTech-Projects\TXT-Files\omit_list.dat, C:\V-Projects\YCD-Auto-Generator\Data\omit_list.dat, 1
;=======================================================================================;
;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\tf.ahk
;=======================================================================================;
;;;Main Gui
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global ignoreOmitRefID := "SPJ"
Global ignoreRefID := "FID|PCB1|MT|TP|ASM|TH|U99_"
Global ignorePN := "01020155L|01050200L|01051366L|01051372L|01053695L|01053700L|01054101L|01055309L|01055720L|01055730L|01056392L|01058017L|01058018L|01058023L|01058024L|01058047L|01058248L|01059010L|01059015L|01059115L|01051361L|01054103L|01058053L|01059002L|01051005L|01058002L|01056807L|01055218L|01300710L|01300720L|01300730L|01055745L|01200242L|01050022L"
;;Deleted 01050405L
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, MainG: Add, GroupBox, hWndhGrpbox xm+0 ym+0 w440 h460 Section,
Gui, MainG: Add, Button, xs+10 ys+15 gGetAddDataGui, Add Data
Gui, MainG: Add, Tab3, hWndhTab xs+10 ys+40 w425 h405 vDataTab -Wrap,
Gui, MainG: Tab

Gui, MainG: Add, GroupBox, xm+0 ym+460 w440 h85 Section,
Gui, MainG: Add, Text, xs+10 ys+20, Blank Board ID:
Gui, MainG: Add, Text, xs+10 ys+40, ECO:
Gui, MainG: Add, Text, xs+250 ys+20, TOP Board Rotation:
Gui, MainG: Add, Text, xs+250 ys+40, BOT Board Rotation:

Gui, MainG: Add, Edit, xs+100 ys+16 h18 vBBoardID +Limit9
Gui, MainG: Add, Edit, xs+100 ys+36 h18 vEcoNum +Limit5
Gui, MainG: Add, Edit, xs+360 ys+16 h18 w60 vTopRtn +Number +Limit3
Gui, MainG: Add, Edit, xs+360 ys+36 h18 w60 vBotRtn +Number +Limit3

Gui, MainG: Add, CheckBox, xs+10 ys+65 vIsGenBB, Also generate the build board YCDs

Gui, MainG: Add, Button, x195 y560 h30 gGenerateYCD, GENERATE
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
    GuiControlGet, topRtn, , TopRtn
    GuiControlGet, botRtn, , BotRtn
    GuiControlGet, isGenBB, , IsGenBB
    
    if (topRtn = "" || botRtn = "" || bBoardID = "" || ecoNum = "") {
        MsgBox, 16, ERROR, Please fill out all required field!!!
        return
    }
    
    if (listTabArr.Length() = "") {
        MsgBox, 16, ERROR, No data to generate!!!!`nPlease add!!
        return
    }
    
    FileSelectFolder, selectedFolder, , 3
    if (selectedFolder = "")
        return
    
    ;Create YCD files based on how many 7 level PCB also included 1st level if checked
    Loop, % isGenBB ? listTabArr.Length() + 1 : listTabArr.Length()
    {
        if (A_Index < listTabArr.Length() + 1) {
            RegExMatch(listTabArr[A_Index], "^([0-9]){8}+L", 7LPcb)
            RegExMatch(listTabArr[A_Index], "([A-Z]|[0-9]){3}$", eclNum)
            RegExMatch(eclNum, "^([A-Z]|[0-9]){1}", eclChar)
            ycdTopFilePath = %selectedFolder%\%7LPcb%_%eclNum%_TOP.ycd
            ycdBotFilePath = %selectedFolder%\%7LPcb%_%eclNum%_BOT.ycd
            FileCopy, C:\V-Projects\YCD-Auto-Generator\Templates\TemplateYCD.txt, %ycdTopFilePath%, 1
            FileCopy, C:\V-Projects\YCD-Auto-Generator\Templates\TemplateYCD.txt, %ycdBotFilePath%, 1
            justCreatedFilesArr.Push(ycdTopFilePath)
            justCreatedFilesArr.Push(ycdBotFilePath)
        }
        
        if (isGenBB && A_Index > listTabArr.Length()) {
            ycdTopFilePath = %selectedFolder%\%bBoardID%_%eclChar%_%ecoNum%_TOP.ycd
            ycdBotFilePath = %selectedFolder%\%bBoardID%_%eclChar%_%ecoNum%_BOT.ycd
            FileCopy, C:\V-Projects\YCD-Auto-Generator\Templates\TemplateYCD.txt, %ycdTopFilePath%, 1
            FileCopy, C:\V-Projects\YCD-Auto-Generator\Templates\TemplateYCD.txt, %ycdBotFilePath%, 1
            justCreatedFilesArr.Push(ycdTopFilePath)
            justCreatedFilesArr.Push(ycdBotFilePath)
        }
    }
    ;Modify YCD files (Loop each file just created)
    Loop, 110
        blankLine .= A_Space
    tabCountIndexTop := 1
    tabCountIndexBot := 1
    totalYCDFile := justCreatedFilesArr.Length()
    Loop, % totalYCDFile
    {   
        ycdFilePath := "!" . justCreatedFilesArr[A_Index]
        
        SplitPath, ycdFilePath, ycdFileName
        progressCount := A_Index * 100 / justCreatedFilesArr.Length()
        Progress, %progressCount%, File: .../%ycdFileName% `n File Number %A_Index%/%totalYCDFile%, Generating YCD Files..., YCD Auto Generator
        
        ;Modify TOP files
        if (RegExMatch(ycdFilePath, "TOP") > 0) {
            TF_Replace(ycdFilePath, "ycdRecipeName", bBoardID . "_" . eclChar . "_INS_" ecoNum)
            TF_Replace(ycdFilePath, "ycdIsXInvert", "0")
            TF_Replace(ycdFilePath, "ycdIsTopSide", "1")
            TF_Replace(ycdFilePath, "ycdBoardRtn", topRtn)
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
            
            ;Generate data for blank board ycd!!!
            if (isGenBB && RegExMatch(ycdFileName, bBoardID) > 0) {
                fileList := ""
                mergeFile := ""
                Loop, % totalYCDFile
                {
                    if (RegExMatch(justCreatedFilesArr[A_Index], "TOP") > 0 && RegExMatch(justCreatedFilesArr[A_Index], bBoardID) > 0)
                        mergeFile := justCreatedFilesArr[A_Index]
                    if (RegExMatch(justCreatedFilesArr[A_Index], "TOP") = 0 || RegExMatch(justCreatedFilesArr[A_Index], bBoardID) > 0)
                        Continue
                    fileList .= justCreatedFilesArr[A_Index] "`n"
                }
                TF_Merge(fileList, , "!" . mergeFile)
                TF_RemoveDuplicateLines("!" . mergeFile, , , 0, True)
            }
        }
        
        ;Modify BOT files
        if (RegExMatch(ycdFilePath, "BOT") > 0) {
            TF_Replace(ycdFilePath, "ycdRecipeName", bBoardID . "_" . eclChar . "_INS_" ecoNum)
            TF_Replace(ycdFilePath, "ycdIsXInvert", "1")
            TF_Replace(ycdFilePath, "ycdIsTopSide", "0")
            TF_Replace(ycdFilePath, "ycdBoardRtn", botRtn)
            ;Add parts
            startedLine := 19
            Loop, %mainPartTotal%
            {
                if ((tabArray%tabCountIndexBot%[A_Index].layer = "BottomLayer") && (tabArray%tabCountIndexBot%[A_Index].partNum != "0") && (RegExMatch(tabArray%tabCountIndexBot%[A_Index].refID, ignoreRefID) = 0) && (RegExMatch(tabArray%tabCountIndexBot%[A_Index].partNum, ignorePN) = 0)) {
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
            
            ;Generate data for blank board ycd!!!
            if (isGenBB && RegExMatch(ycdFileName, bBoardID) > 0) {
                fileList := ""
                mergeFile := ""
                Loop, % totalYCDFile
                {
                    if (RegExMatch(justCreatedFilesArr[A_Index], "BOT") > 0 && RegExMatch(justCreatedFilesArr[A_Index], bBoardID) > 0)
                        mergeFile := justCreatedFilesArr[A_Index]
                    if (RegExMatch(justCreatedFilesArr[A_Index], "BOT") = 0 || RegExMatch(justCreatedFilesArr[A_Index], bBoardID) > 0)
                        Continue
                    fileList .= justCreatedFilesArr[A_Index] "`n"
                }
                TF_Merge(fileList, , "!" . mergeFile)
                TF_RemoveDuplicateLines("!" . mergeFile, , , 0, True)
            }
        }
        ;endedLine := TF_Find(ycdFilePath, 20, "", "PartListEnd", ReturnFirst = 1, ReturnText = 0)
        endedLine := TF_CountLines(ycdFilePath)
        ;Sort lines
        TF_Sort(ycdFilePath, "F SortStrCmpLogical", 19, endedLine - 1)
        if (isGenBB && RegExMatch(ycdFileName, bBoardID) > 0) {
            lineToRemove := TF_Find(ycdFilePath, , , "PartListEnd", 1, 0)
            TF_RemoveLines(ycdFilePath, lineToRemove, lineToRemove)
            ycdFilePathNormal := StrReplace(ycdFilePath, "!", "")
            FileAppend, `n[PartListEnd], %ycdFilePathNormal%
        }
    }
    Progress, Off
    
    ;;DONE!
    OnMessage(0x44, "CheckIcon") ;Add icon
    MsgBox 0x80, DONE, Finished auto generate *.ycd files!!!
    OnMessage(0x44, "") ;Clear icon
    
    Run, %selectedFolder%
}

;=======================================================================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;;;
ShowAddDataGui() {
    Global
    Gui, AddDataG: Destroy
    posPrev1 := 1    ;just for not-showing line number bug
    posPrev2 := 1    ;just for not-showing line number bug
    
    Gui, AddDataG: Default
    Gui, AddDataG: -MinimizeBox -MaximizeBox +hWndhAddDataGWnd
    Gui, AddDataG: Add, Text, x10 y10, Paste EBOM data here!
    Gui, AddDataG: Add, Edit, xm+34 ym+25 w350 r30 Section +HScroll hWndheditField1 veditField1
    Gui, AddDataG: Add, Edit, xs-34 ys+0 w35 r31.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField1
    Gui, AddDataG: Add, Text, x455 y10, Paste INS data here!
    Gui, AddDataG: Add, Radio, x680 y10 vRadioNewFormat +Checked Group, New Format
    Gui, AddDataG: Add, Radio, x770 y10 vRadioOldFormat, Old Format
    Gui, AddDataG: Add, Edit, xm+479 ym+25 w350 r30 Section +HScroll hWndheditField2 veditField2
    Gui, AddDataG: Add, Edit, xs-34 ys+0 w35 r31.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField2
    
    Gui, AddDataG: Add, Button, x400 y415 w50 h30 gMergeData, Merge
    
    Gui, AddDataG: Add, Checkbox, x370 vskipDataCheckBox, Skip showing data
    
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
            if (RegExMatch(A_LoopField, "^([0-9]){8}+L+([A-Z]|[0-9]){3}$") = 0 && A_LoopField = "")
                return False
        }
    }
    
    return True
}

validateINSData(data) {
    Global
    GuiControlGet, isNewFormat, , RadioNewFormat
    GuiControlGet, isOldFormat, , RadioOldFormat
    
    if (isNewFormat = 1) {
        Loop, Parse, data, `t`n
        {
            if (A_Index = 1) {
                if (RegExMatch(A_LoopField, "Altium Designer Pick and Place Locations") = 0)
                    return False
            }
            
            if (A_Index = 14) {
                if (RegExMatch(A_LoopField, "^([A-Z]){1,}+\d{1,}") = 0)
                    return False
            }
        }
    }
    
    if (isOldFormat = 1) {
        Loop, Parse, data, `t`n
        {
            if (A_Index = 1) {
                if (RegExMatch(A_LoopField, "insertfile.txt") = 0)
                    return False
            }
            
            if (A_Index = 6) {
                if (RegExMatch(A_LoopField, "^([A-Z]){1,}+\d{1,}") = 0)
                    return False
            }
        }
    }
    
    return True
}

generateDataToView(dataField1, dataField2, isSkipShowData) {
    Global
    Gui, MainG: Default
    
    Loop, Parse, dataField1, `t`n
        totalEBOMLines++
    Loop, Parse, dataField2, `t`n
        totalINSLines++
    
    ;Create tabs based on EBOM field
    listTabArr := []
    listTabNames := ""
    Loop, Parse, dataField1, `n
    {
        partTotal++
        if (A_Index = 1) {
            Loop, Parse, A_LoopField, `t`n
            {
                if (RegExMatch(A_LoopField, "^([0-9]){8}+L+([A-Z]|[0-9]){3}$") > 0) {
                    tabCount++
                    listTabNames .= "|" . A_LoopField       ;Format: 70006750L000
                    listTabArr.Push(A_LoopField)
                }
            }
        }
    }
    GuiControl, , DataTab, %listTabNames%
    ;;;;Create array data for ListView(s)
    ;;Create arrays and get data from INS field
    tabCountIndex := 1
    DefineArray:
    tabName := listTabArr[tabCountIndex]
    progressCount := totalINSLinesAllBuild * 100 / (totalINSLines * (tabCount - 1))
    Progress, %progressCount%, Build %tabCountIndex%/%tabCount% is stored, Collecting data..., YCD Auto Generator
    tabArray%tabCountIndex% := [{}]
    Loop, Parse, dataField2, `t`n
    {
        totalINSLinesAllBuild++
        if (A_LoopField = "")   ;Skip blank line
            Continue
        ;;;;;Adding data with new format
        if (isNewFormat = 1) {
            if (A_Index >= 14) {     ;Skip all the intro, go from line 14 (usually is) which has data...
                mainPartCount := A_Index - 13    ;Count how many line in Info data
                tabArray%tabCountIndex%[mainPartCount] := {}    ;Create object inside array
                strLine := RegExReplace(A_LoopField, "\s+", "`,")
                Loop, Parse, strLine, `,`n
                {
                    if (A_Index = 1) {
                        refID := A_LoopField
                        tabArray%tabCountIndex%[mainPartCount].refID := A_LoopField
                    }
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
        
        ;;;;;Adding data with old format
        if (isOldFormat = 1) {
            if (A_Index >= 6) {
                mainPartCount := A_Index - 5    ;Count how many line in Info data
                tabArray%tabCountIndex%[mainPartCount] := {}    ;Create object inside array
                Loop, Parse, A_LoopField, `,`n
                {
                    if (A_Index = 1)
                        tabArray%tabCountIndex%[mainPartCount].refID := A_LoopField
                    if (A_Index = 2) {
                        pn := A_LoopField
                        tabArray%tabCountIndex%[mainPartCount].partNum := A_LoopField
                    }
                    if (A_Index = 3) {
                        pkg := A_LoopField
                        tabArray%tabCountIndex%[mainPartCount].package := A_LoopField
                    }
                    if (A_Index = 4)
                        tabArray%tabCountIndex%[mainPartCount].xPos := A_LoopField
                    if (A_Index = 5)
                        tabArray%tabCountIndex%[mainPartCount].yPos := A_LoopField
                    if (A_Index = 6)
                        tabArray%tabCountIndex%[mainPartCount].rotation := RemoveTrailingZeros(A_LoopField)
                    if (A_Index = 7) {
                        if (A_LoopField = "NO")
                            tabArray%tabCountIndex%[mainPartCount].layer := "TopLayer"
                        if (A_LoopField = "YES")
                            tabArray%tabCountIndex%[mainPartCount].layer := "BottomLayer"
                    }
                    
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
    }
    if (tabCountIndex < tabCount) {
        tabCountIndex++
        goto DefineArray
    }   
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
    NextArray:
    tabName := listTabArr[tabCountIndex]
    statusIndex := tabCountIndex + 2    ; + 2 to skip refID and P/N
    progressCount := tabCountIndex * 100 / (tabCount - 1)
    Progress, %progressCount%, BuildID: %tabName% -- %tabCountIndex%/%tabCount% Build, Merging EBOM & INS data..., YCD Auto Generator
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
                if (tabArray%tabCountIndex%[A_Index].refID = comparedPartID) {
                    tabArray%tabCountIndex%[A_Index].status := partStatus
                    if (partStatus != "" && partStatus != "OMIT" && partStatus != A_Space)
                        tabArray%tabCountIndex%[A_Index].partNum := partStatus
                    Break
                }
            }

        }
    }
    if (tabCountIndex < tabCount) {
        tabCountIndex++
        goto NextArray
    }
    
    ;Create ListView(s) based on how many tabs had created
    Loop, %tabCount%
    {
        tabCountIndex := A_Index    ;Count how many tabs (How many parts)
        Gui, MainG: Tab, %A_Index%
        GuiControl, Choose, DataTab, |%A_Index%
        if (isSkipShowData)
            Continue
        tabName := listTabArr[A_Index]
        Gui, MainG: Add, ListView, r20 w400 Grid vPartDataListView%A_Index% hWndhLV%A_Index%, RefID|Part Number|Status|Layer|X-Pos|Y-Pos|Rotation|Package|Omit Package|Omit Part Number
        hwndLVID := hLV%A_Index%
        Loop, %mainPartTotal%
        {
            mainPartTotalAllBuild++
            progressCount := mainPartTotalAllBuild * 100 / (mainPartTotal * tabCount)
            Progress, %progressCount%, Build: %tabCountIndex%/%tabCount% -- Row#: %A_Index%/%mainPartTotal%, Displaying Data..., YCD Auto Generator
            ;;;Add data to each ListView
            LV_Add("", tabArray%tabCountIndex%[A_Index].refID, tabArray%tabCountIndex%[A_Index].partNum, tabArray%tabCountIndex%[A_Index].status, tabArray%tabCountIndex%[A_Index].layer, tabArray%tabCountIndex%[A_Index].xPos, tabArray%tabCountIndex%[A_Index].yPos, tabArray%tabCountIndex%[A_Index].rotation, tabArray%tabCountIndex%[A_Index].package,tabArray%tabCountIndex%[A_Index].omitPkg, tabArray%tabCountIndex%[A_Index].omitPN)
            LV_ModifyCol( , Auto)
            SendMessage, 0x115, 7,,, ahk_id %hwndLVID%  ;WM_VSCROLL
        }
    }
    Progress, Off
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
