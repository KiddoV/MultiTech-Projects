/*
    Program:    Conduit Controller WEBAPP based on HTML, CSS, JAVASCRIPT, AHK.
                This exe file setup all file to run the application.
    Author:     Viet Ho
    
*/
#SingleInstance Force
#NoEnv
SetWorkingDir C:\V-Projects\Web-Applications\Conduit-Controller
SetBatchLines -1

;=======================================================================================;
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\css
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\css
IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\js
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\js
IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Libs
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Libs

FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\Web-App\conduit_controller_webapp.ahk, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\conduit_controller_webapp.ahk, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\webapp\Webapp.ahk, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Libs\Webapp.ahk, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\webapp\JSON_ToObj.ahk, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Libs\JSON_ToObj.ahk, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\HTML-Files\conduit_controller_index.html, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\index.html, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\CSS-Files\material.min.css, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\css\material.min.css, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\JAVASCRIPT-Files\material.min.js, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\js\material.min.js, 1
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

file := FileOpen("C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\webapp.json", "w")      ;delete all text
file.Close()    ;close file object
FileAppend, %MAIN_JSON_CONTENT%, webapp.json     ;rewrite text

;=======================================================================================;
;;;After setup...Starts main program
Run, %A_WorkingDir%/conduit_controller_webapp.ahk