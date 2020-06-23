#Singleinstance force

html=
(
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<style>
.xdotBttn {
    border: 2px solid #4CAF50;
    max-width: 30px;
    max-height: 30px;
    min-width: 30px;
    min-height: 30px;
    padding: 1px 1px;
    text-align: center;
    align-content: center;
    text-decoration: none;
    display: inline-block;
    margin: 4px 2px;
    transition-duration: 0.4s;
    cursor: pointer;
}

.xdotBttn:hover {
    background-color: white;
}
</style>
</head>
<body>

<h2>XDot Controller UI References</h2>

<div>
<button class="xdotBttn"><img src="C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-GUI\check_mark.png" width="24" height="24"></button>
<button id="xdot1" class="xdotBttn">P01</button>
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

xdot1_OnClick() {
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