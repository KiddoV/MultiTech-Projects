#NoTrayIcon
SetTitleMatchMode, RegEx

mainPort := %0%
Loop, 
{
    WinWait %mainPort% FAILURE
    IfWinExist, %mainPort% FAILURE 
    {
        send #^!+0
        Break
    }
}

Return

