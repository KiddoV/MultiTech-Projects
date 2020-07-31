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
IfNotExist C:\V-Projects\RTIAuto-FinalConfig\transfering-files
    FileCreateDir C:\V-Projects\RTIAuto-FinalConfig\transfering-files
    
FileInstall C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz, C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz, 1
    
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global config4GFilePath := "C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz"

;;;;;;;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;;;;;;
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\JSON_ToObj.ahk
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

step0() {
    Global          ;To use WB
    
    CommGui()
    
    Progress, ZH0 M FS10, RUNNING COMMISSIONING......., , STEP 0
    ;;Setting new Username and password
    Sleep 1000
    url:= "https://192.168.2.1/api/commissioning"
    json =
    (LTrim
        {"username":"admin","aasID":"","aasAnswer":""}
    )
    req := ComObjCreate("Msxml2.XMLHTTP")
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, SET NEW USERNAME SUCCESSFULY!, , STEP 0
    } else if (resObj.error = "commissioning is finished") {
        Progress, ZH0 M FS10, COMMISSIONING IS FINISHED!`nGO TO LOGIN STEP!..., , STEP 0
        Sleep 500
        Goto Login-Step
    } else {
        Progress, ZH0 M FS10 CTde1212, SET NEW USERNAME FALIED!, , STEP 0
        return 0
    }
    userToken := resObj.result.aasID
    
    Sleep 1000
    json =
    (LTrim
        {"username":"admin","aasID":"%userToken%","aasAnswer":"admin2205!"}
    )
    req := ComObjCreate("Msxml2.XMLHTTP")
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, SET NEW PASSWORD SUCCESSFULY!, , STEP 0
    } else {
        Progress, ZH0 M FS10 CTde1212, SET NEW PASSWORD FALIED!, , STEP 0
        return 0
    }
    
    Sleep 1000
    req := ComObjCreate("Msxml2.XMLHTTP")
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, CONFIRM NEW PASSWORD SUCCESSFULY!, , STEP 0
    } else {
        Progress, ZH0 M FS10 CTde1212, CONFIRM NEW PASSWORD FALIED!, , STEP 0
        return 0
    }
    
    ;;Login STEP
    Sleep 1500
    Login-Step:
    url:= "https://192.168.2.1/api/login?username=admin&password=admin2205!"
    req := ComObjCreate("Msxml2.XMLHTTP")
    req.Open("GET", url, False)
    req.Send()
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, LOGIN SUCCESSFULY!, , STEP 0
    } else {
        errMsg := Format("{:U}", resObj.error)
        Progress, ZH0 M FS10 CTde1212, ERR: %errMsg%, LOGIN FALIED!, STEP 0
        return 0
    }
    uploadConfigToken := resObj.result.token
    
    ;;Upload config STEP
    Sleep 1000
    WB.Navigate("https://192.168.2.1/administration/save-restore")
    ;url:= "https://192.168.2.1/api/command/upload_config?token=%uploadConfigToken%"
    ;req := ComObjCreate("Msxml2.XMLHTTP")
    ;req.Open("POST", url, False)
    ;req.SetRequestHeader("Content-Type", "multipart/form-data")
    ;
    ;;req.SetRequestHeader("Content-Disposition", "form-data; name='archivo'; filename='config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz'")
    ;;fileContent := "C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz"
    ;req.Send()
    ;resObj := json_toobj(req.responseText)
    ;if (resObj.status = "success") {
        ;Progress, ZH0 M FS10 CT0ac90a, UPLOAD CONFIG FILE SUCCESSFULY!, , STEP 0
    ;} else {
        ;errMsg := Format("{:U}", resObj.error)
        ;Progress, ZH0 M FS10 CTde1212 W350, ERR: %errMsg%, UPLOAD CONFIG FILE FALIED!, STEP 0
        ;return 0
    ;}
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