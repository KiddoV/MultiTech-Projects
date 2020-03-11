/*
    Author: Viet Ho
*/

SetTitleMatchMode, RegEx

IfNotExist C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func
    FileCreateDir C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\u-boot.BMP, C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func\u-boot.BMP, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\romBoot.BMP, C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func\romBoot.BMP, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
;Firmware list
Global allFirmwares := ["mLinux 4.1.9", "mLinux 4.1.9 - NO WiFi", "mLinux 5.1.8", "mLinux 5.1.8 - NO WiFi", "AEP 1.4.3", "AEP 1.6.4", "AEP 5.0.0", "AEP 5.1.2", "AEP 5.1.5"]

;Paths and Links
Global mli419Path := "C:\vbtest\MTCDT\mLinux-4.1.9-2x7\mtcdt-rs9113-flash-full-4.1.9.tcl"
Global mli419NoWiFPath := "C:\vbtest\MTCDT\mLinux-4.1.9-no-WiFiBT\mtcdt-flash-full-4.1.9.tcl"
Global mli518Path := "C:\vbtest\MTCDT\mLinux-5.1.8-2x7\mtcdt-rs9113-flash-full-5.1.8.tcl"
Global mli518NoWiFPath := "C:\vbtest\MTCDT\mLinux-5.1.8-no-WiFiBT\mtcdt-flash-full-5.1.8.tcl"
Global aep143Path := "C:\vbtest\MTCDT\AEP-1_4_3\mtcdt-flash-full-AEP.001.tcl"
Global aep164Path := "C:\vbtest\MTCDT\AEP-1_6_4\mtcdt-flash-full-AEP.tcl"
Global aep500Path := "C:\vbtest\MTCDT\AEP-5_0_0\mtcdt-flash-full-AEP.tcl"
Global aep512Path := "C:\vbtest\MTCDT\AEP-5_1_2\mtcdt-flash-full-AEP.tcl"
Global aep515Path := "C:\vbtest\MTCDT\AEP-5_1_5\mtcdt-flash-full-AEP.tcl"

;Application Directories
Global SAM_BA := "C:\Program Files (x86)\Atmel\sam-ba_2.15\sam-ba.exe"

Global probarNum := 0
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

;Menu bar
Menu FileMenu, Add, Quit, quitHandler
Menu MenuBar, Add, &File, :FileMenu
Menu EditMenu, Add, Change File Location, changeFileHandler
Menu MenuBar, Add, &Edit, :EditMenu
Menu HelpMenu, Add, Keyboard Shortcuts, keyShcutHandler
Menu HelpMenu, Add, About, aboutHandler
Menu MenuBar, Add, &Help, :HelpMenu
Gui Menu, MenuBar

Gui -MinimizeBox -MaximizeBox
Gui Add, Button, x63 y144 w80 h23 gmainRun, &RUN
Gui Add, GroupBox, x8 y4 w194 h77, Select Firmware Version
Gui Add, CheckBox, x9 y101 w191 h23 vcheck, % " Included Re-Program Step"
Gui Add, Progress, x8 y175 w193 h13 -Smooth vprogress, 0
For each, item in allFirmwares
    firmware .= (each == 1 ? "" : "|") . item
Gui Add, DropDownList, x16 y36 w177 vfware Choose1, %firmware%
Gui Font,, Times New Roman
Gui Add, StatusBar,, Click button to start!
Gui Font

Gui Show, x856 y322 w208 h215, All Firmware Auto-Installer
Return

;;;;;;;;;All menu handlers
quitHandler:
ExitApp
Return

changeFileHandler:
MsgBox 0, Message, This feature will be added in the future release!
Return

keyShcutHandler:
MsgBox 0, Keyboard Shortcuts, Ctrl + R to RUN`nCtrl + Q to Exit App
Return
aboutHandler:
MsgBox 0, Message, Created and Tested by Viet Ho
Return

GuiEscape:
GuiClose:
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;HOT KEYS;;;;;;;;
^q:: ExitApp
^r:: mainRun()
;;;;;;;;;;;;;;;;;;;;;;;;

mainRun() {
    GuiControl,, progress, 0 ;Set Progress to 0 everytime user hit RUN
    probarNum := 0
    GuiControlGet, fware ;Get value from DropDownList
    GuiControlGet, check ;Get value from CheckBox
    
    If !WinExist("COM.*") {
        SB_SetText("Missing COM port...")
        MsgBox, 8240, Alert, Please connect to PORT first! ;Uses 48 + 8192
        SB_SetText("Run after PORT is connected")
        return
    }
    
    SB_SetText("Starting...")
    If (check = 1) {
        ;MsgBox, 33, Question, Begin Auto-Reprogram firmware %fware%? ;Uses 1 + 32
        OnMessage(0x44, "PlayInCircleIcon")
        MsgBox 0x81, BEGIN, Begin Auto-Reprogram firmware %fware%?
        OnMessage(0x44, "")
        IfMsgBox OK 
        {
            If (searchUboot() = 0) {
                SB_SetText("...")
                MsgBox, 16, Error, Can't find U-Boot> prompt`nMake sure you get "U-Boot>" displayed on TeraTerm first!
                return
            }
                
            If (searchRomBoot() = 1) {
                addTipMsg("Firmware on the device is already erased`nJump to installing step!", "Tip", 3500)
                GuiControl , , check, 0
                GuiControlGet, check ;Get value from CheckBox again
                install_firmware(fware, check)
                return
            }
            erase_firmware()
            install_firmware(fware, check)
        }
        IfMsgBox Cancel
        {
            SB_SetText("...")
            return
        }
    } 
    Else {
        ;MsgBox, 33, Question, Begin Auto-Install firmware %fware%?
        OnMessage(0x44, "PlayInCircleIcon")
        MsgBox 0x81, BEGIN, Begin Auto-Install firmware %fware%?
        OnMessage(0x44, "")
        IfMsgBox OK
            install_firmware(fware, check)
        IfMsgBox Cancel
        {
            SB_SetText("...")
            return
        }
        SB_SetText("Click button to start!")
            return
    }
}

erase_firmware() {
    addToProgressBar(5)
    ControlSend, ,nand{Space}erase.chip{Enter}, COM.*
    Sleep 1700
    ControlSend, ,reset{Enter}, COM.*
    addToProgressBar(5)
}


install_firmware(fw, chk) {
    If (searchRomBoot() = 0) {
        SB_SetText("...")
        MsgBox, 16, Error, Can't find RomBOOT`nMake sure firmware on the device is erased!
        return
    }
    Run %SAM_BA%
    SB_SetText("Opening SAM-BA...")
    addToProgressBar(5)
    
    WinWaitActive SAM-BA.*
    WinActivate SAM-BA.*
    Send {Enter}
    WinWaitActive SAM-BA.*|Invalid.*
    If WinExist("Invalid.*") {
        WinActivate Invalid.*
        Send {Enter}
        SB_SetText("Failed to connect to SAM-BA...")
        MsgBox, 16, Error, Cannot CONNECT to SAM-BA Port`nPlease try again!
        GuiControl,, progress, 0
        return
    }
    Else {
        addToProgressBar(10)
        BlockInput On
        BlockInput MouseMove
        WinActivate SAM-BA.*
        Sleep 300
        Click, 82, 43 Left, , Down
        Sleep, 70
        Click, 82, 43 Left, , Up
        Send {Down}{Down}{Down}{Down}{Enter}
        WinWaitActive Select Script File.*
        WinActivate Select Script File.*
        
        addToProgressBar(10)
        If (fw = "mLinux 4.1.9")
            ControlSetText, Edit1, %mli419Path%, Select Script File.*
        If (fw = "mLinux 4.1.9 - NO WiFi")
            ControlSetText, Edit1, %mli419NoWiFPath%, Select Script File.*
        If (fw = "mLinux 5.1.8")
            ControlSetText, Edit1, %mli518Path%, Select Script File.*
        If (fw = "mLinux 5.1.8 - NO WiFi")
            ControlSetText, Edit1, %mli518NoWiFPath%, Select Script File.*
        If (fw = "AEP 1.4.3")
            ControlSetText, Edit1, %aep143Path%, Select Script File.*
        If (fw = "AEP 1.6.4")
            ControlSetText, Edit1, %aep164Path%, Select Script File.*
        If (fw = "AEP 5.0.0")
            ControlSetText, Edit1, %aep500Path%, Select Script File.*
        If (fw = "AEP 5.1.2")
            ControlSetText, Edit1, %aep512Path%, Select Script File.*
        If (fw = "AEP 5.1.5")
            ControlSetText, Edit1, %aep515Path%, Select Script File.*
        
        Sleep 400
        ControlClick Button2, Select Script File.*, , Left, 3
        
        ;This if statement fix a bug on some old computer
        If WinExist("Select Script File.*") {
            WinActivate Select Script File.*
            Click, 511, 365 Left, , Down
            Sleep 100
            Click, 511, 365 Left, , Up
        }
        BlockInput MouseMoveOff
        BlockInput Off
        
        WinWaitClose Select Script File.*
    
        WinWaitActive Please Wait.*
        addToProgressBar(10)
        SB_SetText("Waiting for process...")
        
        Loop, 50
        {
            addToProgressBar(1)
            If !WinExist("Please Wait.*")
                Break
            Sleep 1000
        }
        WinWaitClose Please Wait.*
        
        Sleep 500
        WinActivate SAM-BA.*
        WinClose SAM-BA.*
        WinActivate COM.*
        Send !i
        addToProgressBar(10)
        
        SB_SetText("DONE!")
        GuiControl,, progress, 100
        If (chk = 1) {
            OnMessage(0x44, "CheckIcon")
            MsgBox 0x80, DONE, FINISHED Auto-reprogram %fw%!
            OnMessage(0x44, "")
        }
        Else {
            OnMessage(0x44, "CheckIcon")
            MsgBox 0x80, DONE, FINISHED Auto-Install %fw%!
            OnMessage(0x44, "")
        }
        GuiControl,, progress, 0
        SB_SetText("Click button to start again!")
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
addToProgressBar(number) {
    index := probarNum += number
    GuiControl,, progress, %index%
}

addTipMsg(text, title, time) {
    SplashImage, C:\tempImg.gif, FS11, %text%, ,%title%
    
    SetTimer, RemoveTipMsg, %time%
    return
    
    RemoveTipMsg:
    SplashImage, Off
    return
}

;;;Search Images Functions
searchUboot() {
    WinActivate COM.*
    CoordMode, Pixel, Window
    ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080,*50 C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func\u-boot.BMP
    If ErrorLevel 
        return 0 ;Return false if not found
    If ErrorLevel = 0
        return 1 ;Return true if FOUND
}

searchRomBoot() {
    WinActivate COM.*
    CoordMode, Pixel, Window
    ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func\romBoot.BMP
    If ErrorLevel
        return 0 ;Return false if not found
    If ErrorLevel = 0
        return 1 ;Return true if FOUND
}

;;;Icon for MsgBox
/*Usage Sample
OnMessage(0x44, "CheckIcon") ;Add icon
MsgBox 0x80, DONE, FINISHED Auto-reprogram %fw%!
OnMessage(0x44, "") ;Clear icon
*/
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
