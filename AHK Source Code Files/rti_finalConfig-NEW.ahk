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
IfNotExist C:\V-Projects\RTIAuto-FinalConfig\ttl
    FileCreateDir C:\V-Projects\RTIAuto-FinalConfig\ttl
IfNotExist C:\V-Projects\RTIAuto-FinalConfig\caches
    FileCreateDir C:\V-Projects\RTIAuto-FinalConfig\caches
IfNotExist C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui
    FileCreateDir C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui
    
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\rti_check_status.ttl, C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_check_status.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\rti_all-config-in-one.ttl, C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_all-config-in-one.ttl, 1

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\check_mark.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\x_mark.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\play_orange.png, 1

FileInstall C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz, C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz, 1
FileInstall C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\RT_Python_Deps.tar.gz, C:\V-Projects\RTIAuto-FinalConfig\transfering-files\RT_Python_Deps.tar.gz, 1
FileInstall C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\RT_CDC.1.0.3.0.PRD.minimalmodbus.tar.gz, C:\V-Projects\RTIAuto-FinalConfig\transfering-files\RT_CDC.1.0.3.0.PRD.minimalmodbus.tar.gz, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global config4GFilePath := "C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz"

Global xImg := "C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\x_mark.png"
Global checkImg := "C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\check_mark.png"
Global playImg := "C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\play_orange.png"

Global step0ErrMsg := "Unknown ERROR"
;;;;;;;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;;;;;;
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\JSON_ToObj.ahk
;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;
Gui, Add, GroupBox, xm+0 ym+0 w190 h155 Section
Gui, Font, Bold
Gui, Add, Text, xs+40 ys+20 vstep1Label, STEP 0. Commissioning
Gui, Add, Text, xs+40 ys+45 vstep2Label, STEP 1. Ping Test
Gui, Add, Text, xs+40 ys+70 vstep3Label, STEP 2. Save OEM
Gui, Font
Gui Add, Text, xs+10 ys+90 w175 h2 +0x10
Gui, Add, Button, xs+20 ys+95 w50 h20 gRunStep0, Step 0
Gui, Add, Button, xs+120 ys+95 w50 h20 gRunStep1and2, Step 1&&2
Gui, Add, Button, xs+70 ys+120 w50 h30 gRunAll, RUN

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess1,
Gui, Add, Picture, xs+7 ys+42 w18 h18 +BackgroundTrans vprocess2,
Gui, Add, Picture, xs+7 ys+67 w18 h18 +BackgroundTrans vprocess3,

posX := A_ScreenWidth - 300
posY := A_ScreenHeight - 900
Gui, Show, x%posX% y%posY%, RTI Auto-Final Configurator    ;Starts GUI

Return ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PickFileHelper:
    WinWait, Choose File to Upload
    IfWinExist, Choose File to Upload
    {
        Sleep 1000
        ControlSetText, Edit1, %config4GFilePath%, Choose File to Upload
        Sleep 1000
        ControlClick, Button1, Choose File to Upload, , Left, 2
        Sleep 300
        SetTimer, PickFileHelper, Off
    }
Return

CloseSSLHelper:
    IfWinExist, Security Alert
    {
        ControlClick, Button1, Security Alert, , Left, 2
        Sleep 100
        SetTimer, CloseSSLHelper, Off
    }
Return

CloseCertErrorHelper:
    ToolTip HERE!
    IfWinExist, Security Warning
    {
        Sleep 200
        ControlClick, Button2, Security Warning, , Left, 2
        Sleep 100
        IfWinNotExist, Security Warning
            SetTimer, CloseCertErrorHelper, Off
    }
Return

GuiClose:
    ExitApp
Return

;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN FUNCTIONs;;;;;;;;;;;;;;
RunAll() {
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running the final configuration steps for RTI?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (step0() = 0)
        {
            Progress, Off
            MsgBox, 16, STEP 0 FAILED, %step0ErrMsg%
            return
        }
        Sleep 200000
        Loop,
        {
            if (checkRTIStatus()) {
                Break
            }
            Sleep 5000
        }
        Gui, comm: Destroy
        Progress, Off
        if (step1() = 0)
            return
        if (step2() = 0)
            return
    }   
    IfMsgBox Cancel
        Return
}

RunStep0() {
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running LOGIN STEP for RTI?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        step0()
    }
    IfMsgBox Cancel
        Return
}

RunStep1and2() {
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running STEP 1 AND 2 for RTI?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (checkRTIStatus()) {
            step1()
            step2()
        } else {
            MsgBox, 16, ERROR, RTI is not READY!`nPlease wait or check connection!
            return
        }
    }
    IfMsgBox Cancel
        Return
}

;;;;;;;;;;;;;
step0() {
    Global          ;To use WB
    Progress, ZH0 M FS10, RUNNING COMMISSIONING`, PLEASE WAIT......., , STEP 0
    RunWait, Taskkill /f /im iexplore.exe, , Hide   ;Fix bug where IE open many times
    SetTimer, CloseSSLHelper, 100
    Gui Add, ActiveX, vWB, about:<!DOCTYPE html><meta http-equiv="X-UA-Compatible" content="IE=edge">
    ;WB := ComObjCreate("InternetExplorer.Application") ;create a IE instance
    req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;For http request
    WB.Navigate("https://192.168.2.1/commissioning")
    if (!CheckIELoad(WB)) {
        step0ErrMsg := "Failed to connect to <https://192.168.2.1/commissioning>"
        return 0
    }

    ;;;Bypass security
    ;SetTimer, CloseSSLHelper, 100
    ;Progress, ZH0 M FS10, BYPASSING SECURITY..., , STEP 0
    ;Sleep 1000
    url := "https://192.168.2.1/api/commissioning"
    req.open("GET", url, False)
    req.Send()
    resObj := json_toobj(req.responseText)
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, BYPASS SECURITY SUCCESSFULY!, , STEP 0
    } else if (resObj.error = "commissioning is finished") {
        Progress, ZH0 M FS10, COMMISSIONING IS FINISHED!`nGO TO LOGIN STEP!..., , STEP 0
        Sleep 500
        Goto Login-Step 
    } else {
        Progress, ZH0 M FS10 CTde1212, BYPASS SECURITY FALIED!, , STEP 0
        return 0
    }
    
    ;;;Setting new Username and password
    Progress, ZH0 M FS10, SETTING UP NEW USERNAME..., , STEP 0
    Sleep 1000
    url:= "https://192.168.2.1/api/commissioning"
    json =
    (LTrim
        {"username":"admin","aasID":"","aasAnswer":""}
    )
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, SET NEW USERNAME SUCCESSFULY!, , STEP 0
        Sleep 500
    } else if (resObj.error = "commissioning is finished") {
        Progress, ZH0 M FS10, COMMISSIONING IS FINISHED!`nGO TO LOGIN STEP!..., , STEP 0
        Sleep 500
        Goto Login-Step
    } else {
        Progress, ZH0 M FS10 CTde1212, SET NEW USERNAME FALIED!, , STEP 0
        Sleep 500
        return 0
    }
    userToken := resObj.result.aasID
    
    Progress, ZH0 M FS10, SETTING UP NEW PASSWORD..., , STEP 0
    Sleep 1000
    json =
    (LTrim
        {"username":"admin","aasID":"%userToken%","aasAnswer":"admin2205!"}
    )
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, SET NEW PASSWORD SUCCESSFULY!, , STEP 0
        Sleep 500
    } else {
        Progress, ZH0 M FS10 CTde1212, SET NEW PASSWORD FALIED!, , STEP 0
        Sleep 500
        return 0
    }
    
    Progress, ZH0 M FS10, CONFIRMMING NEW PASSWORD..., , STEP 0
    Sleep 1000
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, CONFIRM NEW PASSWORD SUCCESSFULY!, , STEP 0
        Sleep 500
    } else {
        Progress, ZH0 M FS10 CTde1212, CONFIRM NEW PASSWORD FALIED!, , STEP 0
        Sleep 500
        return 0
    }
    
    ;;;Login STEP
    Progress, ZH0 M FS10, LOGGING IN..., , STEP 0
    Sleep 1500
    Login-Step:
    url:= "https://192.168.2.1/api/login?username=admin&password=admin2205!"
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
    Sleep 2000
    
    ;;;Upload file STEP
    Progress, ZH0 M FS10, UPLOADING CONFIGURATION FILE..., , STEP 0
    Sleep 1000
    
    ;WB.Navigate("https://192.168.2.1/administration/save-restore")
    ;if (!CheckIELoad(WB)) {
        ;step0ErrMsg := "Failed to connect to <https://192.168.2.1/administration/save-restore>"
        ;return 0
    ;}
    
    javascript =
    (
    var data = new FormData();
    data.append("configFile", fileInput.files[0],"/C:/vbtest/MTCDT/MTCDT-LAT3-240A-RTI/config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz");
    
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "https://192.168.2.1/api/command/upload_config?token=%uploadConfigToken%");
    xhr.addEventListener("readystatechange", function() {
      if(xhr.readyState === 4) {
        alert(xhr.responseText)
      }
    });
    xhr.send(data);
    )
    WB.document.parentWindow.execScript(javascript)
    ;MsgBox % WB.document.parentWindow.toAHKVar
}

step1() {
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_all-config-in-one.ttl "STEP1", , Hide, TTWinPID
}

step2() {
    
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
    ;WB.ExecWB(63, 2, 70, 0)                 ;Zoom WB window
    
    Gui, comm: Show, , Commissioning Mode
    Return ;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;Run AFTER GUI started
    
    commGuiClose:
        Gui, comm: Destroy
    Return
}
;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL FUNCTIONs;;;;;;;;;;;
checkRTIStatus() {
    cmd := "ping 192.168.2.1 -n 1 -w 1000"
    RunWait, %cmd%,, Hide
    if (ErrorLevel = 1) {
        return False
    }
    if (ErrorLevel = 0) {
        RunWait, %ComSpec% /c start C:\teraterm\ttermpro.exe /V /M=C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_check_status.ttl /nossh , ,Hide, TTWinPID
        FileRead, actrlStatus, C:\V-Projects\RTIAuto-FinalConfig\caches\rti_status.dat
        if (actrlStatus != "SUCCESSED") {
            return False
        }
    }
    return True
}

CheckIELoad(WB, Timeout := 50) {
    If !WB
        Return False
    Loop, %Timeout%
    {
        Sleep,100
        ;ToolTip, Loop 1: %A_Index%
        if (A_Index = Timeout)
            Return False
    } Until (WB.busy)
    Loop, %Timeout%
    {
        Sleep,100
        ;ToolTip, Loop 2: %A_Index%
        if (A_Index = Timeout)
            Return False
    } Until (!WB.busy)
    Loop, %Timeout%
    {
        Sleep,100
        ;ToolTip, Loop 3: %A_Index%
        if (A_Index = Timeout)
            Return False
    } Until (WB.Document.Readystate = "Complete")
    
    Return True
}

;;;Icon for MsgBox
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