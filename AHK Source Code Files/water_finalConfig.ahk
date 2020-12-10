 /*
    Author: Viet Ho
*/
;=======================================================================================;
SetTitleMatchMode, RegEx
#SingleInstance Force
#NoEnv
SetBatchLines -1
;;;;;;;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;;;;;;
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\JSON_ToObj.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\CreateFormData.ahk
;=======================================================================================;
;;;;;;;;;;;;;;;;;;Installs Files;;;;;;;;;;;;;;;;;
IfNotExist C:\V-Projects\WATER-FinalConfig\imgs-for-gui
    FileCreateDir C:\V-Projects\WATER-FinalConfig\imgs-for-gui
IfNotExist C:\V-Projects\WATER-FinalConfig\transfering-files
    FileCreateDir C:\V-Projects\WATER-FinalConfig\transfering-files
    
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\WATER-FinalConfig\imgs-for-gui\check_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\WATER-FinalConfig\imgs-for-gui\x_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\WATER-FinalConfig\imgs-for-gui\play_orange.png, 1

FileInstall C:\vbtest\MTCDT\MTCDT-LAT1-240A-915-ECL-WATER\config_MTCDT-LAT1-240A_1_7_4_04_15_20_with_UTC.tar.gz, C:\V-Projects\WATER-FinalConfig\transfering-files\config_MTCDT-LAT1-240A_1_7_4_04_15_20_with_UTC.tar.gz
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global actrlCheckStatTTLFilePath := "C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_check_status_new.ttl"
Global actrlMainRunConfigFilePath := "C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one_new.ttl"
Global actrlStatusCacheFilePath := "C:\V-Projects\ACTRLAuto-FinalConfig\caches\actrl_status_new.dat"

Global xImg := "C:\V-Projects\WATER-FinalConfig\imgs-for-gui\x_mark.png"
Global checkImg := "C:\V-Projects\WATER-FinalConfig\imgs-for-gui\check_mark.png"
Global playImg := "C:\V-Projects\WATER-FinalConfig\imgs-for-gui\play_orange.png"

Global ErrMsg := "Unknown"
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, Add, Text, x100 y10, WATER-94557670LF
Gui, Add, GroupBox, xm+0 ym+15 w275 h130 Section, Part 1
Gui, Font, Bold
Gui, Add, Text, xs+35 ys+20 vstep1Label, STEP 1. Confirmation and Upload Config
Gui, Add, Text, xs+35 ys+45 vstep2Label, STEP 2. Installation of Upgrade Scripts
Gui, Add, Text, xs+35 ys+70 vstep3Label, STEP 3. Copy Install/Upgrade Packages
Gui, Font

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess1,
Gui, Add, Picture, xs+7 ys+42 w18 h18 +BackgroundTrans vprocess2,
Gui, Add, Picture, xs+7 ys+67 w18 h18 +BackgroundTrans vprocess3,

Gui, Add, Button, xs+100 ys+100 w75 h25 gRunPart1, RUN PART 1

Gui, Add, Text, x11 y155, Run Commission Controller before running Part 2

Gui, Add, GroupBox, xm+0 ym+165 w275 h80 Section, Part 2
Gui, Font, Bold
Gui, Add, Text, xs+35 ys+20 vstep4Label, STEP 4. Install Security Package
Gui, Font

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess4,

Gui, Add, Button, xs+100 ys+50 w75 h25 gRunPart2, RUN PART 2
;;;Functions to run BEFORE main gui started;;;

posX := A_ScreenWidth - 300
posY := A_ScreenHeight - 900
Gui, Show, x%posX% y%posY%, Water Auto-Final Configurator    ;Starts GUI

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
~^q::
GuiClose:
    ExitApp
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;Main Functions;;;;;;;;;;;;;;;;
RunPart1() {
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, Begin Part 1, Start running PART 1 (All 3 steps) for WATER?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox Cancel
        Return
    IfMsgBox OK
    {
        if (Step1() = 0)
        {
            changeStepLabelStatus("step1Label", "FAIL")
            Progress, Off
            MsgBox, 16, STEP 1 FAILED, %ErrMsg%
            return
        }
        Progress, ZH0 M FS10, FINISHED STEP 1`nWAITING FOR CONDUIT TO REBOOT..., , STEP 1
        Sleep 250000
        Loop,
        {
            if (checkConduitStatus()) {
                Break
            }
            Sleep 5000
        }
        Progress, Off
    }
}

RunPart2() {
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, Begin Part 2, Start running PART 2 (Only step 4) for WATER?`nRemember to run Commission Controller before doing this step!
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox Cancel
        Return
    IfMsgBox OK
    {
        
    }
}

Step1() {
    changeStepLabelStatus("step1Label", "PLAY")
    RunWait, Taskkill /f /im iexplore.exe, , Hide   ;Fix bug where IE open many times
    
    req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;For http request
    
    ;;Login to conduit
    Progress, ZH0 M FS10, LOGIN TO CONDUIT`, PLEASE WAIT......., , STEP 1
    Sleep 1000
    SetTimer, CloseSSLHelper, 100
    url := "https://192.168.2.1/api/login?username=admin&password=admin"
    req.open("GET", url, True)
    req.Send()
    Loop, 50
    {
        Sleep 1000
        if (A_Index = 50) {
            ErrMsg = Failed to connect to <https://192.168.2.1/>`nERR: TIMEOUT!!!
            return 0
        } else if (req.readyState = 4){
            Break
        }
    }
    resObj := json_toobj(req.responseText)
    loginToken := resObj.result.token
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, LOGIN SUCCESSFULY!, , STEP 1
        Sleep 500
    } else {
        Progress, ZH0 M FS10 CTde1212, LOGIN FALIED!, , STEP 1
        Sleep 500
        return 0
    }
    
    ;;Check firmware version
    Progress, ZH0 M FS10, CHECKING FIRMWARE VERSION......., , STEP 1
    url := "https://192.168.2.1/api/system"
    req.open("GET", url, True)
    req.Send()
    Loop, 50
    {
        Sleep 1000
        if (A_Index = 50) {
            ErrMsg = Failed to connect to <https://192.168.2.1/>`nERR: TIMEOUT!!!
            return 0
        } else if (req.readyState = 4){
            Break
        }
    }
    resObj := json_toobj(req.responseText)
    if (resObj.result.firmware = "1.7.4") {
        Progress, ZH0 M FS10 CT0ac90a, CORRECT FIMWARE: 1.7.4, , STEP 1
        Sleep 500
    } else {
        ErrMsg = ZH0 M FS10 CT0ac90a, INCORRECT FIMWARE! EXPECTED: 1.7.4
        return 0
    }
    
    ;;Disable first time set up
    Progress, ZH0 M FS10, DISABLING FIRST TIME SET UP......., , STEP 1
    url := "https://192.168.2.1/api/system"
    json =
    (LTrim
        {"firstTimeSetup" : "false"}
    )
    req.Open("PUT", url, True)
    req.SetRequestHeader("Content-Type", "application/json")
    req.Send(json)
    Loop, 50
    {
        Sleep 1000
        if (A_Index = 50) {
            ErrMsg = Failed to connect to <https://192.168.2.1/>`nERR: TIMEOUT!!!
            return 0
        } else if (req.readyState = 4){
            Break
        }
    }
    resObj := json_toobj(req.responseText)
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, DISABLING FIRST TIME SET UP SUCCESSFULY, , STEP 1
        Sleep 500
    } else {
        errMsg := Format("{:U}", resObj.error)  ;CAP string
        ErrMsg = DISABLING FIRST TIME SET UP FALIED!`nERR: %errMsg%
        return 0
    }
    Progress, ZH0 M FS10, SAVING SET UP......., , STEP 1
    url := "https://192.168.2.1/api/command/save"
    req.Open("POST", url, True)
    req.Send()
    Loop, 50
    {
        Sleep 1000
        if (A_Index = 50) {
            ErrMsg = Failed to connect to <https://192.168.2.1/>`nERR: TIMEOUT!!!
            return 0
        } else if (req.readyState = 4){
            Break
        }
    }
    resObj := json_toobj(req.responseText)
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, SAVE SET UP SUCCESSFULY, , STEP 1
        Sleep 500
    } else {
        errMsg := Format("{:U}", resObj.error)  ;CAP string
        ErrMsg = SAVE SET UP FALIED!`nERR: %errMsg%
        return 0
    }
    
    ;;Upload config file
    Progress, ZH0 M FS10, UPLOADING CONFIGURATION FILE..., , STEP 1
    Sleep 1000
    ;MsgBox % loginToken
    url:= "https://192.168.2.1/api/command/upload_config?token=%loginToken%"
    configPath := "C:\V-Projects\WATER-FinalConfig\transfering-files\config_MTCDT-LAT1-240A_1_7_4_04_15_20_with_UTC.tar.gz"
    objParam := { Filedata: [configPath] }
    CreateFormData(PostData, hdr_ContentType, objParam)     ;Create a form data to send file to the server
    req.Open("POST", url, False)
    req.SetRequestHeader("Content-Type", hdr_ContentType)
    req.Send(PostData)

    resObj := json_toobj(req.responseText)
    if (resObj.status = "success") {
        Progress, ZH0 M FS10 CT0ac90a, UPLOAD CONFIG FILE SUCCESSFULY!, , STEP 1
        Sleep 500
    } else {
        errMsg := Format("{:U}", resObj.error)  ;CAP string
        ErrMsg = UPLOAD CONFIG FILE FALIED!`nERR: %errMsg%
        return 0
    }
    changeStepLabelStatus("step1Label", "DONE")
    return 1
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
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

;httpRequest(url, method, json := "", package := "") {
    ;req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;For http request
    ;resText := ""
    ;
    ;if (method == "GET") {
        ;req.open("GET", url, True)
        ;req.Send()
        ;Loop, 50
        ;{
            ;Sleep 1000
            ;if (A_Index = 50) {
                ;return
            ;} else if (req.readyState = 4){
                ;Break
            ;}
        ;}
    ;} else if (method == "POST") {
        ;
    ;}
;}

checkConduitStatus() {
    cmd := "ping 192.168.2.1 -n 1 -w 1000"
    RunWait, %cmd%,, Hide
    if (ErrorLevel = 1) {
        return False
    }
    if (ErrorLevel = 0) {
        
    }
    return True
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