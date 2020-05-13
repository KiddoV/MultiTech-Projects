/*
    Program:    Conduit Controller WEBAPP based on HTML, CSS, JAVASCRIPT, AHK
    Author:     Viet Ho
    
*/
#SingleInstance Force
#NoEnv
SetWorkingDir C:\V-Projects\Web-Applications\Conduit-Controller
SetBatchLines -1

;=======================================================================================;
;;;Start HTML UI
#Include C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Libs\Webapp.ahk
#Include C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Libs\JSON_ToObj.ahk
__Webapp_AppStart:
;<< Header End >>

webCtrl := getDOM()     ;get HTML DOM object

Gui -MaximizeBox -Resize
Return      ;cut auto run main thread.

;Custom protocol's url event handler
app_call(args) {
	MsgBox %args%
	if InStr(args,"msgbox/hello")
		MsgBox Hello world!
	else if InStr(args,"soundplay/ding")
		SoundPlay, %A_WinDir%\Media\ding.wav
}

;Function to run when page is loaded
app_page(NewURL) {
	wb := getDOM()
	
	setZoomLevel(100)
	
	if InStr(NewURL,"index.html") {
		;disp_info()
	}
}