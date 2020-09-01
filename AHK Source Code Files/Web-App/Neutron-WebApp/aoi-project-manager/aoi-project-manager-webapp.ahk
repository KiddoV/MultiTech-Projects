/*
    Author: Viet Ho
*/
;=======================================================================================;
SetTitleMatchMode, RegEx
#SingleInstance Force
#NoEnv
SetBatchLines -1
;;;Include the Neutron library
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Neutron.ahk
;;;Other library
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Class_SQLiteDB.ahk
;=======================================================================================;
;;;;;;;;;;Installs some files;;;;;;;;;;
;IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\css
    ;FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\Assets\css
;IfNotExist C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\js
    ;FileCreateDir C:\V-Projects\WEB-APPLICATIONS\Conduit-Controller\assets\js
;=======================================================================================;
;;;;;;;;;;;;;Variables Definition;;;;;;;;;;;;;;;;

;=======================================================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()
NeutronWebApp.Load("aoi_project_manager_index.html")

NeutronWebApp.Gui("-Resize +LabelAOIProManager")

;;;Run BEFORE WebApp Started;;;
NeutronWebApp.doc.getElementById("title-label").innerHTML := "AOI Project Manager"    ;;;;Set app title

;Display the Neutron main window
NeutronWebApp.Show("w800 h600")

;;;Run AFTER WebApp Started;;;

Return

;=======================================================================================;
;;;Callback Functions
AutoCloseAlertBox:
    NeutronWebApp.doc.getElementById("close-alert-btn").click()
    SetTimer, AutoCloseAlertBox, Off
Return

;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, aoi_project_manager_index.html, aoi_project_manager_index.html     ;Main html file
FileInstall, html_msgbox.html, html_msgbox.html     ;MsgBox html file
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.bundle.min.js, bootstrap.bundle.min.js
FileInstall, aoi_pro_man_main.css, aoi_pro_man_main.css
FileInstall, fontawesome.js, fontawesome.js
FileInstall, solid.js, solid.js
FileInstall, SQLite3.dll, SQLite3.dll       ;Required to use Class_SQLiteDB.ahk
;=======================================================================================;
^q::
AOIProManagerClose:
    NeutronWebApp.Destroy()     ;Free memory  
    Gui, Destroy
    ExitApp
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
TestBttn(neutron, event) {
    ;HtmlMsgBox("", "Test MsgBox", "", "")
    ;MsgBox HELLO FROM AHK
    ;NeutronWebApp.wnd.alert("Hi")
    DisplayAlertMsg("Login successfully!", "alert-success")
}


;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
HtmlMsgBox(Options := "", Title := "", Text := "", Timeout := 0) {
    NeutronMsgBox := new NeutronWindow()
    NeutronMsgBox.Load("html_msgbox.html")
    ;NeutronMsgBox.Gui("-Resize +LabelHtmlMsgBox")
    NeutronMsgBox.doc.getElementById("title-label").innerHTML := %Title%    ;;;;Set MsgBox title
    
    NeutronMsgBox.Show("")
    
    Return
    
}

DisplayAlertMsg(Text := "", Color := "", Timeout := 2000) {
    NeutronWebApp.doc.getElementById("alert-box-content").innerHTML := Text
    NeutronWebApp.doc.getElementById("alert-box").classList.add(Color)
    NeutronWebApp.doc.getElementById("alert-box").classList.add("show")
    
    SetTimer, AutoCloseAlertBox, %Timeout%
}