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

Global DBStatus := ""
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
    DisplayAlertMsg("SQLite Error, Could not find Database file!!", "alert-danger", 5000)
IfExist, %MainDBFilePath% 
{
    If !AOI_Pro_DB.OpenDB(MainDBFilePath) {         ;Connect to the main Database
       MsgBox, 16, SQLite Error, % "Failed connecting to Database`nMsg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    }
}

#Persistent
SetTimer, CheckDataBaseStatus, 400

Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;=======================================================================================;
;;;Callback Functions
AutoCloseAlertBox:
    ;NeutronWebApp.doc.getElementById("close-alert-btn").click()
    NeutronWebApp.doc.getElementById("alert-box").classList.remove("show")
    NeutronWebApp.doc.getElementById("alert-box-container").style.zIndex := "-99"
    SetTimer, AutoCloseAlertBox, Off
Return

CheckDataBaseStatus:
    NeutronWebApp.doc.getElementById("icon-database-status").classList.remove("icon-working" , "icon-stopped")
    IfNotExist, %MainDBFilePath%
    {
        DBStatus := "STOPPED - MISSING DATABASE MAIN FILE"
        NeutronWebApp.doc.getElementById("icon-database-status").classList.add("icon-stopped")
    }
    IfExist, %MainDBFilePath%
    {
        NeutronWebApp.doc.getElementById("icon-database-status").classList.add("icon-working")
    }  
Return

;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, aoi_project_manager_index.html, aoi_project_manager_index.html     ;Main html file
FileInstall, html_msgbox.html, html_msgbox.html     ;MsgBox html file
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js
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
    DisplayAlertMsg("You click the button!!!!", "alert-success")
    ;SQL := "SELECT * FROM Users;"
    ;If !AOI_Pro_DB.GetTable(SQL, Result)
       ;MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    ;MsgBox % Result.ColumnCount
}

SearchProgram(neutron, event) {
    Local RowCount := 0
    ;;Get string from search bar
    searchInput := NeutronWebApp.doc.getElementById("prog-search-bar").value
    if (searchInput == "") {
        DisplayAlertMsg("Search field is empty!!!", "alert-warning")
        Return
    }
    
    ;;Get data from DB
    NeutronWebApp.doc.getElementById("search-status-label").innerHTML := "Searching..."
    SQL := "SELECT * FROM aoi_programs WHERE prog_build_number LIKE '%" . searchInput . "%' OR prog_full_name LIKE '%" . searchInput . "%' OR prog_pcb_number LIKE '%" . searchInput . "%' OR prog_current_eco LIKE '%" . searchInput . "%' OR prog_current_ecl LIKE '%" . searchInput . "%' ORDER BY prog_pcb_number, prog_build_number ASC"
    
    If !AOI_Pro_DB.GetTable(SQL, Result) {
        DisplayAlertMsg("Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    RowCount := Result.RowCount
    NeutronWebApp.doc.getElementById("search-status-label").innerHTML := "Found " . RowCount . " result(s)"
    
    DisplayProgCard(Result)
    
}

OnEnter(neutron, event) {
    if (event.keyCode == 13 && event.srcElement.id == "prog-search-bar") {
        SearchProgram(neutron, event)
    }
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
    NeutronWebApp.doc.getElementById("alert-box-container").style.zIndex := "99"
    NeutronWebApp.doc.getElementById("close-alert-btn").style.display := "block"
    NeutronWebApp.doc.getElementById("alert-box").classList.add("show")
    
    SetTimer, AutoCloseAlertBox, %Timeout%
}

DisplayProgCard(Result) {
    ;MsgBox % BuildJson(Result)
    If (Result.HasNames) {
        NeutronWebApp.doc.getElementById("search-result-container").innerHTML := ""     ;Delete all old result before display new result
        If (Result.HasRows) {
            Loop, % Result.RowCount {
                Result.Next(Row)
                Loop, % Result.ColumnCount
                {
                    If (A_Index = 1)
                        progDBId := Row[A_Index]
                    If (A_Index = 2)
                        progFullName := Row[A_Index]
                    If (A_Index = 3)
                        progStatus := Row[A_Index]
                    If (A_Index = 4)
                        buildNum := Row[A_Index]
                    If (A_Index = 5)
                        pcbNum := Row[A_Index]
                    If (A_Index = 7)
                        currentECO := Row[A_Index]
                    If (A_Index = 8)
                        currentECL := Row[A_Index]
                    If (A_Index = 15)
                        machineBrandName := Row[A_Index]
                }
                
                
                progStatusClass := progStatus = "USABLE" ? "pro-card-status-useable" : progStatus = "NEEDUPDATE" ? "pro-card-status-needupdate" : progStatus = "NOTREADY" ? "pro-card-status-notready" : progStatus = "INPROGRESS" ? "pro-card-status-inprogress" : ""
                brandLogoPath := machineBrandName = "YesTech" ? "yestech-logo.png" : machineBrandName = "TRI" ? "rti-logo.png" : ""
                html =
                (Ltrim
                <div id="%progDBId%" type="button" class="card p-1 pl-2 mb-2 %progStatusClass% fast animated bounceInDown hoverable" style="max-width: 99`%;  height: 60px;">
                    <div class="row">
                        <div class="col-md-10">
                            <div class="row">
                                <h6 class="col-sm pt-1 prog-card-title">%buildNum%</h6>
                                <h6 class="col-sm pt-1 prog-card-title">%currentECL%</h6>
								<h6 class="col-sm pt-1 prog-card-title">%currentECO%</h6>
								<h6 class="col-sm pt-1 prog-card-title">%pcbNum%</h6>
							</div>
							<div class="row">
								<p class="col-sm text-muted prog-card-subtitle">%progFullName%</p>
							</div>
						</div>
						<div class="col-md-2" style="">
                            <img id="prog-card-brand-logo" src="%brandLogoPath%" class="rounded mx-auto d-block img-fluid z-depth-1" style="margin-top: -7px; z-index: 80;" width="65" height="65">
						</div>
					</div>
                </div>
                )
                NeutronWebApp.doc.getElementById("search-result-container").insertAdjacentHTML("beforeend", html)
            }
        }
    }
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

;;;;;;;;;;;;;;;;;;;;;;;;
;;;Function to print out JSON format!
BuildJson(obj) 
{
    str := "" , array := true
    for k in obj {
        if (k == A_Index)
            continue
        array := false
        break
    }
    for a, b in obj
        str .= (array ? "" : """" a """: ") . (IsObject(b) ? BuildJson(b) : IsNumber(b) ? b : """" b """") . ", "	
    str := RTrim(str, " ,")
    return (array ? "[" str "]" : "{" str "}")
}
IsNumber(Num)
{
    if Num is number
        return true
    else
        return false
}