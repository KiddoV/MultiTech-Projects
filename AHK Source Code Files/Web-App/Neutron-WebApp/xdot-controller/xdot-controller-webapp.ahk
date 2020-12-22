/*
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

IfNotExist C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\xdot-properties.json
    FileAppend, , C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\xdot-properties.json


;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
Global JSON := new JSON()
Global JQTermObj := []
Global TermComObj := []

FileRead, xdotPropJson, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\xdot-properties.json
Global XDotPropObj := JSON.Load(xdotPropJson)
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
;Term01.echo("WTF YOU ARE TALKING ABOUT?")

#Persistent
ReadCOMMsg := Func("ReadCOMMsg").Bind()
SetTimer, %ReadCOMMsg%, 10
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

;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, xdot_controller_index.html, xdot_controller_index.html     ;Main html file
;;Boostrap components for GUI (All CSS and JS required!)
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

FileInstall, xdot_ctrler_main.css, xdot_ctrler_main.css
FileInstall, xdot_ctrler_main.js, xdot_ctrler_main.js
;;Buit-in Images
;=======================================================================================;
^q::
XDotCtrlerClose:
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

;;;;;;;;;;;;Functions For HTML Used
SendTermCmd(neutron, jqTermObj, termCmd) {              ;;;Generaly used for all JQ-Terminals
    terminalId := jqTermObj.name()
    ;jqTermObj.echo("[[;black;white]" . termCmd . "]")
    ;jqTermObj.echo(terminalId)
    TermComObj[terminalId].Send(termCmd, 1)
}

TestBtn(neutron, event) {
    ;JQTermObj[2].echo("HELLO FROM 2")
    ;TestCOM.Send(inputStr, 1)
    TermComObj[1].Send("at", 1)
    TermComObj[1].Wait("OK")
    If (TermComObj[1].WaitResult == 1) {
        JQTermObj[1].echo("[[;lightgreen;]Success!]")
    } Else {
        JQTermObj[1].error("Failed!")
    }
    TermComObj[1].Send("at+di", 1)
    TermComObj[1].Wait("42")
    If (TermComObj[1].WaitResult == 1) {
       JQTermObj[1].echo("[[;lightgreen;]Success!]")
    } Else {
        JQTermObj[1].error("Failed!")
    }
    TermComObj[1].Send("at+di", 1)
    TermComObj[1].Wait("(\d+){2}+(-)")
    If (TermComObj[1].WaitResult == 1) {
        JQTermObj[1].echo("[[;lightgreen;]Success!]")
        JQTermObj[1].echo("[[;lightgreen;]" . TermComObj[1].WaitMatchStrLine . "]")
    } Else {
        JQTermObj[1].error("Failed!")
    }
    TermComObj[1].Send("ati", 1)
    TermComObj[1].Wait("3.1.2")
    If (TermComObj[1].WaitResult == 1) {
        JQTermObj[1].echo("[[;lightgreen;]Success!]")
        JQTermObj[1].echo("[[;lightgreen;]" . TermComObj[1].WaitMatchStrLine . "]")
    } Else {
        JQTermObj[1].error("Failed!")
    }
    
    Sleep 2000
    FileCopy, C:\V-Projects\XDot-Controller\BIN-Files\xdot-firmware-3.1.0-AS923-mbed-os-5.7.7.bin, D:\, 1
    If (ErrorLevel)
        JQTermObj[1].error("Could not install firmware to D drive!")
    JQTermObj[1].echo("[[;lightgreen;]Successfuly installed firmware!]")
    
    Sleep 2000
    TermComObj[1].Disconnect()
    JQTermObj[1].echo("[[;yellow;]Disconnected to COM101]")
    If (!TermComObj[1].Connect(11, 9600)) {
        JQTermObj[1].error(TermComObj[1].ErrMsg)
    } Else {
        JQTermObj[1].echo("[[;lightgreen;]Successfully connecting to COM" . 11 . "]")
    }
    TermComObj[1].Send(13)
    JQTermObj[1].echo("[[;yellow;]Sent break!]")
    
    Sleep 2000
    TermComObj[1].Disconnect()
    JQTermObj[1].echo("[[;yellow;]Disconnected to COM11]")
    If (!TermComObj[1].Connect(101)) {
        JQTermObj[1].error(TermComObj[1].ErrMsg)
    } Else {
        JQTermObj[1].echo("[[;lightgreen;]Successfully connecting to COM" . 101 . "]")
    }
    TermComObj[1].Send("ati", 1)
    TermComObj[1].Wait("OK")
    If (TermComObj[1].WaitResult == 1) {
        JQTermObj[1].echo("[[;lightgreen;]Success!]")
    } Else {
        JQTermObj[1].error("Failed!")
    }
}

TestBtn2(neutron, event) {
    #Persistent
    JQTermObj[1].echo("[[;lightblue;]Disconnecting COM101...]")
    TermComObj[1].Disconnect()
    JQTermObj[1].echo("[[;yellow;]Disconnected to COM101]")
    JQTermObj[1].echo("[[;lightblue;]Connecting to COM11...]")
    If (!TermComObj[1].Connect(11, 9600)) {
        JQTermObj[1].error(TermComObj[1].ErrMsg)
        Return
    } Else {
        JQTermObj[1].echo("[[;lightgreen;]Successfully connecting to COM" . 11 . "]")
    }
    JQTermObj[1].echo("[[;lightblue;]Trying to send break...]")
    ;ch := Chr(Byte)
    Sleep 1000
    Loop, 1
    {
        TermComObj[1].Send(0x00)
        JQTermObj[1].echo("[[;yellow;]Sent " . A_Index . " byte!]")
        ;Sleep 2000
    }
    TermComObj[1].Disconnect()
    JQTermObj[1].echo("[[;lightblue;]Finished sending break!]")
    
    JQTermObj[1].echo("[[;lightblue;]Disconnecting COM11...]")
    Sleep 2000
    TermComObj[1].Disconnect()
    JQTermObj[1].echo("[[;yellow;]Disconnected to COM11]")
    JQTermObj[1].echo("[[;lightblue;]Connecting to COM101...]")
    Sleep 1000
    If (!TermComObj[1].Connect(101, 115200)) {
        JQTermObj[1].error(TermComObj[1].ErrMsg)
        Return
    } Else {
        JQTermObj[1].echo("[[;lightgreen;]Successfully connecting to COM" . 101 . "]")
    }
    TermComObj[1].Send("ati", 1)
    TermComObj[1].Wait("OK")
    If (TermComObj[1].WaitResult == 1) {
        JQTermObj[1].echo("[[;lightgreen;]Success!]")
    } Else {
        JQTermObj[1].error("Failed!")
    }
}

