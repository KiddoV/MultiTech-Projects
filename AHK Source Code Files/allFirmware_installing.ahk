/*
    Author: Viet Ho
*/
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1
SetTitleMatchMode, RegEx

;;;Include the libraries
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\JSON.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Class_LV_Rows.ahk

;;;;;;;;;;Installs Folder Location and Files;;;;;;;;;;
IfNotExist C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func
    FileCreateDir C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func

FileInstall C:\MultiTech-Projects\Imgs-for-Search-Func\u-boot.BMP, C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func\u-boot.BMP, 1
FileInstall C:\MultiTech-Projects\Imgs-for-Search-Func\romBoot.BMP, C:\V-Projects\AFAuto-Installer\Imgs-for-Search-Func\romBoot.BMP, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
Global isMTCDT := True
Global isMTCAP := False
Global productName := ""

;Firmware list in AHK Object
Global allMTCDTFirmwareProperties := [{}]
allMTCDTFirmwareProperties[1] := {fwName: "mLinux 4.0.1", fwPath: "C:\vbtest\MTCDT\mLinux-4.0.1-2x7\mtcdt-rs9113-flash-full-4.0.1.tcl"}
allMTCDTFirmwareProperties[2] := {fwName: "mLinux 4.0.1 - NO WiFi", fwPath: "C:\vbtest\MTCDT\mLinux-4.0.1-no-WiFiBT\mtcdt-flash-full-4.0.1.tcl"}
allMTCDTFirmwareProperties[3] := {fwName: "mLinux 4.1.9", fwPath: "C:\vbtest\MTCDT\mLinux-4.1.9-2x7\mtcdt-rs9113-flash-full-4.1.9.tcl"}
allMTCDTFirmwareProperties[4] := {fwName: "mLinux 4.1.9 - NO WiFi", fwPath: "C:\vbtest\MTCDT\mLinux-4.1.9-no-WiFiBT\mtcdt-flash-full-4.1.9.tcl"}
allMTCDTFirmwareProperties[5] := {fwName: "mLinux 5.1.8", fwPath: "C:\vbtest\MTCDT\mLinux-5.1.8-2x7\mtcdt-rs9113-flash-full-5.1.8.tcl"}
allMTCDTFirmwareProperties[6] := {fwName: "mLinux 5.1.8 - NO WiFi", fwPath: "C:\vbtest\MTCDT\mLinux-5.1.8-no-WiFiBT\mtcdt-flash-full-5.1.8.tcl"}
allMTCDTFirmwareProperties[7] := {fwName: "mLinux 5.2.7", fwPath: "C:\vbtest\MTCDT\mLinux-5.2.7\mtcdt-flash-full-5.2.7.tcl"}
allMTCDTFirmwareProperties[8] := {fwName: "mLinux-Sag 5.1.8", fwPath: "C:\vbtest\MTCDT\MLINUX_SagecomImage_518\mtcdt-flash-full-5.1.8.tcl"}
allMTCDTFirmwareProperties[9] := {fwName: "AEP 1.4.3", fwPath: "C:\vbtest\MTCDT\AEP-1_4_3\mtcdt-flash-full-AEP.001.tcl"}
allMTCDTFirmwareProperties[10] := {fwName: "AEP 1.6.4", fwPath: "C:\vbtest\MTCDT\AEP-1_6_4\mtcdt-flash-full-AEP.tcl"}
allMTCDTFirmwareProperties[11] := {fwName: "AEP 1.7.4", fwPath: "C:\vbtest\MTCDT\AEP-1_7_4\mtcdt-flash-full-AEP_174.tcl"}
allMTCDTFirmwareProperties[12] := {fwName: "AEP 5.0.0", fwPath: "C:\vbtest\MTCDT\AEP-5_0_0\mtcdt-flash-full-AEP.tcl"}
allMTCDTFirmwareProperties[13] := {fwName: "AEP 5.1.2", fwPath: "C:\vbtest\MTCDT\AEP-5_1_2\mtcdt-flash-full-AEP.tcl"}
allMTCDTFirmwareProperties[14] := {fwName: "AEP 5.1.5", fwPath: "C:\vbtest\MTCDT\AEP-5_1_5\mtcdt-flash-full-AEP.tcl"}
allMTCDTFirmwareProperties[15] := {fwName: "AEP 5.1.6", fwPath: "C:\vbtest\MTCDT\AEP-5_1_6\mtcdt-flash-full-AEP.tcl"}
allMTCDTFirmwareProperties[16] := {fwName: "AEP 5.2.1", fwPath: "C:\vbtest\MTCDT\AEP-5_2_1\mtcdt-flash-full-AEP.tcl"}
allMTCDTFirmwareProperties[17] := {fwName: "AEP 5.2.5", fwPath: "C:\vbtest\MTCDT\AEP-5_2_5\mtcdt-flash-full-AEP.tcl"}
allMTCDTFirmwareProperties[18] := {fwName: "AEP 5.3.0", fwPath: "C:\vbtest\MTCDT\AEP-5_3_0\mtcdt-flash-full-AEP.tcl"}
allMTCDTFirmwareProperties[19] := {fwName: "Actility 2.2.9", fwPath: "C:\vbtest\MTCDT\v2.2.9-LoRa-H\Generic-915\mtcdt-flash-Generic-915-v2_2_9-LoRa-H.production.tcl"}

Global allMTCAPFirmwareProperties := [{}]
allMTCAPFirmwareProperties[1] := {fwName: "mLinux 5.1.8", fwPath: "C:\vbtest\MTCAP\mLinux_v5_1_8\mtcap-flash-full-5.1.8.tcl"}
allMTCAPFirmwareProperties[2] := {fwName: "AEP 5.1.6", fwPath: "C:\vbtest\MTCAP\AEP_v5_1_6\mtcap-flash-full-AEP.tcl"}
allMTCAPFirmwareProperties[3] := {fwName: "AEP 5.2.1", fwPath: "C:\vbtest\MTCAP\AEP_v5_2_1\mtcap-flash-full-AEP521.tcl"}

;Firmware list in JSON format
Global allFirmwarePropertiesJson := ""
allFirmwarePropertiesJson =
(
{
    "allMTCDTFirmwareProperties": [
        { "fwName": "mLinux 4.0.1", "fwPath": "C:\\vbtest\\MTCDT\\mLinux-4.0.1-2x7\\mtcdt-rs9113-flash-full-4.0.1.tcl" },
        { "fwName": "mLinux 4.0.1 - NO WiFi", "fwPath": "C:\\vbtest\\MTCDT\\mLinux-4.0.1-no-WiFiBT\\mtcdt-flash-full-4.0.1.tcl"},
        { "fwName": "mLinux 4.1.9", "fwPath": "C:\\vbtest\\MTCDT\\mLinux-4.1.9-2x7\\mtcdt-rs9113-flash-full-4.1.9.tcl"},
        { "fwName": "mLinux 4.1.9 - NO WiFi", "fwPath": "C:\\vbtest\\MTCDT\\mLinux-4.1.9-no-WiFiBT\\mtcdt-flash-full-4.1.9.tcl"},
        { "fwName": "mLinux 5.1.8", "fwPath": "C:\\vbtest\\MTCDT\\mLinux-5.1.8-2x7\\mtcdt-rs9113-flash-full-5.1.8.tcl"},
        { "fwName": "mLinux 5.1.8 - NO WiFi", "fwPath": "C:\\vbtest\\MTCDT\\mLinux-5.1.8-no-WiFiBT\\mtcdt-flash-full-5.1.8.tcl"},
        { "fwName": "mLinux 5.2.7", "fwPath": "C:\\vbtest\\MTCDT\\mLinux-5.2.7\\mtcdt-flash-full-5.2.7.tcl"},
        { "fwName": "mLinux-Sag 5.1.8", "fwPath": "C:\\vbtest\\MTCDT\\MLINUX_SagecomImage_518\\mtcdt-flash-full-5.1.8.tcl"},
        { "fwName": "AEP 1.4.3", "fwPath": "C:\\vbtest\\MTCDT\\AEP-1_4_3\\mtcdt-flash-full-AEP.001.tcl"},
        { "fwName": "AEP 1.6.4", "fwPath": "C:\\vbtest\\MTCDT\\AEP-1_6_4\\mtcdt-flash-full-AEP.tcl"},
        { "fwName": "AEP 1.7.4", "fwPath": "C:\\vbtest\\MTCDT\\AEP-1_7_4\\mtcdt-flash-full-AEP_174.tcl"},
        { "fwName": "AEP 5.0.0", "fwPath": "C:\\vbtest\\MTCDT\\AEP-5_0_0\\mtcdt-flash-full-AEP.tcl"},
        { "fwName": "AEP 5.1.2", "fwPath": "C:\\vbtest\\MTCDT\\AEP-5_1_2\\mtcdt-flash-full-AEP.tcl"},
        { "fwName": "AEP 5.1.5", "fwPath": "C:\\vbtest\\MTCDT\\AEP-5_1_5\\mtcdt-flash-full-AEP.tcl"},
        { "fwName": "AEP 5.1.6", "fwPath": "C:\\vbtest\\MTCDT\\AEP-5_1_6\\mtcdt-flash-full-AEP.tcl"},
        { "fwName": "AEP 5.2.1", "fwPath": "C:\\vbtest\\MTCDT\\AEP-5_2_1\\mtcdt-flash-full-AEP.tcl"},
        { "fwName": "AEP 5.2.5", "fwPath": "C:\\vbtest\\MTCDT\\AEP-5_2_5\\mtcdt-flash-full-AEP.tcl"},
        { "fwName": "AEP 5.3.0", "fwPath": "C:\\vbtest\\MTCDT\\AEP-5_3_0\\mtcdt-flash-full-AEP.tcl"},
        { "fwName": "Actility 2.2.9", "fwPath": "C:\\vbtest\\MTCDT\\v2.2.9-LoRa-H\\Generic-915\\mtcdt-flash-Generic-915-v2_2_9-LoRa-H.production.tcl"}
    ],
    "allMTCAPFirmwareProperties": [
        { "fwName": "mLinux 5.1.8", "fwPath": "C:\\vbtest\\MTCAP\\mLinux_v5_1_8\\mtcap-flash-full-5.1.8.tcl"},
        { "fwName": "AEP 5.1.6", "fwPath": "C:\\vbtest\\MTCAP\\AEP_v5_1_6\\mtcap-flash-full-AEP.tcl"},
        { "fwName": "AEP 5.2.1", "fwPath": "C:\\vbtest\\MTCAP\\AEP_v5_2_1\\mtcap-flash-full-AEP521.tcl"}
    ]
}
)

Global AllFirmwareProperties := {}

;Application Directories
Global SAM_BA := "C:\Program Files (x86)\Atmel\sam-ba_2.15\sam-ba.exe"
Global MainFwPropertiesFilePath := "C:\V-Projects\AFAuto-Installer\fw-properties.json"

Global probarNum := 0

Global JSON := new JSON()

Global LvRowHandle := {}        ;;;Instance for Class_LV_Rows.ahk
;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
ProcessSettings()       ;;;Must run before GUI

;Menu bar
    Menu FileMenu, Add, Quit, quitHandler
Menu MenuBar, Add, &File, :FileMenu     ;;Main menu
        Menu ProductsSubMenu, Add, MTCDT, mtcdtHandler
        Menu ProductsSubMenu, Add, MTCAP, mtcapHandler
    Menu OptionsMenu, Add, Products, :ProductsSubMenu
Menu MenuBar, Add, &Options, :OptionsMenu     ;;Main menu
    Menu EditMenu, Add, Firmware Collection, fwCollectionHandler
Menu MenuBar, Add, &Edit, :EditMenu     ;;Main menu
Menu HelpMenu, Add, Keyboard Shortcuts, keyShcutHandler
    Menu HelpMenu, Add, About, aboutHandler
Menu MenuBar, Add, &Help, :HelpMenu     ;;Main menu
Gui Menu, MenuBar

Menu, ProductsSubMenu, Check, MTCDT

Gui -MaximizeBox
Gui Font, Bold
Gui Add, Text, x11 y4 w100 vproLabel, MTCDT
Gui Font
Gui Add, GroupBox, x8 y24 w186 h60 Section, Select Firmware Version
For each, item in AllFirmwareProperties.allMTCDTFirmwareProperties
    firmware .= (each == 1 ? "" : "|") . item.fwName
Gui Add, DropDownList, x16 y50 w169 vfware Choose1, %firmware%
For each, item in AllFirmwareProperties.allMTCAPFirmwareProperties
    firmware2 .= (each == 1 ? "" : "|") . item.fwName
Gui Add, DropDownList, x16 y50 w169 vmtcapFware +Hidden Choose1, %firmware2%
Gui Add, CheckBox, x9 y90 h23 vcheck, % " Included Re-Program Step"
Gui Add, Button, x60 y124 w80 h23 gmainRun, &RUN
Gui Add, Progress, x8 y155 w185 h13 -Smooth vprogress, 0
Gui Font,, Times New Roman
Gui Add, StatusBar,, Click button to start!
Gui Font

;;;;;Functions to run BEFORE Gui started
OnMessage(0x100, "WM_KEYDOWN")
;MsgBox % AllFirmwareProperties.allMTCDTFirmwareProperties[1].fwPath

posX := A_ScreenWidth - 300
Gui Show, w200 h195 x%posX% y300, All Firmware Auto-Installer
Return

;;;;;;;;;All menu handlers
quitHandler:
ExitApp
Return

fwCollectionHandler() {
    IfWinExist, Firmware Collection
        WinActivate, Firmware Collection
    Else
        OpenFirmwareCollection()
}

mtcdtHandler() {
    Menu, ProductsSubMenu, ToggleCheck, MTCDT
    Menu, ProductsSubMenu, ToggleCheck, MTCAP
    GuiControl, , proLabel, MTCDT
    isMTCDT := True
    isMTCAP := False
    productName := "MTCDT"
    GuiControl, Hide, mtcapFware
    GuiControl, Show, fware
}

mtcapHandler() {
    Menu, ProductsSubMenu, ToggleCheck, MTCAP
    Menu, ProductsSubMenu, ToggleCheck, MTCDT
    GuiControl, , proLabel, MTCAP
    isMTCDT := False
    isMTCAP := True
    productName := "MTCAP"
    GuiControl, Hide, fware
    GuiControl, Show, mtcapFware
}

keyShcutHandler() {
    MsgBox 0, Keyboard Shortcuts, Ctrl + R to RUN`nCtrl + Q to Exit App
}
aboutHandler() {
    MsgBox 0, Message, Created and Tested by Viet Ho
}

GuiClose:
    ExitApp
Return

;;;;;;;;;;OnMessage Functions
WM_KEYDOWN(lparam) {
    ;;If user press Delete key (46) on a ListView
    If (lparam == 46 && Instr(A_GuiControl, "LV")) {
        Gui, ListView, %A_GuiControl%
        LvRowHandle.SetHwnd(h%A_GuiControl%)
        If (LvRowHandle.Delete())                  ; Deletes seleted rows.
            LvRowHandle.Add()                      ; Add an entry in History if there are rows selected.
    }
    
    If (lparam == 17) {     ;If user press Ctrl key (17)
        While, % GetKeyState("Control")     ;While user still hoding Ctrl
        {
            If (GetKeyState("Z")) {     ;Wait for user to press Z
                If (Instr(A_GuiControl, "LV")) {
                    Gui, ListView, %A_GuiControl%                  
                    LvRowHandle.Undo()                   ; Go to previous History entry.          
                }
            }
        }
    }
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;HOT KEYS;;;;;;;;
^q:: ExitApp
^r:: mainRun()
^!c::
    IfWinExist, ahk_id %FWCollectionGui%
        WinActivate, ahk_id %FWCollectionGui%
    Else
        OpenFirmwareCollection()
return
;;;;;;;;;;;;;;;;;;;;;;;;

mainRun() {
    GuiControl,, progress, 0 ;Set Progress to 0 everytime user hit RUN
    probarNum := 0
    If (isMTCDT)
        GuiControlGet, fware, , fware ;Get value from DropDownList
    If (isMTCAP)
        GuiControlGet, fware, , mtcapFware ;Get value from DropDownList

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
        MsgBox 0x81, BEGIN, Begin Auto-Reprogram firmware %fware% on %productName%?
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
        MsgBox 0x81, BEGIN, Begin Auto-Install firmware %fware% on %productName%?
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
        ;BlockInput On
        ;BlockInput MouseMove
        WinActivate SAM-BA.*
        Sleep 300
        Click, 82, 43 Left, , Down
        Sleep, 70
        Click, 82, 43 Left, , Up
        Send {Down}{Down}{Down}{Down}{Enter}
        WinWaitActive Select Script File.*
        WinActivate Select Script File.*

        addToProgressBar(10)

        If (isMTCDT) {
            Loop, % AllFirmwareProperties.allMTCDTFirmwareProperties.Length()
            {
                If (fw == AllFirmwareProperties.allMTCDTFirmwareProperties[A_Index].fwName) {
                    fwPath := AllFirmwareProperties.allMTCDTFirmwareProperties[A_Index].fwPath
                    If !FileExist(fwPath) {
                        MsgBox, 16, File Not Found, % "Could not located this file: `n<" fwPath " >`nPlease check if file is presented!"
                        GuiControl,, progress, 0
                        WinKill, Select Script File.*
                        WinKill, SAM-BA.*
                        Return
                    }
                    ControlSetText, Edit1, %fwPath%, Select Script File.*
                    Break
                }
            }
        }

        If (isMTCAP) {
            Loop, % AllFirmwareProperties.allMTCAPFirmwareProperties.Length()
            {
                If (fw == AllFirmwareProperties.allMTCAPFirmwareProperties[A_Index].fwName) {
                    fwPath := AllFirmwareProperties.allMTCAPFirmwareProperties[A_Index].fwPath
                    If !FileExist(fwPath) {
                        MsgBox, 16, % "File Not Found, Could not located this file: `n<" fwPath " >`nPlease check if file is presented!"
                        GuiControl,, progress, 0
                        WinKill, Select Script File.*
                        WinKill, SAM-BA.*
                        Return
                    }
                    ControlSetText, Edit1, %fwPath%, Select Script File.*
                    Break
                }
            }
        }


        Sleep 300
        ControlSend Edit1, {Enter}, Select Script File.*
        ControlClick Button2, Select Script File.*, , Left, 3 ;Click button if Enter not working

        ;This if statement fix a bug on some old computer
        If WinExist("Select Script File.*") {
            WinActivate Select Script File.*
            Click, 511, 365 Left, , Down
            Sleep 100
            Click, 511, 365 Left, , Up
        }

        ;BlockInput MouseMoveOff
        ;BlockInput Off

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
        if (!isMTCAP)
            Send !i
        addToProgressBar(10)

        SB_SetText("DONE!")
        GuiControl,, progress, 100
        If (chk = 1) {
            OnMessage(0x44, "CheckIcon")
            MsgBox 0x80, DONE, FINISHED Auto-reprogram %fw% on %productName%!
            OnMessage(0x44, "")
        }
        Else {
            OnMessage(0x44, "CheckIcon")
            MsgBox 0x80, DONE, FINISHED Auto-Install %fw% on %productName%!
            OnMessage(0x44, "")
        }
        GuiControl,, progress, 0
        SB_SetText("Click button to start again!")
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
ProcessSettings() {
    IfNotExist, %MainFwPropertiesFilePath%
    {
        FileAppend, %allFirmwarePropertiesJson%, %MainFwPropertiesFilePath%
        AllFirmwareProperties := JSON.Load(allFirmwarePropertiesJson)
    } 
    Else
    {
        FileRead, jsonContents, %MainFwPropertiesFilePath%
        AllFirmwareProperties := JSON.Load(jsonContents)
    }
}

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

;;=====================================================================================;;
;;;;;;;;;;;;;Additional GUIs;;;;;;;;;;;;;;;;
OpenFirmwareCollection() {
    Global
    ;;;GUI  ;;===============================;;
    Gui, fwCollect: Default
    Gui, fwCollect: +HwndFWCollectionGui
    
    Gui, fwCollect: Add, Tab3, Section w525 h340 vfwCollectTabCon, MTCDT|MTCAP
    Gui, fwCollect: Tab, 1    ;;;;;
        Gui, fwCollect: Add, ListView, h300 w500 vfwCollectLV1 hWndhfwCollectLV1 gOnLVEvents +Grid, #|Firmware Version|TCL File Path
    Gui, fwCollect: Tab, 2    ;;;;;
        Gui, fwCollect: Add, ListView, h300 w500 vfwCollectLV2 hWndhfwCollectLV2 gOnLVEvents +Grid, #|Firmware Version|TCL File Path
    Gui, fwCollect: Tab
    
    Gui, fwCollect: Add, GroupBox, xm+0 h95 w525 Section,
    Gui, fwCollect: Add, Text, xs+10 ys+15, Firmware Version:
    Gui, fwCollect: Add, Edit, xs+100 ys+12 vinFwVers,
    Gui, fwCollect: Add, Text, xs+230 ys+15, (Please follow the DEFAULT format)
    Gui, fwCollect: Add, Text, xs+10 ys+40, TCL File Path:
    Gui, fwCollect: Add, Edit, xs+100 ys+37 w355 vinTclFPath,
    Gui, fwCollect: Add, Button, xs+460 ys+36 gBrowseFWFile, Browse...
    Gui, fwCollect: Add, Button, xs+425 ys+65 gAddToCollection, Add to Collection
    
    Gui, fwCollect: Add, Button, xs+170 ys+100 h30 gSaveCollection, SAVE COLLECTION
    Gui, fwCollect: Add, Button, xs+290 ys+100 h30 gCancelSaveCollection, CANCEL
    
    ;;;;;RUN before GUI started
    OpenFirmwareCollection_AddDataToLV()
    
    LvRowHandle := New LV_Rows(hfwCollectLV1, hfwCollectLV2)
    ; Set initial history state for both lists
    LvRowHandle.SetHwnd(hfwCollectLV1)
    LvRowHandle.Add()
    LvRowHandle.SetHwnd(hfwCollectLV2)
    LvRowHandle.Add()
    
    Gui, fwCollect: Show, , Firmware Collection
    Return  ;;===============================;;
    
    fwCollectGuiClose:
        Gui, fwCollect: Destroy
    Return
    
    ;;=======================================;;
    BrowseFWFile:
        FileSelectFile, tclFileSelected, 3, C:\vbtest, Select a TCL File, Documents (*.tcl)
        if (tclFileSelected != "")
            GuiControl, Text, inTclFPath, %tclFileSelected%
    Return  ;;;;;;;;;;;;
    
    AddToCollection:
        GuiControlGet, inputFwName, , inFwVers
        GuiControlGet, inputFwPath, , inTclFPath
        GuiControlGet, whichTab, , fwCollectTabCon
        
        If (inputFwName == "" || inputFwPath == "") {
            MsgBox, 16, ERROR, Please input values!
            Return
        } Else {
            If (RegExMatch(inputFwPath, "i)^(?:[\w]\:|\\)(\\[a-z_\-\s0-9\.]+)+\.(tcl)$") = 0) {
                MsgBox, 16, ERROR, Invalid value for TCL file path!!!!
                Return
            } Else {
                If (whichTab == "MTCDT") {
                    Gui, fwCollect: ListView, fwCollectLV1     ; Specify which listview will be updated with LV commands               
                    LV_Add("AutoHdr", LV_GetCount() + 1, inputFwName, inputFwPath)
                    SendMessage, 0x115, 7,,, ahk_id %hfwCollectLV1%  ;WM_VSCROLL | Auto scroll to bottom
                } Else If (whichTab == "MTCAP") {
                    Gui, fwCollect: ListView, fwCollectLV2     ; Specify which listview will be updated with LV commands               
                    LV_Add("AutoHdr", LV_GetCount() + 1, inputFwName, inputFwPath)
                    SendMessage, 0x115, 7,,, ahk_id %hfwCollectLV2%  ;WM_VSCROLL | Auto scroll to bottom
                }
            }
        }
    Return  ;;;;;;;;;;;;
    
    CancelSaveCollection:
        MsgBox, % 64 + 4, Cancel, All changes will not be save!`nAre you sure you want to quit this window?
        IfMsgBox Yes
            Gui, fwCollect: Destroy
        IfMsgBox No
            Return           
    Return  ;;;;;;;;;;;;
    
    SaveCollection:
        MsgBox, % 49 + 8192, Confirmation, This action will override all existing items in the collection!`nAre you sure you want to proceed?
        IfMsgBox OK
        {
            AllFirmwareProperties := {}     ;;Empty the firmware main object
            
            listOfLV := "fwCollectLV1|fwCollectLV2"     ;;Make a loop for multiple LV
            Loop, Parse, listOfLV, |
            {
                listviewIndex := A_Index
                lvControlName := A_LoopField
                
                Gui, fwCollect: ListView, %lvControlName%     ; Specify which listview will be updated with LV commands
                ;;Create new collection
                Loop, % LV_GetCount()
                {
                    rowNumber := A_Index
                    Loop, % LV_GetCount("Column")
                    {
                        colNumber := A_Index
                        if (colNumber == 2)
                            LV_GetText(outFwVers, rowNumber, colNumber)
                        if (colNumber == 3)
                            LV_GetText(outTclPath, rowNumber, colNumber)
                        if (colNumber == LV_GetCount("Column")) {   ;;End of column
                            if (listviewIndex == 1)
                                AllFirmwareProperties.allMTCDTFirmwareProperties[rowNumber] := {fwName: outFwVers, fwPath: outTclPath}
                            if (listviewIndex == 2)
                                AllFirmwareProperties.allMTCAPFirmwareProperties[rowNumber] := {fwName: outFwVers, fwPath: outTclPath}
                        }
                    }
                }                
            }
            
            newJsonStr := JSON.Dump(AllFirmwareProperties)
            filehandle := FileOpen(MainFwPropertiesFilePath, "w")
            If !IsObject(filehandle) {
                MsgBox, 16, ERROR, Could not open <%MainFwPropertiesFilePath%> for writing!!
                Return
            }
            filehandle.Write(newJsonStr)
            filehandle.Close()
            
            firmware1 := "", firmware2 := ""    ;;Reset each time
            ;;Change dropdown appearance
            For each, item in AllFirmwareProperties.allMTCDTFirmwareProperties
                firmware1 .= (each == 1 ? "|" : "|") . item.fwName
            GuiControl, 1:, fware, %firmware1%
            GuiControl, 1: Choose, fware, 1
            
            For each, item in AllFirmwareProperties.allMTCAPFirmwareProperties
                firmware2 .= (each == 1 ? "|" : "|") . item.fwName
            GuiControl, 1:, mtcapFware, %firmware2%
            GuiControl, 1: Choose, mtcapFware, 1
            
            Gui, fwCollect: Destroy
        }
        IfMsgBox Cancel
            Return
    Return  ;;;;;;;;;;;;
    
    OnLVEvents:
        Gui, fwCollect: ListView, %A_GuiControl%     ; Set selected ListView as Default.
        LvRowHandle.SetHwnd(h%A_GuiControl%) ; Select active hwnd in Handle.
        activeList := A_GuiControl
        If (A_GuiControlEvent == "DoubleClick") {   ;;When user double click!
            Gui, lvEditor: Destroy
            rowNumber := LV_GetNext()
            Loop, % LV_GetCount("Column")
            {
                LV_GetText((A_Index == 1) ? outFwIndex : Continue, rowNumber, A_Index)
                LV_GetText((A_Index == 2) ? outFwName : Continue, rowNumber, A_Index)
                LV_GetText((A_Index == 3) ? outFwPath : Continue, rowNumber, A_Index)
            }
            lvProperties := [rowNumber, activeList]
            lvItems := [outFwIndex, outFwName, outFwPath]
            OpenLVEditor(lvProperties, lvItems)
        }
        ; Detect Drag event.
        If (A_GuiControlEvent = "D")
        {
            Dragging := True
            CtrlDrag := GetKeyState("Ctrl", "P")
            TargetRow := LvRowHandle.Drag(A_GuiEvent,,,,, !CtrlDrag) ; Call Drag function.
            If (GetKeyState("Ctrl", "P"))          ; Control-Drag = copy
                GoSub, CopySelection
            Else If (A_GuiEvent == "d")            ; Right-click drag
                Menu, MoveCopyMenu, Show
            LvRowHandle.Add()                         ; Add an entry in History.
            Dragging := False
        }
        ;MsgBox % A_GuiControl ", " A_GuiControlEvent ", " A_GuiEvent     
    Return  ;;;;;;;;;;;;
    
    CopySelection:
        LV_Rows.Copy()
        LV_Rows.Paste(TargetRow)
    Return
}

OpenLVEditor(lvProperties, lvItems) {
    Global
    lvRowNumber := lvProperties[1]
    lvActiveList := lvProperties[2]
    lvItemNumber := lvItems[1]
    
    ;;;GUI  ;;===============================;;
    Gui, lvEditor: Default 
    Gui, lvEditor: +ToolWindow +AlwaysOnTop +hWndLVEditor
    Gui, lvEditor: Add, GroupBox, x5 y0 w450 h70 Section,
    Gui, lvEditor: Add, Text, xs+10 ys+15, Firmware Version:
    Gui, lvEditor: Add, Edit, xs+100 ys+12 w150 vinFwVersEdit, % lvItems[2]
    Gui, lvEditor: Add, Text, xs+10 ys+45, TCL File Path:
    Gui, lvEditor: Add, Edit, xs+100 ys+42 w150 w280 r1 vinTclFPathEdit, % lvItems[3]
    GUi, lvEditor: Add, Button, xs+385 ys+41 gBrowseFWFileEdit, Browse...
    
    Gui, lvEditor: Add, Button, xs+160 ys+75 w70 h25 gSaveEdit, Save
    Gui, lvEditor: Add, Button, xs+240 ys+75 w70 h25 gCancelEdit, Cancel
    
    CoordMode, Mouse, Screen
    MouseGetPos, mPosX, mPosY   ;;Get mouse pos
    mPosX += 15, mPosY += 10
    Gui, lvEditor: Show, x%mPosX% y%mPosY%, % "LV Editor - (Item Number: " . lvItemNumber . ")"
    Return  ;;===============================;;
    
    CancelEdit:
    lvEditorGuiEscape:
    lvEditorGuiClose:
        Gui, lvEditor: Destroy
    Return
    ;;===================================================;;
    BrowseFWFileEdit:
        FileSelectFile, tclFileSelected, 3, C:\vbtest, Select a TCL File, Documents (*.tcl)
        if (tclFileSelected != "")
            GuiControl, Text, inTclFPathEdit, %tclFileSelected%
    Return  ;;;;;;;;;;;;
    
    SaveEdit:
        GuiControlGet, inputFwName, , inFwVersEdit
        GuiControlGet, inputFwPath, , inTclFPathEdit
        
        If (inputFwName == "" || inputFwPath == "") {
            MsgBox, % 16 + 4096, ERROR, Please input values!
            Return
        } Else {
            If (RegExMatch(inputFwPath, "i)^(?:[\w]\:|\\)(\\[a-z_\-\s0-9\.]+)+\.(tcl)$") = 0) {
                MsgBox, % 16 + 4096, ERROR, Invalid value for TCL file path!!!!
                Return
            } Else {
                Gui, fwCollect: Default
                Gui, fwCollect: ListView, %lvActiveList%     ; Specify which listview will be updated with LV commands
                LV_Modify(lvRowNumber, "AutoHdr", lvItemNumber, inputFwName, inputFwPath)
                Gui, lvEditor: Destroy
            }
        }
    Return  ;;;;;;;;;;;;
}

OpenFirmwareCollection_AddDataToLV() {
    Gui, fwCollect: ListView, fwCollectLV1     ; Specify which listview will be updated with LV commands 
    Loop, % AllFirmwareProperties.allMTCDTFirmwareProperties.Length()
    {
        LV_Add("", A_Index, AllFirmwareProperties.allMTCDTFirmwareProperties[A_Index].fwName, AllFirmwareProperties.allMTCDTFirmwareProperties[A_Index].fwPath)
    }
    Loop, % LV_GetCount("Column")
        LV_ModifyCol(A_Index, "AutoHdr")
    
    Gui, fwCollect: ListView, fwCollectLV2     ; Specify which listview will be updated with LV commands
    Loop, % AllFirmwareProperties.allMTCAPFirmwareProperties.Length()
    {
        LV_Add("", A_Index, AllFirmwareProperties.allMTCAPFirmwareProperties[A_Index].fwName, AllFirmwareProperties.allMTCAPFirmwareProperties[A_Index].fwPath)
    }
    Loop, % LV_GetCount("Column")
        LV_ModifyCol(A_Index, "AutoHdr")
}