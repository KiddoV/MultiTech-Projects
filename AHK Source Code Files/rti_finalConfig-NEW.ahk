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
Gui, Add, Text, xs+40 ys+20 vstep0Label, STEP 0. Commissioning
Gui, Add, Text, xs+40 ys+45 vstep1Label, STEP 1. Ping Test
Gui, Add, Text, xs+40 ys+70 vstep2Label, STEP 2. Save OEM
Gui, Font
Gui Add, Text, xs+10 ys+90 w175 h2 +0x10
Gui, Add, Button, xs+20 ys+95 w50 h20 gRunStep0, Step 0
Gui, Add, Button, xs+120 ys+95 w50 h20 gRunStep1and2, Step 1&&2
Gui, Add, Button, xs+70 ys+120 w50 h30 gRunAll, RUN

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess0,
Gui, Add, Picture, xs+7 ys+42 w18 h18 +BackgroundTrans vprocess1,
Gui, Add, Picture, xs+7 ys+67 w18 h18 +BackgroundTrans vprocess2,

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
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running the final configuration steps for RTI?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (step0() = 0)
        {
            changeStepLabelStatus("step0Label", "FAIL")
            Progress, Off
            MsgBox, 16, STEP 0 FAILED, %step0ErrMsg%
            return
        }
        Progress, ZH0 M FS10, WAITING FOR CONDUIT TO REBOOT..., , STEP 0
        Sleep 200000
        Loop,
        {
            if (checkRTIStatus()) {
                Break
            }
            Sleep 5000
        }
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
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running LOGIN STEP for RTI?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (step0() = 0)
        {
            changeStepLabelStatus("step0Label", "FAIL")
            Progress, Off
            MsgBox, 16, STEP 0 FAILED, %step0ErrMsg%
            return
        }
        Progress, Off
        MsgBox, , STEP 0, STEP 0 LOGIN IS DONE. PLEASE WAIT UNTIL CONDUIT REBOOTED!
    }
    IfMsgBox Cancel
        Return
}

RunStep1and2() {
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start running STEP 1 AND 2 for RTI?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        if (checkRTIStatus()) {
            if (step1() = 0) {
                MsgBox, 16, STEP 1 FAILED, %step0ErrMsg%
                return
            }
                
            if (step2() = 0) {
                MsgBox, 16, STEP 2 FAILED, %step0ErrMsg%
                return
            }
                
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
    Loop, 100
    {
        Sleep 250
        if (A_Index = 100) {
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
    configPath := "C:\V-Projects\RTIAuto-FinalConfig\transfering-files\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz"
    objParam := { Filedata: [configPath] }
    CreateFormData(PostData, hdr_ContentType, objParam)
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

step1() {
    changeStepLabelStatus("step1Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_all-config-in-one.ttl "STEP1", , Hide, TTWinPID
    WinWait, STEP 1 DONE|STEP 1 FAILED
    IfWinExist, STEP 1 FAILED
    {
        changeStepLabelStatus("step1Label", "FAIL")
        return 0
    }
    IfWinExist, STEP 1 DONE
    {
        changeStepLabelStatus("step1Label", "DONE")
        return 1
    }
}

step2() {
    changeStepLabelStatus("step2Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\RTIAuto-FinalConfig\ttl\rti_all-config-in-one.ttl "STEP2", , Hide, TTWinPID
    WinWait, STEP 2 DONE|STEP 2 FAILED
    IfWinExist, STEP 2 FAILED
    {
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

; CreateFormData() by tmplinshi, AHK Topic: https://autohotkey.com/boards/viewtopic.php?t=7647
; Thanks to Coco: https://autohotkey.com/boards/viewtopic.php?p=41731#p41731
; Modified version by SKAN, 09/May/2016

CreateFormData(ByRef retData, ByRef retHeader, objParam) {
	New CreateFormData(retData, retHeader, objParam)
}

Class CreateFormData {

	__New(ByRef retData, ByRef retHeader, objParam) {

		Local CRLF := "`r`n", i, k, v, str, pvData
		; Create a random Boundary
		Local Boundary := this.RandomBoundary()
		Local BoundaryLine := "------------------------------" . Boundary

    this.Len := 0 ; GMEM_ZEROINIT|GMEM_FIXED = 0x40
    this.Ptr := DllCall( "GlobalAlloc", "UInt",0x40, "UInt",1, "Ptr"  )          ; allocate global memory

		; Loop input paramters
		For k, v in objParam
		{
			If IsObject(v) {
				For i, FileName in v
				{
					str := BoundaryLine . CRLF
					     . "Content-Disposition: form-data; name=""" . k . """; filename=""" . FileName . """" . CRLF
					     . "Content-Type: " . this.MimeType(FileName) . CRLF . CRLF
          this.StrPutUTF8( str )
          this.LoadFromFile( Filename )
          this.StrPutUTF8( CRLF )
				}
			} Else {
				str := BoundaryLine . CRLF
				     . "Content-Disposition: form-data; name=""" . k """" . CRLF . CRLF
				     . v . CRLF
        this.StrPutUTF8( str )
			}
		}

		this.StrPutUTF8( BoundaryLine . "--" . CRLF )

    ; Create a bytearray and copy data in to it.
    retData := ComObjArray( 0x11, this.Len ) ; Create SAFEARRAY = VT_ARRAY|VT_UI1
    pvData  := NumGet( ComObjValue( retData ) + 8 + A_PtrSize )
    DllCall( "RtlMoveMemory", "Ptr",pvData, "Ptr",this.Ptr, "Ptr",this.Len )

    this.Ptr := DllCall( "GlobalFree", "Ptr",this.Ptr, "Ptr" )                   ; free global memory 

    retHeader := "multipart/form-data; boundary=----------------------------" . Boundary
	}

  StrPutUTF8( str ) {
    Local ReqSz := StrPut( str, "utf-8" ) - 1
    this.Len += ReqSz                                  ; GMEM_ZEROINIT|GMEM_MOVEABLE = 0x42
    this.Ptr := DllCall( "GlobalReAlloc", "Ptr",this.Ptr, "UInt",this.len + 1, "UInt", 0x42 )   
    StrPut( str, this.Ptr + this.len - ReqSz, ReqSz, "utf-8" )
  }
  
  LoadFromFile( Filename ) {
    Local objFile := FileOpen( FileName, "r" )
    this.Len += objFile.Length                     ; GMEM_ZEROINIT|GMEM_MOVEABLE = 0x42 
    this.Ptr := DllCall( "GlobalReAlloc", "Ptr",this.Ptr, "UInt",this.len, "UInt", 0x42 )
    objFile.RawRead( this.Ptr + this.Len - objFile.length, objFile.length )
    objFile.Close()       
  }

	RandomBoundary() {
		str := "0|1|2|3|4|5|6|7|8|9|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z"
		Sort, str, D| Random
		str := StrReplace(str, "|")
		Return SubStr(str, 1, 12)
	}

	MimeType(FileName) {
		n := FileOpen(FileName, "r").ReadUInt()
		Return (n        = 0x474E5089) ? "image/png"
		     : (n        = 0x38464947) ? "image/gif"
		     : (n&0xFFFF = 0x4D42    ) ? "image/bmp"
		     : (n&0xFFFF = 0xD8FF    ) ? "image/jpeg"
		     : (n&0xFFFF = 0x4949    ) ? "image/tiff"
		     : (n&0xFFFF = 0x4D4D    ) ? "image/tiff"
		     : "application/octet-stream"
	}

}