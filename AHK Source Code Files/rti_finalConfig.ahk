/*
    Author: Viet Ho
*/

SetTitleMatchMode, RegEx

IfNotExist C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func
    FileCreateDir C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func
    
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\xButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\xButton.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\xButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\xButton2.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\advancedButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\advancedButton.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\toUnsafe.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\toUnsafe.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\browseButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\browseButton.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\restoreButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\restoreButton.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\okButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\okButton.bmp, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

Gui Add, GroupBox, x8 y10 w138 h95, Step by Step
Gui Add, Button, x37 y30 w80 h17 gloginStep, &LOGIN
Gui Add, Button, x37 y55 w80 h17 grunStep1 +Disabled, STEP &1
Gui Add, Button, x37 y80 w80 h17 grunStep2 +Disabled, STEP &2
Gui Add, Button, x37 y121 w80 h25 gmainRun +Disabled, &RUN A to Z
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
    addTipMsg("BEGIN LOGIN STEP", "LOGIN STEP", 3000)
    Run, %A_DesktopCommon%\Google Chrome.lnk
    ;Run, %ComSpec% /c start chrome.exe --ignore-certificate-errors --test-type https://192.168.2.1 , ,Hide
    WinWait Commissioning.*|Privacy.*|Sign In.*
    if WinExist("Privacy.*") {
        searchAdvancedButton(2, 1000)
        Sleep 300
        searchToUnsafeLink(2, 1000)
        WinWait Commissioning.*
    }
    if WinExist("Commissioning.*") {
        WinActivate Commissioning.*
        WinWaitActive Commissioning.*
        
        ControlSend, ,admin{Enter}, Commissioning.*
        Sleep 3000
        Send admin2205{!}{Enter}
        Sleep 2000
        Send admin2205{!}{Enter}
        WinWait Sign In.*
    }
    ;https://192.168.2.1/sign-in
    if WinExist("Sign In.*") {
        WinActivate Sign In.*
        Sleep 1000
        Send admin{Tab}
        Send admin2205{!}{Enter}
        WinWait mPower.*
    }
    
    WinWait mPower.*
    WinActivate mPower.*
    searchXButton(8, 500)
    Sleep 500
    return
    
    Run, %ComSpec% /c start chrome.exe https://192.168.2.1/administration/save-restore, ,Hide
    WinWait Save.*
    WinActivate Save.*
    searchBrowseButton(3, 1000)
    WinWait Open.*
    ControlSetText, Edit1, C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz, Open.*
    ControlClick Button1, Open.*, , Left, 2
    searchRestoreButton(3, 1000)
    searchOkButton(3, 1000)
    WinWaitClose Save.*
    addTipMsg("FINISHED RESETTING CONDUIT", "LOGIN STEP", 2000)
}

runStep1() {
    if !FileExist("C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step1.PINGTESTappinstall.ttl") {
        MsgBox 16, FILE NOT FOUND, The file:`nStep1.PINGTESTappinstall.ttl`nwas not found in this location:`nC:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\`nPlease check and run again!
        return 0
    }
    SB_SetText("Begin Step 1")
    Run, %ComSpec% /c start C:\teraterm\ttermpro.exe   /M=C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step1.PINGTESTappinstall.ttl, ,Hide
    
    WinWait Connection Error.*, ,10000
}

runStep2() {
    if !FileExist("C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step2.saveOEM.ttl") {
        MsgBox 16, FILE NOT FOUND, The file:`nStep2.saveOEM.ttl`nwas not found in this location:`nC:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\`nPlease check and run again!
        return 0
    }
    SB_SetText("Begin Step 2")
    Run, %ComSpec% /c start C:\teraterm\ttermpro.exe   /M=C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step2.saveOEM.ttl, ,Hide
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
addTipMsg(text, title, time) {
    SplashImage, C:\tempImg.gif, FS11, %text%, ,%title%
    
    SetTimer, RemoveTipMsg, %time%
    return
    
    RemoveTipMsg:
    SplashImage, Off
    return
}

;;;;Search Images Functions;;;;
searchUsername(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, %WorkingDir%\Imgs-for-Search-Func\username.bmp
        If ErrorLevel = 0
        {
            MsgBox %FoundX%, %FoundY%
            MouseMove FoundX, FoundY
            MsgBox FOUND
            return 1 ;Return true if found
        }
            
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found    
}

searchXButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate mPower.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\xButton2.bmp
        If ErrorLevel = 0
        {
            MsgBox FOUND X2
            ;ControlClick x%FoundX%+10 y%FoundY%+10, mPower.*, , Left, 2 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel
    {
        WinActivate mPower.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\xButton.bmp
        If ErrorLevel = 0
        {
            MsgBox FOUND X1
            ;ControlClick x%FoundX%+10 y%FoundY%+10, mPower.*, , Left, 2 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    MsgBox BUTTON X NOT FOUND!
    return 0 ;Return false if NOT found 
}

searchAdvancedButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Privacy.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\advancedButton.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Privacy.*, , Left, 1 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found 
}

searchToUnsafeLink(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Privacy.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\toUnsafe.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Privacy.*, , Left, 2 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found 
}

searchBrowseButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Save.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\browseButton.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Save.*, , Left, 1 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found
}

searchRestoreButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Save.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\restoreButton.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Save.*, , Left, 1 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found
}

searchOkButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Save.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\okButton.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Save.*, , Left, 1 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found
}
;;;;Outsize Functions;;;;