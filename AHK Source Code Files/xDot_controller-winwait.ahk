#NoTrayIcon
SetTitleMatchMode, RegEx
mainPort := %0%
Loop,
{
    WinWait %mainPort% FAILURE|%mainPort% PASSED
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
}
Return