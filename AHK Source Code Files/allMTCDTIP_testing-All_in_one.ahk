/*
    Author: Viet Ho
*/

#SingleInstance Force
#NoEnv
SetBatchLines -1
SetTitleMatchMode, RegEx

;===============================================;
;;;;;;;;;;;;;VARIABLEs DEFINITION


;===============================================;
;;;;;;;;;;;;;;;;;;;MAIN GUI

Gui Add, Button, x155 y5 w55 h20 vhistoryBttn gShowTestHist, HISTORY
Gui, Add, Text, x17 y5 w100 h21, Select Item Number

Gui, Add, Tab3, x10 y27 w202 h65 vwhichTab gChangeTab, 266L|267L
Gui, Tab, 1
For each, item in 266_ItemNums
    itmNum1 .= (each == 1 ? "" : "|") . item
Gui, Add, DropDownList, x23 y59 w176 vitemNum1 Choose1, %itmNum1%
Gui, Tab, 2
For each, item in 267_ItemNums
    itmNum2 .= (each == 1 ? "" : "|") . item
Gui, Add, DropDownList, x23 y59 w176 vitemNum2 Choose1, %itmNum2%
Gui, Tab

posX := A_ScreenWidth - 400
Gui, Show, x%posX% y100, All MTCDT Auto-Tester
Return
;===============================================;
;;;;;;;;HOT KEYs;;;;;;;;
^q:: ExitApp

;===============================================;
;;;;;;;;;;;;;;;;;;;ADDITIONAL FUNTIONs
ChangeTab() {
    
}

;===============================================;
;;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs
ShowTestHist() {
    
}