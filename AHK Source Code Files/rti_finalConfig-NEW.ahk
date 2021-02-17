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
    
FileInstall C:\MultiTech-Projects\TTL-Files\rti_check_status.ttl, C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_check_status.ttl, 1
FileInstall C:\MultiTech-Projects\TTL-Files\rti_all-config-in-one.ttl, C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_all-config-in-one.ttl, 1

FileInstall C:\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\check_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\x_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\play_orange.png, 1

FileInstall C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz, C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz, 1
FileInstall C:\vbtest\MTCDT\MTCDT-L4N1-246A-DTE 2-ATT-RTI\config_MTCDT-L4N1-246A_5_3_0_12_02_20.tar.gz, C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_MTCDT-L4N1-246A_5_3_0_12_02_20.tar.gz, 1
FileInstall C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\RT_Python_Deps.tar.gz, C:\V-Projects\RTIAuto-FinalConfig\transfering-files\RT_Python_Deps.tar.gz, 1
FileInstall C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\RT_CDC.1.0.3.0.PRD.minimalmodbus.tar.gz, C:\V-Projects\RTIAuto-FinalConfig\transfering-files\RT_CDC.1.0.3.0.PRD.minimalmodbus.tar.gz, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global config4GFilePath := "C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz"

Global xImg := "C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\x_mark.png"
Global checkImg := "C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\check_mark.png"
Global playImg := "C:\V-Projects\RTIAuto-FinalConfig\imgs-for-gui\play_orange.png"
Global skuItems := ["94557585LF", "94557700LF"]

Global step0ErrMsg := "Unknown ERROR!!?"
Global step1ErrMsg := "Unknown ERROR!!?"
Global step2ErrMsg := "UnKnown ERROR!!?"
;;;;;;;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;;;;;;
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\JSON_ToObj.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\CreateFormData.ahk
;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;
Gui, Font, Bold
Gui, Add, Text, cred x11 y10, SKU#:
Gui, Font
For each, item In skuItems
    items .= (each == 1 ? "" : "|") . item
Gui, Add, DropDownList, x60 y5 w140 vskuDropList gOnSkuDropDown Choose2, %items%
GuiControlGet, defaultItem, , skuDropList

Gui Add, Text, x0 y35 w220 h2 +0x10 ;The line in between

Gui, Add, GroupBox, xm+0 ym+35 w190 h155 vskuNumberToRun Section, %defaultItem%
Gui, Font, Bold
Gui, Add, Text, xs+40 ys+20 vstep0Label, STEP 0. Commissioning
Gui, Add, Text, xs+40 ys+45 vstep1Label, STEP 1. Ping Test
Gui, Add, Text, xs+40 ys+70 vstep2Label, STEP 2. Save OEM
Gui, Font

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess0,
Gui, Add, Picture, xs+7 ys+42 w18 h18 +BackgroundTrans vprocess1,
Gui, Add, Picture, xs+7 ys+67 w18 h18 +BackgroundTrans vprocess2,

Gui Add, Text, xs+10 ys+90 w175 h2 +0x10
Gui, Add, Button, xs+20 ys+95 w50 h20 gRunStep0, Step 0
Gui, Add, Button, xs+160 ys+42 w20 h20 gRunStep1, 1
Gui, Add, Button, xs+160 ys+67 w20 h20 gRunStep2, 2
Gui, Add, Button, xs+120 ys+95 w50 h20 gRunStep1and2, Step 1&&2
Gui, Add, Button, xs+70 ys+120 w50 h30 gRunAll, RUN

posX := A_ScreenWidth - 300
posY := A_ScreenHeight - 900
Gui, Show, x%posX% y%posY% w210, RTI Auto-Final Configurator    ;Starts GUI

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
    GuiControlGet, skuNum, , skuNumberToRun
    
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION - %skuNum%, Start running the final configuration steps for RTI (%skuNum%)?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        startTime := A_TickCount
        
        if (step0(skuNum) = 0)
        {
            changeStepLabelStatus("step0Label", "FAIL")
            Progress, Off
            MsgBox, 16, STEP 0 FAILED, %step0ErrMsg%
            return
        }
        Progress, ZH0 M FS10, WAITING FOR CONDUIT TO REBOOT..., , STEP 0
        Sleep 230000
        Loop,
        {
            if (checkRTIStatus()) {
                Break
            }
            Sleep 5000
        }
        Progress, Off
        if (step1(skuNum) = 0) {
            MsgBox, 16, STEP 1 FAILED, %step1ErrMsg%
            return
        }
                
        if (step2(skuNum) = 0) {
            MsgBox, 16, STEP 2 FAILED, %step2ErrMsg%
            return
        }
        
        endTime := A_TickCount - startTime
        totalTimeInMin := Round((endTime / 1000) / 60)
        
        OnMessage(0x44, "CheckIcon") ;Add icon
        MsgBox 0x81, FINISHED, Finished auto-final configuration for RTI`nTotal time ran from STEP 0 => STEP 2: %totalTimeInMin% (minutes).
        OnMessage(0x44, "") ;Clear icon
    }
    IfMsgBox Cancel
        Return
}

RunStep0() {
    GuiControlGet, skuNum, , skuNumberToRun
    
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION - %skuNum%, Start running LOGIN STEP for RTI (%skuNum%)?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (step0(skuNum) = 0)
        {
            changeStepLabelStatus("step0Label", "FAIL")
            Progress, Off
            MsgBox, 16, STEP 0 FAILED, %step0ErrMsg%
            return
        }
        Progress, Off
        MsgBox, 64, STEP 0, STEP 0 LOGIN IS DONE. PLEASE WAIT UNTIL CONDUIT REBOOTED!
    }
    IfMsgBox Cancel
        Return
}

RunStep1() {
    GuiControlGet, skuNum, , skuNumberToRun
    
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION - %skuNum%, Start running STEP 1 for RTI (%skuNum%)?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (checkRTIStatus()) {
            if (step1(skuNum) = 0) {
                MsgBox, 16, STEP 1 FAILED, %step1ErrMsg%
                return
            }
            MsgBox, 64, STEP 1, STEP 1 IS DONE. YOU CAN RUN STEP 2 NOW!!
        } else {
            MsgBox, 16, ERROR, RTI is not READY!`nPlease wait or check connection!
            return
        }
    }
    IfMsgBox Cancel
        Return
}

RunStep2() {
    GuiControlGet, skuNum, , skuNumberToRun
    
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION - %skuNum%, Start running STEP 2 for RTI (%skuNum%)?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (checkRTIStatus()) {
            if (step2(skuNum) = 0) {
                MsgBox, 16, STEP 2 FAILED, %step2ErrMsg%
                return
            }
            MsgBox, 64, STEP 2, STEP 2 IS DONE!!
        } else {
            MsgBox, 16, ERROR, RTI is not READY!`nPlease wait or check connection!
            return
        }
    }
    IfMsgBox Cancel
        Return
}

RunStep1and2() {
    GuiControlGet, skuNum, , skuNumberToRun

    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION - %skuNum%, Start running STEP 1 AND 2 for RTI (%skuNum%)?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        startTime := A_TickCount
        
        if (checkRTIStatus()) {
            if (step1(skuNum) = 0) {
                MsgBox, 16, STEP 1 FAILED, %step1ErrMsg%
                return
            }
                
            if (step2(skuNum) = 0) {
                MsgBox, 16, STEP 2 FAILED, %step2ErrMsg%
                return
            }
            
            endTime := A_TickCount - startTime
            totalTimeInMin := Round((endTime / 1000) / 60)
            
            OnMessage(0x44, "CheckIcon") ;Add icon
            MsgBox 0x81, STEP 1&2, STEP 1 & 2 are DONE!!`nTotal time ran from STEP 1 => STEP 2: %totalTimeInMin% (minutes)
            OnMessage(0x44, "") ;Clear icon
                
        } else {
            MsgBox, 16, ERROR, RTI is not READY!`nPlease wait or check connection!
            return
        }
    }
    IfMsgBox Cancel
        Return
}

;;;;;;;;;;;;;
step0(sku) {
    changeStepLabelStatus("step0Label", "PLAY")
    Progress, ZH0 M FS10, RUNNING COMMISSIONING`, PLEASE WAIT......., , STEP 0
    RunWait, Taskkill /f /im iexplore.exe, , Hide   ;Fix bug where IE open many times
    
    req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;For http request
    
    ;;;Check connection and Bypass security
    Sleep 1000
    SetTimer, CloseSSLHelper, 100
    Progress, ZH0 M FS10, CHECKING FOR CONNECTION..., , STEP 0
    url := "https://192.168.2.1/api/commissioning"
    req.open("GET", url, True)
    req.Send()
    Loop, 50
    {
        Sleep 1000
        if (A_Index = 50) {
            step0ErrMsg = Failed to connect to <https://192.168.2.1/commissioning>`nERR: TIMEOUT!!!
            return 0
        } else if (req.readyState = 4){
            Break
        }
    }
    ;Progress, ZH0 M FS10, BYPASSING SECURITY..., , STEP 0
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, BYPASS SECURITY SUCCESSFULY!, , STEP 0
        Sleep 1000
    } else if (resObj.error = "commissioning is finished") {
        Progress, ZH0 M FS10, COMMISSIONING IS FINISHED!`nGO TO LOGIN STEP!..., , STEP 0
        Sleep 1000
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
    Login-Step:
    Progress, ZH0 M FS10, LOGGING IN..., , STEP 0
    Sleep 1500
    url:= "https://192.168.2.1/api/login?username=admin&password=admin2205!"
    req.Open("GET", url, False)
    req.Send()
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, LOGIN SUCCESSFULY!, , STEP 0
    } else {
        errMsg := Format("{:U}", resObj.error)  ;CAP string
        step0ErrMsg = LOGIN FALIED!`nERR: %errMsg%
        return 0
    }
    uploadConfigToken := resObj.result.token
    Sleep 2000
    
    ;;;Upload file STEP
    Progress, ZH0 M FS10, UPLOADING CONFIGURATION FILE..., , STEP 0
    Sleep 1000
    
    url:= "https://192.168.2.1/api/command/upload_config?token=%uploadConfigToken%"
    if (sku == "94557700LF")
        configPath := "C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz"
    else if (sku == "94557585LF")
        configPath := "C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_MTCDT-L4N1-246A_5_3_0_12_02_20.tar.gz"
        
    objParam := { Filedata: [configPath] }
    CreateFormData(PostData, hdr_ContentType, objParam)     ;Create a form data to send file to the server
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", hdr_ContentType)
    req.Send(PostData)

    resObj := json_toobj(req.responseText)
    ;MsgBox % req.responseText
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, UPLOAD CONFIG FILE SUCCESSFULY!, , STEP 0
        Sleep 500
    } else {
        errMsg := Format("{:U}", resObj.error)  ;CAP string
        step0ErrMsg = UPLOAD CONFIG FILE FALIED!`nERR: %errMsg%
        ;Progress, ZH0 M FS10 CTde1212 W350, ERR: %errMsg%, UPLOAD CONFIG FILE FALIED!, STEP 0
        return 0
    }
    
    changeStepLabelStatus("step0Label", "DONE")
}

step1(sku) {
    changeStepLabelStatus("step1Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_all-config-in-one.ttl "STEP1" %sku%, , Hide, TTWinPID
    WinWait, STEP 1 DONE|STEP 1 FAILED
    IfWinExist, STEP 1 FAILED|CONNECTION ERROR
    {
        WinGetText, errMsg, STEP 1 FAILED
        step1ErrMsg = %errMsg%
        changeStepLabelStatus("step1Label", "FAIL")
        return 0
    }
    IfWinExist, STEP 1 DONE
    {
        changeStepLabelStatus("step1Label", "DONE")
        return 1
    }
}

step2(sku) {
    changeStepLabelStatus("step2Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_all-config-in-one.ttl "STEP2" %sku%, , Hide, TTWinPID
    WinWait, STEP 2 DONE|STEP 2 FAILED
    IfWinExist, STEP 2 FAILED|CONNECTION ERROR
    {
        WinGetText, errMsg, STEP 2 FAILED
        step2ErrMsg = %errMsg%
        changeStepLabelStatus("step2Label", "FAIL")
        return 0
    }
    IfWinExist, STEP 2 DONE
    {
        changeStepLabelStatus("step2Label", "DONE")
        return 1
    }
}

;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;

;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL FUNCTIONs;;;;;;;;;;;
OnSkuDropDown() {
    GuiControlGet, skuDropList
    GuiControl, , skuNumberToRun, %skuDropList%
}

changeStepLabelStatus(ctrID := "", status := "") {
    Gui, 1: Default
    RegExMatch(ctrID, "\d", num)    ;Get button number in variable
    
    if (status = "PLAY") {
        Gui, Font, cdeb812 Bold
        GuiControl, Font, %ctrID%
        Gui, Font
        GuiControl, , process%num%, %playImg%
    } else if (status = "FAIL") {
        Gui, Font, cde1212 Bold
        GuiControl, Font, %ctrID%
        Gui, Font
        GuiControl, , process%num%, %xImg%
    } else if (status = "DONE") {
        Gui, Font, c0ac90a Bold
        GuiControl, Font, %ctrID%
        Gui, Font
        GuiControl, , process%num%, %checkImg%
    } else {
        Gui, Font, Bold
        GuiControl, Font, %ctrID%
        Gui, Font
        GuiControl, , process%num%,
    }
}

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

resetStepLabelStatus() {
    Gui, 1: Default
    index := 0
    Loop, 3
    {
        Gui, Font, Bold
        GuiControl, Font, step%index%Label
        Gui, Font
        GuiControl, , process%index%,
        GuiControl, Move, process%index%, w18 h18
        index++
    }
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