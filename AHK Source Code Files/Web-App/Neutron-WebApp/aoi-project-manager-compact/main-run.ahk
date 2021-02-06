/*
    Author: Viet Ho
*/
;=======================================================================================;
SetTitleMatchMode, RegEx
#SingleInstance Force
#NoEnv
SetBatchLines -1

;;;Include the Neutron library
#Include C:\MultiTech-Projects\AHK Source Code Files\Web-App\Neutron-WebApp\aoi-project-manager-compact\libs\Neutron.ahk
;;;Other library
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Class_SQLiteDB.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\JSON.ahk
;=======================================================================================;
;;;;;;;;;;Installs Folder Location and Files;;;;;;;;;;
IfNotExist C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\compact
    FileCreateDir C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\compact

FileInstall, C:\MultiTech-Projects\DLL-files\32-bit\SQLite3.dll, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\compact\SQLite3.dll, 1
FileInstall, C:\MultiTech-Projects\EXE-Files\aoi-pro-man_autoUpdateDBTable.exe, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\compact\aoi-pro-man_autoUpdateDBTable.exe, 1

;;For Semantic-icon usage
FileCopyDir, C:\MultiTech-Projects\AHK Source Code Files\Web-App\Neutron-WebApp\aoi-project-manager-compact\assets, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\compact\assets, 1
;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
Global JSON := new JSON()

Global AppTitleName := "AOI Project Manager"
Global MainDBFilePath := "C:\MultiTech-Projects\SQLite-DB\AOI_Pro_Manager_DB.DB"
Global MainSettingsFilePath := "C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\compact\app-settings.ini"
Global CompFindUrl := "virtu.multitech.prv"

Global DBStatus := ""

Global IsUserLogin := False
Global UserInfo := {userId: "???", userFirstName: "???", userLastName: "???", userInitial: "???", userUserName: "???", userPassword: "???", userRole: "N/A"}
;=======================================================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()

NeutronWebApp.Load("aoi_project_manager_index.html")

NeutronWebApp.Gui("+Caption +MinSize1020x750 +LabelAOIProManager")

;;;Run BEFORE WebApp Started;;;
RegRead, ieVers, HKLM, Software\Microsoft\Internet Explorer, svcVersion     ;;;Check Internet Explorer version
ProcessIniFile()
;;changeUserLoginDisplay("LOCKED")

;Display the Neutron main window
NeutronWebApp.Show("w1020 h750")

;;;Run AFTER WebApp Started;;;
NeutronWebApp.doc.getElementById("ie-vers").innerHTML := ieVers == "" ? "N/A" : ieVers
Gui, % NeutronWebApp.hWnd ": Show", , % AppTitleName   ;;;;Set app title
;;NeutronWebApp.doc.getElementById("title-label").innerHTML := "AOI Project Manager"    ;;;;Set app title
;;Connecting to Database
Global AOI_Pro_DB := new SQLiteDB(MainSettingsFilePath)

;IfNotExist, %MainDBFilePath%
    ;DisplayAlertMsg("SQLite Error, Could not find Database file!!", "alert-danger", 5000)
;IfExist, %MainDBFilePath%
;{
    ;If !AOI_Pro_DB.OpenDB(MainDBFilePath) {         ;Connect to the main Database
       ;MsgBox, 16, SQLite Error, % "Failed connecting to Database`nMsg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    ;}
;}

;;;Register Global objects to be used in other script (Sqlite DB object not working!!!)
ObjRegisterActive(NeutronWebApp, GUID1)

#Persistent
;;SetTimer, CheckDataBaseStatus, 400
;;SetTimer, CheckWebSourceStatus, 400
Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=======================================================================================;
;;;Callback Functions
OnExit, AOIProManagerClose
Return
;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, aoi_project_manager_index.html, aoi_project_manager_index.html     ;Main html file
;;JS and CSS components for GUI (All CSS and JS required!)
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js

FileInstall, aoi_pro_man_main.css, aoi_pro_man_main.css
FileInstall, aoi_pro_man_main.js, aoi_pro_man_main.js

;;Supports IE8
FileInstall, html5shiv-printshiv.js, html5shiv-printshiv.js
FileInstall, CSS_selector_engine.js, CSS_selector_engine.js

;;Buit-in Images
FileInstall, default-brand-logo.png, default-brand-logo.png
FileInstall, yestech-logo.png, yestech-logo.png
FileInstall, rti-logo.png, rti-logo.png
;=======================================================================================;
AOIProManagerClose:
    ;For xprocess in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process  WHERE name = 'aoi-pro-man_autoUpdateDBTable.exe' ")
    ;Process, Close, % xprocess.ProcessId

    AOI_Pro_DB.CloseDB()
    NeutronWebApp.Destroy()     ;Free memory
    Gui, Destroy
    ExitApp
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Main Functions;;;;;;;;;;;;;;;;
Test(neutron, event) {
    MsgBox Hello!
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
ProcessIniFile() {
    IfNotExist, %MainSettingsFilePath%
    {
        FileAppend,
        (LTrim
         [Settings]
         MainDBFilePath=%MainDBFilePath%
         [Main]
         DllPath=C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\compact\SQLite3.dll
        ), %MainSettingsFilePath%
    }
    IfExist, %MainSettingsFilePath%
    {
        IniRead, out1, %MainSettingsFilePath%, Settings, MainDBFilePath
        MainDBFilePath := out1
    }
}

ObjRegisterActive(Object, CLSID, Flags:=0) {
    static cookieJar := {}
    if (!CLSID) {
        if (cookie := cookieJar.Remove(Object)) != ""
            DllCall("oleaut32\RevokeActiveObject", "uint", cookie, "ptr", 0)
        return
    }
    if cookieJar[Object]
        throw Exception("Object is already registered", -1)
    VarSetCapacity(_clsid, 16, 0)
    if (hr := DllCall("ole32\CLSIDFromString", "wstr", CLSID, "ptr", &_clsid)) < 0
        throw Exception("Invalid CLSID", -1, CLSID)
    hr := DllCall("oleaut32\RegisterActiveObject"
        , "ptr", &Object, "ptr", &_clsid, "uint", Flags, "uint*", cookie
        , "uint")
    if hr < 0
        throw Exception(format("Error 0x{:x}", hr), -1)
    cookieJar[Object] := cookie
}

;=======================================================================================;
;;;;;;;;;;Hot Keys;;;;;;;;;;
^q::
    Gosub AOIProManagerClose
Return