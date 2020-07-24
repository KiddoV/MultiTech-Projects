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

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\actrl_check_status.ttl, C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_check_status.ttl, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\TTL-Files\actrl_all-config-in-one.ttl, C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one.ttl, 1

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\check_mark.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\x_mark.png, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\play_orange.png, 1

FileInstall C:\vbtest\MTCDT\Acutrol\conduit-external.tar.gz, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\conduit-external.tar.gz, 1
FileInstall C:\vbtest\MTCDT\Acutrol\config_MTCDT-LAT1-210A_1_4_3_10_12_17_CumulusAPN.tar, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\config_MTCDT-LAT1-210A_1_4_3_10_12_17_CumulusAPN.tar, 1
FileInstall C:\vbtest\MTCDT\Acutrol\20_000_000_003_conduit_install, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\20_000_000_003_conduit_install, 1
FileInstall C:\vbtest\MTCDT\Acutrol\20_000_000_004_conduit_upgrade, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\20_000_000_004_conduit_upgrade, 1
FileInstall C:\vbtest\MTCDT\Acutrol\20_000_000_005_conduit_upgrade, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\20_000_000_005_conduit_upgrade, 1
FileInstall C:\vbtest\MTCDT\Acutrol\20_000_000_006_conduit_upgrade, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\20_000_000_006_conduit_upgrade, 1
FileInstall C:\vbtest\MTCDT\Acutrol\20_000_000_007_conduit_upgrade, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\20_000_000_007_conduit_upgrade, 1
FileInstall C:\vbtest\MTCDT\Acutrol\30_001_007_006_azureacutrol_install, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\30_001_007_006_azureacutrol_install, 1
FileInstall C:\vbtest\MTCDT\Acutrol\30_001_007_007_acutrol_upgrade, C:\V-Projects\ACTRLAuto-FinalConfig\transfering-files\30_001_007_007_acutrol_upgrade, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global actrlStatusCacheFilePath := "C:\V-Projects\ACTRLAuto-FinalConfig\caches\actrl_status.dat"

Global xImg := "C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\x_mark.png"
Global checkImg := "C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\check_mark.png"
Global playImg := "C:\V-Projects\ACTRLAuto-FinalConfig\imgs-for-gui\play_orange.png"
;;;;;;;;;;;;;;;;;;;;;MAIN GUI;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, Add, GroupBox, xm+0 ym+0 w260 h200 Section
Gui, Font, Bold
Gui, Add, Text, xs+30 ys+20 vstep1Label, STEP 1. Checking LAN Connection
Gui, Add, Text, xs+30 ys+45 vstep2Label, STEP 2. Transfering Configuration File
Gui, Add, Text, xs+30 ys+70 vstep3Label, STEP 3. Importing Other Configurations
Gui, Add, Text, xs+30 ys+95 vstep4Label, STEP 4. Transfering Upgrade Files
Gui, Add, Text, xs+30 ys+120 vstep5Label, STEP 5. Finalizing Installation
Gui, Font

Gui, Add, Picture, xs+7 ys+17 w18 h18 +BackgroundTrans vprocess1,
Gui, Add, Picture, xs+7 ys+42 w18 h18 +BackgroundTrans vprocess2,
Gui, Add, Picture, xs+7 ys+67 w18 h18 +BackgroundTrans vprocess3,
Gui, Add, Picture, xs+7 ys+92 w18 h18 +BackgroundTrans vprocess4,
Gui, Add, Picture, xs+7 ys+117 w18 h18 +BackgroundTrans vprocess5,

Gui, Add, Button, xs+100 ys+150 w60 h40 grunConfig, RUN

;;;Functions to run BEFORE main gui started;;;

posX := A_ScreenWidth - 300
posY := A_ScreenHeight - 900
Gui, Show, x%posX% y%posY%, Acutrol Auto-Final Configurator    ;Starts GUI

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
            resetStepLabelStatus()
            WinClose, 192.168.2.1:22
            
            ;;STEP 1&2
            Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one.ttl "STEP1&2", , Hide
            WinWait, ^STEP 1$|CONNECTION ERROR
            IfWinExist, CONNECTION ERROR
                Return
            WinSet, AlwaysOnTop, On, ^STEP 1$
            changeStepLabelStatus("step1Label", "PLAY")
            WinWait, STEP 1 DONE|STEP 1 FAILED
            IfWinExist, STEP 1 DONE
                changeStepLabelStatus("step1Label", "DONE")
            IfWinExist, STEP 1 FAILED
            {
                changeStepLabelStatus("step1Label", "FAIL")
                return
            }
            WinWait, ^STEP 2$
            WinSet, AlwaysOnTop, On, ^STEP 2$
            changeStepLabelStatus("step2Label", "PLAY")
            WinWait, STEP 2 DONE
            changeStepLabelStatus("step2Label", "DONE")
            
            ;;STEP 3
            SplashTextOn, 300, 20, WAITING..., WAITING FOR CONDUIT TO REBOOT.......
            Sleep 160000
            CheckStatus:
            Loop,
            {
                if (checkActrlStatus()) {
                    Break
                }
                Sleep 5000
            }
            Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one.ttl "STEP3", , Hide
            WinWait, ^STEP 3$|CONNECTION ERROR
            WinSet, AlwaysOnTop, On, ^STEP 3$
            IfWinExist, CONNECTION ERROR
            {
                ControlClick, Button1, CONNECTION ERROR, , Left, 3
                Goto CheckStatus
            }
            SplashTextOff
            changeStepLabelStatus("step3Label", "PLAY")
            WinWait, STEP 3 DONE
            changeStepLabelStatus("step3Label", "DONE")
            
            ;;STEP 4
            SplashTextOn, 300, 20, WAITING..., WAITING FOR CONDUIT TO REBOOT.......
            Sleep 160000
            CheckStatus2:
            Loop,
            {
                if (checkActrlStatus()) {
                    Break
                }
                Sleep 5000
            }
            Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one.ttl "STEP4", , Hide
            WinWait, ^STEP 4$|CONNECTION ERROR
            WinSet, AlwaysOnTop, On, ^STEP 4$
            IfWinExist, CONNECTION ERROR
            {
                ControlClick, Button1, CONNECTION ERROR, , Left, 3
                Goto CheckStatus2
            }
            SplashTextOff
            changeStepLabelStatus("step4Label", "PLAY")
            WinWait, STEP 4 DONE
            changeStepLabelStatus("step4Label", "DONE")
            
            ;;STEP 5
            SplashTextOn, 300, 20, WAITING..., WAITING FOR CONDUIT TO REBOOT.......
            Sleep 200000
            CheckStatus3:
            Loop,
            {
                if (checkActrlStatus()) {
                    Break
                }
                Sleep 5000
            }
            Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\ACTRLAuto-FinalConfig\ttl\actrl_all-config-in-one.ttl "STEP5", , Hide
            WinWait, ^STEP 5$|CONNECTION ERROR
            WinSet, AlwaysOnTop, On, ^STEP 5$
            IfWinExist, CONNECTION ERROR
            {
                ControlClick, Button1, CONNECTION ERROR, , Left, 3
                Goto CheckStatus3
            }
            SplashTextOff
            changeStepLabelStatus("step5Label", "PLAY")
            WinWait, STEP 5 DONE
            WinWaitClose, 192.168.2.1:22
            changeStepLabelStatus("step5Label", "DONE")
            
            OnMessage(0x44, "CheckIcon") ;Add icon
            MsgBox 0x80, DONE, FINISHED auto-config the last 5 step!
            OnMessage(0x44, "") ;Clear icon
            resetStepLabelStatus()
            return
        }
        IfMsgBox Cancel
            Return
        
    } else {
        MsgBox, 16, ERROR, ACUTROL is not READY!`nPlease wait or check connection!
        return
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
    Loop, 5
    {
        Gui, Font, Bold
        GuiControl, Font, step%A_Index%Label
        Gui, Font
        GuiControl, , process%A_Index%,
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