#include <AutoItConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

WinWaitActive(" SAM-BA 2.15  - at91sam9g25-ek","")
MouseClick("left",80,45,1)
MouseClick("left",116,131,1)
WinWaitActive("Program Manager","FolderView")
MouseClick("left",350,567,2)
WinWaitActive("SAM-BA 2.15 ","")
MouseClick("left",122,152,1)
WinWaitActive(" SAM-BA 2.15  - at91sam9g25-ek","")
MouseClick("left",97,45,1)
MouseClick("left",113,130,1)
WinWaitActive("Select Script File to execute...","Files of &type:")
MouseClick("left",234,103,1)