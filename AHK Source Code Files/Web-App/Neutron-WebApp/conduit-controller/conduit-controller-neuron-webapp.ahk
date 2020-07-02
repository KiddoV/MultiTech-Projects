 /*
    Author: Viet Ho
*/
;=======================================================================================;
SetTitleMatchMode, RegEx
#SingleInstance Force
#NoEnv
SetBatchLines -1
;;;Include the Neutron library
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\Neutron.ahk
;=======================================================================================;
;;;;;;;;;;Installs some files;;;;;;;;;;
;IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\css
    ;FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\css
;IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\js
    ;FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\js
;=======================================================================================;
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;
;Firmware list
Global allFirmwares := ["mLinux 4.0.1", "mLinux 4.0.1 - NO WiFi", "mLinux 4.1.9", "mLinux 4.1.9 - NO WiFi", "mLinux 5.1.8", "mLinux 5.1.8 - NO WiFi", "AEP 1.4.3", "AEP 1.6.4", "AEP 5.0.0", "AEP 5.1.2", "AEP 5.1.5", "AEP 5.1.6"]

;=======================================================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()
NeutronWebApp.Load("conduit_controller_index.html")

NeutronWebApp.Gui("-Resize +LabelCController")

;;Run BEFORE WebApp Started
NeutronWebApp.doc.getElementById("title-label").innerHTML := "Conduit Controller"    ;;Set app title

;Display the Neutron main window
NeutronWebApp.Show("w320 h500")

;;Run AFTER WebApp Started
GetDisplayData()

Return
;=======================================================================================;
;;;Must include FileInstall to work on EXE file
FileInstall, conduit_controller_index.html, conduit_controller_index.html
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, conduit_controller_main.css, conduit_controller_main.css
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.bundle.min.js, bootstrap.bundle.min.js
;=======================================================================================;
^q::
CControllerClose:
    Gui, Destroy
    ExitApp
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
GetDisplayData() {    
    ;;Add html content to firmware dropdown
    html := ""
    For each, item in allFirmwares
        html .= NeutronWebApp.FormatHTML("<option>{}</option>", item)
    NeutronWebApp.qs("#firmwareDropdown").innerHTML := html
}

MainButton(NeutronWebApp, event) {
    progBar := NeutronWebApp.doc.getElementById("programProgbar")
    progBar.style.width :=  10`%
    Sleep 100
    progBar.style.width :=  20`%
    Sleep 300
    progBar.style.width :=  30`%
    Sleep 200
    progBar.style.width :=  40`%
    Sleep 1000
    progBar.style.width :=  50`%
    Sleep 5000
    progBar.style.width :=  100`%
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;

