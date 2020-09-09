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
;;;;;;;;;;Installs Folder Location and Files;;;;;;;;;;
IfNotExist C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager

FileInstall, C:\MultiTech-Projects\DLL-files\SQLite3.dll, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\SQLite3.dll
;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
Global MainDBFilePath := "C:\MultiTech-Projects\SQLite-DB\AOI_Pro_Manager_DB.DB"    
Global MainSettingsFilePath := "C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\app-settings.ini"
;=======================================================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()

NeutronWebApp.Load("aoi_project_manager_index.html")

NeutronWebApp.Gui("-Resize +LabelAOIProManager")

;;;Run BEFORE WebApp Started;;;
NeutronWebApp.doc.getElementById("title-label").innerHTML := "AOI Project Manager"    ;;;;Set app title
ProcessIniFile()

;Display the Neutron main window
NeutronWebApp.Show("w800 h600")

;;;Run AFTER WebApp Started;;;
;;Connecting to Database
Global AOI_Pro_DB := new SQLiteDB()
IfNotExist, %MainDBFilePath%
{
    MsgBox, 16, SQLite Error, Could not find Database file!!
    Return
}
If !AOI_Pro_DB.OpenDB(MainDBFilePath) {         ;Connect to the main Database
   MsgBox, 16, SQLite Error, % "Failed connecting to Database`nMsg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
   Return
}

Return

;=======================================================================================;
;;;Callback Functions
AutoCloseAlertBox:
    ;NeutronWebApp.doc.getElementById("close-alert-btn").click()
    NeutronWebApp.doc.getElementById("alert-box").classList.remove("show")
    NeutronWebApp.doc.getElementById("alert-box").style.zIndex := "-99"
    SetTimer, AutoCloseAlertBox, Off
Return

;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, aoi_project_manager_index.html, aoi_project_manager_index.html     ;Main html file
FileInstall, html_msgbox.html, html_msgbox.html     ;MsgBox html file
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.bundle.min.js, bootstrap.bundle.min.js
FileInstall, bootstrap-table.min.css, bootstrap-table.min.css
FileInstall, bootstrap-table.min.js, bootstrap-table.min.js
FileInstall, aoi_pro_man_main.css, aoi_pro_man_main.css
FileInstall, fontawesome.js, fontawesome.js
FileInstall, solid.js, solid.js
;FileInstall, SQLite3.dll, SQLite3.dll       ;Required to use Class_SQLiteDB.ahk
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
    ;DisplayAlertMsg("You <strong>click</strong> the button!!!!", "alert-success")
    SQL := "SELECT * FROM Users;"
    If !AOI_Pro_DB.GetTable(SQL, Result)
       MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    MsgBox % Result.ColumnCount
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

DisplayAlertMsg(Text := "", Color := "", Timeout := 2500) {
    NeutronWebApp.doc.getElementById("alert-box-content").innerHTML := Text
    NeutronWebApp.doc.getElementById("alert-box").classList.add(Color)
    NeutronWebApp.doc.getElementById("alert-box").style.zIndex := "99"
    NeutronWebApp.doc.getElementById("close-alert-btn").style.display := "block"
    NeutronWebApp.doc.getElementById("alert-box").classList.add("show")
    
    SetTimer, AutoCloseAlertBox, %Timeout%
}

ProcessIniFile() {
    IfNotExist, %MainSettingsFilePath%
    {
        FileAppend,
        (LTrim
         [Settings]
         MainDBFilePath=%MainDBFilePath%
        ), %MainSettingsFilePath%
    }
    IfExist, %MainSettingsFilePath%
    {
        IniRead, out1, %MainSettingsFilePath%, Settings, MainDBFilePath
        MainDBFilePath := out1
    }
}