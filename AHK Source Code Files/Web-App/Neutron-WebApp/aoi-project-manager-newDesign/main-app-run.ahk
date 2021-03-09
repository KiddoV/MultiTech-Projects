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
IfNotExist, %MainDBFilePath%
    DisplayAlertMsg("Could not find Database file!!", "SQLite Error", 0, "error")
IfExist, %MainDBFilePath%
{
    If !AOI_Pro_DB.OpenDB(MainDBFilePath) {         ;Connect to the main Database
        errMsg := "Err Msg: " . AOI_Pro_DB.ErrorMsg . "<br>Err Code: " . AOI_Pro_DB.ErrorCode
        DisplayAlertMsg(errMsg, "SQLite Error", 0, "error")
    }
}

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
FileInstall, jquery-3.5.1.js, jquery-3.5.1.js       ;;JQuery lib
FileInstall, app-custom.css, app-custom.css         ;;Main custom CSS
FileInstall, app-custom.js, app-custom.js           ;;Main custom JS

;;;Fomantic/Semantic-UI
FileInstall, semantic.css, semantic.css
FileInstall, semantic.js, semantic.js
FileInstall, semantic-icons.css, semantic-icons.css

;;;OverlayScrollbar
FileInstall, jquery.overlayScrollbars.js, jquery.overlayScrollbars.js
FileInstall, overlayScrollbars.css, overlayScrollbars.css
;=======================================================================================;
;;;Callback Functions

;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
;;;Called From HTML
Test(neutron, event) {
    errMsg := "Err Msg: " . DB.ErrorMsg . "<br>Err Code: " . DB.ErrorCode
    DisplayAlertMsg("Err Msg: " . DB.ErrorMsg . "<br>Err Code: " . DB.ErrorCode, "SQLite Error", 0, "error")
}

GetRecipesBySearch(neutron, searchKeyWords) {
    ;searchKeyWords := neutron.qs("#recipe-search-field").value
    
    If (searchKeyWords == "") {
        neutron.qs("#recipe-search-status-label").innerHTML := "Please input value..."	
        Return false
    }
    
    ;;Get data from DB
    neutron.qs("#recipe-search-status-label").innerHTML := "Searching..."
    neutron.qs("#recipe-search .input").classList.add("loading")
    neutron.qs("#recipe-search-field").value := ""
    
    SQL := "SELECT * FROM aoi_programs LEFT JOIN aoi_builds ON prog_build_number=build_number LEFT JOIN aoi_pcbs ON prog_pcb_number=pcb_number WHERE prog_build_number LIKE '%" . searchKeyWords . "%' OR prog_full_name LIKE '%" . searchKeyWords . "%' OR prog_pcb_number LIKE '%" . searchKeyWords . "%' OR prog_current_eco LIKE '%" . searchKeyWords . "%' OR prog_current_ecl LIKE '%" . searchKeyWords . "%' ORDER BY prog_pcb_number, prog_build_number ASC"
    If !AOI_Pro_DB.GetTable(SQL, Result) {
        DisplayAlertMsg("Err Msg: " . DB.ErrorMsg . "<br>Err Code: " . DB.ErrorCode, "SQLite Error", 0, "error")
        Return false
    }
    
    rowCount := Result.RowCount
    NeutronWebApp.qs("#recipe-search-status-label").innerHTML := "Found " . rowCount . " result(s)"
    If (!Result.HasRows) {
        DisplayAlertMsg("Not found any result!", , , "warning")
        Return false
    }
    
    searchResult := DataBaseTableToObject(Result)
    Loop, % searchResult.Length()
    {
        searchResult[A_Index, "recipeStatusCSSClass"] := (searchResult[A_Index].prog_status == "USABLE") ? "usable" : (searchResult[A_Index].prog_status == "NEED UPDATE") ? "needupdate" : (searchResult[A_Index].prog_status == "NOT READY") ? "notready" : (searchResult[A_Index].prog_status == "IN PROGRESS") ? "inprogress" : (searchResult[A_Index].prog_status == "SUBSTITUTE") ? "substitute" : "black"
        searchResult[A_Index, "recipeBrandLogo"] := (searchResult[A_Index].prog_aoi_machine == "YesTech") ? "yestech-logo.png" : (searchResult[A_Index].prog_aoi_machine == "TRI") ? "rti-logo.png" : "no-brand-logo.png"
        searchResult[A_Index, "buildPartStatusCSSClass"] := (searchResult[A_Index].build_part_status == "ACTIVE") ? "green" : (searchResult[A_Index].build_part_status == "BETA") ? "blue" : (searchResult[A_Index].build_part_status == "OBSOLETE") ? "orange" : (searchResult[A_Index].build_part_status == "USE UP") ? "yellow" : (searchResult[A_Index].build_part_status == "LAST-TIME BUY") ? "teal" : (searchResult[A_Index].build_part_status == "NO DESIGN") ? "brown" : "grey"
        searchResult[A_Index, "pcbPartStatusCSSClass"] := (searchResult[A_Index].pcb_part_status == "ACTIVE") ? "green" : (searchResult[A_Index].pcb_part_status == "BETA") ? "blue" : (searchResult[A_Index].pcb_part_status == "OBSOLETE") ? "orange" : (searchResult[A_Index].pcb_part_status == "USE UP") ? "yellow" : (searchResult[A_Index].pcb_part_status == "LAST-TIME BUY") ? "teal" : (searchResult[A_Index].pcb_part_status == "NO DESIGN") ? "brown" : "grey"
        If (searchResult[A_Index].prog_created_by != "") {
            createdByUserID := searchResult[A_Index].prog_created_by
            SQL := "SELECT * FROM users WHERE user_id=" . createdByUserID
            If !AOI_Pro_DB.GetTable(SQL, RecipeCreatedUserInfo) {
                DisplayAlertMsg("Err Msg: " . DB.ErrorMsg . "<br>Err Code: " . DB.ErrorCode, "SQLite Error", 0, "error")
                Return false
            }
            searchResult[A_Index, "recipeCreatedByUserInfo"] := DataBaseTableToObject(RecipeCreatedUserInfo)
        }
    }
    
    Clipboard := JSON.Dump(searchResult)
    Return JSON.Dump(searchResult)
    ;Return searchResult
    ;DisplayRecipeCard(searchResult)
}

MainMenuHandle(neutron, event, selectedItem) {
    If (selectedItem == "exit") {
        Gosub AOIProManagerClose
    } Else If (selectedItem == "reload") {
        AOI_Pro_DB.CloseDB()
        NeutronWebApp.Destroy()     ;Free memory
        Gui, Destroy
        Reload
    }
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
DisplayAlertMsg(msg, title := "", timeout := "auto", color := "", icon := "") {
    timeout := (timeout * 1 == timeout) ? timeout : """" . timeout . """"
    icon := (icon == "") ? ((color == "error") ? "bug" : (color == "info") ? "info" : (color == "success") ? "check" : (color == "warning") ? "exclamation triangle" : "") : icon
    js = 
    (LTrim
    $("main").toast({
        position: "top right",
        title: "%title%",
        message: "%msg%",
        showProgress: "bottom",
        displayTime: %timeout%,
        class: "%color%",
        showIcon: "%icon%",
        compact: false,
        newestOnTop: true,
    });
    )
    
    NeutronWebApp.wnd.execScript(js)
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

;;;Function to print out JSON format From SQLite DB
BuildJson(obj) {
    str := "" , array := true
    For k in obj
    {
        if (k == A_Index)
            continue
        array := false
        break
    }
    For a, b in obj
        str .= (array ? "" : """" a """: ") . (IsObject(b) ? BuildJson(b) : (0 * b == 0) ? b : """" b """") . ", "
    str := RTrim(str, " ,")
    Return (array ? "[" str "]" : "{" str "}")
}
;=======================================================================================;
;;;;;;;;;;Hot Keys;;;;;;;;;;
~^q::
    Gosub AOIProManagerClose
return
~^f::
    NeutronWebApp.wnd.jq("#recipe-search-field").focus()
return