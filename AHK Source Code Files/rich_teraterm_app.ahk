/*
    Author: Viet Ho
*/
SetTitleMatchMode, RegEx
;=======================================================================================;
#Include <My_RS323>
#Include <Class_RichEdit>
;=======================================================================================;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

;;;;;Variables Definition;;;;;
Global comList := ""
Global comListDropList := ""
Global appTitle := "Alternate Teraterm"

;;Main GUI
;Gui, Font, s10, Terminal
;Gui Add, Edit, x10 y40 w550 h368 +ReadOnly hWndhOutput voutputField
;Gui, Font
RichEdit := new RichEdit(1, "x10 y40 w550 h368")
RichEdit.SetBkgndColor(0x2C292D)
RichEdit.SetOptions(["ReadOnly"], "Set")
RichEdit.SetDefaultFont({"Name": "Courier New", "Color": 0xFDF9F3, "Size": 12})
Gui Add, Edit, x10 y415 w550 h21 +Multi -VScroll hWndhInput vinputField gsendInput
Gui Add, Button, x10 y8 w80 h23 gGetSerialPort, Serial Port

;;;;;Run Before Gui Started;;;;;
comList := getCmdOut("[System.IO.Ports.SerialPort]::getportnames()")
Loop, Parse, comList, `n
{
    if (A_LoopField = "")
        Continue
    comListDropList .= A_LoopField "|"
}

;;Starts main gui
Gui Show, , %appTitle%

;;;;;Run After Gui Started;;;;;
ControlFocus, Edit2, %appTitle%
;connectRS232()

Return

GuiEscape:
GuiClose:
    ExitApp


;=======================================================================================;
;##################### ADDITIONAL GUIs #####################;
GetSerialPort() {
    Global
    Gui, serialPort: Default
    Gui, serialPort: +ToolWindow
    
    Gui, serialPort: Add, GroupBox, xm+0 ym+0 w300 h200 Section, Options
    Gui Font, Bold
    Gui, serialPort: Add, Text, xs+10 ys+20, Port:
    Gui, serialPort: Add, Text, xs+10 ys+50, Baud Rate:
    Gui, serialPort: Add, Text, xs+10 ys+80, Data:
    Gui, serialPort: Add, Text, xs+10 ys+110, Parity:
    Gui, serialPort: Add, Text, xs+10 ys+140, Stop:
    Gui, serialPort: Add, Text, xs+10 ys+170, Transmit Delay:
    Gui Font
    Gui, serialPort: Add, DropDownList, xs+150 ys+17 vcomPort, %comListDropList%
    Gui, serialPort: Add, DropDownList, xs+150 ys+47 vbaud, 9600|115200||
    Gui, serialPort: Add, DropDownList, xs+150 ys+77 vbitData, 7 bit|8 bit||
    Gui, serialPort: Add, DropDownList, xs+150 ys+107 vparity, None||Odd|Even|Mark|Space
    Gui, serialPort: Add, DropDownList, xs+150 ys+137 vbitStop, 1 bit||1.5 bit|2 bit
    Gui, serialPort: Add, Edit, xs+150 ys+167 w120 vtransDelay, 0
    
    
    Gui, serialPort: Add, Button, xm+100 ym+220 w100 h30 gconnectRS232, CONNECT
    
    Gui, serialPort: Show, , Serial Port
    Return
    
    serialPortGuiEscape:
    serialPortGuiClose:
        Gui, serialPort: Destroy
    Return
}

;=======================================================================================;
;##################### MAIN FUNCTIONs #####################;
connectRS232() {
    Global
    RS232_Close(RS232_FILEHANDLE)   ;Close instance before connect
    GuiControlGet comPort, , comPort
    GuiControlGet baud, , baud
    GuiControlGet bitData, , bitData
    GuiControlGet parity, , parity
    GuiControlGet bitStop, , bitStop
    GuiControlGet transDelay, , transDelay
    
    ;Reformat all variables
    comPort := RegExReplace(comPort, "\R")
    RegExMatch(bitData, "\d+", bitData)
    RegExMatch(parity, "^[A-Z]", parity)
    RegExMatch(bitStop, "\d+", bitStop)
    
    RS232_PORT = %comPort%
    RS232_BAUD = %baud%
    RS232_DATA = %bitData%
    RS232_PARITY = %parity%
    RS232_STOP = %bitStop%
    RS232_DELAY = %transDelay%
    
    ;RS232_PORT := "COM101"
    ;RS232_BAUD := 115200
    ;RS232_DATA := 8
    ;RS232_PARITY := "N"
    ;RS232_STOP := 1
    ;RS232_DELAY := 0
    
    RS232_SETTINGS = %RS232_PORT%:baud=%RS232_BAUD% parity=%RS232_PARITY% data=%RS232_DATA% stop=%RS232_STOP% dtr=Off
    ;Init
    RS232_FILEHANDLE := RS232_Initialize(RS232_SETTINGS)
    If (RS232_FILEHANDLE = 0) {
        MsgBox 16, , Failed connecting to COM41!
        return
    }
    SetTimer, ReadData, -%RS232_DELAY%
    Gui, serialPort: Destroy
}

sendInput() {
    Global
    
    inData := ""
    
    Gui, 1: Submit, NoHide
    inData := StrReplace(inputField, inDataHistory)
    inDataHistory := inputField
    
    Loop, Parse, inData
        dataCode := Asc(SubStr(A_LoopField, 0))
    if (dataCode != "")
        RS232_Write(RS232_FILEHANDLE, dataCode) ; Send it out the RS232 COM port
    return
}

;##################### Timer Labels #####################;
;;;;
ReadData:
	;read data that is on the serial port buffer
	;post it to the terminal output
	Read_Data := RS232_Read(RS232_FILEHANDLE, "0xFF", RS232_BYTES_RECEIVED)
	if (RS232_Bytes_Received > 0) {
		Critical On
		ASCII =
		Read_Data_Num_Bytes := StrLen(Read_Data) / 2 ;RS232_Read() returns 2 characters for each byte
		textRecieved := ""
		Loop %Read_Data_Num_Bytes%
		{
			StringLeft, Byte, Read_Data, 2
			StringTrimLeft, Read_Data, Read_Data, 2
			Byte = 0x%Byte%
			;msgbox %Byte%
			Byte := Byte + 0 ;Convert to Decimal       


			ASCII_Chr := Chr(Byte)
			textRecieved .= ASCII_Chr
			
		}
		Critical Off
        Gui, 1: Submit, NoHide
		textRecieved := outputField . textRecieved
        GuiControl, 1: , outputField, %textRecieved%
        
        SendMessage, 0x115, 7,,, ahk_id %hOutput%  ;WM_VSCROLL
	}
	SetTimer, ReadData, -%RS232_DELAY%
Return

;=======================================================================================;
;##################### ADDITIONAL FUNCTIONs #####################;
getCmdOut(command) {
    output := ""
    RunWait, PowerShell.exe -ExecutionPolicy Bypass -Command %command% | clip , , Hide
    output := Clipboard    Clipboard := ""
    return output
}

;=======================================================================================;
;##################### HOT KEYs #####################;
~F5::
    RS232_Write(RS232_FileHandle,13) ; Send it out the RS232 COM port
Return

~Enter::
    ControlGetFocus, focusedCtrl, %appTitle%
    if (focusedCtrl = "Edit2") {
        ;RS232_Write(RS232_FileHandle, 13)   ;Send linebreak
        Guicontrol, 1: , inputField,        ;Empty text in the field
    }
Return

;~Backspace::
    ;ControlGetFocus, focusedCtrl, %appTitle%
    ;if (focusedCtrl = "Edit2") {
        ;RS232_Write(RS232_FileHandle, 111)
    ;}
;Return
