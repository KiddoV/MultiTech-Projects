#NoTrayIcon
SetTitleMatchMode, RegEx
mainPort = % A_Args[1]
breakPort = % A_Args[2]
TTWinPID = % A_Args[3]
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
    
    If (A_Index > 3) {
        IfWinNotExist, ahk_pid %TTWinPID%
        {
            SetTimer, TriggerIcon, 10
            MsgBox 16, PORT %mainPort% ERROR, PORT %mainPort% Teraterm window has been CLOSED UNEXPECTEDLY while RUNNING!`nXDot might need to Re-Program again!
            Return
            
            TriggerIcon:
                SendInput #^!+8
                IfWinExist PORT %mainPort% ERROR
                    SetTimer, TriggerIcon, Off
            Return
            
            Break
        }
    }
}
Return