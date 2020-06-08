/*
    
*/
;=======================================================================================;
;;;Main Gui
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, MainG: Add, Button, x10 y5 gGetAddDataGui, Add Data

Gui, MainG: Add, Tab3, x10 y35 w425 h575 vDataTab -Wrap, 
;Gui, Tab, 1
;Gui, Add, ListView, r30 w400 Grid vPartDataListView, 

;Gui, Add, Edit, xm+34 ym+24 w350 r35 Section +HScroll hWndheditField1 veditField1
;Gui, Add, Edit, xs-34 ys+0 w35 r36.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField1

;Gui, Add, Edit, xm+479 ym+24 w350 r35 Section +HScroll hWndheditField2 veditField2
;Gui, Add, Edit, xs-34 ys+0 w35 r36.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField2

;;;Functions to run BEFORE main gui is started;;;

Gui, MainG: Show, , YCD Auto Generator

;;;Functions to run AFTER main gui is started;;;

;#Persistent
;SetTimer, DrawLineNum1, 1
;SetTimer, DrawLineNum2, 1
Return      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;DrawLineNum1:
    ;pos1 := DllCall("GetScrollPos", "UInt", heditField1, "Int", 1)
    ;IfEqual, pos1, % posPrev1, return                       ;if nothing new
    ;posPrev1 := pos1
    ;drawLineNumbers(pos1, "lineNumEditField1")                     ;draw line numbers
;Return

;DrawLineNum2:
    ;pos2 := DllCall("GetScrollPos", "UInt", heditField2, "Int", 1)
    ;IfEqual, pos2, % posPrev2, return                       ;if nothing new
    ;posPrev2 := pos2
    ;drawLineNumbers(pos2, "lineNumEditField2")                     ;draw line numbers
;Return

MainGGuiClose:
    ExitApp
Return
;=======================================================================================;    
;;;;;;;;;;;;;;;;;;MAIN FUNCTIONs;;;;;;;;;;;;;;;;;; 
GetAddDataGui() {
    ShowAddDataGui()
}

;=======================================================================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;;;
ShowAddDataGui() {
    Global
    Gui, AddDataG: Destroy
    posPrev1 := 1    ;just for not-showing line number bug
    posPrev2 := 1    ;just for not-showing line number bug
    
    Gui, AddDataG: Default
    Gui, AddDataG: +ToolWindow +AlwaysOnTop +hWndhAddDataGWnd
    Gui, AddDataG: Add, Text, x10 y10, Paste EBOM data here!
    Gui, AddDataG: Add, Edit, xm+34 ym+25 w350 r30 Section +HScroll hWndheditField1 veditField1
    Gui, AddDataG: Add, Edit, xs-34 ys+0 w35 r31.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField1
    Gui, AddDataG: Add, Text, x455 y10, Paste Part Design Information data here!
    Gui, AddDataG: Add, Edit, xm+479 ym+25 w350 r30 Section +HScroll hWndheditField2 veditField2
    Gui, AddDataG: Add, Edit, xs-34 ys+0 w35 r31.3 -VScroll -HScroll -Border Disabled Right vlineNumEditField2
    
    Gui, AddDataG: Add, Button, x400 y415 w50 h30 gSubmitData, Submit
    
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
    SubmitData:
        GuiControlGet, editFieldVar1, , editField1
        GuiControlGet, editFieldVar2, , editField2
        if (editFieldVar1 = "" || editFieldVar2 = "") {
            MsgBox 4112, ERROR, Field 1 or Field 2 is empty!
            return
        }
        if (!validateEBOMData(editFieldVar1)) {
            MsgBox 4112, ERROR, Invalid EBOM data! Please retry!
            return
        }
        if (!validateDesignInfoData(editFieldVar2)) {
            MsgBox 4112, ERROR, Invalid Part Design Infomation data! Please retry!
            return
        }
        
        Gui, AddDataG: Destroy
        generateDataToView(editFieldVar1, editFieldVar2)
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
            if (RegExMatch(A_LoopField, "^([0-9]){8}+L+([0-9]){3}$") > 0 && A_LoopField != "")
                return True
        }
    }
    
    return False
}

validateDesignInfoData(data) {
    Loop, Parse, data, `t`n
    {
        if (A_Index = 14) {
            if (RegExMatch(A_LoopField, "^([A-Z]){1,}+\d{1,}") > 0)
                return True
        }
    }
    
    return False
}

generateDataToView(dataField1, dataField2) {
    Global
    Gui, MainG: Default
    
    ;Create tabs
    listTabNames := ""
    Loop, Parse, dataField1, `n
    {
        if (A_Index = 1) {
            Loop, Parse, A_LoopField, `t`n
            {
                if (RegExMatch(A_LoopField, "^([0-9]){8}+L+([0-9]){3}$") > 0) {
                    tabCount++
                    listTabNames .= "|" . A_LoopField       ;Format: 70006750L000
                }
            }
        }
    }
    GuiControl, , DataTab, %listTabNames%
    Sleep 100
    
    ;Create data for ListView(s)
    tabCountIndex := 0
    Loop, Parse, dataField1, `n
    {
        if (A_Index > 1) {      ;Skip the first line
            partCount := A_Index - 1
            array%tabCountIndex% := [{}]
            MsgBox % tabCountIndex
            Loop, Parse, A_LoopField, `t`n
            {
                if (A_Index = 1)
                    array%tabCountIndex%[partCount].refID := A_LoopField
                if (A_Index = 2)
                    array%tabCountIndex%[partCount].partNum := A_LoopField
            }
        }
        if (tabCountIndex < tabCount)
            tabCountIndex++
    }
    MsgBox % array2[1].partNum
    ;Create ListView(s) based on how many tabs had created
    Loop, %tabCount%
    {
        Gui, MainG: Tab, %A_Index%
        Gui, MainG: Add, ListView, r30 w400 Grid vPartDataListView%A_Index%, RefID|Part Number|Status|Layer|X-Pos|Y-Pos|Rotation|Package
    }
    
    
}

;=======================================================================================;
;;;;;;;;;;;;;;;;;;HOT KEYs;;;;;;;;;;;;;;;;;;
^q::
    ExitApp
return

fakeData1 = 
(LTrim
Part Reference	<Core Design>	70006750L000	70006751L000
C1	04041101L	 	 
C2	04041101L	 	OMIT
C3	04041101L	 	OMIT
C4	04041101L	 	OMIT
C5	04041101L	 	OMIT
C6	04041101L	 	OMIT
C7	04041101L	 	OMIT
C8	04041101L	 	OMIT
C9	04041101L	 	 
C10	04041101L	 	OMIT
C11	04041101L	 	OMIT
C12	04041101L	 	OMIT
C13	04041101L	 	OMIT
C14	04041101L	 	OMIT
C15	04041101L	 	OMIT
C16	04041101L	 	OMIT
C17	04040033L	OMIT	OMIT
C18	04040033L	OMIT	OMIT
C19	04040033L	OMIT	OMIT
C20	04041101L	 	 
C21	04040033L	OMIT	OMIT
C22	04040033L	OMIT	OMIT
C23	03342550L	OMIT	OMIT
C24	04040033L	OMIT	OMIT
C25	04040033L	OMIT	OMIT
C26	04040033L	OMIT	OMIT
C27	04041101L	 	 
C28	04042100L	 	 
C29	03342222L	 	 
C30	03342222L	 	 
C31	04041101L	 	 
C32	04041101L	 	 
C33	04040033L	 	 
C34	04040033L	 	 
C35	04040010L	 	 
C36	04040010L	 	 
C37	04041101L	OMIT	OMIT
C38	04041101L	 	 
C39	04040033L	 	 
C40	04040033L	 	 
C41	04044101L	 	 
C42	04040033L	 	 
C43	04040033L	 	 
C44	04040100L	 	 
C45	04044101L	 	 
C46	04040033L	 	 
C47	04044101L	 	 
C48	04041101L	 	 
C49	04044101L	 	 
C50	03342550L	 	 
C51	03341045L	 	 
C52	04040010L	 	 
C53	04040033L	 	 
C54	04040220L	 	 
C55	03341045L	 	 
C56	04041101L	 	 
C57	03342222L	 	 
C58	03342222L	 	 
C59	03341045L	OMIT	OMIT
C60	04044101L	OMIT	OMIT
C61	03341045L	OMIT	OMIT
C62	03342222L	OMIT	OMIT
C63	04040033L	OMIT	OMIT
C64	04040033L	OMIT	OMIT
C65	04040033L	OMIT	OMIT
C66	04040033L	OMIT	OMIT
C67	04041101L	 	 
C68	04041101L	 	OMIT
C69	04041101L	 	OMIT
C70	04040033L	OMIT	OMIT
CR1	03440011L	 	 
CR2	03452250L	 	 
CR3	00800016L	 	 
FB1	03900039L	 	 
FID1	0	OMIT	OMIT
FID2	0	OMIT	OMIT
FID3	0	OMIT	OMIT
FID4	0	OMIT	OMIT
J1	NoPin1	OMIT	OMIT
J2	NoPin1	OMIT	OMIT
J3	NoPin1	OMIT	OMIT
J4	NoPin1	OMIT	OMIT
J5	NoPin1	OMIT	OMIT
J6	NoPin1	OMIT	OMIT
J7	NoPin1	OMIT	OMIT
J8	NoPin1	OMIT	OMIT
J9	NoPin1	OMIT	OMIT
J10	NoPin1	OMIT	OMIT
J11	NoPin1	OMIT	OMIT
J12	NoPin1	OMIT	OMIT
J13	NoPin1	OMIT	OMIT
J14	NoPin1	OMIT	OMIT
J15	NoPin1	OMIT	OMIT
J16	NoPin1	OMIT	OMIT
J17	NoPin1	OMIT	OMIT
J18	NoPin1	OMIT	OMIT
J19	NoPin1	OMIT	OMIT
J20	NoPin1	OMIT	OMIT
J21	NoPin1	OMIT	OMIT
J22	NoPin1	OMIT	OMIT
J23	NoPin1	OMIT	OMIT
J24	01058350L	 	 
J25	01058350L	OMIT	 
J26	01058350L	 	 
J27	01058350L	OMIT	 
J28	01058350L	OMIT	 
J29	NoPin1	OMIT	OMIT
J30	NoPin1	OMIT	OMIT
J31	NoPin1	OMIT	OMIT
J32	NoPin1	OMIT	OMIT
J33	01058350L	 	OMIT
J34	01058350L	 	OMIT
J35	01058350L	 	OMIT
J36	01058350L	 	OMIT
J37	01058350L	 	OMIT
J38	01058350L	 	OMIT
J39	01058350L	 	OMIT
J40	01058350L	 	OMIT
J41	01058350L	 	 
J42	NoPin1	OMIT	OMIT
J43	NoPin1	OMIT	OMIT
J44	NoPin1	OMIT	OMIT
J45	NoPin1	OMIT	OMIT
J46	NoPin1	OMIT	OMIT
J47	NoPin1	OMIT	OMIT
J48	NoPin1	OMIT	OMIT
J49	NoPin1	OMIT	OMIT
J50	NoPin1	OMIT	OMIT
J51	NoPin1	OMIT	OMIT
J52	NoPin1	OMIT	OMIT
J53	NoPin1	OMIT	OMIT
J54	NoPin1	OMIT	OMIT
J55	NoPin1	OMIT	OMIT
J56	NoPin1	OMIT	OMIT
J57	NoPin1	OMIT	OMIT
J58	01058350L	OMIT	 
J59	NoPin1	OMIT	OMIT
J60	NoPin1	OMIT	OMIT
J61	01058350L	 	 
J62	NoPin1	OMIT	OMIT
J63	01058350L	 	 
J64	NoPin1	OMIT	OMIT
J65	01058024L	OMIT	OMIT
J66	01051530L	 	 
J67	01051340L	 	 
J68	01051340L	 	 
J69	01051340L	 	 
J70	01058024L	OMIT	OMIT
JP1	CAD00126	OMIT	OMIT
JP2	01058017L	OMIT	OMIT
L1	03910001L	 	 
L2-1	03910233L	 	 
L2-2	03910231L	OMIT	OMIT
LED1	03900200L	 	 
MT1	0	OMIT	OMIT
MT2	0	OMIT	OMIT
MT3	0	OMIT	OMIT
NT1	0	OMIT	OMIT
PCB1	10002430L	 	 
Q1	03452810L	 	 
Q2	03452810L	 	 
R1	04030000L	OMIT	 
R2	04030022L	 	 
R3	04030022L	 	 
R4	04022470L	 	 
R5	04022470L	 	 
R6	04031470L	 	 
R7	04030000L	 	OMIT
R8	04030000L	 	OMIT
R9	04030000L	 	OMIT
R10	04030000L	 	OMIT
R11	04030000L	OMIT	OMIT
R12	04030000L	 	OMIT
R13	04030000L	 	OMIT
R14	04030000L	 	OMIT
R15	04030000L	OMIT	OMIT
R16	04030000L	OMIT	OMIT
R17	04022470L	 	OMIT
R18	04030000L	 	OMIT
R19	04030000L	OMIT	OMIT
R20	04030100L	 	 
R21	04022470L	 	 
R22	04030000L	OMIT	OMIT
R23	04031470L	 	 
R24	04031100L	 	 
R25	04022990L	 	 
R26	04030000L	 	 
R27	04030000L	 	 
R28	04031470L	 	 
R29	04022268L	 	 
R30	04022100L	 	 
R31	04033845L	 	 
R32	04023158L	 	 
R33	04022470L	 	 
R34	04022470L	 	 
R35	04022470L	 	 
R36	04031470L	 	 
R37	04031470L	OMIT	OMIT
R38	04031470L	OMIT	OMIT
R39	04030000L	 	 
R40	04030000L	 	 
R41	04033820L	OMIT	OMIT
R42	04023124L	OMIT	OMIT
R43	04022470L	 	OMIT
R44	04022470L	 	OMIT
R45	04022470L	 	OMIT
R46	04022470L	 	OMIT
R47	04022470L	 	OMIT
R48	04022470L	 	OMIT
R49	04022470L	 	OMIT
R50	04022470L	 	 
R51	04022470L	 	 
R52	04022470L	 	OMIT
REF1	SocketModemPinoutGuide	OMIT	OMIT
SPJ1	CAD00131	OMIT	OMIT
SPJ2	CAD00131	OMIT	OMIT
SPJ3	CAD00131	OMIT	OMIT
SPJ4	CAD00131	OMIT	OMIT
SPJ5	CAD00131	OMIT	OMIT
SPJ6	CAD00131	OMIT	OMIT
SPJ7	CAD00131	OMIT	OMIT
SPJ8	CAD00131	OMIT	OMIT
SPJ9	CAD00131	OMIT	OMIT
SPJ10	CAD00131	OMIT	OMIT
SPJ11	CAD00131	OMIT	OMIT
SPJ12	CAD00131	OMIT	OMIT
SPJ13	CAD00131	OMIT	OMIT
SPJ14	CAD00131	OMIT	OMIT
SPJ15	CAD00131	OMIT	OMIT
SPJ16	CAD00131	OMIT	OMIT
SPJ17	CAD00131	OMIT	OMIT
SPJ18	CAD00131	OMIT	OMIT
SPJ19	CAD00131	OMIT	OMIT
SPJ20	CAD00131	OMIT	OMIT
SPJ21	CAD00131	OMIT	OMIT
SPJ22	CAD00131	OMIT	OMIT
TP1	0	OMIT	OMIT
TP2	0	OMIT	OMIT
TP4	0	OMIT	OMIT
TP5	0	OMIT	OMIT
TP6	0	OMIT	OMIT
TP7	0	OMIT	OMIT
TP8	0	OMIT	OMIT
TP9	0	OMIT	OMIT
TP10	0	OMIT	OMIT
TP11	0	OMIT	OMIT
TP12	0	OMIT	OMIT
U1	00800049L	 	 
U2	00800049L	 	OMIT
U3	00800049L	 	OMIT
U4	00800049L	 	OMIT
U5	00800049L	 	OMIT
U6	00800049L	 	OMIT
U7	00800049L	 	OMIT
U8	00800049L	 	OMIT
U9	00674340L	 	 
U10	39125831L	39125830L	39125830L
U11	00690100L	OMIT	OMIT
U12	70002470LB	OMIT	OMIT
U13	00801022L	 	 
U14	00801026L	 	 
U15	00751726L	 	 
U16	00801046L	 	 
U17	00784390L	 	 
U18	00801047L	OMIT	OMIT
U19	00800049L	 	OMIT

)

fakeData2 = 
(LTrim
Altium Designer Pick and Place Locations
C:\projects\SVN\AltiumCheckouts\MTSMC-L4G1-Rev0\Outputs\Pick Place for MTSMC-L4G1.txt

========================================================================================================================
File Design Information:

Date:       14/05/20
Time:       12:50
Revision:   2858
Variant:    No variations
Units used: mil

Designator Comment    Layer       Footprint                       Center-X(mil) Center-Y(mil) Rotation 
SPJ22      CAD00131   TopLayer    SolderPasteJumper-A             2943.354      219.646       45       
SPJ21      CAD00131   TopLayer    SolderPasteJumper-A             3100.000      250.500       360      
J65        01058024L  TopLayer    CON-01058024L-B                 2766.400      305.000       360      
MT3        0          TopLayer    MH-128PT-220-SP-A               3040.000      110.000       90       
MT2        0          TopLayer    MH-128PT-220-SP-A               110.000       1265.000      270      
MT1        0          TopLayer    MH-128PT-220-SP-A               110.000       110.000       0        
L2-1       03910233L  TopLayer    SM-L-2-L7_6-W6_9-A              970.000       615.000       0        
SPJ20      CAD00131   BottomLayer SolderPasteJumper-A             2943.354      219.646       225      
SPJ19      CAD00131   BottomLayer SolderPasteJumper-A             2900.500      50.000        270      
SPJ18      CAD00131   BottomLayer SolderPasteJumper-A             2900.500      135.000       270      
SPJ17      CAD00131   BottomLayer SolderPasteJumper-A             3100.000      250.500       180      
SPJ16      CAD00131   BottomLayer SolderPasteJumper-A             256.500       1325.000      90       
SPJ15      CAD00131   BottomLayer SolderPasteJumper-A             256.500       1252.000      90       
SPJ14      CAD00131   BottomLayer SolderPasteJumper-A             121.000       1120.500      0        
SPJ13      CAD00131   BottomLayer SolderPasteJumper-A             50.000        1120.500      0        
SPJ12      CAD00131   TopLayer    SolderPasteJumper-A             256.500       1325.000      270      
SPJ11      CAD00131   TopLayer    SolderPasteJumper-A             256.500       1252.000      270      
SPJ10      CAD00131   BottomLayer SolderPasteJumper-A             217.646       1161.353      45       
SPJ9       CAD00131   TopLayer    SolderPasteJumper-A             50.000        1120.500      180      
SPJ8       CAD00131   BottomLayer SolderPasteJumper-A             123.000       254.500       180      
SPJ7       CAD00131   BottomLayer SolderPasteJumper-A             256.500       50.000        90       
SPJ6       CAD00131   BottomLayer SolderPasteJumper-A             256.500       123.000       90       
SPJ5       CAD00131   BottomLayer SolderPasteJumper-A             50.000        254.500       180      
SPJ4       CAD00131   TopLayer    SolderPasteJumper-A             50.000        254.500       0        
SPJ3       CAD00131   TopLayer    SolderPasteJumper-A             123.000       254.500       360      
SPJ2       CAD00131   TopLayer    SolderPasteJumper-A             256.500       123.000       270      
SPJ1       CAD00131   TopLayer    SolderPasteJumper-A             256.500       50.000        270      
C7         04041101L  TopLayer    SM-C-0402-B                     2510.000      995.000       90       
U19        00800049L  TopLayer    SM-SC70-6-A                     2760.000      1045.000      90       
R52        04022470L  BottomLayer SM-R-0402-B                     2170.000      1265.000      360      
R51        04022470L  BottomLayer SM-R-0402-B                     1225.000      815.000       270      
R50        04022470L  BottomLayer SM-R-0402-B                     1270.000      815.000       90       
R18        04030000L  BottomLayer SM-R-0402-B                     2695.000      1055.000      180      
R17        04022470L  BottomLayer SM-R-0402-B                     2785.000      1055.000      180      
Q2         03452810L  BottomLayer SM-SOT23-GSD-A                  1285.000      650.000       270      
C70        04040033L  BottomLayer SM-C-0402-B                     2785.000      1010.000      360      
C69        04041101L  TopLayer    SM-C-0402-B                     2680.000      1085.000      90       
C68        04041101L  TopLayer    SM-C-0402-B                     2680.000      995.000       90       
R49        04022470L  BottomLayer SM-R-0402-B                     2510.000      1285.000      270      
R48        04022470L  BottomLayer SM-R-0402-B                     2853.000      1035.000      90       
R47        04022470L  BottomLayer SM-R-0402-B                     3005.000      1285.000      270      
R46        04022470L  BottomLayer SM-R-0402-B                     2510.000      965.000       180      
R45        04022470L  BottomLayer SM-R-0402-B                     2798.000      1285.000      270      
R44        04022470L  BottomLayer SM-R-0402-B                     2960.000      1285.000      270      
R43        04022470L  BottomLayer SM-R-0402-B                     3085.000      1010.000      360      
CR3        00800016L  TopLayer    SM-SOT666-6-B                   2765.000      595.000       90       
C67        04041101L  TopLayer    SM-C-0402-B                     2480.000      145.000       360      
R42        04023124L  BottomLayer SM-R-0402-B                     1110.000      795.000       360      
R41        04033820L  BottomLayer SM-R-0402-B                     1180.000      815.000       270      
U18        00801047L  BottomLayer QFN_50_L3_10-W2_10-A            970.000       755.000       270      
R40        04030000L  TopLayer    SM-R-0402-B                     715.000       240.000       180      
R39        04030000L  TopLayer    SM-R-0402-B                     1050.000      105.000       180      
R38        04031470L  BottomLayer SM-R-0402-B                     815.000       620.000       270      
R37        04031470L  BottomLayer SM-R-0402-B                     770.000       580.000       90       
C66        04040033L  TopLayer    SM-C-0402-B                     645.000       220.000       270      
C65        04040033L  TopLayer    SM-C-0402-B                     980.000       85.000        270      
C64        04040033L  TopLayer    SM-C-0402-B                     785.000       220.000       270      
C63        04040033L  TopLayer    SM-C-0402-B                     1120.000      85.000        270      
C62        03342222L  BottomLayer SM-C-1206-A                     1060.000      540.000       360      
C61        03341045L  BottomLayer SM-C-0603-A                     1025.000      611.000       360      
C60        04044101L  BottomLayer SM-C-0402-B                     1110.000      841.000       180      
C59        03341045L  BottomLayer SM-C-0603-A                     915.000       611.000       180      
C23        03342550L  BottomLayer SM-C-1206-A                     880.000       540.000       180      
U10        39125831L  TopLayer    LCC1_3-144-L32_15-W29_15-B      1800.000      690.000       270      
U14        00801026L  BottomLayer SM-SOT23-5-B                    2520.000      710.000       360      
R16        04030000L  BottomLayer SM-R-0402-B                     2695.000      1010.000      360      
R14        04030000L  BottomLayer SM-R-0402-B                     2626.000      1285.000      270      
TP12       0          BottomLayer 60R0-A                          455.000       1000.000      90       
TP11       0          BottomLayer 60R0-A                          155.000       480.000       90       
TP10       0          BottomLayer 60R0-A                          655.000       480.000       90       
TP9        0          BottomLayer 60R0-A                          555.000       480.000       90       
TP8        0          BottomLayer 60R0-A                          355.000       1000.000      90       
TP7        0          BottomLayer 60R0-A                          455.000       480.000       90       
TP6        0          BottomLayer 60R0-A                          355.000       480.000       90       
R36        04031470L  BottomLayer SM-R-0402-B                     940.000       1275.000      360      
JP2        01058017L  TopLayer    BLKCON_100-VH-TM-1-SQ-W_100-2-A 1095.000      1320.000      360      
JP1        CAD00126   TopLayer    CON-PROGRAM-A                   3035.000      675.000       270      
U12        70002470LB TopLayer    70002470L-B                     350.000       667.500       0        
U17        00784390L  BottomLayer QFN_50-20-3_00-A                2730.000      745.000       180      
U16        00801046L  TopLayer    DFN_50-17-L5_10-W4_10-A         950.000       865.000       270      
U15        00751726L  BottomLayer SM-SOT353-A                     2525.000      540.000       360      
U7         00800049L  TopLayer    SM-SC70-6-A                     2590.000      1045.000      90       
U6         00800049L  TopLayer    SM-SC70-6-A                     2760.000      1260.000      90       
U5         00800049L  TopLayer    SM-SC70-6-A                     2925.000      1260.000      90       
U4         00800049L  TopLayer    SM-SC70-6-A                     2925.000      1045.000      90       
U2         00800049L  TopLayer    SM-SC70-6-A                     3085.000      1260.000      90       
R35        04022470L  BottomLayer SM-R-0402-B                     2760.000      870.000       270      
R34        04022470L  BottomLayer SM-R-0402-B                     2675.000      875.000       360      
R33        04022470L  BottomLayer SM-R-0402-B                     2605.000      825.000       270      
R32        04023158L  BottomLayer SM-R-0402-B                     800.000       860.000       360      
R31        04033845L  BottomLayer SM-R-0402-B                     775.000       975.000       270      
R30        04022100L  BottomLayer SM-R-0402-B                     820.000       975.000       270      
R29        04022268L  BottomLayer SM-R-0402-B                     800.000       710.000       270      
R28        04031470L  BottomLayer SM-R-0402-B                     415.000       1165.000      90       
R27        04030000L  BottomLayer SM-R-0402-B                     2860.000      720.000       180      
R23        04031470L  BottomLayer SM-R-0402-B                     2775.000      610.000       360      
R22        04030000L  BottomLayer SM-R-0402-B                     2735.000      565.000       180      
R21        04022470L  BottomLayer SM-R-0402-B                     1660.000      1270.000      180      
R20        04030100L  BottomLayer SM-R-0402-B                     255.000       520.000       270      
R19        04030000L  BottomLayer SM-R-0402-B                     635.000       865.000       360      
R15        04030000L  BottomLayer SM-R-0402-B                     2605.000      1010.000      360      
R13        04030000L  BottomLayer SM-R-0402-B                     2510.000      1010.000      360      
R12        04030000L  BottomLayer SM-R-0402-B                     2740.000      1285.000      270      
R9         04030000L  BottomLayer SM-R-0402-B                     2930.000      1055.000      360      
R8         04030000L  BottomLayer SM-R-0402-B                     3085.000      1055.000      180      
R7         04030000L  BottomLayer SM-R-0402-B                     3110.000      1285.000      270      
R6         04031470L  BottomLayer SM-R-0402-B                     2750.000      95.000        180      
R5         04022470L  BottomLayer SM-R-0402-B                     2430.000      50.000        360      
R4         04022470L  TopLayer    SM-R-0402-B                     2570.000      145.000       360      
R3         04030022L  TopLayer    SM-R-0402-B                     2790.000      740.000       270      
R1         04030000L  BottomLayer SM-R-0402-B                     825.000       1295.000      90       
LED1       03900200L  BottomLayer LED-RS-2-1-L_118-W_079-B        605.000       1277.000      180      
J69        01051340L  TopLayer    CON-01051340L-D                 881.970       355.000       90       
J68        01051340L  TopLayer    CON-01051340L-D                 575.000       116.970       180      
J67        01051340L  TopLayer    CON-01051340L-D                 891.970       105.000       90       
J66        01051530L  TopLayer    CON-01051530L-B                 350.000       667.500       270      
J70        01058024L  TopLayer    CON-01058024L-B                 2766.400      445.000       360      
FB1        03900039L  TopLayer    SM-L-1206-A                     870.000       1250.000      360      
CR2        03452250L  BottomLayer SM-SOT23-6-A                    620.000       760.000       90       
C58        03342222L  TopLayer    SM-C-1206-A                     1075.000      1010.000      180      
C57        03342222L  BottomLayer SM-C-1206-A                     1015.000      925.000       360      
C56        04041101L  BottomLayer SM-C-0402-B                     2860.000      675.000       180      
C55        03341045L  TopLayer    SM-C-0603-A                     1100.000      905.000       90       
C54        04040220L  BottomLayer SM-C-0402-B                     755.000       695.000       90       
C53        04040033L  BottomLayer SM-C-0402-B                     800.000       905.000       180      
C52        04040010L  BottomLayer SM-C-0402-B                     775.000       780.000       180      
C51        03341045L  TopLayer    SM-C-0603-A                     935.000       1010.000      360      
C50        03342550L  TopLayer    SM-C-1206-A                     900.000       1085.000      360      
C49        04044101L  BottomLayer SM-C-0402-B                     2550.000      615.000       360      
C48        04041101L  BottomLayer SM-C-0402-B                     2620.000      540.000       270      
C47        04044101L  BottomLayer SM-C-0402-B                     2400.000      725.000       90       
C46        04040033L  BottomLayer SM-C-0402-B                     1010.000      450.000       90       
C45        04044101L  BottomLayer SM-C-0402-B                     1060.000      450.000       270      
C43        04040033L  BottomLayer SM-C-0402-B                     620.000       630.000       270      
C42        04040033L  BottomLayer SM-C-0402-B                     535.000       925.000       180      
C41        04044101L  BottomLayer SM-C-0402-B                     1130.000      470.000       360      
C40        04040033L  BottomLayer SM-C-0402-B                     665.000       630.000       270      
C39        04040033L  BottomLayer SM-C-0402-B                     300.000       520.000       270      
C38        04041101L  BottomLayer SM-C-0402-B                     575.000       630.000       90       
C37        04041101L  BottomLayer SM-C-0402-B                     255.000       630.000       270      
C34        04040033L  TopLayer    SM-C-0402-B                     2500.000      305.000       270      
C32        04041101L  TopLayer    SM-C-0402-B                     2545.000      305.000       90       
C31        04041101L  TopLayer    SM-C-0402-B                     2590.000      305.000       90       
C30        03342222L  BottomLayer SM-C-1206-A                     2350.000      385.000       360      
C29        03342222L  TopLayer    SM-C-1206-A                     2575.000      515.000       270      
C28        04042100L  TopLayer    SM-C-0402-B                     705.000       1250.000      270      
C27        04041101L  TopLayer    SM-C-0402-B                     750.000       1250.000      270      
C26        04040033L  BottomLayer SM-C-0402-B                     2570.000      1285.000      270      
C25        04040033L  BottomLayer SM-C-0402-B                     2510.000      1055.000      180      
C24        04040033L  BottomLayer SM-C-0402-B                     2685.000      1285.000      90       
C22        04040033L  BottomLayer SM-C-0402-B                     2843.000      1285.000      90       
C21        04040033L  BottomLayer SM-C-0402-B                     2930.000      1015.000      360      
C20        04041101L  TopLayer    SM-C-0402-B                     2450.000      75.000        270      
C19        04040033L  BottomLayer SM-C-0402-B                     3017.000      1035.000      270      
C18        04040033L  BottomLayer SM-C-0402-B                     870.000       1295.000      270      
C17        04040033L  BottomLayer SM-C-0402-B                     3065.000      1285.000      270      
C16        04041101L  TopLayer    SM-C-0402-B                     2510.000      1320.000      90       
C15        04041101L  TopLayer    SM-C-0402-B                     2510.000      1085.000      90       
C10        04041101L  TopLayer    SM-C-0402-B                     3005.000      1320.000      90       
C9         04041101L  BottomLayer SM-C-0402-B                     2430.000      105.000       360      
C8         04041101L  TopLayer    SM-C-0402-B                     2510.000      1230.000      90       
C6         04041101L  TopLayer    SM-C-0402-B                     2685.000      1230.000      90       
C5         04041101L  TopLayer    SM-C-0402-B                     2845.000      1230.000      90       
C4         04041101L  TopLayer    SM-C-0402-B                     2845.000      995.000       90       
C3         04041101L  TopLayer    SM-C-0402-B                     3005.000      995.000       90       
C2         04041101L  TopLayer    SM-C-0402-B                     3005.000      1230.000      90       
C1         04041101L  BottomLayer SM-C-0402-B                     2660.000      95.000        360      
TP5        0          BottomLayer 60R0-A                          1860.000      1330.000      90       
TP4        0          BottomLayer 60R0-A                          1725.000      1330.000      90       
TP2        0          TopLayer    70_135_PAD-A                    390.000       135.000       90       
TP1        0          TopLayer    70_135_PAD-A                    2495.000      385.000       180      
U1         00800049L  BottomLayer SM-SC70-6-A                     2540.000      70.000        180      
PCB1       10002430L  TopLayer    COPPERPCB-NUMBER-C              285.000       1290.000      180      
FID4       0          TopLayer    FID35D-C                        285.000       1170.000      90       
FID3       0          BottomLayer FID35D-C                        3065.000      390.000       90       
FID2       0          TopLayer    FID35D-C                        3045.000      345.000       90       
FID1       0          BottomLayer FID35D-C                        265.000       1120.000      90       
U3         00800049L  TopLayer    SM-SC70-6-A                     3085.000      1045.000      90       
U13        00801022L  BottomLayer SM-SOT23-5-B                    1245.000      465.000       270      
U11        00690100L  BottomLayer DFN1_27-9-L6_10-W5_10-A         395.000       725.000       270      
U9         00674340L  TopLayer    SM-SOT353-A                     2545.000      70.000        180      
U8         00800049L  TopLayer    SM-SC70-6-A                     2590.000      1260.000      90       
R26        04030000L  BottomLayer SM-R-0402-B                     2860.000      765.000       180      
R25        04022990L  TopLayer    SM-R-0402-B                     820.000       940.000       90       
R24        04031100L  BottomLayer SM-R-0402-B                     460.000       1290.000      360      
R11        04030000L  BottomLayer SM-R-0402-B                     2605.000      1055.000      180      
R10        04030000L  BottomLayer SM-R-0402-B                     2900.000      1285.000      270      
R2         04030022L  TopLayer    SM-R-0402-B                     2740.000      740.000       270      
Q1         03452810L  BottomLayer SM-SOT23-GSD-A                  520.000       1175.000      360      
L2-2       03910231L  TopLayer    SM-L-2-L6_73-W6_73-A            970.000       615.000       0        
L1         03910001L  TopLayer    SM-L-0402-A                     975.000       375.000       270      
J63        01058350L  BottomLayer CON-01058350L-C                 738.700       1160.000      90       
J61        01058350L  BottomLayer CON-01058350L-C                 896.180       1160.000      90       
J58        01058350L  BottomLayer CON-01058350L-C                 1132.400      1160.000      90       
J41        01058350L  BottomLayer CON-01058350L-C                 2470.980      1160.000      90       
J40        01058350L  BottomLayer CON-01058350L-C                 2549.800      1160.000      90       
J39        01058350L  BottomLayer CON-01058350L-C                 2628.500      1160.000      90       
J38        01058350L  BottomLayer CON-01058350L-C                 2707.200      1160.000      90       
J37        01058350L  BottomLayer CON-01058350L-C                 2785.980      1160.000      90       
J36        01058350L  BottomLayer CON-01058350L-C                 2864.690      1160.000      90       
J35        01058350L  BottomLayer CON-01058350L-C                 2943.500      1160.000      90       
J34        01058350L  BottomLayer CON-01058350L-C                 3022.200      1160.000      90       
J33        01058350L  BottomLayer CON-01058350L-C                 3100.910      1160.000      90       
J28        01058350L  BottomLayer CON-01058350L-C                 2785.980      215.000       90       
J27        01058350L  BottomLayer CON-01058350L-C                 2707.200      215.000       90       
J26        01058350L  BottomLayer CON-01058350L-C                 2628.500      215.000       90       
J25        01058350L  BottomLayer CON-01058350L-C                 2549.800      215.000       90       
J24        01058350L  BottomLayer CON-01058350L-C                 2470.980      215.000       90       
CR1        03440011L  TopLayer    SM-D-SMA-A                      2760.000      100.000       180      
C44        04040100L  TopLayer    SM-C-0402-B                     1050.000      355.000       180      
C36        04040010L  TopLayer    SM-C-0402-B                     2455.000      305.000       270      
C35        04040010L  TopLayer    SM-C-0402-B                     2455.000      490.000       90       
C33        04040033L  TopLayer    SM-C-0402-B                     2500.000      490.000       90       
C14        04041101L  TopLayer    SM-C-0402-B                     2685.000      1320.000      90       
C13        04041101L  TopLayer    SM-C-0402-B                     2845.000      1320.000      90       
C12        04041101L  TopLayer    SM-C-0402-B                     2845.000      1085.000      90       
C11        04041101L  TopLayer    SM-C-0402-B                     3005.000      1085.000      90       

)