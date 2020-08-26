if (!checkNetWorkDrive()) {
    MsgBox FAILED TO CONNECT TO NETWORK DRIVE
}

Test() {
    DllCall("SetErrorMode", "uint", SEM_FAILCRITICALERRORS := 1)
    Global remotePath := "Z:\XDOT"
    Global networkPath := "\\192.168.1.132\XDOT"

    DriveGet, driveType, Type, %remotePath%

    MsgBox % remotePath " ---> " driveType

    DriveGet, driveType, Type, %networkPath%

    MsgBox % networkPath " ---> " driveType

    DriveGet, driveStatus, Status, %remotePath%, NETWORK

    MsgBox % "With NETWORK: " remotePath " ---> " driveStatus

    DriveGet, driveStatus, Status, %remotePath%

    MsgBox % "Without NETWORK: " remotePath " ---> " driveStatus

    DriveGet, driveStatus, Status, %networkPath%, NETWORK

    MsgBox % "With NETWORK: " networkPath " ---> " driveStatus

    DriveGet, driveStatus, Status, %networkPath%

    MsgBox % "Without NETWORK: " networkPath " ---> " driveStatus
}

checkNetWorkDrive() {
    cmd := "ping 192.168.1.132 -n 1 -w 1000"
    RunWait, %cmd%,, Hide
    if (ErrorLevel = 1) {
        DllCall("SetErrorMode", "uint", SEM_FAILCRITICALERRORS := 1)
        return False
    }
    if (ErrorLevel = 0) {
        Test()
        return True
    }
}