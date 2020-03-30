#SingleInstance off
#NoTrayIcon
SendMode Input

#Include Lib\Webapp.ahk
__Webapp_AppStart:
;<< Header End >>


;Get our HTML DOM object
iWebCtrl := getDOM()

;Change App name on run-time
setAppName("My Webapp.ahk Application")

; cut auto run main thread.
Return

; Webapp.ahk-only Sensitive hotkeys
#IfWinActive, ahk_group __Webapp_windows
Esc::
	ExitApp
Return
#IfWinActive

; Our custom protocol's url event handler
app_call(args) {
	MsgBox %args%
	if InStr(args,"msgbox/hello")
		MsgBox Hello world!
	else if InStr(args,"soundplay/ding")
		SoundPlay, %A_WinDir%\Media\ding.wav
}


; function to run when page is loaded
app_page(NewURL) {
	wb := getDOM()
	
	setZoomLevel(100)
	
	if InStr(NewURL,"webapp-test-html.html") {
		disp_info()
	}
}

disp_info() {
	wb := getDOM()
	Sleep, 10
	;x := wb.document.getElementById("ahk_info")
	;x.innerHTML := "<i>Webapp.ahk is currently running on " . GetAHK_EnvInfo() . ".</i>"
}