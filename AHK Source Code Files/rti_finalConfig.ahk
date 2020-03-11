/*
    Author: Viet Ho
*/

SetTitleMatchMode, RegEx
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Add, GroupBox, x8 y10 w138 h95, Step by Step
Gui Add, Button, x37 y30 w80 h17 gloginStep, &LOGIN
Gui Add, Button, x37 y55 w80 h17 grunStep1, STEP &1
Gui Add, Button, x37 y80 w80 h17 grunStep2, STEP &2
Gui Add, Button, x37 y121 w80 h25 gmainRun, &RUN A to Z
Gui Add, StatusBar,, Status Bar

Gui -MaximizeBox
Gui Show, h176, RTI Auto-Final Configer
Return

GuiEscape:
GuiClose:
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;

mainRun() {
    
    loginStep()
    
    if (runStep1() = 0) {
        return
    }
    
    if (runStep2() = 0) {
        return
    }
}

loginStep() {
    Run, %ComSpec% /c start chrome.exe https://192.168.2.1/commissioning -ignore-certificate-errors, ,Hide
}

runStep1() {
    if !FileExist("C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step1.PINGTESTappinstall.ttl") {
        MsgBox 16, FILE NOT FOUND, The file:`nStep1.PINGTESTappinstall.ttl`nwas not found in this location:`nC:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\`nPlease check and run again!
        return 0
    }
    SB_SetText("Begin Step 1")
    Run, %ComSpec% /c start C:\teraterm\ttermpro.exe   /M=C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step1.PINGTESTappinstall.ttl, ,Hide
}

runStep2() {
    if !FileExist("C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step2.saveOEM.ttl") {
        MsgBox 16, FILE NOT FOUND, The file:`nStep2.saveOEM.ttl`nwas not found in this location:`nC:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\`nPlease check and run again!
        return 0
    }
    SB_SetText("Begin Step 2")
    Run, %ComSpec% /c start C:\teraterm\ttermpro.exe   /M=C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step2.saveOEM.ttl, ,Hide
}