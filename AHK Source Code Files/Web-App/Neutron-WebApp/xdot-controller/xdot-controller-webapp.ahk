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
;=======================================================================================;
;;;;;;;;;;Installs Folder Location and Files;;;;;;;;;;
IfNotExist C:\V-Projects\WEB-APPLICATIONS\XDot-Controller
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\XDot-Controller
;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
;=======================================================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()

NeutronWebApp.Load("xdot_controller_index.html")

NeutronWebApp.Gui("+MinSize1200x900 +LabelXDotCtrler")

;;;Run BEFORE WebApp Started;;;
NeutronWebApp.qs("#title-label").innerHTML := "XDot Controller"    ;;;;Set app title

;Display the Neutron main window
NeutronWebApp.Show("w1200 h900")

;;;Run AFTER WebApp Started;;;


;=======================================================================================;
;;;Callback Functions
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
;;;;;;;;;;;;;;;Functions For HTML Used
Test(neutron, jqTermObj, termCmd) {
    jqTermObj.echo("You type " . termCmd)
    MsgBox % jqTermObj.get_command()
}
