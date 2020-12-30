/*
    Author: Viet Ho
    EXE Script
    This script get called by the main script!
*/
;=======================================================================================;
#NoTrayIcon
SetTitleMatchMode, RegEx

;=======================================================================================;
;;;;;Libraries

;=======================================================================================;
;;;;;Variable Definition
Global XDotIndex := A_Args[1]
Global NeutronObj := ComObjActive(A_Args[2])
Global JQTermObj := ComObjActive(A_Args[3])
Global XComObj := ComObjActive(A_Args[4])
Global XDotPropObj := ComObjActive(A_Args[5])
;==========================================================================================;
;;;;;Main Logics
If (!TestEachXDot(XDotIndex)) {
    
}
;==========================================================================================;
;;;;;Main Functions
TestEachXDot(index) {
    xDotProp := XDotPropObj.xdotProperties[index * 1]
    
    testFirmwareVers := "3.0.2-debug-mbed144"
    xIndex := xDotProp.index
    xDriveLetter := xDotProp.driveLetter
    xMainPort := xDotProp.mainPort
    xMbedPort := xDotProp.mbedPort
    xTestPortName := xDotProp.testPortName
    
    termObj := JQTermObj[index]
    comObj := XComObj[index]
    
    If (xDotProp = "") {
        PrintToTerm(termObj, "FAIL", "SYSTEM ERROR: XDot Property Object could not created!")
        Return 0
    }
    
    If (XComObj[index] != "")
        PrintToTerm(termObj, "WARNING", "Running test on PORT " . xMainPort . "...")
    Else {
        PrintToTerm(termObj, "FAIL", "SYSTEM ERROR: COM Object not created!")
        Return 0
    }
    
    ;;;;Init Test
    ;;Check Connection
    Sleep 500
    comObj.Send("at", 1)
    comObj.Wait("OK|ERROR")
    If (comObj.WaitResult != 0) {
        PrintToTerm(termObj, "SUCCESS", "Check!")
    } Else {
        PrintToTerm(termObj, "FAIL", "TEST FAILED: No response on PORT " . xMainPort)
        Return 0
    }
    
    ;;Check Current Program
    tryNum := 1
    CHECK_CURRENT_PROGRAM:
    Sleep 500
    comObj.Send("ati", 1)
    comObj.Wait(testFirmwareVers)
    If (comObj.WaitResult == 1) {
        PrintToTerm(termObj, "SUCCESS", "Check!")
    } Else {
        PrintToTerm(termObj, "FAIL", "Wrong test firmware version. Expecting: " . testFirmwareVers)
        Sleep 200
        PrintToTerm(termObj, "INFO", "Reprogram xDot to firmware " . testFirmwareVers . ", Please wait....")
        RunWait, %ComSpec% /c copy C:\V-Projects\WEB-APPLICATIONS\XDot-Controller\bin-files\xdot-firmware-3.0.2-US915-mbed-os-5.4.7-debug.bin %xDriveLetter%:\, , Hide
        comObj.Disconnect()
        If (!comObj.Connect(xMbedPort, 9600)) {
            PrintToTerm(termObj, "FAIL", "TEST FAILED: Could not connect to COM" . xMbedPort)
            Return 0
        }
        If (comObj.SendBreak() != 0)
            PrintToTerm(termObj, "WARNING", "Break sent!")
        comObj.Disconnect()
        If (!comObj.Connect(xMainPort)) {
            PrintToTerm(termObj, "FAIL", "TEST FAILED: Could not re-connect to COM" . xMainPort)
            Return 0
        }
        PrintToTerm(termObj, "INFO", "Finished installing firmware!")
        tryNum++
        Sleep 300
        If (tryNum < 3) 
            Goto CHECK_CURRENT_PROGRAM
        Else {
            PrintToTerm(termObj, "FAIL", "TEST FAILED: Could not reprogram xDot!")
            Return 0
        }
        
    }
    
    ;;;;Begin Test
    tryNum := 1
    ;;Join Test
    PrintToTerm(termObj, "INFO", "---Begin Join Test---")
    JOINT_TEST:
    comObj.Send("at+ni=1,XDOT-" . xTestPortName . "-NETWORK", 1)   ;;at+ni=1,XDOT-PORT1-NETWORK
    comObj.Wait("OK", 5000)
    If (comObj.WaitResult == 1) {
        PrintToTerm(termObj, "SUCCESS", "Check!")
    } Else {
        PrintToTerm(termObj, "FAIL", "TEST FAILED: Set NI failed!")
        Return 0
    }
    comObj.Send("at+nk=1,XDOT-" . xTestPortName . "-PASSPHRASE", 1)
    comObj.Wait("OK", 5000)
    If (comObj.WaitResult == 1) {
        PrintToTerm(termObj, "SUCCESS", "Check!")
    } Else {
        PrintToTerm(termObj, "FAIL", "TEST FAILED: Set NK failed!")
        Return 0
    }
    
    ;Sleep 500
    comObj.Send("at+fsb=8", 1)
    comObj.Wait("OK")
    comObj.Send("at+TXP=2", 1)
    comObj.Wait("OK")
    comObj.Send("at+TXDR=DR3", 1)
    comObj.Wait("OK")
    
    Sleep 500
    comObj.Send("at+join", 1)
    comObj.Wait("Success|Fail", 8000)
    If (comObj.WaitResult == 1) {
        PrintToTerm(termObj, "SUCCESS", "Join network successfully!")
    } Else If (comObj.WaitResult != 1) {
        If (tryNum < 100) {
            PrintToTerm(termObj, "FAIL", "Failed joining network. (Try: " . tryNum . ")")
            Sleep 500
            PrintToTerm(termObj, "WARNING", "Retry joining network...")
            Sleep 300
            comObj.Send("at&f", 1)
            comObj.Wait("OK")
            comObj.Send("at&w", 1)
            comObj.Wait("OK")
            comObj.Send("atz", 1)
            comObj.Wait("OK")
            tryNum++
            Sleep 2000
            Goto JOINT_TEST
        }
        PrintToTerm(termObj, "FAIL", "TEST FAILED: Failed to join network! (After " . tryNum . " tries!)")
        Return 0
    }
    
    ;;Ping Test
    Sleep 500
    PrintToTerm(termObj, "INFO", "---Begin Ping Test---")
    
    PrintToTerm(termObj, "INFO", "-------END")
}

;==========================================================================================;
;;;;;Additional Functions
PrintToTerm(termObj, msgType, message) {
    If (msgType == "INFO") {
        termObj.echo("[[;lightblue;]" . message . "]")
    } Else If (msgType == "SUCCESS") {
        termObj.echo("[[;lightgreen;]" . message . "]")
    } Else If (msgType == "FAIL") {
        termObj.error(message)
    } Else If (msgType == "WARNING") {
        termObj.echo("[[;yellow;]" . message . "]")
    } Else {
        termObj.echo("[[;white;]" . message . "]")
    }
}