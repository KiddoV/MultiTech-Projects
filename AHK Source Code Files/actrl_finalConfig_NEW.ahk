 /*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;;;;;;;;;;;;;;;;;;Installs Files;;;;;;;;;;;;;;;;;
IfNotExist C:\V-Projects\ACTRLAuto-FinalConfig\caches
    FileCreateDir C:\V-Projects\ACTRLAuto-FinalConfig\caches
IfNotExist C:\V-Projects\ACTRLAuto-FinalConfig\ttl
    FileCreateDir C:\V-Projects\ACTRLAuto-FinalConfig\ttl
IfNotExist C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui
    FileCreateDir C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui
IfNotExist C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files
    FileCreateDir C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files

FileInstall C:\MultiTech-Projects\TTL-Files\actrl_check_status_new.ttl, C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_check_status_new.ttl, 1
FileInstall C:\MultiTech-Projects\TTL-Files\actrl_all-config-in-one_new.ttl, C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one_new.ttl, 1

FileInstall C:\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\check_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\x_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\play_orange.png, 1

FileInstall C:\vbtest\MTCDT\MTCDT-L4N1-240A-ATT-INST-ACTRL\config_MTCDT-L4N1-247A_5_1_2_01_21_20_CumulusAPN.tar.gz, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\config_MTCDT-L4N1-247A_5_1_2_01_21_20_CumulusAPN.tar.gz, 1
FileInstall C:\vbtest\MTCDT\MTCDT-L4N1-240A-ATT-INST-ACTRL\conduit-external-mlinux4-0.1.0.tar.gz, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\conduit-external-mlinux4-0.1.0.tar.gz, 1
FileInstall C:\vbtest\MTCDT\MTCDT-L4N1-240A-ATT-INST-ACTRL\20_000_001_000_conduit_mlinux4_install, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\20_000_001_000_conduit_mlinux4_install, 1
FileInstall C:\vbtest\MTCDT\MTCDT-L4N1-240A-ATT-INST-ACTRL\30_001_007_008_acutrol_mlinux4_install, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\30_001_007_008_acutrol_mlinux4_install, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global actrlCheckStatTTLFilePath := "C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_check_status_new.ttl"
Global actrlMainRunConfigFilePath := "C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one_new.ttl"
Global actrlStatusCacheFilePath := "C:\V-Projects\ACTRLAuto-FinalConfig\caches\actrl_status_new.dat"

Global xImg := "C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\x_mark.png"
Global checkImg := "C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\check_mark.png"
Global playImg := "C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\play_orange.png"

Global step1ErrMsg := "Unknown ERROR!!?"
Global step2ErrMsg := "Unknown ERROR!!?"
Global step3ErrMsg := "UnKnown ERROR!!?"
Global step4ErrMsg := "Unknown ERROR!!?"
Global step5ErrMsg := "Unknown ERROR!!?"

;;;;;;;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;;;;;;
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\JSON_ToObj.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\CreateFormData.ahk
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, Add, GroupBox, xm+0 ym+0 w255 h190 Section, ACUTROL-94557716LF
Gui, Font, Bold
Gui, Add, Text, xs+35 ys+20 vstep1Label, STEP 1. Commissioning
Gui, Add, Text, xs+35 ys+45 vstep2Label, STEP 2. Upload External MLinux4
Gui, Add, Text, xs+35 ys+70 vstep3Label, STEP 3. Upload 20_000_001_000
Gui, Add, Text, xs+35 ys+95 vstep4Label, STEP 4. Upload 30_001_007_008
Gui, Font

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess1,
Gui, Add, Picture, xs+7 ys+42 w18 h18 +BackgroundTrans vprocess2,
Gui, Add, Picture, xs+7 ys+67 w18 h18 +BackgroundTrans vprocess3,
Gui, Add, Picture, xs+7 ys+92 w18 h18 +BackgroundTrans vprocess4,

Gui Add, Text, xs+10 ys+115 w240 h2 +0x10
Gui, Add, Button, xs+35 ys+120 w65 h20 gRunStep1, STEP 1
Gui, Add, Button, xs+160 ys+120 w65 h20 gRunStep2to4, STEP 2=>4
Gui, Add, Button, xs+100 ys+145 w60 h40 gRunAll, RUN

;;;Functions to run BEFORE main gui started;;;

posX := A_ScreenWidth - 300
posY := A_ScreenHeight - 900
Gui, Show, x%posX% y%posY%, Acutrol Auto-Final Configurator    ;Starts GUI

;;;Functions to run AFTER main gui started;;;

Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;Callback Funtions
CloseSSLHelper:
    IfWinExist, Security Alert
    {
        ControlClick, Button1, Security Alert, , Left, 2
        Sleep 100
        IfWinNotExist, Security Alert
            SetTimer, CloseSSLHelper, Off
    }
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GuiEscape:
GuiClose:
    ExitApp
;===============================================;
;;;;;;;;;;;;;Main Functions;;;;;;;;;;;;;;;;
RunAll() {
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running All 5 STEPs for Acutrol?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        StartTime := A_TickCount
        if (Step1() = 0)
        {
            changeStepLabelStatus("step1Label", "FAIL")
            Progress, Off
            MsgBox, 16, STEP 1 FAILED, %step1ErrMsg%
            return
        }
        Progress, ZH0 M FS10, FINISHED STEP 1`nWAITING FOR CONDUIT TO REBOOT..., , STEP 1
        Sleep 250000
        Loop,
        {
            if (checkActrlStatus()) {
                Break
            }
            Sleep 5000
        }
        Progress, Off
        if (Step2() = 0) {
            MsgBox, 16, STEP 2 FAILED, %step2ErrMsg%
            return
        }
        Progress, ZH0 M FS10, FINISHED STEP 2`nWAITING FOR CONDUIT TO REBOOT..., , STEP 2
        Sleep 230000
        Loop,
        {
            if (checkActrlStatus()) {
                Break
            }
            Sleep 5000
        }
        Progress, Off
        
        if (Step3() = 0) {
            MsgBox, 16, STEP 3 FAILED, %step3ErrMsg%
            return
        }
        Progress, ZH0 M FS10, FINISHED STEP 3`nWAITING FOR CONDUIT TO REBOOT..., , STEP 3
        Sleep 300000
        Loop,
        {
            if (checkActrlStatus()) {
                Break
            }
            Sleep 5000
        }
        Progress, Off
        
        if (Step4() = 0) {
            MsgBox, 16, STEP 4 FAILED, %step3ErrMsg%
            return
        }
        EndTime := A_TickCount - StartTime
        totalTimeInMin := (EndTime / 1000) / 60
        ;RegExMatch(totalTimeInMin, "[1-9]*.[0-9]{2}", totalTimeInMin)
        totalTimeInMin := Round(totalTimeInMin, 2)
        FormatTime, timeNow, , hh:mm:ss tt
        OnMessage(0x44, "CheckIcon") ;Add icon
        MsgBox 0x81, FINISHED, Finished auto-final configuration for ACUTROL.`nFinished at: %timeNow% -- Total run time: %totalTimeInMin% (Minutes)
        OnMessage(0x44, "") ;Clear icon
    }
    IfMsgBox Cancel
        Return
}

RunStep1() {
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running COMMISSIONING STEP for ACUTROL?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (Step1() = 0)
        {
            changeStepLabelStatus("step1Label", "FAIL")
            Progress, Off
            MsgBox, 16, STEP 0 FAILED, %step1ErrMsg%
            return
        }
        Progress, Off
        MsgBox, 64, STEP 1, COMMISSIONING STEP IS DONE. PLEASE WAIT UNTIL CONDUIT REBOOTED!
    }
    IfMsgBox Cancel
        Return
}

RunStep2to4() {
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running STEP 2 Through 4 for ACUTROL?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (checkActrlStatus()) {
            if (Step2() = 0) {
                MsgBox, 16, STEP 2 FAILED, %step2ErrMsg%
                return
            }
            Progress, ZH0 M FS10, FINISHED STEP 2`nWAITING FOR CONDUIT TO REBOOT..., , STEP 2
            Sleep 230000
            Loop,
            {
                if (checkActrlStatus()) {
                    Break
                }
                Sleep 5000
            }
            Progress, Off
            
            if (Step3() = 0) {
                MsgBox, 16, STEP 4 FAILED, %step3ErrMsg%
                return
            }
            Progress, ZH0 M FS10, FINISHED STEP 3`nWAITING FOR CONDUIT TO REBOOT..., , STEP 3
            Sleep 300000
            Loop,
            {
                if (checkActrlStatus()) {
                    Break
                }
                Sleep 5000
            }
            Progress, Off
            
            if (Step4() = 0) {
                MsgBox, 16, STEP 4 FAILED, %step4ErrMsg%
                return
            }
            
            OnMessage(0x44, "CheckIcon") ;Add icon
            MsgBox 0x80, STEP 2=>4, STEP 2 through 4 are DONE!!
            OnMessage(0x44, "") ;Clear icon
                
        } else {
            MsgBox, 16, ERROR, ACUTROL is not READY!`nPlease wait or check connection!
            return
        }
    }
    IfMsgBox Cancel
        Return
}

;;;;;;;;;
Step1() {
    changeStepLabelStatus("step1Label", "PLAY")
    Progress, ZH0 M FS10, RUNNING COMMISSIONING FOR ACUTROL`, PLEASE WAIT......., , STEP 1
    RunWait, Taskkill /f /im iexplore.exe, , Hide   ;Fix bug where IE open many times
    
    req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;For http request
    
    ;;;Check connection and Bypass security
    Sleep 1000
    SetTimer, CloseSSLHelper, 100
    Progress, ZH0 M FS10, CHECKING FOR CONNECTION..., , STEP 1
    step1ErrMsg = Failed to connect to <https://192.168.2.1/commissioning>`nERR: TIMEOUT!!!
    url := "https://192.168.2.1/api/commissioning"
    req.open("GET", url, True)
    req.Send()
    Loop, 50
    {
        Sleep 1000
        if (A_Index = 50) {
            ToolTip HERE! %A_Index%
            step1ErrMsg = Failed to connect to <https://192.168.2.1/commissioning>`nERR: TIMEOUT!!!
            return 0
        } else if (req.readyState = 4){
            Break
        }
    }
    resObj := json_toobj(req.responseText)
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, BYPASS SECURITY SUCCESSFULY!, , STEP 1
        Sleep 1000
    } else if (resObj.error = "commissioning is finished") {
        Progress, ZH0 M FS10, COMMISSIONING IS FINISHED!`nGO TO LOGIN STEP!..., , STEP 1
        Sleep 1000
        Goto Login-Step 
    } else {
        Progress, ZH0 M FS10 CTde1212, BYPASS SECURITY FALIED!, , STEP 1
        return 0
    }
    
    ;;;Setting new Username and password
    Progress, ZH0 M FS10, SETTING UP NEW USERNAME AS "admin"..., , STEP 1
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
        Progress, ZH0 M FS10 CT0ac90a, SET NEW USERNAME SUCCESSFULY!, , STEP 1
        Sleep 500
    } else if (resObj.error = "commissioning is finished") {
        Progress, ZH0 M FS10, COMMISSIONING IS FINISHED!`nGO TO LOGIN STEP!..., , STEP 1
        Sleep 500
        Goto Login-Step
    } else {
        Progress, ZH0 M FS10 CTde1212, SET NEW USERNAME FALIED!, , STEP 1
        Sleep 500
        return 0
    }
    userToken := resObj.result.aasID
    
    Progress, ZH0 M FS10, SETTING UP NEW PASSWORD AS "Multitech_123"..., , STEP 1
    Sleep 1000
    json =
    (LTrim
        {"username":"admin","aasID":"%userToken%","aasAnswer":"Multitech_123"}
    )
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, SET NEW PASSWORD SUCCESSFULY!, , STEP 1
        Sleep 500
    } else {
        step1ErrMsg = SET NEW PASSWORD FALIED!
        return 0
    }
    
    Progress, ZH0 M FS10, CONFIRMMING NEW PASSWORD..., , STEP 1
    Sleep 1000
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, CONFIRM NEW PASSWORD SUCCESSFULY!, , STEP 1
        Sleep 500
    } else {
        step1ErrMsg = CONFIRM NEW PASSWORD FALIED!
        return 0
    }
    
    ;;;Login STEP
    Login-Step:
    Progress, ZH0 M FS10, LOGGING IN..., , STEP 1
    Sleep 1500
    url:= "https://192.168.2.1/api/login?username=admin&password=Multitech_123"
    req.Open("GET", url, False)
    req.Send()
    resObj := json_toobj(req.responseText)
    
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, LOGIN SUCCESSFULY!, , STEP 1
    } else {
        errMsg := Format("{:U}", resObj.error)  ;CAP string
        step1ErrMsg = LOGIN FALIED!`nERR: %errMsg%
        return 0
    }
    uploadConfigToken := resObj.result.token
    Sleep 2000
    
    ;;;Upload file STEP
    Progress, ZH0 M FS10, UPLOADING CONFIGURATION FILE..., , STEP 1
    Sleep 1000
    
    url:= "https://192.168.2.1/api/command/upload_config?token=%uploadConfigToken%"
    configPath := "C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\config_MTCDT-L4N1-247A_5_1_2_01_21_20_CumulusAPN.tar.gz"
    objParam := { Filedata: [configPath] }
    CreateFormData(PostData, hdr_ContentType, objParam)     ;Create a form data to send file to the server
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", hdr_ContentType)
    req.Send(PostData)

    resObj := json_toobj(req.responseText)
    ;MsgBox % req.responseText
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, UPLOAD CONFIG FILE SUCCESSFULY!, , STEP 1
        Sleep 500
    } else {
        errMsg := Format("{:U}", resObj.error)  ;CAP string
        step0ErrMsg = UPLOAD CONFIG FILE FALIED!`nERR: %errMsg%
        ;Progress, ZH0 M FS10 CTde1212 W350, ERR: %errMsg%, UPLOAD CONFIG FILE FALIED!, STEP 1
        return 0
    }
    
    changeStepLabelStatus("step1Label", "DONE")
    return 1
}

Step2() {
    changeStepLabelStatus("step2Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE %actrlMainRunConfigFilePath% "STEP2", , Hide, TTWinPID
    
    WinWait, STEP 2 DONE|STEP 2 FAILED|MACRO: Error
    IfWinExist, STEP 2 FAILED|CONNECTION ERROR|MACRO: Error
    {
        WinGetText, errMsg, STEP 2 FAILED
        if (errMsg != "")
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

Step3() {
    changeStepLabelStatus("step3Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE %actrlMainRunConfigFilePath% "STEP3", , Hide, TTWinPID
    
    WinWait, STEP 3 DONE|STEP 3 FAILED|MACRO: Error
    IfWinExist, STEP 3 FAILED|CONNECTION ERROR|MACRO: Error
    {
        WinGetText, errMsg, STEP 3 FAILED
        if (errMsg != "")
            step3ErrMsg = %errMsg%
        changeStepLabelStatus("step3Label", "FAIL")
        return 0
    }
    IfWinExist, STEP 3 DONE
    {
        changeStepLabelStatus("step3Label", "DONE")
        return 1
    }
}

Step4() {
    changeStepLabelStatus("step4Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE %actrlMainRunConfigFilePath% "STEP4", , Hide, TTWinPID
    
    WinWait, STEP 4 DONE|STEP 4 FAILED|MACRO: Error
    IfWinExist, STEP 4 FAILED|CONNECTION ERROR|MACRO: Error
    {
        WinGetText, errMsg, STEP 4 FAILED
        if (errMsg != "")
            step4ErrMsg = %errMsg%
        changeStepLabelStatus("step4Label", "FAIL")
        return 0
    }
    IfWinExist, STEP 4 DONE
    {
        changeStepLabelStatus("step4Label", "DONE")
        return 1
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
checkActrlStatus() {
    cmd := "ping 192.168.2.1 -n 1 -w 1000"
    RunWait, %cmd%,, Hide
    if (ErrorLevel = 1) {
        return False
    }
    if (ErrorLevel = 0) {
        RunWait, %ComSpec% /c start C:\teraterm\ttermpro.exe /V /M=%actrlCheckStatTTLFilePath% /nossh , ,Hide, TTWinPID
        FileRead, actrlStatus, %actrlStatusCacheFilePath%
        if (actrlStatus != "SUCCESSED") {
            return False
        }
    }
    return True
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

resetStepLabelStatus() {
    Gui, 1: Default
    index := 0
    Loop, 6
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