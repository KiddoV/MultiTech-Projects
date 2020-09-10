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
IfNotExist C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\transfering-files
    FileCreateDir C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\transfering-files
IfNotExist C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\ttl
    FileCreateDir C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\ttl
IfNotExist C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\caches
    FileCreateDir C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\caches
IfNotExist C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\imgs-for-gui
    FileCreateDir C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\imgs-for-gui

FileInstall C:\MultiTech-Projects\TTL-Files\mtcap_92507516LF_check_status.ttl, C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\ttl\mtcap_92507516LF_check_status.ttl, 1
FileInstall C:\MultiTech-Projects\TTL-Files\mtcap_92507516LF_all-config-in-one.ttl, C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\ttl\mtcap_92507516LF_all-config-in-one.ttl, 1

FileInstall C:\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\imgs-for-gui\check_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\imgs-for-gui\x_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\imgs-for-gui\play_orange.png, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global ttlCheckStatusFile := "C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\ttl\mtcap_92507516LF_check_status.ttl"
Global ttlMainConfigRunFile := "C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\ttl\mtcap_92507516LF_all-config-in-one.ttl"

Global xImg := "C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\imgs-for-gui\x_mark.png"
Global checkImg := "C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\imgs-for-gui\check_mark.png"
Global playImg := "C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\imgs-for-gui\play_orange.png"

Global step1ErrMsg := "Unknown ERROR!!?"
Global step2ErrMsg := "Unknown ERROR!!?"
Global step3ErrMsg := "UnKnown ERROR!!?"
;;;;;;;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;;;;;;


;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;
Gui, Add, GroupBox, xm+0 ym+0 w275 h130 Section, MTCAP-92507516LF
Gui, Font, Bold
Gui, Add, Text, xs+40 ys+20 vstep1Label, STEP 1. First-Time Setup
Gui, Add, Text, xs+40 ys+45 vstep2Label, STEP 2. Setup Base Package
Gui, Add, Text, xs+40 ys+70 vstep3Label, STEP 3. Transfer Other Config Files
Gui, Font

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess1, 
Gui, Add, Picture, xs+7 ys+42 w18 h18 +BackgroundTrans vprocess2, 
Gui, Add, Picture, xs+7 ys+67 w18 h18 +BackgroundTrans vprocess3, 

Gui Add, Text, xs+10 ys+90 w255 h2 +0x10
Gui, Add, Button, xs+247 ys+16 w20 h20 gStep1, 1
Gui, Add, Button, xs+247 ys+41 w20 h20 gStep2, 2
Gui, Add, Button, xs+247 ys+66 w20 h20 gStep3, 3
Gui, Add, Button, xs+115 ys+95 w50 h30 gRunAll, RUN

posX := A_ScreenWidth - 350
posY := A_ScreenHeight - 900
Gui, Show, x%posX% y%posY%, MTCAP-92507516LF Auto Final Configurator    ;Starts GUI

Return ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GuiClose:
    ExitApp
Return

;===============================================;
;;;;;;;;;;;;;;;;;;;;;MAIN FUNCTIONs;;;;;;;;;;;;;;
RunAll() {
    resetStepLabelStatus()
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN CONFIGURATION, Start Running All 3 STEPs for MTCAP-92507516?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        StartTime := A_TickCount
        if (checkMTCAPStatus()) {
            if (step1() = 0) {
                MsgBox, 16, STEP 1 FAILED, %step1ErrMsg%
                return
            }
            Progress, ZH0 M FS10, FINISHED STEP 1`nWAITING FOR MTCAP TO REBOOT..., , STEP 1
            Sleep 200000
            Loop,
            {
                if (checkMTCAPStatus()) {
                    Break
                }
                Sleep 5000
            }
            Progress, Off
                      
            if (step2() = 0) {
                MsgBox, 16, STEP 2 FAILED, %step2ErrMsg%
                return
            }
            
            Progress, ZH0 M FS10, FINISHED STEP 2`nWAITING FOR MTCAP TO REBOOT..., , STEP 2
            Sleep 230000
            Loop,
            {
                if (checkMTCAPStatus()) {
                    Break
                }
                Sleep 5000
            }
            Progress, Off
            
            if (step3() = 0) {
                MsgBox, 16, STEP 2 FAILED, %step3ErrMsg%
                return
            }
            EndTime := A_TickCount - StartTime
            totalTimeInMin := (EndTime / 1000) / 60
            RegExMatch(totalTimeInMin, "[1-9]*.[0-9]{2}", totalTimeInMin) 
            FormatTime, timeNow, , hh:mm:ss tt
            OnMessage(0x44, "CheckIcon") ;Add icon
            MsgBox 0x80, ALL STEPs, All 3 STEPs are DONE!!`nFinished at: %timeNow% -- Total run time: %totalTimeInMin% (Minutes)
            OnMessage(0x44, "") ;Clear icon
                
        } else {
            MsgBox, 16, ERROR, MTCAP is not READY!`nPlease wait or check connection!
            return
        }
    }
    IfMsgBox Cancel
        Return
}

Step1() {
    changeStepLabelStatus("step1Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE %ttlMainConfigRunFile% "STEP1", , Hide, TTWinPID
    
    WinWait, STEP 1 DONE|STEP 1 FAILED|MACRO: Error
    IfWinExist, STEP 1 FAILED|CONNECTION ERROR|MACRO: Error
    {
        WinGetText, errMsg, STEP 1 FAILED
        if (errMsg != "")
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

Step2() {
    changeStepLabelStatus("step2Label", "PLAY")
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE %ttlMainConfigRunFile% "STEP2", , Hide, TTWinPID
    
    WinWait, STEP 2 DONE|STEP 2 FAILED|MACRO: Error
    IfWinExist, STEP 2 FAILED|CONNECTION ERROR
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
    Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE %ttlMainConfigRunFile% "STEP3", , Hide, TTWinPID
    
    WinWait, STEP 3 DONE|STEP 3 FAILED|MACRO: Error
    IfWinExist, STEP 3 FAILED|CONNECTION ERROR
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

;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs;;;;;;;;;;;;;;;;

;===============================================;
;;;;;;;;;;;;;;;;;;ADDITIONAL FUNCTIONs;;;;;;;;;;;
resetStepLabelStatus() {
    Gui, 1: Default
    index := 0
    Loop, 4
    {
        Gui, Font, Bold
        GuiControl, Font, step%index%Label
        Gui, Font
        GuiControl, , process%index%,
        GuiControl, Move, process%index%, w18 h18
        index++
    }
}

checkMTCAPStatus() {
    cmd := "ping 192.168.2.1 -n 1 -w 1000"
    RunWait, %cmd%,, Hide
    if (ErrorLevel = 1) {
        return False
    }
    if (ErrorLevel = 0) {
        RunWait, %ComSpec% /c start C:\teraterm\ttermpro.exe /V /M=%ttlCheckStatusFile% /nossh , ,Hide, TTWinPID
        FileRead, actrlStatus, C:\V-Projects\MTCAP-92507516LF-Auto-FinalConfig\caches\mtcap_status.dat
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
