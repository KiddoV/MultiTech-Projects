#Singleinstance force

html=
(
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<style>
.xdotBttn {
    max-width: 30px;
    max-height: 30px;
    min-width: 30px;
    min-height: 30px;
    padding: 1px 1px;
    text-align: center;
    display: inline-block;
    transition-duration: 0.4s;
    cursor: pointer;
}

.xdotBttn:hover {
    background-color: white;
}

.xdotNormalBttn {
    border: 2px solid black;
    font-weight: bold;
}

.xdotPassBttn {
    border: 2px solid #4CAF50;
}
.xdotFailBttn {
    border: 2px solid #f44336;
}

.card {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;
  width: 40`%;
}

</style>
</head>
<body>

<h2>XDot Controller UI References</h2>

<div class="card">
<button id="xdot1" class="xdotBttn xdotPassBttn"><img src="C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check_mark.png" width="23" height="23"></button>
<button id="xdot2" class="xdotBttn xdotFailBttn"><img src="C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x_mark.png" width="23" height="23"></button>
<button id="xdot3" class="xdotBttn xdotNormalBttn"><span>P03</span></button>
<button id="xdot4" class="xdotBttn xdotFailBttn"><img src="C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x_mark.png" width="23" height="23"></button>
<button id="xdot5" class="xdotBttn xdotFailBttn"><img src="C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x_mark.png" width="23" height="23"></button>
<button id="xdot6" class="xdotBttn xdotFailBttn"><img src="C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\x_mark.png" width="23" height="23"></button>
</div>

</body>
<script>
    
</script>
</html>
)

; Gui, +ToolWindow -Caption 
Gui,Margin,0,0
Gui, Add, ActiveX, w530 h490 x0 y0 vwebDoc, HTMLFile
webDoc.write(html)
Gui, Show, Center, Test
; WinSet, Transcolor, FF00FF, Test
add_ButtonHandler()
return

GuiClose:
    ExitApp

green_OnClick() {
    MsgBox Foo!
}

bar_OnClick(){
    MsgBox Bar!
}

add_ButtonHandler() {
    global
    Loop % webDoc.getElementsByTagName("Button").length
        ComObjConnect(b_%A_Index%:=webDoc.getElementsByTagName("Button")[A_Index-1], b_%A_Index%.GetAttribute("Id") "_")
}