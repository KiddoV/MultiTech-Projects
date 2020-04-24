;Author VIET HO

#include <AutoItConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

HotKeySet("^q", "Terminate")

;HotKey Functions
Func Terminate()
   Exit
   WinClose("All Firmware Auto Installer")
   WinKill("All Firmware Auto Installer")
EndFunc

Global $statusText = ""
Global $firmware = ""
Global $comNumber = ""
Global $progressPercentage = "" ;0-100
Global $firmwareList = ["mLinux 4.1.9", "mLinux 4.1.9 - NO-WiFi"]

;Paths and links
Global $SAM_BA = "C:\Program Files (x86)\Atmel\sam-ba_2.15\sam-ba.exe"
Global $pathMli419NoWi = "C:\vbtest\MTCDT\mLinux-4.1.9-no-WiFiBT\mtcdt-flash-full-4.1.9.tcl"
Global $pathMli419 = ""
Global $pathAep512 = "C:\vbtest\MTCDT\AEP-5_1_2\mtcdt-flash-full-AEP.tcl"


#Region ### START Koda GUI section ###
$Form1 = GUICreate("All Firmware Auto Installer", 323, 281, -1, -1)
$Group1 = GUICtrlCreateGroup("Choose The Firmware", 16, 16, 289, 81)
$Combo1 = GUICtrlCreateCombo("", 32, 48, 257, 25)
GUICtrlSetData(-1, "mLinux 4.1.9|mLinux 4.1.9 - NO-WiFi|AEP 5.1.2", "mLinux 4.1.9")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("Run", 120, 208, 81, 25)
$Group2 = GUICtrlCreateGroup("Enter Your COM Number", 16, 104, 289, 73)
$Input1 = GUICtrlCreateInput("", 32, 136, 257, 21)
GUICtrlSetLimit(-1, 4)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetTip(-1, "COM #")
GUICtrlSetCursor (-1, 5)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Progress1 = GUICtrlCreateProgress(16, 248, 286, 17)
$Label1 = GUICtrlCreateLabel("Status..", 16, 232, 288, 11)
GUICtrlSetFont(-1, 8, 400, 0, "Centaur")
$Checkbox1 = GUICtrlCreateCheckbox("Included Reprogram Step", 16, 184, 289, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;This loop keep window open until user click exit
While 1
   $nMsg = GUIGetMsg()
   Switch $nMsg
	  Case $GUI_EVENT_CLOSE
	  Exit

	  Case $Button1
		 if WinExists("[REGEXPTITLE:COM.*]") Then
			main()
		 Else
			MsgBox( 48, "Alert", "Please connect to PORT first!")
		 EndIf
   EndSwitch
WEnd

Func main()
   $firmware = GUICtrlRead($Combo1)
   $comNumber = GUICtrlRead($Input1)

   If GUICtrlRead($Checkbox1) = 1 Then erasing_firmware()
   installing_firmware($firmware)

   ;Debug message
   ;MsgBox($MB_SYSTEMMODAL, "Test Case", "You choose firmware: " & $firmware & ", and COM: " & $comNumber, 10)
EndFunc

#Region ### ERASING PROCESS ###
Func erasing_firmware()
   WinSetOnTop("[REGEXPTITLE:COM.*]", "", $WINDOWS_ONTOP)
   WinActive("[REGEXPTITLE:COM.*]")
   WinWaitActive("[REGEXPTITLE:COM.*]")
   GUICtrlSetData($Label1, "Erasing old firmware...")
   Sleep(200)
   Send("nand erase.chip")
   Send("{ENTER}")
   Sleep(1600)
   Send("reset")
   Send("{ENTER}")
   Sleep(100)
   WinSetOnTop("[REGEXPTITLE:COM.*]", "", $WINDOWS_NOONTOP)
EndFunc

#Region ### INSTALLING PROCESS ###
Func installing_firmware($fw)

   GUICtrlSetData($Label1, "Openning SAM-BA...")
   Run($SAM_BA)
   GUICtrlSetData($Progress1, 10)
   WinWaitActive("SAM-BA 2.15")
   Send("{ENTER}")

   Do
	  Sleep(200)
   Until WinExists("Invalid chip ID") Or WinExists("[REGEXPTITLE:SAM-BA 2.15  - .*]")

   If WinExists("Invalid chip ID") Then
	  GUICtrlSetData($Progress1, 0)
	  GUICtrlSetData($Label1, "Failed to connect SAM-BA")
   Else
   WinWaitActive("[REGEXPTITLE:SAM-BA 2.15  - .*]")
   WinActivate("[REGEXPTITLE:SAM-BA 2.15  - .*]")
   GUICtrlSetData($Label1, "Win actived")
   ;MouseClick("left",80,45,1)
   ControlClick("[REGEXPTITLE:SAM-BA 2.15  - .*]", "","", "left", 1, 80,45)
   EndIf
EndFunc