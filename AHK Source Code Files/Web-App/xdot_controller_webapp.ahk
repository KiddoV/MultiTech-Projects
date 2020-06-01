/*
    Program:    Conduit Controller WEBAPP based on HTML, CSS, JAVASCRIPT, AHK
    Author:     Viet Ho
    
*/
#SingleInstance Force
#NoEnv
SetBatchLines -1
SendMode Input

;=======================================================================================;
;;;Libraries
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\webapp\Webapp.ahk
#Include C:\Users\Administrator\Documents\MultiTech-Projects\AHK Source Code Files\lib\webapp\JSON_ToObj.ahk
;;;Start HTML UI
__Webapp_AppStart:
;<< Header End >>
Global _webCtrl_ := getDOM()     ;get HTML DOM object

Gui -MaximizeBox -Resize
;Actions before page is load
OnMessage(0x201, "GuiMove")
_webCtrl_.Document.getElementById("appTitle").innerText := __Webapp_Name

Return      ;cut auto run main thread.
;=======================================================================================;
;This function runs after page is loaded
app_page(NewURL) {
}

;Our custom protocol's url event handler
app_call(args) {
	MsgBox %args%
	if InStr(args,"msgbox/hello")
		MsgBox Hello world!
	else if InStr(args,"soundplay/ding")
		SoundPlay, %A_WinDir%\Media\ding.wav
}


testbutton() {
    MsgBox % _webCtrl_.Document.getElementById("xDot1").innerText
}


GuiMove:
    MsgBox % A_GuiControl
    PostMessage, 0xA1, 2,,, A
Return

