/*
    Author: Viet Ho
    
    Notes: Use percent sigh (%) in html variable with backstick(`). Ex: 100% => 100`% . Or else it will throw ERROR
*/

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

html =
(
<!DOCTYPE html>
<html>
<head>
<style>
.button {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

.button1 {border-radius: 2px;}
.button2 {border-radius: 4px;}
.button3 {border-radius: 8px;}
.button4 {border-radius: 12px;}
.button5 {border-radius: 50`%;}
</style>
</head>
<body>

<h2>Rounded Buttons</h2>
<p>Add rounded corners to a button with the border-radius property:</p>

<button class="button" style="border-radius: 12px;">2px</button>
<button class="button button2">4px</button>
<button class="button button3">8px</button>
<button class="button button4">12px</button>
<button class="button button5">50`%</button>

</body>
</html>
)
;MsgBox % html

Gui -MinimizeBox -MaximizeBox ;-Caption
Gui, Margin , 0, 0
Gui, Add, ActiveX, vWB w640 h480, about:%html%
Gui, Show

while WB.ReadyState != 4
    Sleep, 50

;Loop, 100
;{
    ;Sleep, 1
    ;WB.document.parentWindow.testVar := A_Index
    ;WB.document.parentWindow.updateText()
;}

;MsgBox, % WB.document.parentWindow.testVar
return


GuiEscape:
GuiClose:
    ExitApp