SetTitleMatchMode, RegEx
#SingleInstance Force
#NoEnv
SetBatchLines -1

#Include C:\MultiTech-Projects\AHK Source Code Files\lib\AHK_Terminal.ahk

Global appTitle := "Test Terminal"
;=============================================================================;
;;Main GUI
Gui, Font, s10, Terminal
Gui Add, Edit, x10 y10 w550 h368 +ReadOnly hWndhOutput voutputField
Gui, Font
Gui Add, Edit, x10 y380 w550 h21 +Multi -VScroll hWndhInput vinputField

;;;;;Run Before Gui Started;;;;;
Global TestCOM := new AHK_Terminal()

;;Starts main gui
Gui Show, , %appTitle%

;;;;;Run After Gui Started;;;;;
If !TestCOM.Connect("COM101") {
    Guicontrol, 1: , outputField, % TestCOM.ErrMsg
} Else {
    Guicontrol, 1: , outputField, % "Connected to " . TestCOM.ComPortNum 
}



Return

GuiEscape:
GuiClose:
    ExitApp
;=============================================================================;
;;Hot Keys
~Enter::
    ControlGetFocus, focusedCtrl, %appTitle%
    if (focusedCtrl = "Edit2") {
        ;RS232_Write(RS232_FileHandle, 13)   ;Send linebreak
        GuiControlGet, inputStr, , inputField
        Guicontrol, 1: , inputField,        ;Empty text in the field
        TestCOM.Send(inputStr, 1)
        msg := ""
        noMoreMsg := 0
        oldBuff := ""
        Loop
        {
            ToolTip, % A_Index
            msg := TestCOM.ReadData()
            oldBuff := TestCOM.OutputBuffer
            Guicontrol, 1: , outputField, % TestCOM.OutputBuffer
            If (msg = "")
                noMoreMsg++
            If (A_Index > 1 && oldBuff == TestCOM.OutputBuffer)
                Break
        }
    }
Return