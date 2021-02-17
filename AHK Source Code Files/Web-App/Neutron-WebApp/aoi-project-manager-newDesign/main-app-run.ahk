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
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\JSON.ahk
;=======================================================================================;
;;;;;;;;;;Installs Folder Location and Files;;;;;;;;;;
IfNotExist C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager

FileInstall, C:\MultiTech-Projects\DLL-files\SQLite3.dll, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\SQLite3.dll, 1

FileCopyDir, C:\MultiTech-Projects\AHK Source Code Files\Web-App\Neutron-WebApp\aoi-project-manager-newDesign\semantic-icons, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\assets\semantic-icons, 1
;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
Global JSON := new JSON()

Global MainDBFilePath := "C:\MultiTech-Projects\SQLite-DB\AOI_Pro_Manager_DB.DB"
Global MainSettingsFilePath := "C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\app-settings.ini"
Global CompFindUrl := "virtu.multitech.prv"

Global DBStatus := ""

Global IsUserLogin := False
Global UserInfo := {userId: "???", userFirstName: "???", userLastName: "???", userInitial: "???", userUserName: "???", userPassword: "???", userRole: "N/A"}
;=======================================================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()

NeutronWebApp.Load("main-index.html")

NeutronWebApp.Gui("+MinSize1050x800 +LabelAOIProManager")

;;;Run BEFORE WebApp Started;;;
NeutronWebApp.qs("#title-label").innerHTML := "AOI Project Manager"    ;;;;Set app title

;Display the Neutron main window
NeutronWebApp.Show("w1050 h800")

;;;Run AFTER WebApp Started;;;

;;Connecting to Database
Global AOI_Pro_DB := new SQLiteDB(MainSettingsFilePath)

#Persistent

Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OnExit, AOIProManagerClose
Return

AOIProManagerClose:
    AOI_Pro_DB.CloseDB()
    NeutronWebApp.Destroy()     ;Free memory
    Gui, Destroy
    ExitApp
Return
;=======================================================================================;
;;;;;;;;;;;;;Install Dependencies;;;;;;;;;;;;;;;;
FileInstall, main-index.html, main-index.html       ;;Main view file
FileInstall, app-custom.css, app-custom.css         ;;Main custom CSS
FileInstall, app-custom.js, app-custom.js           ;;Main custom JS

FileInstall, semantic.css, semantic.css
FileInstall, semantic.js, semantic.js
FileInstall, semantic-icons.css, semantic-icons.css
;=======================================================================================;
;;;Callback Functions

;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
Test(neutron, event) {
    DisplayAlertMsg("This is a test message")
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
DisplayAlertMsg(msg) {
    js = 
    (LTrim
    $("main").toast({
        message: "%msg%"
    });
    )
    
    NeutronWebApp.wnd.execScript(js)
}
;=======================================================================================;
;;;;;;;;;;Hot Keys;;;;;;;;;;
^q::
    Gosub AOIProManagerClose
Return
