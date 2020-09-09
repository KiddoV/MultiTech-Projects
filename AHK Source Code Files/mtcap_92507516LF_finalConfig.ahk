/*
    Author: Viet Ho
*/

SetTitleMatchMode, RegEx
DetectHiddenWindows, On
DetectHiddenText, On

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;===============================================;
;;;;;;;;;;;;;;;;;;Installs Files;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;;;;;;


;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;
Gui, Add, GroupBox, xm+0 ym+0 w190 h155 Section
Gui, Font, Bold
Gui, Add, Text, xs+40 ys+20 vstep0Label, STEP 0. Commissioning
Gui, Add, Text, xs+40 ys+45 vstep1Label, STEP 1. Ping Test
Gui, Add, Text, xs+40 ys+70 vstep2Label, STEP 2. Save OEM
Gui, Font

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess0,
Gui, Add, Picture, xs+7 ys+42 w18 h18 +BackgroundTrans vprocess1,
Gui, Add, Picture, xs+7 ys+67 w18 h18 +BackgroundTrans vprocess2,

Gui Add, Text, xs+10 ys+90 w175 h2 +0x10
Gui, Add, Button, xs+20 ys+95 w50 h20, Step 0
Gui, Add, Button, xs+160 ys+42 w20 h20, 1
Gui, Add, Button, xs+160 ys+67 w20 h20, 2
Gui, Add, Button, xs+120 ys+95 w50 h20, Step 1&&2
Gui, Add, Button, xs+70 ys+120 w50 h30, RUN

posX := A_ScreenWidth - 300
posY := A_ScreenHeight - 900
Gui, Show, x%posX% y%posY%, RTI Auto-Final Configurator    ;Starts GUI

Return ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GuiClose:
    ExitApp
Return

;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN FUNCTIONs;;;;;;;;;;;;;;

;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;

;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL FUNCTIONs;;;;;;;;;;;
