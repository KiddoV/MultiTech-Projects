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

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\actrl_check_status.ttl, C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_check_status.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\actrl_all-config-in-one.ttl, C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one.ttl, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global actrlStatusCacheFilePath := "C:\V-Projects\ACTRLAuto-FinalConfig\caches\actrl_status.dat"

;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, Add, GroupBox, xm+0 ym+0 w260 h200 Section
Gui, Font, Bold
Gui, Add, Text, xs+30 ys+20, STEP 1. Checking LAN Connection
Gui, Add, Text, xs+30 ys+45, STEP 2. Transfering Configuration File
Gui, Add, Text, xs+30 ys+70, STEP 3. Importing Configuration
Gui, Add, Text, xs+30 ys+95, STEP 4. Transfering Upgrading Files
Gui, Add, Text, xs+30 ys+120, STEP 5. Finalizing Installation
Gui, Font

Gui, Add, Button, xs+100 ys+150 w60 h40 grunConfig, RUN

;;;Functions to run BEFORE main gui started;;;

Gui, Show, , Acutrol Auto-Final Configurator    ;Starts GUI

;;;Functions to run AFTER main gui started;;;
;Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /V /M=C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_check_status.ttl, ,Hide, TTWinPID
;Run, %ComSpec% /c start C:\teraterm\ttermpro.exe 192.168.2.1 /ssh /2 /auth=password /user=admin /passwd=admin /timeout=1 /nossh /V, ,Hide, TTWinPID

;#Persistent
;SetTimer, WatchForWindowToClose, 5
;SetTimer, CheckActrlStatus, 10

Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;WatchForWindowToClose:
    ;DetectHiddenWindows, on
    ;IfWinExist, Tera Term: Error
        ;WinClose, Tera Term: Error
;Return
;CheckActrlStatus:
    ;checkActrlStatus()
;Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GuiEscape:
GuiClose:
    ExitApp
;===============================================;
;;;;;;;;;;;;;Main Functions;;;;;;;;;;;;;;;;
runConfig() {
    if (checkActrlStatus()) {
        OnMessage(0x44, "PlayInCircleIcon") ;Add icon
        MsgBox 0x81, RUN CONFIGURATION, Start running the last 5 steps for Acutrol?
        OnMessage(0x44, "") ;Clear icon
        IfMsgBox OK
        {
            Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /M=C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one.ttl, ,Hide, TTWinPID
        }
        IfMsgBox Cancel
            Return
        
    } else {
        MsgBox, 16, ERROR, ACUTROL is not READY!`nPlease wait or check connection!
    }
}

;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
checkActrlStatus() {
    cmd := "ping 192.168.2.1 -n 1 -w 1000"
    RunWait, %cmd%,, Hide
    if (ErrorLevel = 1) {
        return False
    }
    if (ErrorLevel = 0) {
        RunWait, %ComSpec% /c start C:\teraterm\ttermpro.exe /V /M=C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_check_status.ttl /nossh , ,Hide, TTWinPID
        FileRead, actrlStatus, %actrlStatusCacheFilePath%
        if (actrlStatus != "SUCCESSED") {
            return False
        }
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