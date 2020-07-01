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
;Create a new NeutronWindow and navigate to our HTML page
NeutronWebApp := new NeutronWindow()
NeutronWebApp.Load("conduit_controller_index.html")

NeutronWebApp.Gui("-Resize +LabelCController")

;;Run before WebApp Started
NeutronWebApp.doc.getElementById("title-label").innerHTML := "Conduit Controller"    ;;Set app title

;Display the Neutron main window
NeutronWebApp.Show("w320 h500")
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
;=======================================================================================;
