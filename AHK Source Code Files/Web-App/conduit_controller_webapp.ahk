/*
    Program:    Conduit Controller WEBAPP based on HTML, CSS, JAVASCRIPT, AHK
    Author:     Viet Ho
    
*/
;=======================================================================================;
;;;;;;;;;;Installs files for app to run;;;;;;;;;;
IfNotExist C:\V-Projects\Web-Applications\Conduit-Controller\Assets
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets
IfNotExist C:\V-Projects\Web-Applications\Conduit-Controller\Libs
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Libs
;=======================================================================================;
#SingleInstance Force
#NoEnv
SetWorkingDir C:\V-Projects\Web-Applications\Conduit-Controller
SetBatchLines -1

;;Create a JSON file
JSON_CONTENT = 
(LTrim
{
  "name":					"My App",
  "width":					655,
  "height":					480,
  "protocol":				"app",
  "protocol_call":			"app_call",
  "html_url":				"index.html",
  "NavComplete_call":		"app_page",
  "Nav_sounds":				false,
  "fullscreen":				false,
  "DPI_Aware":				true,
  "ZoomLevel":				100,
  "AllowZoomLevelChange":	true
}
)

FileAppend, %JSON_CONTENT%, C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\webapp.json