/*
    Author: Viet Ho
*/

IfNotExist C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func
    FileCreateDir C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\u-boot.BMP, C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func\u-boot.BMP, 1

;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
;Firmware list
Global allFirmwares := ["mLinux 4.1.9", "mLinux 4.1.9 NO WiFi", "AEP 1.4.3", "AEP 5.0.0", "AEP 5.1.2"]

;Paths and Links
Global mli419Path := "C:\vbtest\MTCDT\mLinux-4.1.9-2x7\mtcdt-rs9113-flash-full-4.1.9.tcl"
Global mli419NoWiFPath := "C:\vbtest\MTCDT\mLinux-4.1.9-no-WiFiBT\mtcdt-flash-full-4.1.9.tcl"
Global aep143Path := "C:\vbtest\MTCDT\AEP-1_4_3\mtcdt-flash-full-AEP.001.tcl"
Global aep500Path := "C:\vbtest\MTCDT\AEP-5_0_0\mtcdt-flash-full-AEP.tcl"
Global aep512Path := "C:\vbtest\MTCDT\AEP-5_1_2\mtcdt-flash-full-AEP.tcl"

;Application Dir
Global SAM_BA := "C:\Program Files (x86)\Atmel\sam-ba_2.15\sam-ba.exe"

;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
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
    setProgressBar(0) ;Set Progress to 0 everytime user hit RUN
    GuiControlGet, fware ;Get value from DropDownList
    GuiControlGet, check ;Get value from CheckBox
    
    SetTitleMatchMode, RegEx
    If !WinExist("COM.*") {
        SB_SetText("Missing COM port...")
        MsgBox, 8240, Alert, Please connect to PORT first! ;Uses 48 + 8192
        SB_SetText("...")
        return
    }
    
    SB_SetText("Starting...")
    If (check = 1) {
        MsgBox, 33, Question, Begin Auto-Reprogram firmware %fware%? ;Uses 1 + 32
        IfMsgBox OK 
        {
            If (searchUboot() = 0)
                return
            erase_firmware()
            install_firmware(fware, check)
        }
        IfMsgBox Cancel
            return
    } 
    Else {
        MsgBox, 33, Question, Begin Auto-Install firmware %fware%?
        IfMsgBox OK
            install_firmware(fware, check)
        IfMsgBox Cancel
        SB_SetText("Click button to start!")
            return
    }
}

erase_firmware() {
    setProgressBar(+10)
    BlockInput On
    WinActivate COM.*
    Send nand{Space}erase.chip{Enter}
    Sleep 1700
    Send reset{Enter}
    BlockInput Off
}

install_firmware(fw, chk) {
    Run %SAM_BA%
    SB_SetText("Opening SAM-BA...")
    setProgressBar(+10)
    SetTitleMatchMode, RegEx
    
    WinWaitActive SAM-BA.*
    Send {Enter}
    WinWaitActive SAM-BA.*|Invalid.*
    If WinExist("Invalid.*") {
        WinActivate Invalid.*
        Send {Enter}
        SB_SetText("Failed to connect to SAM-BA...")
        MsgBox, 16, Error, Cannot CONNECT to SAM-BA Port`nPlease try again!
        setProgressBar(0)
        return
    }
    Else {
        setProgressBar(40)
        BlockInput On
        WinActivate SAM-BA.*
        Sleep 300
        Click, 82, 43 Left, , Down
        Sleep, 70
        Click, 82, 43 Left, , Up
        Send {Down}{Down}{Down}{Down}{Enter}
        WinWaitActive Select Script File.*
        WinActivate Select Script File.*
        BlockInput Off
        
        setProgressBar(50)
        BlockInput On
        If (fw = "mLinux 4.1.9")
            Send %mli419Path%
        If (fw = "mLinux 4.1.9 NO WiFi")
            Send %mli419NoWiFPath%
        If (fw = "AEP 1.4.3")
            Send %aep143Path%
        If (fw = "AEP 5.0.0")
            Send %aep500Path%
        If (fw = "AEP 5.1.2")
            Send %aep512Path%
        
        Sleep 400
        ControlClick Button2, Select Script File.*
        Sleep 200
        Send {Enter}
        Sleep 300
        ;This if stmt fix bug on some old computer
        If WinExist("Select Script File.*") {
            WinActivate Select Script File.*
            Click, 511, 365 Left, , Down
            Sleep 100
            Click, 511, 365 Left, , Up
        }
        BlockInput Off
        
        WinWaitClose Select Script File.*
    
        WinWaitActive Please Wait.*
        setProgressBar(70)
        SB_SetText("Waiting for process...")
        
        WinWaitClose Please Wait.*
        setProgressBar(80)
        
        Sleep 500
        WinActivate SAM-BA.*
        WinClose SAM-BA.*
        WinActivate COM.*
        Send !i
        setProgressBar(90)
        
        SB_SetText("DONE!")
        setProgressBar(100)
        If (chk = 1) {
            MsgBox, 64, Message, FINISHED Auto-reprogram %fw%!
        }
        Else {
            MsgBox, 64, Message, FINISHED Auto-install %fw%!
        }
        setProgressBar(0)
        SB_SetText("Click button to start again!")
    }
}

;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
setProgressBar(number) {
    GuiControl,, progress, %number%
}

;;;Search Images Functions
searchUboot() {
    SetTitleMatchMode, RegEx
    WinActivate COM.*
    CoordMode, Pixel, Window
    ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\AFAuto-Installer\Imgs-for-Search-Func\u-boot.BMP
    If ErrorLevel
    {
        MsgBox, 16, Error, Can't find U-Boot> prompt`nMake sure you get "U-Boot>" displayed on TeraTerm first!
        return 0 ;Return false if not found
    }
}
