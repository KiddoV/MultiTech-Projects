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

;=======================================================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()
NeutronWebApp.Load("aoi_project_manager_index.html")

NeutronWebApp.Gui("-Resize +LabelAOIProManager")

;;;Run BEFORE WebApp Started;;;
NeutronWebApp.doc.getElementById("title-label").innerHTML := "AOI Project Manager"    ;;;;Set app title

;Display the Neutron main window
NeutronWebApp.Show("w800 h700")

;;;Run AFTER WebApp Started;;;


Return
;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, aoi_project_manager_index.html, aoi_project_manager_index.html
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.bundle.min.js, bootstrap.bundle.min.js
FileInstall, aoi_pro_man_main.css, aoi_pro_man_main.css
;=======================================================================================;
^q::
AOIProManagerClose:
    Gui, Destroy
    ExitApp
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;

;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;


