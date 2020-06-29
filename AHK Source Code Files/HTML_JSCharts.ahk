/*
    
*/
    htmlTemp = 
    (LTrim Join
    <!DOCTYPE HTML>
    <html>
    <head>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <script src="C:\Users\Administrator\Documents\MultiTech-Projects\JAVASCRIPT-Files\chart.min.js"></script>
    </head>
    <body>
    <canvas id="myChart" width="350" height="200"></canvas>
    </body>
    <script>
    </script>
    </html>
    )
Class HTML_JSCharts {
    
    ;;=============================================================;;
    __New(ChartName, Options := "") {
        Global
        
        Gui, Add, ActiveX, hWndhWnd v%ChartName% %Options%, Shell.Explore
        ChartName.silent := true ;Surpress JS Error boxes
        Display(ChartName, htmlTemp)
    }

}

Display(WB, html_str) {
    Count:=0
    while % FileExist(f:=A_Temp "\" A_TickCount A_NowUTC "-tmp" Count ".DELETEME.html")
        Count+=1
    FileAppend,%html_str%,%f%
    WB.Navigate("file://" . f)
}