﻿/*
    XDot Controller Function Library
    Contain all functions used by XDot Controller Scripts
*/
;;;;;;;;;;;;;Libraries;;;;;;;;;;;;;;;;
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Toolbar.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Class_LV_Colors.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\LV_EX.ahk
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\XDot-Controller\Imgs-for-GUI
    FileCreateDir C:\V-Projects\XDot-Controller\Imgs-for-GUI
IfNotExist C:\V-Projects\XDot-Controller\TTL-Files
    FileCreateDir C:\V-Projects\XDot-Controller\TTL-Files
IfNotExist C:\V-Projects\XDot-Controller\INI-Files
    FileCreateDir C:\V-Projects\XDot-Controller\INI-Files
IfNotExist C:\V-Projects\XDot-Controller\EXE-Files
    FileCreateDir C:\V-Projects\XDot-Controller\EXE-Files
IfNotExist C:\V-Projects\XDot-Controller\BIN-Files
    FileCreateDir C:\V-Projects\XDot-Controller\BIN-Files
IfNotExist C:\V-Projects\XDot-Controller\TEMP-DATA
    FileCreateDir C:\V-Projects\XDot-Controller\TEMP-DATA

IfNotExist Z:\XDOT\Data
    FileCreateDir Z:\XDOT\Data
IfNotExist Z:\XDOT\Saved-Nodes
    FileCreateDir Z:\XDOT\Saved-Nodes
IfNotExist Z:\XDOT\Logging\writing
    FileCreateDir Z:\XDOT\Logging\writing
IfNotExist Z:\XDOT\Logging\system
    FileCreateDir Z:\XDOT\Logging\system

FileInstall C:\MultiTech-Projects\Imgs-for-GUI\x_mark.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\x_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\check_mark.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\check_mark_brown.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark_brown.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\play_orange.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_orange.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\play_brown.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_brown.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\play_blue.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_blue.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\disable.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\excla_mark.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\excla_mark.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\folder-icon.ico, C:\V-Projects\XDot-Controller\Imgs-for-GUI\folder-icon.ico, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\save-icon.ico, C:\V-Projects\XDot-Controller\Imgs-for-GUI\save-icon.ico, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\pen_with_note-icon.ico, C:\V-Projects\XDot-Controller\Imgs-for-GUI\pen_with_note-icon.ico, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\add_file-icon.ico, C:\V-Projects\XDot-Controller\Imgs-for-GUI\add_file-icon.ico, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\green-dot-sm.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\green-dot-sm.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\red-dot-sm.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\red-dot-sm.png, 1
FileInstall C:\MultiTech-Projects\Imgs-for-GUI\yellow-dot-sm.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\yellow-dot-sm.png, 1

FileInstall C:\MultiTech-Projects\TTL-Files\all_xdot_test.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl, 1
FileInstall C:\MultiTech-Projects\TTL-Files\all_xdot_write_euid.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_euid.ttl, 1
FileInstall C:\MultiTech-Projects\TTL-Files\all_xdot_write_eco-lab.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_eco-lab.ttl, 1
FileInstall C:\MultiTech-Projects\TTL-Files\all_xdot_reprogram.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl, 1
FileInstall C:\MultiTech-Projects\TTL-Files\all_xdot_reset.ttl, C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reset.ttl, 1
FileInstall C:\MultiTech-Projects\INI-Files\xdot-tt-settings.INI, C:\V-Projects\XDot-Controller\INI-Files\xdot-tt-settings.INI, 1
FileInstall C:\MultiTech-Projects\EXE-Files\xdot-winwaitEachPort.exe, C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe, 1

FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AS923_JAPAN-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AS923_JAPAN-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AS923-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AS923-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AU915-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-AU915-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-EU868-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-EU868-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-IN865-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-IN865-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-KR920-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-KR920-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-RU864-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-RU864-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1.bin, 1

FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1-debug.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1-debug.bin, 1

FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-AS923_JAPAN-mbed-os-5.7.7.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.1.0-AS923_JAPAN-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-AS923-mbed-os-5.7.7.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.1.0-AS923-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-AU915-mbed-os-5.7.7.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.1.0-AU915-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-EU868-mbed-os-5.7.7.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.1.0-EU868-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-IN865-mbed-os-5.7.7.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.1.0-IN865-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-KR920-mbed-os-5.7.7.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.1.0-KR920-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-US915-mbed-os-5.7.7.bin, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.1.0-US915-mbed-os-5.7.7.bin, 1

FileInstall C:\MultiTech-Projects\Imgs-for-GUI\xdot-panel.png, C:\V-Projects\XDot-Controller\Imgs-for-GUI\xdot-panel.png, 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
;;;Global vars that used the same on 3 Apps
Global remotePath := "Z:\XDOT"
Global lotCodeList := []
Global xdotTestFilePath := "C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl"
Global teratermMacroExePath := "C:\teraterm\ttpmacro.exe"
Global syncModeFilePath := "Z:\XDOT\Data\syncdata.snc"
Global ResultLoggingPath := "Z:\XDOT\Logging\writing"
Global AuthRemoteFilePath := "Z:\XDOT\Data\auth.dat"

Global isReprogram := False
Global isEcoLabMode := False
Global isSyncMode := False
Global ecoLabOn := False ;For auto open ECO LAB mode

Global allFregs := ["AS923", "AS923-JAPAN", "AU915", "EU868", "IN865", "KR920", "RU864", "US915"]
Global allEcoFregs := ["US915", "EU868"]
Global allReProgFw := ["v3.0.2-debug", "v3.2.1-debug"]
Global allWriteFw := ["v3.2.1", "v3.1.0", "-Skip-"]
Global allEcoWriteFw := ["v3.0.2", "v3.2.1"]

Global xImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\x_mark.png"
Global checkImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark.png"
Global check2Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\check_mark_brown.png"
Global play1Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_orange.png"
Global play2Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_brown.png"
Global play3Img := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\play_blue.png"
Global disImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png"
Global exclaImg := "C:\V-Projects\XDot-Controller\Imgs-for-GUI\excla_mark.png"

Global xdotMapRemoteFilePath := "Z:\XDOT\Data\mapping-remote.dat"

;;SetTimer Global Functions
Global Authentication := Func("Authentication").Bind()
Global CheckUserLogin := Func("CheckUserLogin").Bind()

;Global Register_Key := "mtech!createnewaccount"
Global Register_Key := "MTech!Key"
Global Crypt_Key := "Multitech System Inc"
Global UserInfo := {userFirstName: "???", userLastName: "???", userUserName: "???", userPassword: "???", userRole: "N/A", isLogin: False}
Global UserMainDataFilePath := "Z:\XDOT\Data\AppUser.dat"
;=======================================================================================;

WinSet, Redraw, , ahk_id %hIdListView%
;;;;;;Menu bar for MAIN GUI
AddMainMenuBar() {
    Global
    ;;;;;;Menu bar
        Menu FileMenu, Add, Reload Program, reloadProgHandler
        Menu FileMenu, Add  ;Separator
        Menu FileMenu, Add, Logout, logoutHandler
        Menu FileMenu, Add  ;Separator
        Menu FileMenu, Add, Quit, quitHandler
    Menu MainMenuBar, Add, &File, :FileMenu     ;Main button
        Menu OptionMenu, Add, Eco Lab Mode, ecoLabModeHandler
        Menu OptionMenu, Add  ;Separator
        Menu OptionMenu, Add, Enable Sync Mode, endableSyncModeHandler
    Menu MainMenuBar, Add, &Options, :OptionMenu     ;Main button
        Menu ToolMenu, Add, Log Viewer, logViewerHandler
        Menu ToolMenu, Add  ;Separator
        Menu ToolMenu, Add, XDot Mapping, xdotMapHandler
        Menu ToolMenu, Add  ;Separator
        Menu ToolMenu, Add, Analyst, analystHandler
    Menu MainMenuBar, Add, &Tools, :ToolMenu     ;Main button
        Menu HelpMenu, Add, Image Indicators, imageIndicatorHandler
        Menu HelpMenu, Add  ;Separator
        Menu HelpMenu, Add, About, aboutHandler
    Menu MainMenuBar, Add, &Help, :HelpMenu     ;Main button
    Gui Menu, MainMenuBar
    
    ;;;;Run after menu bar is created
    ;Menu, OptionMenu, Disable, Enable Sync Mode
    Menu, OptionMenu, Check, Enable Sync Mode
    isSyncMode := True
    syncModeWriteIni("AutoPick", True)
    Menu, HelpMenu, Disable, About
    Menu, ToolMenu, Disable, XDot Mapping
}
;;;;;;;;;All menu handlers
reloadProgHandler() {
    Reload
}

logoutHandler() {
    UserLogout()
}

quitHandler() {
    ExitApp
}

ecoLabModeHandler() {
    DriveGet, driveStatus, Status, %remotePath%
    if (driveStatus != "Ready" || !isSyncMode) {
        Menu, OptionMenu, ToggleCheck, Eco Lab Mode
        toggleEcoLabMode()
    }
    if (driveStatus = "Ready" && isSyncMode) {
        ;;for autopick EcoLab Mode
        ecoLabOn := !ecoLabOn
        ;MsgBox % ecoLabOn
        syncModeWriteIni("EcoLabOnPC1", ecoLabOn)
        syncModeWriteIni("EcoLabOnPC2", ecoLabOn)
        syncModeWriteIni("EcoLabOnPC3", ecoLabOn)
    }
}

endableSyncModeHandler() {
    Menu, OptionMenu, ToggleCheck, Enable Sync Mode
    isSyncMode := !isSyncMode
    syncModeWriteIni("AutoPick", isSyncMode)
}

logViewerHandler() {
    OpenLogViewer()
}

xdotMapHandler() {
    XDotMappingTool()
}

analystHandler() {
    MsgBox Not implemented yet!
}

imageIndicatorHandler() {
    OpenAboutMsgGui1()
}

aboutHandler() {
    
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
AutoCloseAPWindow() {
    IfWinExist, AutoPlay
        WinClose, AutoPlay
    IfWinExist, ahk_exe cmd.exe
        WinMinimize, ahk_exe cmd.exe
}

;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
runAll() {
    GuiControlGet, isRunTestChecked, , totalGPortRadio
    GuiControlGet, isRunReprogChecked, , reproGPortRadio
    isReprogram := isRunReprogChecked = 1 ? True : False
    
    if (isRunTestChecked = 1) {
        OnMessage(0x44, "PlayInCircleIcon") ;Add icon
        MsgBox 0x81, RUN FUNCTIONAL TEST, Begin FUNCTIONAL TESTS on all %totalGoodPort% ports?
        OnMessage(0x44, "") ;Clear icon
        index := startedIndex
        IfMsgBox OK
        {
            resetXdotBttns()
            deleteOldCacheFiles()
            Loop, %totalPort%
            {
                ctrlVar := xdotProperties[index].ctrlVar
                xStatus := xdotProperties[index].status
                mainPort := xdotProperties[index].mainPort
                breakPort := xdotProperties[index].breakPort
                portName := xdotProperties[index].portName
                driveName := xdotProperties[index].driveName
                ttXPos := xdotProperties[index].ttXPos    ;Position X for teraterm window
                ttYPos := xdotProperties[index].ttYPos    ;Position Y for teraterm window
                
                index++
                
                if (xStatus = "G") {
                    WinKill COM%mainPort%
                    IfWinExist PROGRAMMING
                        Sleep 9000
                    changeXdotBttnIcon(ctrlVar, "PLAY", "TESTING")
                    Run, %teratermMacroExePath% /V C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_test.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, , Hide, TTWinPID
                    Run, %ComSpec% /c start C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe %mainPort% %breakPort% %TTWinPID%, , Hide
                    Sleep 3000
                }
            }
        }
        IfMsgBox Cancel
            return
    }
    
    if (isRunReprogChecked = 1) {
        GuiControlGet, chosenPFw, , chosenPFw, Text
        
        OnMessage(0x44, "PlayInCircleIcon") ;Add icon
        MsgBox 0x81, Run, Begin re-program %totalGoodPort% port(s) to %chosenPFw%?
        OnMessage(0x44, "") ;Clear icon
        index := startedIndex
        IfMsgBox OK
        {
            resetXdotBttns()
            deleteOldCacheFiles()
            Loop, %totalPort%
            {
                StartReprogram:
                ctrlVar := xdotProperties[index].ctrlVar
                xStatus := xdotProperties[index].status
                mainPort := xdotProperties[index].mainPort
                breakPort := xdotProperties[index].breakPort
                portName := xdotProperties[index].portName
                driveName := xdotProperties[index].driveName
                ttXPos := xdotProperties[index].ttXPos    ;Position X for teraterm window
                ttYPos := xdotProperties[index].ttYPos    ;Position Y for teraterm window
                
                index++
                
                if (xStatus = "G") {
                    
                    WinKill COM%mainPort%
                    IfWinExist PROGRAMMING
                        Sleep 9000
                    changeXdotBttnIcon(ctrlVar, "PLAY", "PROGRAMMING")
                    Run, %teratermMacroExePath% C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 %chosenPFw%, , Hide, TTWinPID
                    Run, %ComSpec% /c start C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe %mainPort% %breakPort% %TTWinPID%, , Hide
                    Sleep 2500
                }
            }
        }
        IfMsgBox Cancel
            return
    }
    
}

writeAll() {
    GuiControlGet, chosenFreq, , chosenFreq, Text   ;Get value from DropDownList
    GuiControlGet, chosenWFw, , chosenWFw, Text     ;Get value from DropDownList
    GuiControlGet, recentLotCode, , recentLotCode, Text   ;Get lot code
    
    userRun := UserInfo.userFirstName "_" UserInfo.userLastName
    
    if (recentLotCode == "") {
        MsgBox 4144, WARNING, Please ADD LOT CODE before running!
        return
    }
    
    if (chosenFreq = "") {
        MsgBox 4144, WARNING, Please select a FREQUENCY!
        return
    }
    
    DriveGet, driveStatus, Status, %remotePath%
    if (driveStatus != "Ready") {
        MsgBox 16, ERROR, Server PC not responding. Please check before running!!
        return
    }

    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN EUID WRITE, Begin EUID WRITE on all %totalGoodPort% ports?`n**Make sure you pick the right FREQUENCY**
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        startTime := A_TickCount
        
        isReprogram := False
        resetXdotBttns()
        deleteOldCacheFiles()
        resetNodesToWrite()
        index := startedIndex
        
        ;;; Checking all node id in the input field before running!
        Loop, %totalPort%
        {
            ctrlVar := xdotProperties[index].ctrlVar
            xStatus := xdotProperties[index].status
            node := readNodeLine(index)
            
            if (StrLen(node) > 16) {
                MsgBox 16 , ERROR, Invalid Node ID in one of the IDs. Please recheck your input!!!`nNode ID should only have 16 digits!
                return
            }
            
            if (RegExMatch(node, "^([0-9a-fA-F]){16}$") = 0) && if (xStatus = "G"){
                changeXdotBttnIcon(ctrlVar, "DISABLE", , index)
            }
            
            xStatus := xdotProperties[index].status
            if (xStatus = "G") {
                GuiControl Text, nodeToWrite%index%, %node%
                Lbl_ReplaceNodeLine:
                replaceNodeLine(index, "----")
                ;Recheck if replace node successful
                replaceNode := readNodeLine(index)
                if (replaceNode != "----")
                    goto Lbl_ReplaceNodeLine
            }
            index++
        }
        saveNodesToWrite()
        
        ;After save...recheck if replacement successful again -- Fixing bug
        Lbl_RecheckReplace:
        index := startedIndex
        Random, randIndex, %startedIndex%, % startedIndex + (totalPort - 1)
        replaceNodeAgain := readNodeLine(randIndex)
        if (replaceNodeAgain != "----") {
            Loop, %totalPort%
            {
                xStatus := xdotProperties[index].status
                if (xStatus = "G") {
                    replaceNodeLine(index, "----")
                }
                index++
            }
            saveNodesToWrite()
            goto Lbl_RecheckReplace
        }
        
        ;;;Start writing
        Sleep 500
        index := startedIndex
        Loop, %totalPort%
        {
            ctrlVar := xdotProperties[index].ctrlVar
            xStatus := xdotProperties[index].status
            mainPort := xdotProperties[index].mainPort
            breakPort := xdotProperties[index].breakPort
            driveName := xdotProperties[index].driveName
            if (xStatus = "G") {
                WinKill COM%mainPort%
                IfWinExist PROGRAMMING
                    Sleep 9000
                changeXdotBttnIcon(ctrlVar, "PLAY", "WRITING")
                Gui, Font, c0c63ed Bold
                GuiControl, Font, portLabel%index%
                Gui, Font
                Gui, Font, c0c63ed
                GuiControl, Font, nodeToWrite%index%
                GuiControlGet, node, , nodeToWrite%index%
                StringReplace node, node, %A_Space%, , All  ;Delete all white space in variable
                
                if (firstWriteNode == "" )
                    firstWriteNode := node
                Run, %teratermMacroExePath% C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_euid.ttl dummyParam2`,%mainPort%`,%breakPort%`,%driveName%`,dummyParam6`,%chosenFreq%`,%node%`,%chosenWFw% %recentLotCode% %userRun%, , Hide, TTWinPID
                Run, %ComSpec% /c start C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe %mainPort% %breakPort% %TTWinPID%, , Hide
                lastWriteNode := node
                Sleep 3000
            }
            
            ;;;; Remove the first 24 node and replace with the next nodes on the list (if only port 24 is finised!)
            if (index = 24) {
                FileRead, fileContent, %remotePath%\nodesToWrite.txt
                noNodeCount := 1
                Loop, Parse, fileContent, `n
                    if (A_Index < 24) 
                        if (RegExMatch(A_LoopField, "[0-9a-fA-F]") = 0) {
                            noNodeCount++
                            if (noNodeCount = 24) {
                                listNodeArray := StrSplit(fileContent, "`n", "`t")    ;Convert string to array
                                Loop, 24
                                    removedNode := listNodeArray.RemoveAt(1)  ;Remove the first 24 used nodes
                                newListNodes := ""              ;Convert array back to string
                                For key, var in listNodeArray
                                    newListNodes .= var "`n"
                                newListNodes := RTrim(newListNodes, "`n")       ;remove last while space
                                GuiControl Text, editNode, %newListNodes%       ;Return nodes to edit field
                                saveNodesToWrite()      ;Save new content
                            }
                        }
            }
            index++
        }
        
        Process, WaitClose, xdot-winwaitEachPort.exe
        endTime := A_TickCount - startTime
        totalTimeInMin := (endTime / 1000) / 60
        
        FormatTime, timeNow, , hh:mm:ss tt (MM/dd/yyyy)
        MsgBox, 64, Write EUI Finished, % "You just finished writing EUI at: " timeNow "`nTotal time ran: " Round(totalTimeInMin, 2) " (minutes)`nNOTED: Please fix all failure XDots before labelling!"
    }
    IfMsgBox Cancel
        return
    
}

writeEcoLab() {
    ;Global
    GuiControlGet, chosenEcoFreq, , chosenEcoFreq, Text   ;Get value from DropDownList
    GuiControlGet, chosenEcoWFw, , chosenEcoWFw, Text     ;Get value from DropDownList
    GuiControlGet, recentLotCode, , recentLotCode, Text   ;Get lot code
    
    userRun := UserInfo.userFirstName "_" UserInfo.userLastName
    
    if (chosenEcoFreq = "") {
        MsgBox 4144, WARNING, Please select a FREQUENCY for ECO LAB!
        return
    }
    
    if (chosenEcoWFw = "") {
        MsgBox 4144, WARNING, Please select a FINAL FIRMWARE for ECO LAB!
        return
    }

    DriveGet, driveStatus, Status, %remotePath%
    if (driveStatus != "Ready") {
        MsgBox 16, ERROR, Server PC not responding. Please check before running!!
        return
    }
    
    OnMessage(0x44, "PlayInCircleIcon") ;Add icon
    MsgBox 0x81, RUN EUID WRITE, Begin (ECO LAB) EUID WRITE on %totalGoodPort% ports?
    OnMessage(0x44, "") ;Clear icon
    IfMsgBox OK
    {
        startTime := A_TickCount
        
        Gui, ListView, idListView
        isReprogram := False
        resetXdotBttns()
        deleteOldCacheFiles()
        resetNodesToWrite()
        
        ;LVInstance := ""
        LVInstance.NoSizing(False)
        
        ;;Add data to ListView
        index := startedIndex
        Loop, %totalPort%
        {            
            ctrlVar := xdotProperties[index].ctrlVar
            xStatus := xdotProperties[index].status
            mainPort := xdotProperties[index].mainPort
            
            allIdRead := readNodeLine(index)
            if (RegExMatch(allIdRead, "[0-9a-fA-F]") = 0) && if (xStatus = "G"){
                changeXdotBttnIcon(ctrlVar, "DISABLE", , index)
            }
            
            xStatus := xdotProperties[index].status
            if (xStatus = "G") {
                Loop, Parse, allIdRead, `,|
                {   
                    if (A_Index = 1)
                        serialNumRead := A_LoopField
                    if (A_Index = 2)
                        nodeIdRead := A_LoopField
                    if (A_Index = 3)
                        appKeyRead := A_LoopField
                    if (A_Index = 4)
                        uuidRead := A_LoopField
                }
                
                if (uuidRead = "") {
                    MsgBox 16 , ERROR, Invalid IDs in the node field. Please recheck your input!!!`nNoted, you are on the WRITING PROCESS for ECO LAB!!!
                    return
                }
                
                LV_Insert( A_Index, "", mainPort, nodeIdRead, serialNumRead, appKeyRead, uuidRead)
                LV_Delete(A_Index + 1)
                
                Lbl_ReplaceNodeLine2:
                replaceNodeLine(index, "----")
                ;Recheck if replace node successful
                replaceNode := readNodeLine(index)
                if (replaceNode != "----")
                    goto Lbl_ReplaceNodeLine2
                
                LV_ModifyCol( , "AutoHdr")
            }
            index++
            
            if (xStatus = "D") {
                LV_Modify(A_Index, "+Select")
                LVInstance.Row(A_Index, 0xd9d9d9, 0xc4c4c4)
                LV_Modify(A_Index, "-Select")
            }
        }
        saveNodesToWrite()
        
        ;After save...recheck if replacement successful again -- Fixing bug
        Lbl_RecheckReplace2:
        index := startedIndex
        Random, randIndex, %startedIndex%, % startedIndex + (totalPort - 1)
        replaceNodeAgain := readNodeLine(randIndex)
        if (replaceNodeAgain != "----") {
            Loop, %totalPort%
            {
                xStatus := xdotProperties[index].status
                if (xStatus = "G") {
                    replaceNodeLine(index, "----")
                }
                index++
            }
            saveNodesToWrite()
            goto Lbl_RecheckReplace2
        }
        
        ;;Start writing
        Sleep 500
        indexCount := startedIndex
        Loop, %totalPort%
        {
            ctrlVar := xdotProperties[indexCount].ctrlVar
            xStatus := xdotProperties[indexCount].status
            mainPort := xdotProperties[indexCount].mainPort
            breakPort := xdotProperties[indexCount].breakPort
            driveName := xdotProperties[indexCount].driveName
            allIdStr := ""
            
            if (xStatus = "G") {
                rowNum := A_Index
                WinKill COM%mainPort%
                IfWinExist PROGRAMMING
                    Sleep 9000
                changeXdotBttnIcon(ctrlVar, "PLAY", "WRITING")
                
                changeLVStatusRow(rowNum, "RAN")
                
                ;;Get all id string in ListView each row
                Loop, 5
                {
                    LV_GetText(idStr, rowNum, A_Index)
                    allIdStr .= idStr "|"
                    
                    ;;get first and last node
                    if (A_Index == 2)
                        LV_GetText(node, rowNum, A_Index)
                    if (firstWriteNode == "")
                        firstWriteNode := node
                    lastWriteNode := node
                }
                
                Run, %teratermMacroExePath% C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_eco-lab.ttl dummyParam2`,%mainPort%`,%breakPort%`,%driveName%`,dummyParam6`,%chosenEcoFreq%`,%allIdStr%`,%chosenEcoWFw% %recentLotCode% %userRun%, , Hide, TTWinPID
                Run, %ComSpec% /c start C:\V-Projects\XDot-Controller\EXE-Files\xdot-winwaitEachPort.exe %mainPort% %breakPort% %TTWinPID%, , Hide
                Sleep 3000
            }
            
             if (indexCount = 24) {
                FileRead, fileContent, %remotePath%\nodesToWrite.txt
                noNodeCount := 1
                Loop, Parse, fileContent, `n
                    if (A_Index < 24) 
                        if (RegExMatch(A_LoopField, "[0-9a-fA-F]") = 0) {
                            noNodeCount++
                            if (noNodeCount = 24) {
                                listNodeArray := StrSplit(fileContent, "`n", "`t")    ;Convert string to array
                                Loop, 24
                                    removedNode := listNodeArray.RemoveAt(1)  ;Remove the first 24 used nodes
                                newListNodes := ""              ;Convert array back to string
                                For key, var in listNodeArray
                                    newListNodes .= var "`n"
                                newListNodes := RTrim(newListNodes, "`n")       ;remove last while space
                                GuiControl Text, editNode, %newListNodes%       ;Return nodes to edit field
                                saveNodesToWrite()      ;Save new content
                            }
                        }
            }
            
            indexCount++
        }
        
        Process, WaitClose, xdot-winwaitEachPort.exe
        endTime := A_TickCount - startTime
        totalTimeInMin := (endTime / 1000) / 60
        
        FormatTime, timeNow, , hh:mm:ss tt (MM/dd/yyyy)
        MsgBox, 64, Write EUI Finished, % "You just finished writing EUI at: " timeNow "`nTotal time ran: " Round(totalTimeInMin, 2) " (minutes)`nNOTED: Please fix all failure XDots before labelling!"
    }
    
    IfMsgBox Cancel
        return
}

giveBackToEdit() {
    MsgBox 0x24, Confirmation, Are you sure you want to import all nodes back to edit field? 
    IfMsgBox Yes
    {
        index := startedIndex
        Loop, %totalPort%
        {
            GuiControlGet, nodeToWrite, , nodeToWrite%index%
            if (nodeToWrite != "")
                writeNodeLine(index, nodeToWrite)
            index++
        }
        saveNodesToWrite()
        resetNodesToWrite()
    }
    IfMsgBox No
        return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
resetXdotBttns() {
    Global   
    Loop, 25
    {
        ctrlVar := xdotProperties[A_Index].ctrlVar
        RegExMatch(ctrlVar, "\d+$", num)    ;Get button number based on button variable
        GuiControl, +v%ctrlVar%, Bad%ctrlVar%
        GuiControl, +v%ctrlVar%, Good%ctrlVar%
        GuiControl, +v%ctrlVar%, Play%ctrlVar%
        GuiControl, +gGetXDot, %ctrlVar%    ;Reset G-Label
        GuiControl, Text, %ctrlVar%, P%num%   ;Return button text
        GuiControlGet, hwndVar, Hwnd , %ctrlVar%
        GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
    }
    IL_Destroy(normal_il)   ;Detroy the ImageList stored in GuiButtonIcon() method
}

resetNodesToWrite() {
    Global
    Gui, 1: Default
    index := startedIndex
    Loop, %totalPort%
    {
        GuiControl Text, nodeToWrite%index%,    ;Delete text
        Gui, Font, cblack Bold
        GuiControl, Font, portLabel%index%
        Gui, Font
        Gui, Font, cblack
        GuiControl, Font, nodeToWrite%index%
        index++
    }
    
    Gui, ListView, idListView
    LVInstance.Clear()
    LV_Delete()
    index := startedIndex
    Loop, 8
    {
        mainPort := xdotProperties[index].mainPort
        LV_Add("", mainPort)
        
        index++
    }
}

deleteOldCacheFiles() {
    Loop, 24
    {
        mainPort := xdotProperties[A_Index].mainPort
        FileDelete, C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
    }
}

loadNodesToWrite() {
    FileRead, fileContent, %remotePath%\nodesToWrite.txt
    StringReplace, fileContent, fileContent, %A_Space%, , All
    StringReplace, fileContent, fileContent, %A_Tab%, , All
    GuiControl Text, editNode, %fileContent%
    
    ;Recheck if load successfull
    Lbl_RecheckLoad:
    GuiControlGet readEditContent, , editNode    ;get text from edit field
    if (readEditContent = "") {
        FileRead, fileBakContent, %remotePath%\nodesToWrite.bak
        GuiControl Text, editNode, %fileBakContent%
        goto Lbl_RecheckLoad
    }
}

saveNodesToWrite() {
    fileLoc = %remotePath%\nodesToWrite.txt
    GuiControlGet readEditContent, , editNode    ;get new text
    FileRead mainContent, %remotePath%\nodesToWrite.txt
    
    if (mainContent != "")
        FileCopy %remotePath%\nodesToWrite.txt, %remotePath%\nodesToWrite.bak, 1
    FileRead bakContent, %remotePath%\nodesToWrite.bak
    
    file := FileOpen(fileLoc, "w")      ;delete all text
    file.Close()
    if (readEditContent = "")
        FileAppend, %bakContent%, %fileLoc%     ;write backup text to main file
    FileAppend, %readEditContent%, %fileLoc%     ;write new text to main file
}

readNodeLine(lineNum) {
    GuiControlGet listEditNodes, , editNode
    Loop, Parse, listEditNodes, `n
    {
        if (A_Index = lineNum) {
            if (isEcoLabMode) {
                StringReplace, nodes, A_LoopField, `,, |, All
                return nodes
            } else
                return A_LoopField
        }
    }
}

replaceNodeLine(lineNum, replaceStr := "") {
    GuiControlGet listEditNodes, , editNode
    listEditNodeArray := StrSplit(listEditNodes, "`n", "`t")    ;Convert string to array
    listEditNodeArray[lineNum] := replaceStr    ;Replace text by index
    
    ;Convert array back to string
    newListEditNodes := ""
    For key, var in listEditNodeArray
        newListEditNodes .= var "`n"
    newListEditNodes := RTrim(newListEditNodes, "`n")     ;remove last while space
    GuiControl Text, editNode, %newListEditNodes%
}

writeNodeLine(lineNum, writeStr) {
    GuiControlGet listEditNodes, , editNode
    listEditNodeArray := StrSplit(listEditNodes, "`n", "`t")    ;Convert string to array
    
    listEditNodeArray.InsertAt(lineNum, writeStr)   ;Append text to a specific index
    
    ;Convert array back to string
    newListEditNodes := ""
    For key, var in listEditNodeArray
        newListEditNodes .= var "`n"
    newListEditNodes := RTrim(newListEditNodes, "`n")     ;remove last while space
    GuiControl Text, editNode, %newListEditNodes%
}

radioToggle() {
    isReprogram := !isReprogram
    syncModeWriteIni("TestRadioBttn", !isReprogram)
    syncModeWriteIni("ProgRadioBttn", isReprogram)
    resetXdotBttns()
    deleteOldCacheFiles()
}

browseNode() {
    FileSelectFile, selectedFile, , , Select a NodeID text file..., Text Documents (*.txt; *.doc)
    if (selectedFile = "")
        return
    if (RegExMatch(selectedFile, "\d{10}.txt$") = 0) {
        MsgBox, 16, ERROR, Wrong NODE file!!!
        return
    }
    
    FileRead, outStr, %selectedFile%
    if (outStr = "") {
        MsgBox, 16, ERROR, File is empty!!??
        return
    }
    GuiControl Text, editNode, %outStr%
    
    SplitPath, selectedFile, , , , nameNoExt
    syncModeWriteIni("RecentUsedLotCode", nameNoExt)
    
    saveNodesToWrite()
}

getLotCodeList() {
    lotList := []
    Loop Files, %remotePath%\Saved-Nodes\*.txt, R ; Recurse into subfolders.
    {
        str := A_LoopFileName
        StringReplace, str, str, .txt, , All    ;Remove .txt
        lotList[A_Index] := str
    }
    reverseArray(lotList)
    
    return lotList
}

reverseArray(array)
{
	arrayC := array.Clone()
	tempObj := {}
	for vKey in array
		tempObj.Push(vKey)
	vIndex := tempObj.Length()
	for vKey in array
		array[vKey] := arrayC[tempObj[vIndex--]]
	arrayC := tempObj := ""
}

updateLotCodeList() {
    Gui, 1: Default
    newLotCodeList := getLotCodeList()     ;Reload lot code list var
    newLotCodeDrop := ""
    For each, item in newLotCodeList
    {
        if (each == 1)
            newLotCode := item
        newLotCodeDrop .= (each == 1 ? "" : "|") . item
    }
    GuiControl, , lotCodeSelected, |%newLotCodeDrop%
}

loadNodeFromLot() {
    GuiControlGet outStr, , lotCodeSelected
    syncModeWriteIni("RecentUsedLotCode", outStr)
    if (outStr != "") {
        outStr = %outStr%.txt
        FileRead outVar, %remotePath%\Saved-Nodes\%outStr%
        StringReplace, outVar, outVar, %A_Space%, , All
        StringReplace, outVar, outVar, %A_Tab%, , All
        GuiControl Text, editNode, %outVar%
        saveNodesToWrite()
        IniRead, lot, %syncModeFilePath%, Sync, RecentUsedLotCode
        GuiControl, Text, recentLotCode, %lot%
        GuiControl, Text, lotCodeSelected,      ;Empty the text field
    }
}

changeXdotBttnIcon(guiControlVar, option, mode := "", xIndex := 0) {
    Global                                                  ;Must set all var to global to use GuiControl
    Gui 1: Default
    RegExMatch(guiControlVar, "\d+$", num)                  ;Get the number from control var
    RegExMatch(guiControlVar, "XDot\d.", origCtrlVar)       ;Get the original controlvar Ex: XDot01, XDot02
    hwndVar = h%origCtrlVar%
    
    if (option = "NORMAL") {                  ;;;;=====================NORMAL state
        GuiButtonIcon(%hwndVar%, "", 1, "s24")                  ;Delete icon
        GuiControl, Text, %guiControlVar%, P%num%               ;Add text back
        GuiControl, +v%origCtrlVar%, %guiControlVar%           ;Change var of control to original
        totalGoodPort++
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to
        GuiControl, Enable, portLabel%xIndex%
        GuiControl, Enable, nodeToWrite%xIndex%
        changeLVStatusRow(num, "ENABLE")
    } else if (option = "ERROR") {            ;;;;=====================ERROR ICON
        GuiButtonIcon(%hwndVar%, exclaImg, 1, "s24")         ;Display icon
        GuiControl, +v%origCtrlVar%,  Play%origCtrlVar%          ;Change var of control
    } else if (option = "DISABLE") {            ;;;;=====================DISABLE ICON
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        GuiButtonIcon(%hwndVar%, disImg, 1, "s24")         ;Display icon
        xdotProperties[xIndex].status := "D"
        GuiControl, +vDis%origCtrlVar%,  %origCtrlVar%          ;Change var of control
        totalGoodPort--
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to
        GuiControl, Disable, portLabel%xIndex%
        GuiControl, Disable, nodeToWrite%xIndex%
        changeLVStatusRow(num, "DISABLE")
    } else if (option = "BAD") {                ;;;;=====================BAD ICON
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        GuiButtonIcon(%hwndVar%, xImg, 1, "s24")         ;Display icon
        GuiControl, +vBad%origCtrlVar%,  Play%origCtrlVar%          ;Change var of control
    } else if (option = "GOOD") {               ;;;;=====================GOOD ICON
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        GuiButtonIcon(%hwndVar%, checkImg, 1, "s24")     ;Display icon
        if (mode = "PROGRAMMING")
            GuiButtonIcon(%hwndVar%, check2Img, 1, "s24")     ;Display icon
        GuiControl, +vGood%origCtrlVar%,  Play%origCtrlVar%         ;Change var of control
    } else if (option = "PLAY") {               ;;;;=====================PLAY ICON
        GuiControl, Text, %guiControlVar%,                          ;Delete text
        if (mode = "TESTING") {
            GuiButtonIcon(%hwndVar%, play1Img, 1, "s24") ;Display icon
        }
        else if (mode = "PROGRAMMING") {
            GuiButtonIcon(%hwndVar%, play2Img, 1, "s24") ;Display icon
        }
        else if (mode = "WRITING") {
            GuiButtonIcon(%hwndVar%, play3Img, 1, "s24") ;Display icon
        }
        GuiControl, +vPlay%origCtrlVar%, %guiControlVar%            ;Change var of control
    }
    
    ;;For Mapping Tool
    mapToolStopCounter++
}

OnRightClick() {
    Global
    Gui, 1: Default
    GuiControlGet, hwndVar, Hwnd , %A_GuiControl%
    RegExMatch(A_GuiControl, "\d+$", num)
    numNo0 := LTrim(num, "0")
    lvNum := num
    isXdot := RegExMatch(A_GuiControl, "^XDot[0-9]{2}$")
    isBadXdot := RegExMatch(A_GuiControl, "^BadXDot[0-9]{2}$")
    isGoodXdot := RegExMatch(A_GuiControl, "^GoodXDot[0-9]{2}$")
    isDisXdot := RegExMatch(A_GuiControl, "^DisXDot[0-9]{2}$")
    isDisBadXdot := RegExMatch(A_GuiControl, "^DisBadXDot[0-9]{2}$")
    isDisGoodXdot := RegExMatch(A_GuiControl, "^DisGoodXDot[0-9]{2}$")
    if (isXdot = 1) {   ;Make it only works on Xdot Buttons
        changeXdotBttnIcon(A_GuiControl, "DISABLE", , numNo0)
    } else if (isDisXdot = 1 || isDisBadXdot = 1 || isDisGoodXdot = 1) {
        totalGoodPort++
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to
        GuiControl, Enable, portLabel%numNo0%
        GuiControl, Enable, nodeToWrite%numNo0%
        changeLVStatusRow(num, "ENABLE")
        xdotProperties[num].status := "G"
        if (isDisXdot = 1) {
            newVar := SubStr(A_GuiControl, 4)
            GuiControl, +v%newVar%, %A_GuiControl%  ;Return to original var (XDot01)
            GuiControl, Text, %newVar%, P%num%   ;Return button text
            GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
        } else if (isDisBadXdot = 1) {
            newVar := SubStr(A_GuiControl, 4)
            GuiControl, +v%newVar%, %A_GuiControl%  ;Return to original var (BadXDot01)
            changeLVStatusRow(num, "RAN")
            GuiButtonIcon(hwndVar, xImg, 1, "s24")
        } else if (isDisGoodXdot = 1) {
            newVar := SubStr(A_GuiControl, 4)
            GuiControl, +v%newVar%, %A_GuiControl%  ;Return to original var (GoodXDot01)
            changeLVStatusRow(num, "RAN")
            if (isReprogram)
                GuiButtonIcon(hwndVar, check2Img, 1, "s24")
            else
                GuiButtonIcon(hwndVar, checkImg, 1, "s24")
        }
        
    } else if (isBadXdot = 1 || isGoodXdot = 1) {
        totalGoodPort--
        GuiControl, Text, totalGPortRadio, Run tests on %totalGoodPort% ports
        GuiControl, Text, reproGPortRadio, Reprogram %totalGoodPort% ports to
        GuiControl, Disable, portLabel%numNo0%
        GuiControl, Disable, nodeToWrite%numNo0%        
        xdotProperties[num].status := "D"
        GuiControl, +vDis%A_GuiControl%, %A_GuiControl%     ;Change var of control
        GuiControl, Text, %A_GuiControl%,    ;Delete text
        changeLVStatusRow(num, "DISABLE")
        GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png", 1, "s24")   ;Display icon
    }
}

changeLVStatusRow(lvRowNum, lvStatus := "") {
    Global
    Gui, ListView, idListView       ;Eco Lab ListView
    lvRowNum := (lvRowNum > 8 && lvRowNum < 17) ? lvRowNum -= 8 : lvRowNum
    lvRowNum := (lvRowNum > 16) ? lvRowNum -= 16 : lvRowNum
    
    if (lvStatus = "RAN") {
        LV_Modify(lvRowNum, "+Select")
        LVInstance.Row(lvRowNum, 0x0048b5, 0xFFFFFF)     ;Change to blue/white
        LV_Modify(lvRowNum, "-Select")
    }
    
    if (lvStatus = "DISABLE") {
        LV_Modify(lvRowNum, "+Select")
        LVInstance.Row(lvRowNum, 0xd9d9d9, 0xc4c4c4)     ;Change to grey/grey
        LV_Modify(lvRowNum, "-Select")
    }
    
    if (lvStatus = "ENABLE") {
        LV_Modify(lvRowNum, "+Select")
        LVInstance.Row(lvRowNum, 0xffffff, 0x000000)     ;Change to white/black
        LV_Modify(lvRowNum, "-Select")
    }
}

toggleEcoLabMode() {
    Global
    Gui, 1: Default
    Static toggleState := 1
    
    if (toggleState = 1) {
        isEcoLabMode := True
        ;;Hide old gui controls
        GuiControl, Hide, selectFreqLabel
        GuiControl, Hide, chosenFreq
        GuiControl, Hide, selectWFwLabel
        GuiControl, Hide, chosenWFw
        Loop, 24
        {
            GuiControl, Hide, portLabel%A_Index%
            GuiControl, Hide, nodeToWrite%A_Index%
        }
        GuiControl, Hide, giveBackBttn
        GuiControl, , wfwLabel, FW: v3.0.2
        
        ;;Show new gui controls
        GuiControl, Show, idListView
        GuiControl, , writeLabel, EUID Write (ECO LAB)
        GuiControl, Show, ecoFwLabel
        GuiControl, Show, ecoFreqLabel
        GuiControl, Show, chosenEcoWFw
        GuiControl, Show, chosenEcoFreq
        GuiControl, +gwriteEcoLab, writeAllBttn
        
        toggleState := 0
    } else {
        isEcoLabMode := False
        GuiControl, Show, selectFreqLabel
        GuiControl, Show, chosenFreq
        GuiControl, Show, selectWFwLabel
        GuiControl, Show, chosenWFw
        Loop, 24
        {
            GuiControl, Show, portLabel%A_Index%
            GuiControl, Show, nodeToWrite%A_Index%
        }
        GuiControl, Show, giveBackBttn
        GuiControl, , wfwLabel, FW: v3.2.1
        
        GuiControl, Hide, idListView
        GuiControl, , writeLabel, EUID Write
        GuiControl, Hide, ecoFwLabel
        GuiControl, Hide, ecoFreqLabel
        GuiControl, Hide, chosenEcoWFw
        GuiControl, Hide, chosenEcoFreq
        GuiControl, +gwriteAll, writeAllBttn
        
        toggleState := 1
    }
}

syncModeActive() {
    IfNotExist, %syncModeFilePath%
    {
        FileCreateDir, %remotePath%\Data
        FileAppend, [Sync]`nAutoPick=`nFrequencyDropPos=`n, %syncModeFilePath%
    }
            
    IfExist, %syncModeFilePath%
    {
        Static oldFreqDropPos
        Static oldFreqEcoDropPos
        Static oldWFwDropPos
        Static oldWFwEcoDropPos
        Static oldPFwDropPos
         
        ;;Update lot code label
        GuiControlGet, oldLot, , recentLotCode
        IniRead, lotCode, %syncModeFilePath%, Sync, RecentUsedLotCode
        if (oldLot != lotCode) {
            GuiControl, Text, recentLotCode, %lotCode%
        }
        
        IniRead, autoPick, %syncModeFilePath%, Sync, AutoPick
        if (autoPick) {
            isSyncMode := True
            Menu, OptionMenu, Check, Enable Sync Mode
            
            ;;Auto choose Writing Frequency
            IniRead, freqDropPos, %syncModeFilePath%, Sync, FrequencyDropPos
            IniRead, freqEcoDropPos, %syncModeFilePath%, Sync, FrequencyEcoDropPos
            if (freqDropPos != oldFreqDropPos) {
                oldFreqDropPos := freqDropPos
                GuiControl, Choose, chosenFreq, %freqDropPos%
            }
            if (freqEcoDropPos != oldFreqEcoDropPos) {
                oldFreqEcoDropPos := freqEcoDropPos
                GuiControl, Choose, chosenEcoFreq, %freqEcoDropPos%
            }
            
            ;;Auto choose Writing Firmware
            IniRead, wFwDropPos, %syncModeFilePath%, Sync, WriteFirmwareDropPos
            IniRead, wFwEcoDropPos, %syncModeFilePath%,  Sync, WriteFirmwareEcoDropPos
            if (wFwDropPos != oldWFwDropPos) {
                oldWFwDropPos := wFwDropPos
                GuiControl, Choose, chosenWFw, %wFwDropPos%
                GuiControlGet, chosenWFw, , chosenWFw, Text
                GuiControl, , wfwLabel, FW: %chosenWFw%
            }
            if (wFwEcoDropPos != oldWFwEcoDropPos) {    ;;for ECO LAB
                oldWFwEcoDropPos := wFwEcoDropPos
                GuiControl, Choose, chosenEcoWFw, %wFwEcoDropPos%
            }
            
            ;;Auto choose Programming Firmware
            IniRead, pFwDropPos, %syncModeFilePath%, Sync, ProgramFirmwareDropPos
            if (pFwDropPos != oldPFwDropPos) {
                oldPFwDropPos := pFwDropPos
                GuiControl, Choose, chosenPFw, %pFwDropPos%
            }
            
            ;;Auto choose radio bttn in Functional Test section
            IniRead, testRadioBttn, %syncModeFilePath%, Sync, TestRadioBttn
            IniRead, progRadioBttn, %syncModeFilePath%, Sync, ProgRadioBttn
            if (testRadioBttn)
                GuiControl, , totalGPortRadio, 1
            else if (progRadioBttn)
                GuiControl, , reproGPortRadio, 1
            
            ;;Auto change to ECO LAB mode
            ;IniRead, isEcoLabOn, %syncModeFilePath%, Sync, EcoLabOn
            ;if (isEcoLabOn != "ERROR" && isEcoLabOn) {
                ;toggleEcoLabMode()
            ;}
        }
        if (!autoPick) {
            isSyncMode := False
            Menu, OptionMenu, Uncheck, Enable Sync Mode
            
            oldFreqDropPos = ""
            oldWFwDropPos = ""
            oldPFwDropPos = ""
        }
    }
}

syncModeWriteIni(key, var) {
    IfExist, %syncModeFilePath%
    {
        IniWrite, %var%, %syncModeFilePath%, Sync, %key%
    }
}

resetSyncDataFile() {
    IniDelete, %syncModeFilePath%, Sync, AutoPick
    IniDelete, %syncModeFilePath%, Sync, FrequencyDropPos
    IniDelete, %syncModeFilePath%, Sync, WriteFirmwareDropPos
    IniDelete, %syncModeFilePath%, Sync, ProgramFirmwareDropPos
    IniDelete, %syncModeFilePath%, Sync, TestRadioBttn
    IniDelete, %syncModeFilePath%, Sync, ProgRadioBttn
    IniDelete, %syncModeFilePath%, Sync, EcoLabOnPC1
    IniDelete, %syncModeFilePath%, Sync, EcoLabOnPC2
    IniDelete, %syncModeFilePath%, Sync, EcoLabOnPC3
}

onChosenFreq() {
    GuiControlGet, chosenFreqPos, , chosenFreq
    GuiControlGet, chosenEcoFreqPos, , chosenEcoFreq
    
    if (isSyncMode) {
        syncModeWriteIni("FrequencyDropPos", chosenFreqPos)
        syncModeWriteIni("FrequencyEcoDropPos", chosenEcoFreqPos)
    }
}

onChosenWFw() {
    GuiControlGet, chosenWFw, , chosenWFw, Text
    GuiControlGet, chosenWFwPos, , chosenWFw
    ;GuiControl, , wfwLabel, FW: %chosenWFw%
    GuiControlGet, chosenEcoWFwPos, , chosenEcoWFw
    if (isSyncMode) {
        syncModeWriteIni("WriteFirmwareDropPos", chosenWFwPos)
        syncModeWriteIni("WriteFirmwareEcoDropPos", chosenEcoWFwPos)
    }
}

onChosenPFw() {
    GuiControlGet, chosenPFwPos, , chosenPFw
    if (isSyncMode) {
        syncModeWriteIni("ProgramFirmwareDropPos", chosenPFwPos)
    }
}

HasValue(haystack, needle) {
    if(!isObject(haystack))
        return false
    if(haystack.Length()==0)
        return false
    for k,v in haystack
        if(v==needle)
            return true
    return false
}

OnExitMainApp(ExitReason, ExitCode) {
    IniWrite, %False%, %xdotMapRemoteFilePath%, Mapping, Activate
    IniDelete, %xdotMapRemoteFilePath%, XDot-Status
    IniDelete, %AuthRemoteFilePath%, AuthenticationSync, 
}

;=======================================================================================;
;;Add an icon to a button with external image file
;;;GuiButtonIcon(hwndVar, "", , "")  ;Delete the icon
;;;GuiButtonIcon(hwndVar, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\disable.png", 1, "s24")   ;Display icon
GuiButtonIcon(Handle, File, Index := 1, Options := "") {
    Local W, H, S, L, T, R, B, A, Psz, DW, Ptr
    RegExMatch(Options, "i)w\K\d+", W), (W="") ? W := 16 :
    RegExMatch(Options, "i)h\K\d+", H), (H="") ? H := 16 :
    RegExMatch(Options, "i)s\K\d+", S), S ? W := H := S :
    RegExMatch(Options, "i)l\K\d+", L), (L="") ? L := 0 :
    RegExMatch(Options, "i)t\K\d+", T), (T="") ? T := 0 :
    RegExMatch(Options, "i)r\K\d+", R), (R="") ? R := 0 :
    RegExMatch(Options, "i)b\K\d+", B), (B="") ? B := 0 :
    RegExMatch(Options, "i)a\K\d+", A), (A="") ? A := 4 :
    Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
    VarSetCapacity( button_il, 20 + Psz, 0 )
    NumPut( normal_il := DllCall( "ImageList_Create", DW, W, DW, H, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )   ; Width & Height
    NumPut( L, button_il, 0 + Psz, DW )     ; Left Margin
    NumPut( T, button_il, 4 + Psz, DW )     ; Top Margin
    NumPut( R, button_il, 8 + Psz, DW )     ; Right Margin
    NumPut( B, button_il, 12 + Psz, DW )    ; Bottom Margin
    NumPut( A, button_il, 16 + Psz, DW )    ; Alignment
    SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
    return IL_Add( normal_il, File, Index)
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

addTipMsg(text, title, time) {
    SplashImage, C:\tempImg.gif, FS11, %text%, ,%title%
    
    SetTimer, RemoveTipMsg, %time%
    return
    
    RemoveTipMsg:
    SplashImage, Off
    return
}

SetEditCueBanner(HWND, Cue) {  ; requires AHL_L
   Static EM_SETCUEBANNER := (0x1500 + 1)
   Return DllCall("User32.dll\SendMessageW", "Ptr", HWND, "Uint", EM_SETCUEBANNER, "Ptr", True, "WStr", Cue)
}

getCmdOut(command) {
    RunWait, PowerShell.exe -ExecutionPolicy Bypass -Command %command% | clip , , Hide
    return Clipboard
}

; Function: AutoXYWH .Move and resize control automatically when GUI resizes.
AutoXYWH(DimSize, cList*){       ; http://ahkscript.org/boards/viewtopic.php?t=1079
  static cInfo := {}
 
  If (DimSize = "reset")
    Return cInfo := {}
 
  For i, ctrl in cList {
    ctrlID := A_Gui ":" ctrl
    If ( cInfo[ctrlID].x = "" ){
        GuiControlGet, i, %A_Gui%:Pos, %ctrl%
        MMD := InStr(DimSize, "*") ? "MoveDraw" : "Move"
        fx := fy := fw := fh := 0
        For i, dim in (a := StrSplit(RegExReplace(DimSize, "i)[^xywh]")))
            If !RegExMatch(DimSize, "i)" dim "\s*\K[\d.-]+", f%dim%)
              f%dim% := 1
        cInfo[ctrlID] := { x:ix, fx:fx, y:iy, fy:fy, w:iw, fw:fw, h:ih, fh:fh, gw:A_GuiWidth, gh:A_GuiHeight, a:a , m:MMD}
    }Else If ( cInfo[ctrlID].a.1) {
        dgx := dgw := A_GuiWidth  - cInfo[ctrlID].gw  , dgy := dgh := A_GuiHeight - cInfo[ctrlID].gh
        For i, dim in cInfo[ctrlID]["a"]
            Options .= dim (dg%dim% * cInfo[ctrlID]["f" dim] + cInfo[ctrlID][dim]) A_Space
        GuiControl, % A_Gui ":" cInfo[ctrlID].m , % ctrl, % Options
} } }

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;OnMessage Functions;;;;
WM_KEYDOWN(lparam) {
    If (lparam = 13 && A_GuiControl = "lotCodeSelected") {  ;When press enter in Lot code select section
        loadNodeFromLot()
    }
    
    If (lparam == 13 && (A_GuiControl == "inUsername" || A_GuiControl == "inPassword")){
        UserLogin()
    }
}

;;;Add tooltip on hover for a control (%ControlName%_TT)
;WM_MOUSEMOVE() {
    ;Static CurrControl, PrevControl, _TT  ; _TT is kept blank for use by the ToolTip command below.
    ;CurrControl := A_GuiControl
    ;If (CurrControl <> PrevControl and not InStr(CurrControl, " "))
    ;{
        ;ToolTip  ; Turn off any previous tooltip.
        ;SetTimer, DisplayToolTip, 400
        ;PrevControl := CurrControl
    ;}
    ;return

    ;DisplayToolTip:
        ;SetTimer, DisplayToolTip, Off
        ;ToolTip % %CurrControl%_TT  ; The leading percent sign tell it to use an expression.
        ;SetTimer, RemoveToolTip, 5000
    ;Return

    ;RemoveToolTip:
        ;SetTimer, RemoveToolTip, Off
        ;ToolTip
    ;Return
;}
;=======================================================================================;
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;ADDITIONAL GUIs
;;;;;;XDot GUI
GetXDot() {
    Global
    isXdot := RegExMatch(A_GuiControl, "^XDot[0-9]{2}$")
    isBadXdot := RegExMatch(A_GuiControl, "^BadXDot[0-9]{2}$")
    isGoodXdot := RegExMatch(A_GuiControl, "^GoodXDot[0-9]{2}$")
    
    GuiControlGet, recentLotCode, , recentLotCode, Text   ;Get lot code
    
    if (isXdot = 1 || isBadXdot = 1 || isGoodXdot = 1) {    ;; Check If XDot button is in disabled state. Do not open the GUI!
        WinGetPos mainX, mainY, mainWidth, mainHeight, ahk_id %hMainWnd%
        Gui, xdot: Cancel
        Gui, xdot: Destroy
        RegExMatch(A_GuiControl, "\d+$", num) ;Get button number based on button variable
        
        ctrlVar := xdotProperties[num].ctrlVar
        mainPort := xdotProperties[num].mainPort
        breakPort := xdotProperties[num].breakPort
        portName := xdotProperties[num].portName
        driveName := xdotProperties[num].driveName
        ttXPos := xdotProperties[num].ttXPos    ;Position X for teraterm window
        ttYPos := xdotProperties[num].ttYPos    ;Position Y for teraterm window
        FileRead, data, C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
        
        WinActivate COM%mainPort%
        ;;;GUI
        Gui, xdot: Default
        Gui, xdot: +ToolWindow +AlwaysOnTop +hWndhXdotWnd
        Gui xdot: Add, GroupBox, xm+0 ym+0 w200 h70 Section, XDot-%num% Connecting Infomation
        Gui Font, Bold
        Gui xdot: Add, Text, xs+8 ys+20, • COM PORT: %mainPort%
        Gui xdot: Add, Link, xs+145 ys+19 gConnectMainPort, <a href="#">Connect</a>
        Gui xdot: Add, Text, xs+8 ys+35, • BREAK PORT: %breakPort%
        Gui xdot: Add, Text, xs+8 ys+50, • DRIVE NAME: %driveName%
        Gui xdot: Add, Link, xs+145 ys+49 gOpenXdotFolder, <a href="#">Open</a>
        Gui Font
        
        Gui xdot: Add, Tab3, xm+0 ym+75 w200 h130 +Theme -Background Section, Functional Test|EUID Write
        Gui xdot: Tab, 1
        Gui xdot: Add, Text, xs+110 ys+30, Connecting
        Gui xdot: Add, Text, xs+110 ys+50, Programmable
        Gui xdot: Add, Text, xs+110 ys+70, Joinning
        Gui xdot: Add, Text, xs+110 ys+90, Ping
        Gui xdot: Add, Text, xs+110 ys+110, RSSI
        
        ;Image indicators
        Gui xdot: Add, Picture, xs+80 ys+28 w17 h17 +BackgroundTrans vprocess1, 
        Gui xdot: Add, Picture, xs+80 ys+48 w17 h17 +BackgroundTrans vprocess2, 
        Gui xdot: Add, Picture, xs+80 ys+68 w17 h17 +BackgroundTrans vprocess3, 
        Gui xdot: Add, Picture, xs+80 ys+88 w17 h17 +BackgroundTrans vprocess4, 
        Gui xdot: Add, Picture, xs+80 ys+108 w17 h17 +BackgroundTrans vprocess5, 
        buttonLabel1 := (isBadXdot = 1 && RegExMatch(data, "TEST") > 0) ? "RE-RUN" : "RUN"
        Gui xdot: Add, Button, w50 h45 xs+10 ys+50 gFunctionalTestEach, %buttonLabel1%
        Gui xdot: Tab
        
        Gui xdot: Tab, 2
        Gui xdot: Add, Text, xs+5 ys+25, STAT:
        Gui xdot: Add, Text, xs+5 ys+45, FREQ:
        Gui xdot: Add, Text, xs+5 ys+65, FW:
        Gui xdot: Add, Text, xs+5 ys+85, EUID:
        Gui xdot: Add, Edit, xs+45 ys+23 w148 h16 vxStatus +ReadOnly, READY
        Gui xdot: Add, Edit, xs+45 ys+43 w148 h16 vxFreq,
        Gui xdot: Add, Edit, xs+45 ys+63 w148 h16 vxFw,
        Gui xdot: Add, Edit, xs+45 ys+83 w148 h16 vxEUID,
        buttonLabel2 := (isBadXdot = 1 && RegExMatch(data, "WRITE") > 0) ? "RE-RUN" : "RUN"
        Gui xdot: Add, Button, xs+75 ys+100 w50 h25 vwriteBttnEach gWriteIDEach, %buttonLabel2%
        Gui xdot: Tab
        
        Gui xdot: Add, GroupBox, xm+0 ym+205 w200 h55 Section, Programming
        Gui xdot: Add, Button, w180 xs+10 ys+20 gToDebugEach, Program %ctrlVar% to debug mode
        
        ;;Modify GUI for ECO LAB MODE!!!
        if (isEcoLabMode) {
            GuiControl, Text, xFreq, %chosenEcoFreq%  ;Change text
            GuiControl, Disable, xFreq
            GuiControl, Text, xFw, %chosenEcoWFw%  ;Change text
            GuiControl, Disable, xFw
        }
        
        if (RegExMatch(data, "WRITE") > 0)
            GuiControl, xdot: Choose, SysTabControl321, 2   ;Focus on tab 2
            
        ;;Labels or Functions to run before gui start
        if (RegExMatch(data, "CONNECTION FAILED") > 0) {
            GuiControl, , process1, %xImg%
        } else if (RegExMatch(data, "FAILED TO PROGRAM") > 0) {
            GuiControl, , process1, %checkImg%
            GuiControl, , process2, %xImg%
        } else if (RegExMatch(data, "FAILED TO JOIN") > 0) {
            GuiControl, , process1, %checkImg%
            GuiControl, , process2, %checkImg%
            GuiControl, , process3, %xImg%
        } else if (RegExMatch(data, "PING.*FAILURE") > 0) {
            GuiControl, , process1, %checkImg%
            GuiControl, , process2, %checkImg%
            GuiControl, , process3, %checkImg%
            GuiControl, , process4, %xImg%
        } else if (RegExMatch(data, "RSSI LEVEL FAILURE") > 0) {
            GuiControl, , process1, %checkImg%
            GuiControl, , process2, %checkImg%
            GuiControl, , process3, %checkImg%
            GuiControl, , process4, %checkImg%
            GuiControl, , process5, %xImg%
        } else if (RegExMatch(data, "ALL PASSED") > 0) {
            GuiControl, , process1, %checkImg%
            GuiControl, , process2, %checkImg%
            GuiControl, , process3, %checkImg%
            GuiControl, , process4, %checkImg%
            GuiControl, , process5, %checkImg%
        }
        IfNotExist C:\V-Projects\XDot-Controller\TEMP-DATA\%mainPort%.dat
        {
            Gui 1: Default
            GuiControlGet, chosenFreq, , chosenFreq, Text   ;Get value from DropDownList
            GuiControlGet, chosenWFw, , chosenWFw, Text     ;Get value from DropDownList
            GuiControlGet, chosenEcoFreq, , chosenEcoFreq, Text   ;Get value from DropDownList
            GuiControlGet, chosenEcoWFw, , chosenEcoWFw, Text     ;Get value from DropDownList
            
            RegExMatch(A_GuiControl, "\d+$", num)
            node := readNodeLine(num)
            
            Gui xdot: Default
            GuiControl, Text, xFreq, %chosenFreq%   ;Change text
            GuiControl, Text, xFw, %chosenWFw%   ;Change text
            GuiControl, Text, xEUID, %node%   ;Change text
        }
        
        if (isBadXdot = 1 || isGoodXdot = 1) && if (RegExMatch(data, "WRITE") > 0) {
            Loop, Parse, data, `|
            {
                if (A_Index = 3) {
                    euidParse := A_LoopField
                    if (isEcoLabMode)
                        StringReplace, euidParse, euidParse, `,, |, All
                    GuiControl, Text, xEUID, %euidParse%   ;Change text
                }
                if (A_Index = 4) {
                    if (RegExMatch(A_LoopField, "FAIL|WRONG|INVALID|NOT"))
                        Gui, Font, cf24b3f
                    else if (RegExMatch(A_LoopField, "PASS"))
                        Gui, Font, c41e81c
                    GuiControl, Font, xStatus
                    GuiControl, Text, xStatus, %A_LoopField%   ;Change text
                }
                if (A_Index = 5)
                    GuiControl, Text, xFreq, %A_LoopField%   ;Change text
                if (A_Index = 6)
                    GuiControl, Text, xFw, %A_LoopField%   ;Change text
            }
        }
        
        mainY := mainY + 145
        Gui xdot: Show, x%mainX% y%mainY%, XDot %num%
        Return

        xdotGuiEscape:
        xdotGuiClose:
            Gui, xdot: Destroy
        Return
        
        ;;;Functions and Labels for xdot GUI;;;
        FunctionalTestEach:
            changeXdotBttnIcon(ctrlVar, "PLAY", "TESTING")
            
            WinKill COM%mainPort%
            Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE %xdotTestFilePath% dummyParam %mainPort% %breakPort% %portName% %driveName% singleTest newTTVersion, ,Hide

            ;;;Track processes
            Gui xdot: Default
            Loop, 5
            {
               GuiControl, , process%A_Index%, %play1Img%
               WinWait PASSED%A_Index%|%mainPort% FAILURE
               IfWinExist %mainPort% FAILURE
               {
                   GuiControl, , process%A_Index%, %xImg%
                   goto XdotFailed
               }
               GuiControl, , process%A_Index%, %checkImg%
            }
            
            changeXdotBttnIcon(ctrlVar, "GOOD")
        Return
        
        XdotFailed:
            changeXdotBttnIcon(ctrlVar, "BAD")
        Return
            
        ToDebugEach:
            isReprogram := True
            IfNotExist %driveName%:\
            {
                MsgBox 16, ERROR, Drive (%driveName%:\) does not exist!
                Return
            }
            
            changeXdotBttnIcon(ctrlVar, "PLAY", "PROGRAMMING")
            WinKill COM%mainPort%
            Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reprogram.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 "v3.0.2-debug", ,Hide
            ;msg = Reprogramming on PORT %mainPort%...Please wait!
            ;title = PORT %mainPort% PROGRAMMING
            ;addTipMsg(msg, title, 17000)
            ;RunWait, %ComSpec% /c copy C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin %driveName%:\ , ,Hide
            ;Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_reset.ttl dummyParam2 %mainPort% %breakPort% %portName% %driveName% dummyParam7 newTTVersion, ,Hide
            WinWait %mainPort% FAILURE|%mainPort% PASSED
            ifWinExist, %mainPort% FAILURE
                changeXdotBttnIcon(ctrlVar, "BAD")
            ifWinExist, %mainPort% PASSED
                changeXdotBttnIcon(ctrlVar, "GOOD", "PROGRAMMING")
        Return
        
        WriteIDEach:
            WinKill COM%mainPort%
            GuiControlGet, inFreq, , xFreq
            GuiControlGet, inFw, , xFw
            GuiControlGet, inId, , xEUID
            GuiControlGet, writeBttnLabel, , writeBttnEach
            if (inFreq = "" || inId = "" || inFw = "") {
                MsgBox 16 , INVALID, Please enter all requires fields!
                return
            }
            
            if (RegExMatch(inFreq, "[A-Z]+([0-9]{3})") = 0) {
                MsgBox 16 , ERROR, INPUT INVALID FREQUENCY. RETRY!
                return
            }
            
            if (!isEcoLabMode) {
                if (HasValue(allWriteFW, inFw) = 0) {
                    MsgBox 16 , ERROR, INPUT INVALID FIRMWARE VERSION. RETRY!
                    return
                }
            }
            
            if (isEcoLabMode) {
                if (HasValue(allEcoWriteFw, inFw) = 0) {
                    MsgBox 16 , ERROR, INPUT INVALID FIRMWARE VERSION. RETRY!
                    return
                }
            }
            
            if (!isEcoLabMode)
                if (RegExMatch(inId, "[g-zG-Z]") > 0 || StrLen(inId) <> 16) {
                    MsgBox 16 , ERROR, INPUT INVALID EUID. RETRY!
                    return
                }
            
            if (isEcoLabMode)
                if (RegExMatch(inId, "[g-zG-Z]") > 0 || StrLen(inId) < 18) {
                    MsgBox 16 , ERROR, INPUT INVALID IDs FOR ECO LAB. RETRY!
                    return
                }
            
            if (writeBttnLabel = "RUN") {
                OnMessage(0x44, "PlayInCircleIcon") ;Add icon
                MsgBox 0x81, RUN WRITE EUID, Begin EUID WRITE on PORT %mainPort%?
                OnMessage(0x44, "") ;Clear icon
                IfMsgBox Cancel
                    return
            }
            changeXdotBttnIcon(ctrlVar, "PLAY", "WRITING")
            Gui xdot: Default
            Gui, Font, c0c63ed
            GuiControl, Font, xStatus
            GuiControl, Text, xStatus, RUNNING   ;Change text
            if (isEcoLabMode)   ;;EcoLab
                Run, %teratermMacroExePath% C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_eco-lab.ttl dummyParam2`,%mainPort%`,%breakPort%`,%driveName%`,singleWrite`,%inFreq%`,%mainPort%|%inId%`,%inFw% %recentLotCode%, , Hide
            else    ;;Normal
                Run, %ComSpec% /c cd C:\teraterm &&  TTPMACRO.EXE C:\V-Projects\XDot-Controller\TTL-Files\all_xdot_write_euid.ttl dummyParam2`,%mainPort%`,%breakPort%`,%driveName%`,singleWrite`,%inFreq%`,%inId%`,%inFw% %recentLotCode%, ,Hide
            
            WinWait %mainPort% FAILURE|%mainPort% PASSED
            ifWinExist, %mainPort% FAILURE
            {
                WinGetText textOnWin, %mainPort% FAILURE
                Gui, Font, cf24b3f
                GuiControl, Font, xStatus
                GuiControl, Text, xStatus, %textOnWin%   ;Change text
                changeXdotBttnIcon(ctrlVar, "BAD")
            }
            ifWinExist, %mainPort% PASSED
            {
                Gui, Font, c41e81c
                GuiControl, Font, xStatus
                GuiControl, Text, xStatus, PASSED   ;Change text
                changeXdotBttnIcon(ctrlVar, "GOOD")
            }
        Return
        
        ConnectMainPort:
            IfWinNotExist COM%mainPort%
                Run, %ComSpec% /c start C:\teraterm\ttermpro.exe /C=%mainPort%, , Hide
            WinActivate COM%mainPort%
        Return
        
        OpenXdotFolder:
            IfNotExist %driveName%:\
            {
                MsgBox 16, ERROR, Drive (%driveName%:\) does not exist!
                Return
            }
            Run, %driveName%:\
        Return
    }
    Return
}

;;;;;;Log Viewer GUI
OpenLogViewer() {
    Global
    GuiControlGet, recentLotCode, , recentLotCode, Text   ;Get lot code from main GUI
    ;;;GUI  ;;===============================;;
    Gui, logView: Default
    Gui, logView: +Resize +MinSize850x650 +HwndLogViewGui
    Gui, logView: Add, Tab3, Section w832 h620 vlogViewMainTabCon, Result Logging|System Logging
    ;;;;;;; Tab Content ;;;;;;;;;
    Gui, logView: Tab, 1    ;;;;;
        Gui, logView: Add, Edit, xs+5 ys+30 w100 vlotInputBox gSearchLot +Number,
        Gui, logView: Add, ListBox, xs+5 ys+57 w100 h557 vlotListBox gPickLot 0x100 Sort, 
        Gui, logView: Add, ListView, xs+110 ys+30 w713 h585 hWndhlotListView vlotListView +Grid, ???|???|???|???|???|???|
    Gui, logView: Tab, 2    ;;;;;
    
    Gui, logView: Tab
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Gui, logView: Add, StatusBar, vlogStatusBar
    SB_SetParts(230, 300)
    
    ;; Create an instance to use Class_LV_Color
    lotListViewInstance := New LV_Colors(hlotListView, True, False)
    
    ; Create a popup menu to be used as the context menu:
        Menu, LogViewContextMenuSub, Add, Red, cntxMenuFlagHander
        Menu, LogViewContextMenuSub, Add, Yellow, cntxMenuFlagHander
        Menu, LogViewContextMenuSub, Add, Green, cntxMenuFlagHander
        Menu, LogViewContextMenuSub, Add, Brown, cntxMenuFlagHander
    Menu, logView: LogViewContextMenu, Add, Marks, :LogViewContextMenuSub
    
    ;;;;Run Before GUI STARTED
    lotCount := 0
    logLotList := ""
    Loop, Files, %ResultLoggingPath%\*.log
    {
        fullFileName := A_LoopFileName
        StringReplace, fullFileName, fullFileName, .log, , All    ;Remove .log
        logLotList .= "|" . fullFileName
        lotCount += 1
    }
    GuiControl, , lotListBox, % logLotList
    SB_SetText("Total Lot Code: " . lotCount, 1)
    LogViewer_DisplayResultLog(recentLotCode)
    
    Gui, logView: Show, w850 h650, Log Viewer
    Return  ;;===============================;;
    
    ;; Auto re-size and re-position when main window changed.
    logViewGuiSize:
        Gui, logView: Default
        If (A_EventInfo = 1) ;The window has been minimized.
            Return
        AutoXYWH("wh", "logViewMainTabCon")
        AutoXYWH("h", "lotListBox")
        AutoXYWH("wh", "lotListView")
    Return
    
    logViewGuiContextMenu:      ; Launched in response to a right-click or press of the Apps key.
        if (A_GuiControl == "lotListView") {
            Menu, logView: LogViewContextMenu, Show, %A_GuiX%, %A_GuiY%
        }
    Return
    
    cntxMenuFlagHander:
        Gui, logView: Default
        selectedRowNumber := 0  ; This causes the first loop iteration to start the search at the top of the list.
        Loop
        {
            selectedRowNumber := LV_GetNext(selectedRowNumber)  ; Resume the search at the row after that found by the previous iteration.
            If Not selectedRowNumber                            ; If the above returned zero, so there are no more selected rows.
                break
            If (A_ThisMenuItem == "Red")
                lotListViewInstance.Row(selectedRowNumber, 0xf44336, 0xffffff)  ;;Change color
            Else If (A_ThisMenuItem == "Yellow")
                lotListViewInstance.Row(selectedRowNumber, 0xfbc02d, 0xffffff)  ;;Change color
            Else If (A_ThisMenuItem == "Green")
                lotListViewInstance.Row(selectedRowNumber, 0x2e7d32, 0xffffff)  ;;Change color
            Else If (A_ThisMenuItem == "Brown")
                lotListViewInstance.Row(selectedRowNumber, 0x6d4c41, 0xffffff)  ;;Change color
            LV_Modify(selectedRowNumber, "-Select")     ;;De-selected row
        }
    return
    
    logViewGuiClose:
        Gui, logView: Destroy
    Return
    
    ;;;Functions and Labels for logView GUI;;;
    ;;===============================;;
    SearchLot:
        
    Return  ;;=======================;;
    
    ;;===============================;;
    PickLot:
        If (A_GuiControlEvent == "DoubleClick") {
            GuiControlGet, boxLotCode, , lotListBox  ; Retrieve the ListBox's current selection.
            LogViewer_DisplayResultLog(boxLotCode)
        }
    Return  ;;=======================;;
}

LogViewer_DisplayResultLog(lotCode) {
    If (lotCode == "")
        Return
    SB_SetText("Current Lot Code in View: " lotCode, 3)
    Gui, logView: ListView, lotListView     ; Specify which listview will be updated with LV commands  
    LV_Delete()                             ; Delete all rows in listview
    Loop, % LV_GetCount("Column")
        LV_DeleteCol(1)             ;Delete all cols before init new one!
    
    itemCount := 0
    passedCount := 0
    failedCount := 0
    lvItems := {}
    IL_Destroy(ILSt)
    ILSt:= IL_Create(1, 1, 0)
    LV_SetImageList(ILSt, 1)
    IL_Add(ILSt, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\green-dot-sm.png")
    IL_Add(ILSt, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\red-dot-sm.png")
    IL_Add(ILSt, "C:\V-Projects\XDot-Controller\Imgs-for-GUI\yellow-dot-sm.png")
    
    Loop, Read, %ResultLoggingPath%/%lotCode%.log
    {
        
        lineCount := A_Index
        fileLineContents := A_LoopReadLine
        If (fileLineContents == "")
            Continue
        Loop, Parse, fileLineContents, `,
        {
            itemCount := A_Index
            If (lineCount > 1)
                Break
        }
        
        ;;Add Column to LV
        If (itemCount == 10) {
            colHeaders := "@|Date|Time|Main Port|Status|In NodeID|Out NodeID|In Frequency|Out Frequency|MBed Port|User"
            Loop, Parse, colHeaders, |
            {
                If (A_LoopField == "") ;the end has been reached
                    Break
                LV_InsertCol(A_Index, "AutoHdr", A_LoopField)
            }
        } Else If (itemCount == 14) {
            colHeaders := "@|Date|Time|Main Port|Status|In NodeID|Out NodeID|In Frequency|Out Frequency|In UUID|Out UUID|In AppKey|Out AppKey|MBed Port|User"
            Loop, Parse, colHeaders, |
            {
                If (A_LoopField == "") ;the end has been reached
                    Break
                LV_InsertCol(A_Index, "AutoHdr", A_LoopField)
            }
        }
        ;; Add items to LV
        ;;; It's ok to insert 13 items to a LV with 9 items?
        StringSplit, item, fileLineContents, `,
        If (RegExMatch(item4, "PASSED")) {
            LV_Add("Icon" . 1, , item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14)
            passedCount += 1
        }
        If (RegExMatch(item4, "FAILED|INVALID|WRONG|NOT FOUND")) {
            LV_Add("Icon" . 2, , item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14)
            failedCount += 1
        }
        lvItems.Push({1: item1, 2: item2, 3: item3, 4: item4, 5: item5, 6: item6, 7: item7, 8: item8, 9: item9, 10: item10, 11: item11, 12: item12, 13: item13, 14: item14})
    }
    Loop, % LV_GetCount("Column")
        LV_ModifyCol(A_Index, "AutoHdr")
    LV_ModifyCol(6, "SortDesc")
    SB_SetText("Total Ran: " . passedCount + failedCount . " | Total Passed: " . passedCount . " | Total Failed: " . failedCount, 2)
}

OpenAboutMsgGui1() {
    Global
    Gui, msgGui1: Default
    Gui, msgGui1: +ToolWindow +AlwaysOnTop +hWndhMsgGui1Wnd
    
    Gui, msgGui1: Add, Picture, x10 y10 w25 h25 +BackgroundTrans, %play1Img%
    Gui, msgGui1: Add, Picture, x10 y40 w25 h25 +BackgroundTrans, %play2Img%
    Gui, msgGui1: Add, Picture, x10 y70 w25 h25 +BackgroundTrans, %play3Img%
    Gui, msgGui1: Add, Picture, x10 y100 w25 h25 +BackgroundTrans, %xImg%
    Gui, msgGui1: Add, Picture, x10 y130 w25 h25 +BackgroundTrans, %checkImg%
    Gui, msgGui1: Add, Picture, x10 y160 w25 h25 +BackgroundTrans, %check2Img%
    Gui, msgGui1: Add, Picture, x10 y190 w25 h25 +BackgroundTrans, %disImg%
    Gui, msgGui1: Add, Picture, x10 y220 w25 h25 +BackgroundTrans, %exclaImg%
    
    Gui, msgGui1: Font, s9 Bold, Arial
    Gui, msgGui1: Add, Text, x50 y15, Running Testing Process
    Gui, msgGui1: Add, Text, x50 y45, Running Re-Programming Process
    Gui, msgGui1: Add, Text, x50 y75, Running Writing Process
    Gui, msgGui1: Add, Text, x50 y105, XDot is FAILED on Testing or Writing
    Gui, msgGui1: Add, Text, x50 y135, XDot is PASSED on Testing or Writing
    Gui, msgGui1: Add, Text, x50 y165, XDot is PASSED on Re-Programming
    Gui, msgGui1: Add, Text, x50 y195, XDot Button is DISABLED
    Gui, msgGui1: Add, Text, x50 y225, Teraterm was CLOSED unexpectedly
    Gui, msgGui1: Font
    
    Gui, msgGui1: Add, Button, x210 y255 w55 gOkBttnOnclick, OK
    
    Gui, msgGui1: Show, , Application Image Indicators
    
    Return  ;;;;;;;;;;;;
    
    msgGui1GuiEscape:
    msgGui1GuiClose:
        Gui, msgGui1: Destroy
    Return
    
    OkBttnOnclick:
        Gui, msgGui1: Destroy
    Return
}

;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; Users Authentication ;;;;;;;;;;;;;
Authentication() {      ;;Sync mode for Authentication | Auto check login/logout
    IniRead, syncUserInfo, %AuthRemoteFilePath%, AuthenticationSync, UserInfo
    If (syncUserInfo != A_Space && syncUserInfo != "ERROR") {
        syncUserInfoDec := DecryptString(syncUserInfo, 2021)
        
        If FileExist(UserMainDataFilePath) {
            Loop, Read, %UserMainDataFilePath%
            {
                getUserLoginInfo := DecryptString(A_LoopReadLine, Crypt_Key)
                If (getUserLoginInfo == syncUserInfoDec) {
                    
                    Loop, Parse, getUserLoginInfo, `|
                    {
                        if (A_Index == 1)
                            getUserName := A_LoopField
                        if (A_Index == 2)
                            getPassword := A_LoopField
                        if (A_Index == 3)
                            getFirstName := A_LoopField
                        if (A_Index == 4)
                            getLastName := A_LoopField
                        if (A_Index == 5)
                            getAcctRole := A_LoopField
                            
                        if (A_Index == 5) {    
                            UserInfo := {userFirstName: getFirstName, userLastName: getLastName, userUserName: getUserName, userPassword: getPassword, userRole: getAcctRole, isLogin: True}
                            Gui, 1: -Disabled
                            Gui, auth: Destroy
                            Gui, 1: Default
                            SB_SetText("Username: " . UserInfo.userUserName . " ( " . UserInfo.userFirstName . " " UserInfo.userLastName " ) - " UserInfo.userRole, 1)
                            SetTimer, %Authentication%, Off
                            SetTimer, %CheckUserLogin%, 100
                        }
                    }
                    Break
                }
            }
        }
    }
}

CheckUserLogin() {
    IniRead, isLogin, %AuthRemoteFilePath%, AuthenticationSync, IsUserLogin
    If (!isLogin) {
        UserLogout()
        DisplayLogin()
    }
}

DisplayLogin() {
    Global
    Gui, auth: +AlwaysOnTop -MinimizeBox -MaximizeBox -Resize +HwndhAuthGui
    Gui, auth: Add, Text, y10 cRed vloginStatusLabel w290, Please login to use the program!
    Gui, auth: Add, GroupBox, xm+0 ym+20 Section w280 h80,
    Gui, auth: Add, Text, xs+10 ys+18, Username:
    Gui, auth: Add, Edit, xs+90 ys+15 w180 vinUsername hWndhInUsername,
    Gui, auth: Add, Text, xs+10 ys+48, Password:
    Gui, auth: Add, Edit, xs+90 ys+45 w180 vinPassword hWndhInPassword +Password,
    
    Gui, auth: Add, Button, xs+90 ys+90 w100 gUserLogin, Login
    Gui auth: Add, Link, xs+83 ys+120 gUserSignUp, <a href="#">Sign up a new account!</a>
    
    Gui, auth: Show, w300, XDot Controller - Authentication
    
    Gui, 1: +Disabled
    
    #Persistent
    SetTimer, %Authentication%, 10
    SetTimer, %CheckUserLogin%, Off
    Return  ;;;;;;;;;;;;;;;;
    
    authGuiClose:
        ExitApp
    Return
}

UserLogin() {
    Gui, auth: Default
    GuiControlGet, userName, , inUsername
    GuiControlGet, userPassword, , inPassword
    
    If (userName == "" || userPassword == "") {
        GuiControl, Text, loginStatusLabel, % "Invalid! Please type Username and Password"
        Return
    }
    
    If FileExist(UserMainDataFilePath) {
        Loop, Read, %UserMainDataFilePath%
        {
            getUserLoginInfo := DecryptString(A_LoopReadLine, Crypt_Key)
            Loop, Parse, getUserLoginInfo, `|
            {
                if (A_Index == 1)
                    getUserName := A_LoopField
                if (A_Index == 2)
                    getPassword := A_LoopField
                if (A_Index == 3)
                    getFirstName := A_LoopField
                if (A_Index == 4)
                    getLastName := A_LoopField
                if (A_Index == 5)
                    getAcctRole := A_LoopField
                    
                if (getUserName == userName && getPassword == userPassword && A_Index == 5) {                    
                    UserInfo := {userFirstName: getFirstName, userLastName: getLastName, userUserName: getUserName, userPassword: getPassword, userRole: getAcctRole, isLogin: True}
                    Gui, 1: -Disabled
                    Gui, auth: Destroy
                    IniWrite, % EncryptString(getUserLoginInfo, 2021), %AuthRemoteFilePath%, AuthenticationSync, UserInfo
                    IniWrite, %True%, %AuthRemoteFilePath%, AuthenticationSync, IsUserLogin
                    Gui, 1: Default
                    SB_SetText("Username: " . UserInfo.userUserName . " ( " . UserInfo.userFirstName . " " UserInfo.userLastName " ) - " UserInfo.userRole, 1)
                    Return
                }
            }
        }
        GuiControl, Text, loginStatusLabel, % "Wrong username or password. Try again!"
        Return
    } Else {
        GuiControl, Text, loginStatusLabel, % "No accounts in system. Please create at least 1!"
        Return
    }
}

UserLogout() {
    IniDelete, %AuthRemoteFilePath%, AuthenticationSync, UserInfo
    UserInfo := {userFirstName: "???", userLastName: "???", userUserName: "???", userPassword: "???", userRole: "N/A", isLogin: False}
    Gui, 1: Default
    SB_SetText("Username: " . UserInfo.userUserName . " ( " . UserInfo.userFirstName . " " UserInfo.userLastName " ) - " UserInfo.userRole, 1)
    IniWrite, %False%, %AuthRemoteFilePath%, AuthenticationSync, IsUserLogin
}

UserSignUp() {
    ;;Create new sign up Gui
    Global
    Gui, authSiUp: +AlwaysOnTop -MinimizeBox -MaximizeBox -Resize +HwndAuthSiUpGui
    Gui, authSiUp: Add, Text, y10 w290, This process require an administrative right!`n Please ask the ADMIN to help you create an account!
    Gui, authSiUp: Add, GroupBox, xm+0 ym+30 Section w280 h180,
    Gui, authSiUp: Add, Text, xs+10 ys+18, Register Code:
    Gui, authSiUp: Add, Edit, xs+90 ys+15 w180 vinRegisterCode +Password,
    Gui, authSiUp: Add, Text, xs+10 ys+45 w265 h2 +0x10 ;;-----------------------------
    
    Gui, authSiUp: Add, Text, xs+10 ys+60, First Name:
    Gui, authSiUp: Add, Edit, xs+70 ys+57 w65 vinFirstName,
    Gui, authSiUp: Add, Text, xs+145 ys+60, Last Name:
    Gui, authSiUp: Add, Edit, xs+205 ys+57 w65 vinLastName,
    Gui, authSiUp: Add, Text, xs+10 ys+90, New Username:
    Gui, authSiUp: Add, Edit, xs+95 ys+87 w175 vinNewUsername,
    Gui, authSiUp: Add, Text, xs+10 ys+120, New Password:
    Gui, authSiUp: Add, Edit, xs+95 ys+117 w175 +Password vinNewPassword,
    Gui, authSiUp: Add, Text, xs+10 ys+150, Account Role:
    Gui, authSiUp: Add, DropDownList, xs+95 ys+147 w175 +Choose2 vinAcctRole, ADMIN|OPPERATOR
    Gui, authSiUp: Add, Text, cred xs+5 ys+180 w300 vsignupStatusLabel,
    
    Gui, authSiUp: Add, Button, xs+90 ys+200 w100 gUserSignUpSubmit, Submit
    
    Gui, authSiUp: Show, w300 h270, XDot Controller - Sign Up
    Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    UserSignUpSubmit:
        Gui, authSiUp: Default
        GuiControlGet, registerCode, , inRegisterCode
        GuiControlGet, firstName, , inFirstName
        GuiControlGet, lastName, , inLastName
        GuiControlGet, newUsername, , inNewUsername
        GuiControlGet, newPassword, , inNewPassword
        GuiControlGet, acctRole, , inAcctRole
        
        if (registerCode == "" || firstName == "" || lastName == "" || newUsername == "" || newPassword == "" || acctRole == "") {
            GuiControl, Text, signupStatusLabel, % "Please fill all required fields!"
            return
        }
        
        if (registerCode != Register_Key) {
            GuiControl, Text, signupStatusLabel, % "Wrong REGISTER CODE. Try again!"
            return
        }
        
        newUserData := newUsername . "|" . newPassword . "|" . firstName . "|" . lastName . "|" acctRole
        If FileExist(UserMainDataFilePath) 
        {
            Loop, Read, %UserMainDataFilePath%
            {
                Loop, Parse, A_LoopReadLine, `|
                {
                    if (A_Index == 1) {
                        existUsername := A_LoopField
                        if (existUsername == newUsername) {
                            GuiControl, Text, signupStatusLabel, % "Username already exist!. Please choose a different one."
                            Return
                        }
                    }
                }
            }
            newUserData := EncryptString(newUserData, Crypt_Key)
            FileAppend, %newUserData%`n, %UserMainDataFilePath%
            Gui, authSiUp: Destroy
        } Else {
            newUserData := EncryptString(newUserData, Crypt_Key)
            FileAppend, %newUserData%`n, %UserMainDataFilePath%
            Gui, authSiUp: Destroy
        }
    Return
    
    authSiUpGuiClose:
        Gui, authSiUp: Destroy
    Return
}

EncryptString(String, Key)
{
	Random,, Key
	Loop, Parse, String
	{
		Random x, 1, 100000
		Random y, 1, 100000
		newString .= (Asc(A_loopfield) + x) y
	}
	Return newString
}

DecryptString(String, Key)
{
	Random,, Key
	While StrLen(String) > 0
	{
		Random x, 1, 100000
		Random y, 1, 100000
		Pos := InStr(String, y)
		oldString .= Chr(SubStr(String, 1, Pos - 1) - x)
		String := SubStr(String, Pos + StrLen(y))
	}	
	Return oldString
}
;=======================================================================================;
;=======================================================================================;
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;Application Tools;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;XDot Mapping Tool
XDotMappingTool() {
    Global
    
    IfNotExist %xdotMapRemoteFilePath%
        FileAppend, , %xdotMapRemoteFilePath%
    IniWrite, %True%, %xdotMapRemoteFilePath%, Mapping, Activate
    
    HTML_PAGE =
    ( LTrim
    <!DOCTYPE html>
    <html>
    <head>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'/>
    <style>
      html, body { padding: 0; margin: 0; overflow: hidden; }
      .bg-img { background-repeat: no-repeat; opacity: 0.5; z-index: 0; }
      .xdot-box { width: 84px; height: 84px; z-index: 2; cursor: pointer; display: inline-block; margin-right: -5px; background-color: rgba(0, 0, 0, 0.1);}
      .xdot-box:not(.xdot-box-disable):hover { opacity: 0.6; }
      .xdot-box-fail { background-color: rgba(255, 0, 0, 0.4); }
      .xdot-box-pass { background-color: rgba(0, 255, 0, 0.4); }
      .xdot-box-disable { background-color: rgba(120, 120, 120, 1); background-image: url(C:/V-Projects/XDot-Controller/Imgs-for-GUI/disable.png); background-repeat: no-repeat; background-size: 75px 75px; background-position: center; opacity: 0.8; }
      .no-select-text { -ms-user-select: none; } /* Internet Explorer/Edge */
      .overlay-div { position: fixed; display: block; width: 100`%; height: 100`%; background-color: rgba(0,0,0,0.5); z-index: 3;}
      .overlay-text { position: absolute; top: 20`%; text-align: center; color: #e57373; cursor: default;}
    </style>
    </head>
    <body oncontextmenu="return false;" class="no-select-text">
      <div style="position: fixed">
          <img id="main-img" class="bg-img" src="C:\V-Projects\XDot-Controller\Imgs-for-GUI\xdot-panel.png" width="500" height="370">
      </div>

      <div id="overlayDiv" class="overlay-div">
        <h2 class="overlay-text">**Could not connect to SERVER!**<br> All PC need to connect to SERVER PC to use this feature!!!</h2>
      </div>

      <div style="margin-top: 15px; position: fixed;">
          <div id="XDot01" class="xdot-box" > </div>
          <div id="XDot02" class="xdot-box" > </div>
          <div id="XDot03" class="xdot-box" > </div>
          <div id="XDot04" class="xdot-box" > </div>
          <div id="XDot05" class="xdot-box" > </div>
          <div id="XDot06" class="xdot-box" > </div>
      </div>
      <div style="margin-top: 100px; position: fixed;">
          <div id="XDot07" class="xdot-box" > </div>
          <div id="XDot08" class="xdot-box" > </div>
          <div id="XDot09" class="xdot-box" > </div>
          <div id="XDot10" class="xdot-box" > </div>
          <div id="XDot11" class="xdot-box" > </div>
          <div id="XDot12" class="xdot-box" > </div>
      </div>
      <div style="margin-top: 185px; position: fixed;">
          <div id="XDot13" class="xdot-box" > </div>
          <div id="XDot14" class="xdot-box" > </div>
          <div id="XDot15" class="xdot-box" > </div>
          <div id="XDot16" class="xdot-box" > </div>
          <div id="XDot17" class="xdot-box" > </div>
          <div id="XDot18" class="xdot-box" > </div>
      </div>
      <div style="margin-top: 270px; position: fixed;">
          <div id="XDot19" class="xdot-box" > </div>
          <div id="XDot20" class="xdot-box" > </div>
          <div id="XDot21" class="xdot-box" > </div>
          <div id="XDot22" class="xdot-box" > </div>
          <div id="XDot23" class="xdot-box" > </div>
          <div id="XDot24" class="xdot-box" > </div>
      </div>
    </body>
    <script>
      document.getElementById('main-img').ondragstart = function() { return false; };
    </script>
    </html>
    )
    
    Gui, xdotMap: Destroy
    Gui, xdotMap: -MinimizeBox -MaximizeBox
    Gui, xdotMap: Add, ActiveX, w500 h370 vWB, Shell.Explorer
    WB.silent := true ;Surpress JS Error boxes
    DisplayWebPage(WB, HTML_PAGE)
    Gui, xdotMap: Add, GroupBox, xm+0 ym+380 w240 h70 Section, Functional Test
    
    Gui, xdotMap: Add, GroupBox, xm+260 ym+380 w240 h70 Section, EUID Write
    
    Gui, xdotMap: Show, , XDot Mapping Tool
    
    #Persistent
    SetTimer, CheckServer, 100
    
    ;;;Run BEFORE GUI started
    While WB.readystate != 4 || WB.busy     ;Wait for IE to load the page
        Sleep 10
    ;;Defines DOM object
    WDoc := WB.document
    ComObjConnect(WDoc, "Doc_")
    ;xdot01Bttn := WB.document.getElementById("xdot01")
    ;rightClickObj := {"oncontextmenu": Func("OnXdotRightClick")}
    ;ComObjConnect(xdot01Bttn, rightClickObj)
    ;WB.document.parentWindow.AHK := Func("OnXdotRightClick")    ;Call AHK function from HTML using onclick="AHK('Function')"
    Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;Run AFTER GUI started
    
    CheckServer:
        DriveGet, driveStatus, Status, %remotePath%
        if (driveStatus = "Ready") {
            WB.document.getElementById("overlayDiv").style.display := "none"
        } else {
            WB.document.getElementById("overlayDiv").style.display := "block"
        }
    Return
    
    xdotMapGuiClose:
        Gui, xdotMap: Destroy
        FileDelete, %A_Temp%\*.DELETEME.html ;clean html tmp file
        IniDelete, %xdotMapRemoteFilePath%, XDot-Status
        IniWrite, %False%, %xdotMapRemoteFilePath%, Mapping, Activate
    Return
}
;;;;;;;;;;;;;Main Function;;;;;;;;;;;;;;
;;;When user RIGHT CLICK on HTML elements
Doc_OnContextMenu(WDoc) {
    htmlId := WDoc.parentWindow.event.srcElement.id
    htmlClassName := WDoc.parentWindow.event.srcElement.classname
    isHtmlXdot := RegExMatch(htmlId, "^XDot[0-9]{2}$")  ;Check if the htmlId is xdot box
    isHtmlXdotDisable := RegExMatch(htmlClassName, "xdot-box-disable")  ;Click if the html xdot bttn disable
    
    mapToolStopCounter := 1
    if (isHtmlXdot) {
        WDoc.getElementById(htmlId).classList.add("xdot-box-disable")
        IniWrite, D, %xdotMapRemoteFilePath%, XDot-Status, %htmlId%
        if (isHtmlXdotDisable) {
            WDoc.getElementById(htmlId).classList.remove("xdot-box-disable")
            IniWrite, N, %xdotMapRemoteFilePath%, XDot-Status, %htmlId%
        }
    }
}

;;;;;;;;;;;Additional Functions;;;;;;;;;;;
DisplayWebPage(WB, html_str) {
	Count:=0
	While % FileExist(f:=A_Temp "\" A_TickCount A_NowUTC "-tmp" Count ".DELETEME.html")
		Count+=1
	FileAppend, %html_str%, %f%
	WB.Navigate("file://" . f)
}

Global mapToolStopCounter := 1      ;To stop the sync loop
mappingToolActivate() {
    IniRead, xDotStatList, %xdotMapRemoteFilePath%, XDot-Status
    if (xDotStatList != "") {
        Loop, 24
        {
            numW0 := Format("{1:02}", A_Index)
            IniRead, xDotStat, %xdotMapRemoteFilePath%, XDot-Status, XDot%numW0%
            ctrlVar = XDot%numW0%
            RegExMatch(ctrlVar, "\d+$", num)
            if (xDotStat = "D" && mapToolStopCounter = 1) {
                changeXdotBttnIcon(ctrlVar, "DISABLE", , A_Index)
            }
            if (xDotStat = "N" && mapToolStopCounter = 1) {
                changeXdotBttnIcon(ctrlVar, "NORMAL", , A_Index)
            }
        }
    }
}