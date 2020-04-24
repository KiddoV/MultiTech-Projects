#NoTrayIcon
SetTitleMatchMode, RegEx
mainPort := %0%
Loop,
{
    WinWait %mainPort% FAILURE|%mainPort% PASSED
    IfWinExist, %mainPort% FAILURE
    {
        SendInput #^!+0
        Break
    }
    IfWinExist, %mainPort% PASSED
    {
        SendInput #^!+9
        Break
    }
}
Return