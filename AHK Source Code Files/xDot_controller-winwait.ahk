#NoTrayIcon
SetTitleMatchMode, RegEx
mainPort = % A_Args[1]
breakPort = % A_Args[2]
Loop,
{
    WinWait %mainPort% FAILURE|%mainPort% PASSED, , 1
    IfWinExist, %mainPort% FAILURE
    {
        SendInput #^!+0
        SendInput #^!+0     ;Just to be sure it work!
        Break
    }
    IfWinExist, %mainPort% PASSED
    {
        SendInput #^!+9
        SendInput #^!+9     ;Just to be sure it work!
        Break
    }
    
    ;If (A_Index > 3) {
        ;index := 1
        ;IfWinNotExist COM%mainPort%|COM%breakPort%
        ;{
            ;SetTimer, TriggerIcon, 10
            ;MsgBox 16, PORT %mainPort% ERROR, PORT %mainPort% Teraterm window has been closed unexpectedly!`nXDot might need to Re-Program again!
            ;Return
            ;
            ;TriggerIcon:
                ;SendInput #^!+8
                ;SendInput #^!+8     ;Just to be sure it work!
                ;IfWinExist PORT %mainPort% ERROR
                    ;SetTimer, TriggerIcon, Off
            ;Return
            ;
            ;Break
        ;}
    ;}
}
Return