;activex gui 2 - test  joedf - 2014/09/19
#SingleInstance, off
OnExit,OnExit

HTML_page =
( Ltrim Join
<!DOCTYPE html>
<html>
	<head>
		<style>
			body{font-family:sans-serif;background-color:#1A1A1A;color:white}
			#title{font-size:36px;}
			input{margin:4px;Border: 2px white solid;background-color:black;color:white;}
			p{font-size:16px;border:solid 1px #666;padding:4px;}
			#footer{text-align:center;}
		</style>
	</head>
	<body>
		<div id="title">Hello World</div>
		<textarea rows="4" cols="70" id="MyTextBox">1234567890-=\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$^&*()_+|~</textarea>
		<p id="footer">
			<input type="button" id="MyButton1" value="Show Content in AHK MsgBox">
			<input type="button" id="MyButton2" value="Change Content with AHK">
			<input type="button" id="MyButton3" value="Greetings from AHK">
		</p>
	</body>
</html>
)

Gui Add, ActiveX, x0 y0 w640 h480 vWB, Shell.Explorer  ; The final parameter is the name of the ActiveX component.
WB.silent := true ;Surpress JS Error boxes
Display(WB,HTML_page)

;Wait for IE to load the page, before we connect the event handlers
while WB.readystate != 4 or WB.busy
	sleep 10

;Use DOM access just like javascript!
MyButton1 := wb.document.getElementById("MyButton1")
MyButton2 := wb.document.getElementById("MyButton2")
MyButton3 := wb.document.getElementById("MyButton3")
ComObjConnect(MyButton1, "MyButton1_") ;connect button events
ComObjConnect(MyButton2, "MyButton2_")
ComObjConnect(MyButton3, "MyButton3_")
Gui Show, w640 h480
return

GuiClose:
ExitApp
OnExit:
	FileDelete,%A_Temp%\*.DELETEME.html ;clean tmp file
ExitApp

; Our Event Handlers
MyButton1_OnClick() {
	global wb
	MsgBox % wb.Document.getElementById("MyTextBox").Value
}
MyButton2_OnClick() {
	global wb
	FormatTime, TimeString, %A_Now%, dddd MMMM d, yyyy HH:mm:ss
	data := "AHK Version " A_AhkVersion " - " (A_IsUnicode ? "Unicode" : "Ansi") " " (A_PtrSize == 4 ? "32" : "64") "bit`nCurrent time: " TimeString
	wb.Document.getElementById("MyTextBox").value := data
}
MyButton3_OnClick() {
	MsgBox Hello world!
}
;------------------
Display(WB,html_str) {
	Count:=0
	while % FileExist(f:=A_Temp "\" A_TickCount A_NowUTC "-tmp" Count ".DELETEME.html")
		Count+=1
	FileAppend,%html_str%,%f%
	WB.Navigate("file://" . f)
}