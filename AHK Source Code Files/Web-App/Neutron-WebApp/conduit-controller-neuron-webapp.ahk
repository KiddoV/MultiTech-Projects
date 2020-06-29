 /*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx
#SingleInstance Force
#NoEnv
SetBatchLines -1
SetWorkingDir C:\V-Projects\Web-Applications\Conduit-Controller

;=======================================================================================;
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\css
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\css
IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\js
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\js

FileInstall C:\Users\Vieth\Documents\MultiTech-Projects\HTML-Files\conduit_controller_index.html, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\index.html, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\CSS-Files\bootstrap.min.css, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\css\bootstrap.min.css, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\JAVASCRIPT-Files\bootstrap.min.js, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\js\bootstrap.min.js, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\JAVASCRIPT-Files\jquery.min.js, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\js\jquery.min.js, 1

;=======================================================================================;
; Include the Neutron library
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\Neutron.ahk

; Create a new NeutronWindow and navigate to our HTML page
NeutronWebApp := new NeutronWindow()
NeutronWebApp.Load("index.html")

; Display the Neutron main window
NeutronWebApp.Show("w400 h500")
Return
;=======================================================================================;