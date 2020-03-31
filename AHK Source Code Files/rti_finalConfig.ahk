/*
    Author: Viet Ho
*/

SetTitleMatchMode, RegEx

IfNotExist C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func
    FileCreateDir C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func
    
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\first-setupArea.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\first-setupArea.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\advancedButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\advancedButton.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\toUnsafe.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\toUnsafe.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\browseArea.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\browseArea.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\restoreButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\restoreArea.bmp, 1
FileInstall C:\Users\Administrator\Documents\MultiTech-Projects\Imgs-for-Search-Func\okButton.bmp, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\okArea.bmp, 1
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;GUI;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
Global WorkingDir
StringTrimRight WorkingDir, A_ScriptDir, 22
SetBatchLines -1

Gui Add, GroupBox, x8 y10 w138 h117, Step by Step
Gui Add, Button, x37 y30 w80 h17 gloginStep vloginBttn, &LOGIN
Gui Add, Text, x16 y52 w124 h2 +0x10
Gui Add, Button, x37 y60 w70 h17 grunStep1 vstep1Bttn, STEP &1
Gui Add, Text, x112 y61 w15 h15 +0x200, ┐
Gui Add, Button, x108 y76 w27 h23 gstep1and2 vstep1and2Bttn, 1&&2
Gui Add, Text, x112 y98 w15 h15 +0x200, ┘
Gui Add, Button, x37 y96 w70 h17 grunStep2 vstep2Bttn, STEP &2
Gui Add, Button, x37 y132 w80 h25 gmainRun vallStepBttn +Disabled, &RUN A to Z
Gui Add, StatusBar,, ...

Gui -MaximizeBox
Gui Show, h186, RTI Auto-Final Configer
Return

GuiEscape:
GuiClose:
    ExitApp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;HOT KEYS;;;;;;;;
^e:: disableGuis("Enable")
^3:: step1and2()
;;;;;;;;;;;;;;;;;;;;;;;;

mainRun() {
    disableGuis("Disable")
    loginStep()
    
    step1and2()
    
    SB_SetText("All done!")
    OnMessage(0x44, "CheckIcon") ;Add icon
    MsgBox 0x80, DONE, FINISHED Auto-Last Config for RTI!
    OnMessage(0x44, "") ;Clear icon
}

step1and2() {
    GuiControl Disable, step1Bttn
    GuiControl Disable, step2Bttn
    GuiControl Disable, step1and2Bttn
    if (runStep1() = 0) {
        disableGuis("Enable")
        return
    }
    
    if (runStep2() = 0) {
        disableGuis("Enable")
        return
    }
    
    SB_SetText("All done!")
    OnMessage(0x44, "CheckIcon") ;Add icon
    MsgBox 0x80, DONE, FINISHED Auto-Last Config for RTI!
    OnMessage(0x44, "") ;Clear icon
    
    GuiControl Enable, step1Bttn
    GuiControl Enable, step2Bttn
    GuiControl Enable, step1and2Bttn
}
loginStep() {
    GuiControl Disable, loginBttn
    addTipMsg("BEGIN LOGIN STEP", 3000)
    SB_SetText("Begin login step...")
    
    IE := ComObjCreate("InternetExplorer.Application")
IE.Visible := 1
IE.Navigate("https://192.168.2.1/commissioning")

javascript =
(
var data = JSON.stringify({"username":"admin","aasID":"","aasAnswer":""});

var xhr = new XMLHttpRequest();

xhr.addEventListener("readystatechange", function() {
  if(this.readyState == 4 && this.status == 200) {
    var resJson = JSON.parse(this.responseText);
    var aasID = resJson.result.aasID;
    alert(aasID);
    setPassword(aasID)
    confirmPassword(aasID)
    login(aasID)
  }
});
xhr.open("POST", "https://192.168.2.1:443/api/commissioning");
xhr.setRequestHeader("Content-Type", "application/json");
xhr.send(data);

function setPassword(aasID) {
    var data = JSON.stringify({"username":"admin","aasID":"" + aasID + "","aasAnswer":"admin2205!"});

    var xhr = new XMLHttpRequest();

    xhr.addEventListener("readystatechange", function() {
        if(this.readyState === 4) {
        var resJson = JSON.parse(this.responseText);
        var aasMsg = resJson.result.aasMsg;
        alert(aasMsg)
    }
    });

    xhr.open("POST", "https://192.168.2.1:443/api/commissioning");
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(data);
}

function confirmPassword(aasID) {
    var data = JSON.stringify({"username":"admin","aasID":"" + aasID + "","aasAnswer":"admin2205!"});

    var xhr = new XMLHttpRequest();

    xhr.addEventListener("readystatechange", function() {
        if(this.readyState === 4) {
        var resJson = JSON.parse(this.responseText);
        var aasMsg = resJson.result.aasMsg;
        alert(this.responseText)
    }
    });

    xhr.open("POST", "https://192.168.2.1:443/api/commissioning");
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(data);
}

function login(aasID) {
    var data = JSON.stringify({"username":"admin","password":"admin2205!"});

    var xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function() {
        if(this.readyState === 4) {
            var resJson = JSON.parse(this.responseText);
            var token = resJson.result.token;
            alert(token);
            console.log(token);
        }
    });

    xhr.open("POST", "https://192.168.2.1/api/login");
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.setRequestHeader("Cookie", "token=" + aasID + "");

    xhr.send(data);
    }

)
sleep 1000

IE_InjectJS(WinExist("ahk_class IEFrame"), javascript)

IE.Navigate("https://192.168.2.1/administration/save-restore")
return
}
;loginStep() {
    ;GuiControl Disable, loginBttn
    ;addTipMsg("BEGIN LOGIN STEP", 3000)
    ;SB_SetText("Begin login step...")
    ;Run, %A_DesktopCommon%\Google Chrome.lnk
    ;;Run, %ComSpec% /c start chrome.exe --ignore-certificate-errors --test-type https://192.168.2.1 , ,Hide
    ;WinWait Commissioning.*|Privacy.*|Sign In.*
    ;if WinExist("Privacy.*") {
        ;searchAdvancedButton(2, 1000)
        ;Sleep 300
        ;searchToUnsafeLink(2, 1000)
        ;WinWait Commissioning.*
    ;}
    ;SB_SetText("Typing username and password")
    ;if WinExist("Commissioning.*") {
        ; Resume processing.
        ;
        ;;WinActivate Commissioning.*
        ;;WinWaitActive Commissioning.*
        ;;Sleep 2000
        ;;ControlSend, ,admin{Enter}, Commissioning.*
        ;;Sleep 3000
        ;;Send admin2205{!}{Enter}
        ;;Sleep 1500
        ;;Send admin2205{!}{Enter}
        ;;WinWait Sign In.*
    ;}
    ;;https://192.168.2.1/sign-in
    ;if WinExist("Sign In.*") {
        ;WinActivate Sign In.*
        ;Sleep 3000
        ;Send admin{Tab}
        ;Send admin2205{!}{Enter}
        ;WinWait mPower.*
    ;}
    ;
    ;WinWait mPower.*
    ;WinActivate mPower.*
    ;searchFirstSetup(10, 500)
    ;
    ;SB_SetText("Getting the source file")
    ;Run, %ComSpec% /c start chrome.exe https://192.168.2.1/administration/save-restore, ,Hide
    ;WinWait Save.*
    ;WinActivate Save.*
    ;searchFirstSetup(4, 500)
    ;WinActivate Save.*
    ;searchBrowseButton(6, 1000)
    ;WinWait Open.*
    ;ControlSetText, Edit1, C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\config_4G_PRD_1_0_3_MTCDT-LAT3-240A_5_1_2_12_20_19.tar.gz, Open.*
    ;ControlSend, Edit1, {Enter}, Open.*
    ;ControlClick Button1, Open.*, , Left, 2
    ;SB_SetText("Resetting...")
    ;searchRestoreButton(6, 1000)
    ;searchOkButton(6, 1000)
    ;SB_SetText("Waiting for conduit to reset")
    ;WinWaitClose Save.*
    ;SB_SetText("Finished reseting conduit!")
;}

runStep1() {
    SB_SetText("Waiting for conduit to reset")
    WinWaitClose Save.*
    GuiControl Disable, step1Bttn
    if !FileExist("C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step1.PINGTESTappinstall.ttl") {
        MsgBox 16, FILE NOT FOUND, The file:`nStep1.PINGTESTappinstall.ttl`nwas not found in this location:`nC:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\`nPlease check and run again!
        return 0
    }
    begin_step1:
    SB_SetText("Begin step 1...")
    addTipMsg("BEGIN STEP 1", 3000)
    Run, %ComSpec% /c start C:\teraterm\ttermpro.exe   /M=C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step1.PINGTESTappinstall.ttl, ,Hide
    
    WinWait SECURITY.*|MACRO: Error.*
    If WinExist("SECURITY.*") {
        ControlClick, Button2, SECURITY.*, , Left, 3
    }
    WinWait MACRO: Error.*, , 6
    If WinExist("MACRO: Error.*") {
        SB_SetText("Failed to connect MACRO...")
        ControlClick, Button1, MACRO: Error.*, , Left, 2
        Sleep 2000
        Goto begin_step1
    }
    ;WinWait Connection Error.*, ,10000
    WinWait TTSSH.*
    SB_SetText("Transfering files...")
    WinWaitClose TTSSH.*
    WinWait DONE.*
    SB_SetText("Waiting for process...")
    WinWaitClose DONE.*
    
    SB_SetText("Checking cell connection...")
    WinWait Status.*
    SB_SetText("Cell connection OK")
    WinWaitClose Status.*
    
    SB_SetText("Waiting for ping test...")
    WinWait Status.*
    ControlClick, Button1, Status.*, , Left, 3
    WinWaitClose Status.*
    SB_SetText("Ping test passed!")
    WinWait Tera Term
    ControlClick, Button1, Tera Term, , Left, 3
    
    While WinExist("Tera Term") {
        WinActivate Tera Term
        Send {Left}{Enter}
        Sleep 500
    }
    WinWaitClose 192.168.2.1.*
    Sleep 1000
    WinClose .*Chrome.*
    SB_SetText("Finished step 1!")
    GuiControl Enable, step1Bttn
}

runStep2() {
    GuiControl Disable, step2Bttn
    if !FileExist("C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step2.saveOEM.ttl") {
        MsgBox 16, FILE NOT FOUND, The file:`nStep2.saveOEM.ttl`nwas not found in this location:`nC:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\`nPlease check and run again!
        return 0
    }
    SB_SetText("Begin step 2...")
    addTipMsg("BEGIN STEP 2", 3000)
    Run, %ComSpec% /c start C:\teraterm\ttermpro.exe   /M=C:\vbtest\MTCDT\MTCDT-LAT3-240A-RTI\Step2.saveOEM.ttl, ,Hide
    
    WinWait SECURITY.*
    ControlClick, Button2, SECURITY.*, , Left, 2
    
    SB_SetText("Waiting for token")
    WinWait Display Token.*
    WinGetText token, Display Token.*
    foundQuoMark := InStr(token, """") ;Search for quotation mark
    if (foundQuoMark > 0) {
        MsgBox 16, ERROR, Bad TOKEN, Please reboot device!
        SB_SetText("Found bad token!")
        return 0
    }
    Sleep 2000
    ControlClick, Button1, Display Token.*, , Left, 2
    SB_SetText("Token is good!")
    WinWait Port.*
    Sleep 2000
    ControlClick, Button1, Port.*, , Left, 2
    SB_SetText("Finished step 2!")
    GuiControl Enable, step2Bttn
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
addTipMsg(text, time) {
    SplashImage, C:\tempImg.gif, B FS12, %text%
    
    SetTimer, RemoveTipMsg, %time%
    return
    
    RemoveTipMsg:
    SplashImage, Off
    return
}

;option is Disable or Enable
disableGuis(option) {
    GuiControl %option%, loginBttn
    GuiControl %option%, step1Bttn
    GuiControl %option%, step2Bttn
    GuiControl %option%, allStepBttn
    GuiControl %option%, step1and2Bttn
}

;;;;Search Images Functions;;;;
searchFirstSetup(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\first-setupArea.bmp
        If ErrorLevel = 0
        {
            FoundX += 136
            FoundY += 8
            ControlClick x%FoundX% y%FoundY%, mPower.*, , Left, 2 ;Click button when found
        }
            
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found    
}

searchAdvancedButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Privacy.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\advancedButton.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Privacy.*, , Left, 1 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found 
}

searchToUnsafeLink(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Privacy.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\toUnsafe.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Privacy.*, , Left, 2 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found 
}

searchBrowseButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Save.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\browseArea.bmp
        If ErrorLevel = 0
        {
            FoundX += 30
            FoundY += 15
            ControlClick x%FoundX% y%FoundY%, Save.*, , Left, 1 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found
}

searchRestoreButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Save.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\restoreArea.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Save.*, , Left, 1 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found
}

searchOkButton(loopCount, sleepTime) {
    Loop, %loopCount%
    {
        WinActivate Save.*
        CoordMode, Pixel, Window
        ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, C:\V-Projects\RTIAuto-LastConfiger\Imgs-for-Search-Func\okArea.bmp
        If ErrorLevel = 0
        {
            ControlClick x%FoundX% y%FoundY%, Save.*, , Left, 1 ;Click button when found
            return 1 ;Return true if found
        }
        Sleep, %sleepTime%
    }
    If ErrorLevel   
        return 0 ;Return false if NOT found
}

;;;Icon for MsgBox;;;
/*Usage Sample
OnMessage(0x44, "CheckIcon") ;Add icon
MsgBox 0x80, DONE, FINISHED Auto-reprogram %fw%!
OnMessage(0x44, "") ;Clear icon
*/
CheckIcon() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        hIcon := LoadPicture("ieframe.dll", "w32 Icon57", _)
        SendMessage 0x172, 1, %hIcon%, Static1 ; STM_SETIMAGE
    }
}
PlayInCircleIcon() {
    DetectHiddenWindows, On
    Process, Exist
    If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
        hIcon := LoadPicture("shell32.dll", "w32 Icon138", _)
        SendMessage 0x172, 1, %hIcon%, Static1 ; STM_SETIMAGE
    }
}

;;;;;;;;;;;;;;;;;FUNCTIONS SUPPORT COM OBJECT IE;;;;;;;;;;;;;;;;;;;;
IE_InjectJS(hWnd_MainWindow, JS_to_Inject="", VarNames_to_Return="", COM_to_Call1="", COM_to_Call2="") {

   window := _win(hWnd_MainWindow)

   wb := WBGet("ahk_id" hWnd_MainWindow)

   if COM_to Call1 
   {
    Loop, Parse, COM_to_Call1, `, 
    {
        wb[A_LoopField]     
    }    
   }     

   if JS_to_Inject
      window.execScript(JS_to_Inject)

   

   if COM_to_Call2 
   {             
    Loop, Parse, COM_to_Call2, `, 
    {
    wb[A_LoopField]     
    }               
   }  

   return SubStr(Ret,1,-1)
}

_win(hwnd, Svr#=1) {               ;// based on ComObjQuery docs

   static msg := DllCall("RegisterWindowMessage", "str", "WM_HTML_GETOBJECT")
        , IID1 := "{0002DF05-0000-0000-C000-000000000046}"  ; IID_IWebBrowserApp
        , IID2 := "{332C4427-26CB-11D0-B483-00C04FD90119}"  ; IID_IHTMLWindow2

   SendMessage msg, 0, 0, Internet Explorer_Server1, ahk_id %hwnd%

   if (ErrorLevel != "FAIL") {

      lResult:=ErrorLevel, VarSetCapacity(GUID,16,0)

      if DllCall("ole32\CLSIDFromString", "wstr","{332C4425-26CB-11D0-B483-00C04FD90119}", "ptr",&GUID) >= 0 {

         DllCall("oleacc\ObjectFromLresult", "ptr",lResult, "ptr",&GUID, "ptr",0, "ptr*",pdoc)

            return  ComObj(9,ComObjQuery(pwb:=ComObjQuery(pdoc,IID1,IID1),IID2,IID2),1)
                ,   ObjRelease(pdoc), ObjRelease(pwb)

      }

   }

}

WBGet(WinTitle="ahk_class IEFrame", Svr#=1) {               ;// based on ComObjQuery docs
   static msg := DllCall("RegisterWindowMessage", "str", "WM_HTML_GETOBJECT")
        , IID := "{0002DF05-0000-0000-C000-000000000046}"   ;// IID_IWebBrowserApp
   SendMessage msg, 0, 0, Internet Explorer_Server%Svr#%, %WinTitle%
   if (ErrorLevel != "FAIL") {
      lResult:=ErrorLevel, VarSetCapacity(GUID,16,0)
      if DllCall("ole32\CLSIDFromString", "wstr","{332C4425-26CB-11D0-B483-00C04FD90119}", "ptr",&GUID) >= 0 {
         DllCall("oleacc\ObjectFromLresult", "ptr",lResult, "ptr",&GUID, "ptr",0, "ptr*",pdoc)
         return ComObj(9,ComObjQuery(pdoc,IID,IID),1), ObjRelease(pdoc)
      }
   }
}