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

Global AppTitleName := "AOI Project Manager - Compact Version"
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

NeutronWebApp.Gui("-Resize +MinSize1000x700 +MaxSize1000x700 +LabelAOIProManager")

;;;Run BEFORE WebApp Started;;;
RegRead, ieVers, HKLM, Software\Microsoft\Internet Explorer, svcVersion     ;;;Check Internet Explorer version
ProcessIniFile()
;;changeUserLoginDisplay("LOCKED")

;Display the Neutron main window
NeutronWebApp.Show("w1000 h700")

;;;Run AFTER WebApp Started;;;
;;NeutronWebApp.doc.getElementById("ie-vers").innerHTML := ieVers == "" ? "N/A" : ieVers
Gui, % NeutronWebApp.hWnd ": Show", , % AppTitleName   ;;;;Set app title
;;NeutronWebApp.doc.getElementById("title-label").innerHTML := "AOI Project Manager"    ;;;;Set app title
;;Connecting to Database
Global AOI_Pro_DB := new SQLiteDB(MainSettingsFilePath)
IfNotExist, %MainDBFilePath%
    MsgBox, 16, SQLite Error, % "SQLite Error, Could not find Database file!!"
IfExist, %MainDBFilePath%
{
    If !AOI_Pro_DB.OpenDB(MainDBFilePath) {         ;Connect to the main Database
       MsgBox, 16, SQLite Error, % "Failed connecting to Database`nMsg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    }
}

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

OnEnter(neutron, event) {
    ;;Enter key event for Program Search Bar
    if (event.keyCode == 13 && event.srcElement.id == "recipe-search-bar") {
        SearchRecipe(neutron, event)
    }
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
SearchRecipe(neutron, event) {
    ;;Get string from search bar
    searchInput := NeutronWebApp.doc.getElementById("recipe-search-bar").value
    If (searchInput == "") {
        MsgBox, 48, Empty Search Field, Please type something to search!
        Return
    }
    
    ;;Get data from DB
    NeutronWebApp.doc.getElementById("search-status-label").innerHTML := "Searching..."
    SQL := "SELECT * FROM aoi_programs LEFT JOIN aoi_pcbs ON prog_pcb_number=pcb_number WHERE prog_build_number LIKE '%" . searchInput . "%' OR prog_full_name LIKE '%" . searchInput . "%' OR prog_pcb_number LIKE '%" . searchInput . "%' OR prog_current_eco LIKE '%" . searchInput . "%' OR prog_current_ecl LIKE '%" . searchInput . "%' ORDER BY prog_pcb_number, prog_build_number ASC"

    If !AOI_Pro_DB.GetTable(SQL, recipeResult) {
        MsgBox, 16, SQLite Error, % "Execute SQL statement FAILED!!!"
        Return
    }

    If (!recipeResult.HasRows) {
        NeutronWebApp.doc.getElementById("search-status-label").innerHTML := "Nothing found... Try again!"
        MsgBox, 48, SQLite Error, % "Not found any result!"
        Return
    }
    
    rowCount := recipeResult.RowCount
    NeutronWebApp.doc.getElementById("search-status-label").innerHTML := "Found " . rowCount . " result(s)"
    DisplayRecipeCard(recipeResult)
}

DisplayRecipeCard(recipeResult) {
    If (recipeResult.HasNames && recipeResult.HasRows) {
        NeutronWebApp.doc.getElementById("search-result-container").innerHTML := ""     ;Delete all old result before display new result

        recipeData := DataBaseTableToObject(recipeResult)
        Loop, % recipeData.Length()
        {
            progDBId := recipeData[A_Index].prog_id
            progFullName := recipeData[A_Index].prog_full_name
            progStatus := recipeData[A_Index].prog_status
            buildNum := recipeData[A_Index].prog_build_number
            pcbNum := recipeData[A_Index].prog_pcb_number
            currentECO := recipeData[A_Index].prog_current_eco
            currentECL := recipeData[A_Index].prog_current_ecl
            dateTimeCreated := recipeData[A_Index].prog_date_created
            dateTimeUpdated := recipeData[A_Index].prog_date_updated
            machineBrandName := recipeData[A_Index].prog_aoi_machine
            progAltType := recipeData[A_Index].prog_alternate_type
            progSubsName := recipeData[A_Index].prog_substitute
            progLibName := recipeData[A_Index].prog_library_name = "" ? "N/A" : recipeData[A_Index].prog_library_name

            pcbPartStatus := recipeData[A_Index].pcb_part_status

            progStatusClass := progStatus = "USABLE" ? "recipe-card-status-useable" : progStatus = "NEED UPDATE" ? "recipe-card-status-needupdate" : progStatus = "NOT READY" ? "recipe-card-status-notready" : progStatus = "IN PROGRESS" ? "recipe-card-status-inprogress" : progStatus = "SUBSTITUTE" ? "recipe-card-status-substitute" : ""
            brandLogoPath := machineBrandName = "YesTech" ? "yestech-logo.png" : machineBrandName = "TRI" ? "rti-logo.png" : "default-brand-icon.png"
            partStatusColor := pcbPartStatus = "ACTIVE" ? "green" : pcbPartStatus = "BETA" ? "indigo" : pcbPartStatus = "OBSOLETE" ? "orange" : pcbPartStatus = "USE UP" ? "yellow" : pcbPartStatus = "LAST-TIME BUY" ? "teal" : pcbPartStatus = "NO DESIGN" ? "brown" : "grey"
            If (dateTimeCreated != "") {
                FormatTime, dateCreated, %dateTimeCreated%, MMM dd, yyyy
                FormatTime, timeCreated, %dateTimeCreated%, hh:mm:ss tt
            } Else {
                dateCreated := "N/A"
            }
            If (dateTimeUpdated != "") {
                FormatTime, dateUpdated, %dateTimeUpdated%, MMM dd, yyyy
                FormatTime, timeUpdated, %dateTimeUpdated%, hh:mm:ss tt
            } Else {
                dateUpdated := "N/A"
            }
            
            recipeNameColorClass := progSubsName != "" ? "text-red" : "text-muted"
                
            html =
            (Ltrim
            <div id="%progDBId%" class="recipe-card panel %progStatusClass%" onclick="ahk.DisplayRecipeData(this)">
                <div class="panel-body row">
                    <div class="col-xs-9">
                        <div class="row">
                            <span class="col-xs-4" style="font-weight: bold;">%buildNum%</span>
                            <span class="col-xs-2" style="">%currentECL%</span>
                            <span class="col-xs-3" style="">%currentECO%</span>
                            <span class="col-xs-3 badge" style="background-color: %partStatusColor%;">%pcbNum%</span>
                        </div>
                        <div class="row">
                            <span class="col-xs-7 %recipeNameColorClass%" style="font-weight: bold">%progFullName%</span>
                            <span class="col-xs-5 text-muted" style="">%progLibName%</span>
                        </div>
                        <div class="row">
                            <span class="col-xs-6" style="font-size: 10px;">Created: %dateCreated%</span>
                            <span class="col-xs-6" style="font-size: 10px;">Last Updated: %dateCreated%</span>
                        </div>
                    </div>
                    <div class="col-xs-3" style="">
                        <img src="%brandLogoPath%" class="" style="border: 1px solid black;" width="55" height="55">
                    </div>
                </div>
            </div>
            )
            NeutronWebApp.doc.getElementById("search-result-container").insertAdjacentHTML("beforeend", html)
        }
    }
}

DisplayRecipeData(neutron, event) {
    recipeCardId := event.id
    
    ;;Get data from DB
    SQL := "SELECT * FROM aoi_programs LEFT JOIN aoi_pcbs ON aoi_pcbs.pcb_number = aoi_programs.prog_pcb_number LEFT JOIN users ON users.user_id = aoi_programs.prog_created_by  LEFT JOIN aoi_builds ON aoi_builds.build_number = aoi_programs.prog_build_number WHERE prog_id=" . recipeCardId
    If !AOI_Pro_DB.GetTable(SQL, RecipeCardData) {
        MsgBox, 16, SQLite Error, % "Execute SQL statement FAILED!!! Could not get data!"
    }

    If (!RecipeCardData.HasRows) {
       MsgBox, 16, SQLite Error, % "Display failed! Got empty Result Set."
    }

    recipeData := DataBaseTableToObject(RecipeCardData)
    
    ;;;Save data to var
    ;;Table 1
    pcmProgDBId := "progCardModal-" . recipeData[1].prog_id
    pcmProgName := recipeData[1].prog_full_name
    pcmProgStatus := recipeData[1].prog_status
    pcmProgBuildNum := recipeData[1].prog_build_number
    pcmProgPcbNum := recipeData[1].prog_pcb_number
    pcmProgCurntEco := recipeData[1].prog_current_eco
    pcmProgCurntEcl := recipeData[1].prog_current_ecl
    pcmProgDateCre := recipeData[1].prog_date_created
    pcmProgAoiMa := recipeData[1].prog_aoi_machine
    pcmProgAltType := recipeData[1].prog_alternate_type
    pcmProgSubsName := recipeData[1].prog_substitute
    ;;Table 2
    pcmPcbStatus := recipeData[1].pcb_part_status
    pcmPcbFullName := recipeData[1].pcb_full_name = "" ? "*No Info In Database*" : recipeData[1].pcb_full_name
    pcmPcbInsFileName := recipeData[1].pcb_ins_file_name
    pcmPcbQty := recipeData[1].pcb_quantity_onhand
    pcmPcbDwg := recipeData[1].pcb_dwg_number
    ;;Table 3
    pcmUserFn := recipeData[1].user_firstname
    pcmUserLn := recipeData[1].user_lastname
    ;;Table 4
    pcmBuildName := recipeData[1].build_name
    pcmBuildCost := recipeData[1].build_cost
    pcmBuildQnty := recipeData[1].build_quantity_onhand
    pcmBuildStatus := recipeData[1].build_part_status
    
    ;;;Process variables
    progStatusColor := pcmProgStatus = "USABLE" ? "#00c853" : pcmProgStatus = "NEED UPDATE" ? "#673ab7" : pcmProgStatus = "NOT READY" ? "#ff3d00" : pcmProgStatus = "IN PROGRESS" ? "#fbc02d" : pcmProgStatus = "SUBSTITUTE" ? "#9e9e9e" : "black"
    pcmProgName := pcmProgAltType = "" ? pcmProgName : pcmProgName . "  <span class='badge'>" . pcmProgAltType . "</span>"
    pcmProgName := pcmProgSubsName = "" ? pcmProgName : pcmProgName . "  <span style='color: red;'>(Use => " . pcmProgSubsName . ")</span>"
    
    ;;Put data to view
    NeutronWebApp.doc.getElementById("recipe-data-header").style.backgroundColor := progStatusColor
    NeutronWebApp.doc.getElementById("recipe-data-title").innerHTML := pcmProgName
}
;===============================================;
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

DataBaseTableToObject(ResultSet) {
    dataObject := [{}]
    If (ResultSet.HasNames) {
        If (ResultSet.HasRows) {
            Loop, % ResultSet.RowCount
            {
                colIndex := A_Index
                ResultSet.Next(Row)
                Loop, % ResultSet.ColumnCount
                {
                    colName := ResultSet.ColumnNames[A_Index]
                    dataObject[colIndex](colName) := Row[A_Index]
                }
            }
        }
    }

    Return dataObject
}

;=======================================================================================;
;;;;;;;;;;Hot Keys;;;;;;;;;;
^q::
    Gosub AOIProManagerClose
Return