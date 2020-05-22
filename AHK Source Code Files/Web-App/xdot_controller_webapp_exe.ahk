/*
    Program:    Conduit Controller WEBAPP based on HTML, CSS, JAVASCRIPT, AHK.
                This exe file setup all file to run the application.
    Author:     Viet Ho
    
*/
#SingleInstance Force
#NoEnv
SetWorkingDir C:\V-Projects\Web-Applications\XDot-Controller
SetBatchLines -1

;=======================================================================================;
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\Assets\css
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\Assets\css
IfNotExist C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\Assets\js
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\Assets\js

FileInstall C:\Users\Vieth\Documents\MultiTech-Projects\AHK Source Code Files\Web-App\conduit_controller_webapp.ahk, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\conduit_controller_webapp.ahk, 1
FileInstall C:\Users\Vieth\Documents\MultiTech-Projects\HTML-Files\xdot_controller_index.html, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\index.html, 1
FileInstall C:\Users\Vieth\Documents\MultiTech-Projects\CSS-Files\material.min.css, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\Assets\css\material.min.css, 1
FileInstall C:\Users\Vieth\Documents\MultiTech-Projects\JAVASCRIPT-Files\material.min.js, C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\Assets\js\material.min.js, 1

;=======================================================================================;
;;;Create a JSON file
MAIN_JSON_CONTENT = 
(LTrim
{
  "name":                   "Conduit Controller",
  "width":                  655,
  "height":                 480,
  "protocol":               "app",
  "protocol_call":          "app_call",
  "html_url":               "index.html",
  "NavComplete_call":       "app_page",
  "Nav_sounds":             false,
  "fullscreen":             false,
  "DPI_Aware":              true,
  "ZoomLevel":              100,
  "AllowZoomLevelChange":   true
}
)

file := FileOpen("C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\webapp.json", "w")      ;delete all text
file.Close()    ;close file object
FileAppend, %MAIN_JSON_CONTENT%, webapp.json     ;rewrite text

;=======================================================================================;
;;;After setup...Starts main program
Run, %A_WorkingDir%/conduit_controller_webapp.ahk