﻿/*
    Author: Viet Ho
*/
;=======================================================================================;
SetTitleMatchMode, RegEx
#SingleInstance Force
#NoEnv
SetBatchLines -1

;;;Include the Neutron library
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Neutron.ahk
;;;Other library
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\AHK_Terminal.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\JSON.ahk
;=======================================================================================;
;;;;;;;;;;Installs Folder Location and Files;;;;;;;;;;
IfNotExist C:\V-Projects\WEB-APPLICATIONS\XDot-Controller
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\XDot-Controller
IfNotExist C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files

IfNotExist C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\xdot-properties.json
    FileAppend, , C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\xdot-properties.json

FileInstall C:\MultiTech-Projects\EXE-Files\xdot-call-each-port.exe, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\xdot-call-each-port.exe, 1

FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AS923_JAPAN-mbed-os-5.11.1.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-AS923_JAPAN-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AS923-mbed-os-5.11.1.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-AS923-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-AU915-mbed-os-5.11.1.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-AU915-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-EU868-mbed-os-5.11.1.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-EU868-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-IN865-mbed-os-5.11.1.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-IN865-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-KR920-mbed-os-5.11.1.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-KR920-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-RU864-mbed-os-5.11.1.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-RU864-mbed-os-5.11.1.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1.bin, 1

FileInstall C:\MultiTech-Projects\BIN-Files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1-debug.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.2.1-US915-mbed-os-5.11.1-debug.bin, 1

FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-AS923_JAPAN-mbed-os-5.7.7.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.1.0-AS923_JAPAN-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-AS923-mbed-os-5.7.7.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.1.0-AS923-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-AU915-mbed-os-5.7.7.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.1.0-AU915-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-EU868-mbed-os-5.7.7.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.1.0-EU868-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-IN865-mbed-os-5.7.7.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.1.0-IN865-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-KR920-mbed-os-5.7.7.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.1.0-KR920-mbed-os-5.7.7.bin, 1
FileInstall C:\MultiTech-Projects\BIN-Files\3.1.0\xdot-firmware-3.1.0-US915-mbed-os-5.7.7.bin, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.1.0-US915-mbed-os-5.7.7.bin, 1
;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
Global JSON := new JSON()
Global JQTermObj := []
Global TermComObj := []

FileRead, xdotPropJson, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\xdot-properties.json
Global XDotPropObj := JSON.Load(xdotPropJson)

;;Define Global Unique IDentifier! (For other script to access objects)
Global guid1 := "{AAAAAAAA-1111-0000-1111-120100111116}"
Global guid2 := "{BBBBBBBB-2222-0000-2222-120100111116}"
Global guid3 := "{CCCCCCCC-3333-0000-3333-120100111116}"
Global guid4 := "{DDDDDDDD-4444-0000-4444-120100111116}"
;=========================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()

NeutronWebApp.Load("xdot_controller_index.html")

NeutronWebApp.Gui("+MinSize1200x900 +LabelXDotCtrler")

;;;Run BEFORE WebApp Started;;;
RegRead, ieVers, HKLM, Software\Microsoft\Internet Explorer, svcVersion     ;;;Check Internet Explorer version
NeutronWebApp.qs("#title-label").innerHTML := "XDot Controller"    ;;;;Set app title

;Display the Neutron main window
NeutronWebApp.Show("w1200 h900")

;;;Run AFTER WebApp Started;;;
AutoGenerateJQTerminal()
;;Use x := ComObjActive("<guid>") to access this object!
ObjRegisterActive(NeutronWebApp, guid1)
ObjRegisterActive(JQTermObj, guid2)
ObjRegisterActive(TermComObj, guid3)
ObjRegisterActive(XDotPropObj, guid4)

#Persistent
ReadCOMMsg := Func("ReadCOMMsg").Bind()
SetTimer, %ReadCOMMsg%, 0
AutoCloseAPWindow := Func("AutoCloseAPWindow").Bind()
SetTimer, %AutoCloseAPWindow%, 10
;CheckCOMStatus := Func("CheckCOMStatus").Bind()
;SetTimer, %CheckCOMStatus%, 200
Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=======================================================================================;
;;;Callback Functions and Labels
ReadCOMMsg() {
    index := XDotPropObj.xdotProperties[1].index
    Loop, % XDotPropObj.xdotProperties.length()
    {
        outMsg := TermComObj[index].ReadData()
        If (outMsg != "") {
            JQTermObj[index].echo(outMsg)
            ;termOut := JQTermObj[index].get_output()
        }
        index++
    }
}

CheckCOMStatus() {
    index := XDotPropObj.xdotProperties[1].index
    Loop, % XDotPropObj.xdotProperties.length()
    {
        terminalNumber := Format("{1:02}", index)     ;Format to 2 digit number 01 02 03...
        elId := "#status-term-" . terminalNumber
        If (TermComObj[index].RS232_FILEHANDLE <> 0) {
            NeutronWebApp.qs(elId).classList.remove("icon-process")
            NeutronWebApp.qs(elId).classList.remove("icon-good")
            NeutronWebApp.qs(elId).classList.add("icon-bad")
        } Else {
            NeutronWebApp.qs(elId).classList.remove("icon-process")
            NeutronWebApp.qs(elId).classList.add("icon-good")
            NeutronWebApp.qs(elId).classList.remove("icon-bad")
        }
        
        index++
    }
}

AutoCloseAPWindow() {
    IfWinExist, AutoPlay
        WinClose, AutoPlay
}

OnExit, XDotCtrlerClose
Return
;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, xdot_controller_index.html, xdot_controller_index.html     ;Main html file
;;Boostrap components for GUI (All CSS and JS required!)
FileInstall, xdot_ctrler_main.css, xdot_ctrler_main.css
FileInstall, xdot_ctrler_main.js, xdot_ctrler_main.js
;;;
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js
FileInstall, mdb.min.css, mdb.min.css
FileInstall, mdb.min.js, mdb.min.js
FileInstall, popper.min.js, popper.min.js
FileInstall, fontawesome.js, fontawesome.js
FileInstall, fa-all.js, fa-all.js
FileInstall, font-googleapi.css, font-googleapi.css
;;JQuery Terminal lib
FileInstall, jquery.terminal.min.js, jquery.terminal.min.js
FileInstall, jquery.terminal.min.css, jquery.terminal.min.css

;;Buit-in Images
;=======================================================================================;
^q::
XDotCtrlerClose:
    For xprocess in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where name = 'xdot-call-each-port.exe' ")
    Process, close, % xprocess.ProcessId
    NeutronWebApp.Destroy()     ;Free memory  
    Gui, Destroy
    ExitApp
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTIONs;;;;;;;;;;;;;;;;;

;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;ADDITIONAL FUNCTIONs;;;;;;;;;;;;;;
;;;;;;;;;;;;Functions For AHK Used
AutoGenerateJQTerminal() {
    xIndex := XDotPropObj.xdotProperties[1].index
    Loop, % XDotPropObj.xdotProperties.length()
    {
        terminalNumber := Format("{1:02}", xIndex)     ;Format to 2 digit number 01 02 03...
        xMainPort := XDotPropObj.xdotProperties[xIndex].mainPort
        xCOMStatus := XDotPropObj.xdotProperties[xIndex].comStatus
        termStatusHtmlId := "#status-term-" . terminalNumber
        
        html = 
        (LTrim
        <div class="d-inline-block pl-2">
            <div class="card" style="width: 250px;">
                <div class="d-flex pl-1 pr-1" style="height: 19px;">
                    <p class="font-weight-bold"><i id="status-term-%terminalNumber%" class="fas fa-circle animated flash infinite slow icon-process"></i> #%terminalNumber% | COM%xMainPort%</p>
                    <span class="flex-grow-1"></span>
                    <span type="button" class="icon-btn-xs"><i class="fas fa-cog"></i></span>
                </div>
                <div id="term-%terminalNumber%" class="terminal allow-select-text" style="border-radius: 0 0 1`% 1`%;"></div>
            </div>
        </div>
        )
        NeutronWebApp.qs("#jq-terminal-container").insertAdjacentHTML("beforeend", html)
        JQTermObj.Push(NeutronWebApp.wnd.initTerminal("term-" . terminalNumber, xIndex))      ;JS Func
        comObj := new AHK_Terminal()
        If (!comObj.Connect(xMainPort)) {
            JQTermObj[xIndex].error(comObj.ErrMsg)
            xCOMStatus := "F"
        } Else {
            JQTermObj[xIndex].echo("[[;lightgreen;]Successfully connecting to COM" . xMainPort . "]")
            TermComObj.Push(comObj)
            xCOMStatus := "G"
        }
        
        xIndex++
    }
    ;JQTermObj[1].echo("HELLO FROM 1")
    JQTermObj[1].focus(true)    ;;Activate the first JQTerminal
}

PrintToTerm(termObj, msgType, message) {
    If (msgType == "INFO") {
        termObj.echo("[[;lightblue;]" . message . "]")
    } Else If (msgType == "SUCCESS") {
        termObj.echo("[[;lightgreen;]" . message . "]")
    } Else If (msgType == "FAIL") {
        termObj.error(message)
    } Else If (msgType == "WARNING") {
        termObj.echo("[[;yellow;]" . message . "]")
    } Else {
        termObj.echo("[[;white;]" . message . "]")
    }
}

;;;;;;;;;;;;Functions For HTML Used
SendTermCmd(neutron, jqTermObj, termCmd) {              ;;;Generaly used for all JQ-Terminals
    terminalId := jqTermObj.name()
    TermComObj[terminalId].Send(termCmd, 1)
}

TestAllXDot(neutron, event) {
    xIndex := XDotPropObj.xdotProperties[1].index   ;;Get index by variable
    Loop, % 1 ;XDotPropObj.xdotProperties.length()
    {
        ;TestEachXDot_CallBack := Func("TestEachXDot_CallBack").Bind(XDotPropObj.xdotProperties[A_Index], A_Index)
        ;SetTimer, %TestEachXDot_CallBack%, 0
        ;If (TermComObj[A_Index] == "")
            ;Continue
        Run, %ComSpec% /c start C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\xdot-call-each-port.exe %A_Index% %guid1% %guid2% %guid3% %guid4%, , Hide, WinPID
        Sleep 300
    }
}


TestBtn(neutron, event) {
    
}

TestBtn2(neutron, event) {
    
}

;;;;;;;;;;;;Third party Functions
CreateGUID()
{
    VarSetCapacity(pguid, 16, 0)
    if !(DllCall("ole32.dll\CoCreateGuid", "ptr", &pguid)) {
        size := VarSetCapacity(sguid, (38 << !!A_IsUnicode) + 1, 0)
        if (DllCall("ole32.dll\StringFromGUID2", "ptr", &pguid, "ptr", &sguid, "int", size))
            return StrGet(&sguid)
    }
    return ""
}

IsEqualGUID(guid1, guid2)
{
    return DllCall("ole32\IsEqualGUID", "ptr", &guid1, "ptr", &guid2)
}

ObjRegisterActive(Object, CLSID, Flags:=0) {
    static cookieJar := {}
    if (!CLSID) {
        if (cookie := cookieJar.Remove(Object)) != ""
            DllCall("oleaut32\RevokeActiveObject", "uint", cookie, "ptr", 0)
        return
    }
    if cookieJar[Object]
        throw Exception("Object is already registered", -1)
    VarSetCapacity(_clsid, 16, 0)
    if (hr := DllCall("ole32\CLSIDFromString", "wstr", CLSID, "ptr", &_clsid)) < 0
        throw Exception("Invalid CLSID", -1, CLSID)
    hr := DllCall("oleaut32\RegisterActiveObject"
        , "ptr", &Object, "ptr", &_clsid, "uint", Flags, "uint*", cookie
        , "uint")
    if hr < 0
        throw Exception(format("Error 0x{:x}", hr), -1)
    cookieJar[Object] := cookie
}