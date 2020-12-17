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
;ReadCOMMsg := Func("ReadCOMMsg").Bind(TermComObj)
;SetTimer, %ReadCOMMsg%, 200
Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=======================================================================================;
;;;Callback Functions and Labels
ReadCOMMsg(comObj) {
    Loop, % XDotPropObj.xdotProperties.length()
    {
        ;MsgBox % comObj[A_Index].ErrMsg
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
    Loop, % XDotPropObj.xdotProperties.length()
    {
        terminalNumber := Format("{1:02}", A_Index)     ;Format to 2 digit number 01 02 03...
        xMainPort := XDotPropObj.xdotProperties[A_Index].mainPort
        
        html = 
        (LTrim
        <div class="d-inline-block pl-2">
            <div class="card" style="width: 250px;">
                <div class="d-flex pl-1 pr-1" style="height: 19px;">
                    <p class="font-weight-bold"><i id="status-term-%terminalNumber%" class="fas fa-circle animated flash infinite slow icon-bad"></i> #%terminalNumber% | COM%xMainPort%</p>
                    <span class="flex-grow-1"></span>
                    <span type="button" class="icon-btn-xs"><i class="fas fa-cog"></i></span>
                </div>
                <div id="term-%terminalNumber%" class="terminal allow-select-text" style="border-radius: 0 0 1`% 1`%;"></div>
            </div>
        </div>
        )
        NeutronWebApp.qs("#jq-terminal-container").insertAdjacentHTML("beforeend", html)
        JQTermObj.Push(NeutronWebApp.wnd.initTerminal("term-" . terminalNumber, A_Index))      ;JS Func
        comObj := new AHK_Terminal()
        If (!comObj.Connect(xMainPort)) {
            JQTermObj[A_Index].error(comObj.ErrMsg)
        } Else {
            JQTermObj[A_Index].echo("[[;lightgreen;]Successfully connecting to COM" . xMainPort . "]")
            TermComObj.Push(comObj)
        }
    }
    ;JQTermObj[1].echo("HELLO FROM 1")
    JQTermObj[1].focus(true)    ;;Activate the first JQTerminal
}

;;;;;;;;;;;;Functions For HTML Used
SendTermCmd(neutron, jqTermObj, termCmd) {              ;;;General used for all JQ-Terminals
    terminalId := jqTermObj.name
    ;jqTermObj.echo("[[;black;white]" . termCmd . "]")
    jqTermObj.echo(terminalId)
    TermComObj[terminalId].Send(termCmd, 1)
    ;jqTermObj.echo(terminalCSSId)
}

TestBtn(neutron, event) {
    ;JQTermObj[2].echo("HELLO FROM 2")
    ;TestCOM.Send(inputStr, 1)
}

