    htmlTemp = 
    (LTrim
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


AnalystGui()

AnalystGui() {
    Global
    labels := "['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange']"
    Gui, alystGui: Default
    Gui, alystGui: +ToolWindow +hWndhAlystGuiWnd
    
    Gui, alystGui: Add, ActiveX, w450 h250 vWebDoc, Shell.Explore
    WebDoc.Read(htmlTemp)
    WebWindow := WebDoc.document.parentWindow
    Gui, alystGui: Add, Button, x210 y450 w55 gTestBttn, TEST
    
    Gui, alystGui: Show, , Data Analyst
    
    Return  ;;;;;;;;;;;;;;
    
    alystGuiGuiEscape:
    alystGuiGuiClose:
        ;Gui, alystGui: Destroy
        ExitApp
    Return
    
    TestBttn:
        javascript =
    (LTrim
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: %labels%,
            datasets: [{
                label: '# of Votes',
                data: [12, 19, 3, 5, 2, 3],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }, {
                label: '# of Votes 2',
                data: [20, 10, 1, 2, 9, 6],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
    )
	WebWindow.execScript(javascript)
    Return
}