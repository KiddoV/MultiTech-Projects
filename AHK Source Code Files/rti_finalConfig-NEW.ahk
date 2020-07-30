/*
    Author: Viet Ho
*/

SetTitleMatchMode, RegEx

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;===============================================;
;;;;;;;;;;;;;;;;;;Installs Files;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;
Gui, Add, GroupBox, xm+0 ym+0 w190 h140 Section
Gui, Font, Bold
Gui, Add, Text, xs+40 ys+20 vstep1Label, STEP 0. Commissioning
Gui, Add, Text, xs+40 ys+45 vstep2Label, STEP 1. Ping Test
Gui, Add, Text, xs+40 ys+70 vstep3Label, STEP 2. Save OEM
Gui, Font

Gui, Add, Button, xs+70 ys+100 w50 h30 gRunAll, RUN

posX := A_ScreenWidth - 300
posY := A_ScreenHeight - 900
Gui, Show, x%posX% y%posY%, RTI Auto-Final Configurator    ;Starts GUI

Return ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GuiClose:
    ExitApp
Return

;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN FUNCTIONs;;;;;;;;;;;;;;
RunAll() {
    step0()
}

;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;
CommGui() {
    Global
    
    Gui, comm: Add, ActiveX, w500 h500 vWB, Shell.Explorer
    WB.Navigate("https://192.168.2.1/commissioning")
    ;Gui, comm: Add, Button, gstep0, Test
    ;WinWait, Security Alert
    ;ControlClick, Button1, Security Alert, , Left, 2
    ;;;Run BEFORE GUI started
    While WB.readystate != 4 || WB.busy     ;Wait for IE to load the page
        Sleep 10
    WB.ExecWB(63, 2, 70, 0)                 ;Zoom WB window
    
    Gui, comm: Show, , Commissioning Mode
    Return ;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;Run AFTER GUI started
    
    commGuiClose:
        Gui, comm: Destroy
    Return
}
;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL FUNCTIONs;;;;;;;;;;;
step0() {
    Global          ;To use WB
    
    CommGui()
    
    WinWait, Commissioning Mode
    SplashTextOn, 300, 20, STEP 0, COMMISSIONING.......
    currentURL := WB.LocationURL
    
    Sleep 1500
    if (currentURL = "https://192.168.2.1/sign-in")
        Goto Login-Step
    ;;Input Username
    While (WB.document.getElementById("answer").value != "admin" && WB.document.getElementById("message").innerHTML = "Username: ")
    {
        WB.document.getElementById("answer").value := ""
        WB.document.getElementById("answer").focus()
        ControlSendRaw, , admin, Commissioning Mode
        Sleep 500
        btn := WB.document.getElementsByTagName("button")
        btn[0].Click()
    }
    
    Sleep 2000
    ;;Input Password
    While (WB.document.getElementById("answer").value != "admin2205!" && WB.document.getElementById("message").innerHTML = "New password: ")
    {
        WB.document.getElementById("answer").value := ""
        WB.document.getElementById("answer").focus()
        ControlSendRaw, , admin2205!, Commissioning Mode
        Sleep 500
        btn := WB.document.getElementsByTagName("button")
        btn[0].Click()
    }
    
    Sleep 2000
    ;;Retype Password
    While (WB.document.getElementById("answer").value != "admin2205!" && WB.document.getElementById("message").innerHTML = "Retype new password: ")
    {
        WB.document.getElementById("answer").value := ""
        WB.document.getElementById("answer").focus()
        ControlSendRaw, , admin2205!, Commissioning Mode
        Sleep 500
        btn := WB.document.getElementsByTagName("button")
        btn[0].Click()
    }
    
    
    Login-Step:
    Sleep 1000
    ;;Login Step
    While (WB.document.getElementById("login").value != "admin" && WB.document.getElementById("password").value != "admin2205!")
    {
        WB.document.getElementById("login").value := ""
        WB.document.getElementById("password").value := ""
        WB.document.getElementById("login").focus()
        ControlSendRaw, , admin, Commissioning Mode
        Sleep 300
        WB.document.getElementById("password").focus()
        ControlSendRaw, , admin2205!, Commissioning Mode
        
        Sleep 500
        WB.document.getElementsByTagName("button").item[0].click()
        
    }
    
    Sleep 4000
    ;;After Login
    WB.document.getElementsByClassName("close").item[0].click()
    Sleep 500
    WB.Navigate("https://192.168.2.1/administration/save-restore")
    Sleep 300
    WB.document.getElementsByTagName("label").item[1].click()
    
    WinWait, Choose File to Upload
    WinActivate, Choose File to Upload
    ControlSetText, Edit1, TEST, Choose File to Upload
}