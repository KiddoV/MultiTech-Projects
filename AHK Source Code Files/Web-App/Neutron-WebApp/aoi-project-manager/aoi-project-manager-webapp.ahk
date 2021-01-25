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
FileInstall, C:\MultiTech-Projects\EXE-Files\aoi-pro-man_autoUpdateDBTable.exe, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\aoi-pro-man_autoUpdateDBTable.exe, 1
;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
Global JSON := new JSON()

Global MainDBFilePath := "C:\MultiTech-Projects\SQLite-DB\AOI_Pro_Manager_DB.DB"
Global MainSettingsFilePath := "C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\app-settings.ini"
Global CompFindUrl := "virtu.multitech.prv"

Global DBStatus := ""

Global IsUserLogin := False
Global UserInfo := {userId: "???", userFirstName: "???", userLastName: "???", userInitial: "???", userUserName: "???", userPassword: "???", userRole: "N/A"}

;;Define Global Unique IDentifier! (For other script to access objects)
Global GUID1 := "{AAAAAAAA-1111-0000-116D-616E61676572}"
;=======================================================================================;
;Create a new NeutronWindow and navigate to our HTML page
Global NeutronWebApp := new NeutronWindow()

NeutronWebApp.Load("aoi_project_manager_index.html")

NeutronWebApp.Gui("+MinSize1020x750 +LabelAOIProManager")

;;;Run BEFORE WebApp Started;;;
NeutronWebApp.qs("#title-label").innerHTML := "AOI Project Manager"    ;;;;Set app title
ProcessIniFile()
changeUserLoginDisplay("LOCKED")

;Display the Neutron main window
NeutronWebApp.Show("w1020 h750")

;;;Run AFTER WebApp Started;;;
;;Connecting to Database
Global AOI_Pro_DB := new SQLiteDB(MainSettingsFilePath)

IfNotExist, %MainDBFilePath%
    DisplayAlertMsg("SQLite Error, Could not find Database file!!", "alert-danger", 5000)
IfExist, %MainDBFilePath% 
{
    If !AOI_Pro_DB.OpenDB(MainDBFilePath) {         ;Connect to the main Database
       MsgBox, 16, SQLite Error, % "Failed connecting to Database`nMsg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    }
}

;;;Register Global objects to be used in other script (Sqlite DB object not working!!!)
ObjRegisterActive(NeutronWebApp, GUID1)

#Persistent
SetTimer, CheckDataBaseStatus, 400
SetTimer, CheckWebSourceStatus, 400
Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;=======================================================================================;
;;;Callback Functions
AutoCloseAlertMsg(elId) {
    NeutronWebApp.doc.getElementById(elId).click()
}

CheckDataBaseStatus:
    ;ToolTip % NeutronWebApp.qs("#icon-database-status").className
    IfExist, %MainDBFilePath%
    {   
        Check_DB := new SQLiteDB(MainSettingsFilePath)
        If !Check_DB.OpenDB(MainDBFilePath) {
            NeutronWebApp.qs("#icon-database-status").classList.remove("icon-problem", "icon-working")    
            NeutronWebApp.qs("#icon-database-status").classList.add("icon-stopped")
        }
        NeutronWebApp.qs("#icon-database-status").classList.remove("icon-problem", "icon-stopped")
        NeutronWebApp.qs("#icon-database-status").classList.add("icon-working")
        Check_DB.CloseDB()
    }
    
    IfNotExist, %MainDBFilePath%
    {
        DBStatus := "STOPPED - MISSING DATABASE MAIN FILE"
        NeutronWebApp.qs("#icon-database-status").classList.remove("icon-working" , "icon-problem")
        NeutronWebApp.qs("#icon-database-status").classList.add("icon-stopped")
    }
Return

CheckWebSourceStatus:
    ;ToolTip, % NeutronWebApp.qs("#icon-web-status").className
    if (checkAnURLStatus(CompFindUrl)) {    ;;URL: virtu.multitech.prv  | IP: 192.168.11.62
        NeutronWebApp.qs("#icon-web-status").classList.remove("icon-problem")
        NeutronWebApp.qs("#icon-web-status").classList.remove("icon-stopped")
        NeutronWebApp.qs("#icon-web-status").classList.add("icon-working")
    } else {
        NeutronWebApp.qs("#icon-web-status").classList.remove("icon-working")
        NeutronWebApp.qs("#icon-web-status").classList.remove("icon-problem")
        NeutronWebApp.qs("#icon-web-status").classList.add("icon-stopped")
    }
Return

OnExit, AOIProManagerClose
Return
;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, aoi_project_manager_index.html, aoi_project_manager_index.html     ;Main html file
FileInstall, html_msgbox.html, html_msgbox.html     ;MsgBox html file
;;Boostrap components for GUI (All CSS and JS required!)
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js
FileInstall, mdb.min.css, mdb.min.css
FileInstall, mdb.min.js, mdb.min.js
FileInstall, popper.min.js, popper.min.js
FileInstall, bootstrap-table.min.css, bootstrap-table.min.css
FileInstall, bootstrap-table.min.js, bootstrap-table.min.js
FileInstall, fontawesome.js, fontawesome.js
FileInstall, fa-all.js, fa-all.js
FileInstall, font-googleapi.css, font-googleapi.css
FileInstall, circle-prog-bar.css, circle-prog-bar.css
FileInstall, bootstrap-select.min.css, bootstrap-select.min.css
FileInstall, bootstrap-select.min.js, bootstrap-select.min.js

FileInstall, aoi_pro_man_main.css, aoi_pro_man_main.css
FileInstall, aoi_pro_man_main.js, aoi_pro_man_main.js
;;Buit-in Images
FileInstall, default-brand-logo.png, default-brand-logo.png
FileInstall, yestech-logo.png, yestech-logo.png
FileInstall, rti-logo.png, rti-logo.png
;=======================================================================================;
AOIProManagerClose:
    For xprocess in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_Process  WHERE name = 'aoi-pro-man_autoUpdateDBTable.exe' ")
    Process, Close, % xprocess.ProcessId
    
    AOI_Pro_DB.CloseDB()
    NeutronWebApp.Destroy()     ;Free memory  
    Gui, Destroy
    ExitApp
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
TestBttn(neutron, event) {

}

TestBttn2(neutron, event) {
    HtmlMsgBox("ERROR", , , "Test MsgBox", "HELLO! This is a message 2", 0)
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
    NeutronWebApp.qs("#search-status-label").innerHTML := "Searching..."
    SQL := "SELECT * FROM aoi_programs LEFT JOIN aoi_pcbs ON prog_pcb_number=pcb_number WHERE prog_build_number LIKE '%" . searchInput . "%' OR prog_full_name LIKE '%" . searchInput . "%' OR prog_pcb_number LIKE '%" . searchInput . "%' OR prog_current_eco LIKE '%" . searchInput . "%' OR prog_current_ecl LIKE '%" . searchInput . "%' ORDER BY prog_pcb_number, prog_build_number ASC"
    
    If !AOI_Pro_DB.GetTable(SQL, Result) {
        DisplayAlertMsg("Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    RowCount := Result.RowCount
    NeutronWebApp.qs("#search-status-label").innerHTML := "Found " . RowCount . " result(s)"
    
    If (!Result.HasRows)
        DisplayAlertMsg("Not found any result!", "alert-warning")
    DisplayProgCard(Result)
    
}

OnEnter(neutron, event) {
    ;;Enter key event for Program Search Bar
    if (event.keyCode == 13 && event.srcElement.id == "prog-search-bar") {
        SearchProgram(neutron, event)
    }
}

OnRightClick(neutron, event) {
    progCardId := event.id
    MouseGetPos, xpos, ypos 
    NeutronWebApp.qs("#prog-card-dropdown-" . progCardId).classList.add("d-block")
}

OnLeftClick(neutron, event) {
    
}
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;Additional Functions;;;;;;;;;;;;;;;;
HtmlMsgBox(Icon := "", Options := "", Size = "w300 h150", Title := "", MainText := "", Timeout := 0) {
    ;;Create instance of Messagebox Gui
    Random, randId, 1, 10
    NeutronMsgBox := new NeutronWindow()
    
    NeutronMsgBox.Load("html_msgbox.html")
    NeutronMsgBox.Gui("-Resize +LabelHtmlMsgBox +hWndHtmlMsgBox")
    
    MsgboxIconElId := Icon = "ERROR" ? "#msgbox-icon-error" : Icon = "INFO" ? "#msgbox-icon-info" : Icon = "CHECK" ? "#msgbox-icon-check" : Icon = "QUESTION" ? "#msgbox-icon-question" : Icon = "WARNING" ? "#msgbox-icon-warning" : ""
    
    ;NeutronMsgBox.qs(MsgboxIconElId).classList.remove("d-none")
    NeutronMsgBox.qs(MsgboxIconElId).classList.add("d-block")
    
    NeutronMsgBox.qs("#title-label").innerHTML := Title     ;;;;Set MsgBox title
    NeutronMsgBox.qs("#msgbox-main-text").innerHTML := MainText
    
    HTMLMsgboxHWND := NeutronMsgBox.HWND
    NeutronMsgBox.Gui("Cancel")
    IfWinNotExist, ahk_id HtmlMsgBox
        NeutronMsgBox.Show(Size)
    
    Return
    
    HtmlMsgBoxClose:
        ;NeutronMsgBox.qs(MsgboxIconElId).classList.remove("d-block")
        ;NeutronMsgBox.qs(MsgboxIconElId).classList.add("d-none")
        ;NeutronMsgBox.Gui("Cancel")
        NeutronMsgBox.Destroy()     ;Free memory
        Gui, Destroy
    Return
}

DisplayAlertMsg(Text := "", ColorClass := "", Timeout := 2500) {
    randId := "close-alert-btn-" . A_TickCount
    
    html =
    (LTrim
    <div class="row justify-content-md-center">
        <div id="alert-box" class="alert alert-dismissible %ColorClass% z-depth-2 fade show" role="alert" auto-close="5000">
            <p id="alert-box-content" style="margin: 0;">%Text%</p>
            <span id="%randId%" type="button" class="close" data-dismiss="alert" style="padding: 2px 10px 0 0;"><i class="fas fa-xs fa-times"></i></span>
        </div>
    </div>
    )
    NeutronWebApp.qs("#alert-box-container").insertAdjacentHTML("afterbegin", html)
    
    NeutronWebApp.wnd.autoCloseAlertMsg(randId, Timeout)    ;JS func
    ;Fn := Func("AutoCloseAlertMsg").Bind(randId)
    ;SetTimer, %Fn%, -%Timeout%
}

DisplayProgCard(Result) {
    If (Result.HasNames && Result.HasRows) {
        NeutronWebApp.doc.getElementById("search-result-container").innerHTML := ""     ;Delete all old result before display new result
        
        programData := DataBaseTableToObject(Result)
        
        Loop, % programData.Length()
        {
            progDBId := programData[A_Index].prog_id
            progFullName := programData[A_Index].prog_full_name
            progStatus := programData[A_Index].prog_status
            buildNum := programData[A_Index].prog_build_number
            pcbNum := programData[A_Index].prog_pcb_number
            currentECO := programData[A_Index].prog_current_eco
            currentECL := programData[A_Index].prog_current_ecl
            dateTimeCreated := programData[A_Index].prog_date_created
            dateTimeUpdated := programData[A_Index].prog_date_updated
            machineBrandName := programData[A_Index].prog_aoi_machine
            progAltType := programData[A_Index].prog_alternate_type
            progSubsName := programData[A_Index].prog_substitute
            progLibName := programData[A_Index].prog_library_name = "" ? "N/A" : programData[A_Index].prog_library_name
            
            pcbPartStatus := programData[A_Index].pcb_part_status
            
            progStatusClass := progStatus = "USABLE" ? "pro-card-status-useable" : progStatus = "NEED UPDATE" ? "pro-card-status-needupdate" : progStatus = "NOT READY" ? "pro-card-status-notready" : progStatus = "IN PROGRESS" ? "pro-card-status-inprogress" : progStatus = "SUBSTITUTE" ? "pro-card-status-substitute" : ""
            brandLogoPath := machineBrandName = "YesTech" ? "yestech-logo.png" : machineBrandName = "TRI" ? "rti-logo.png" : "default-brand-icon.png"
            partStatusColor := pcbPartStatus = "ACTIVE" ? "green" : pcbPartStatus = "BETA" ? "indigo" : pcbPartStatus = "OBSOLETE" ? "deep-orange" : pcbPartStatus = "USE UP" ? "yellow" : pcbPartStatus = "LAST-TIME BUY" ? "teal" : pcbPartStatus = "NO DESIGN" ? "brown" : "grey"
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
            If (progSubsName != "")
                progFullName := progFullName . "<span class='red-text'> (=> " . progSubsName . ")</span>"
                
            html =
            (Ltrim
            <div id="%progDBId%" type="button" class="prog-card card p-1 pl-2 mb-2 %progStatusClass% fast animated bounceInDown hoverable toggle-modal" style="max-width: 99`%; height: 60px;" data-target="#prog-card-modal" onclick="ahk.DisplayProgCardModal(this)">
                <div class="row">
                    <div class="col-md-10">
                        <div class="row">
                            <h6 class="col-sm pt-1 prog-card-title">%buildNum%</h6>
                            <div class="col-sm">
                                <span class="badge badge-dark">%progAltType%</span>
                            </div>
                            <h6 class="col-sm pt-1 prog-card-title">%currentECL%</h6>
                            <h6 class="col-sm pt-1 prog-card-title">%currentECO%</h6>
							<div class="col-sm pt-1 prog-card-title">
                                <span class="badge %partStatusColor%" style="font-size: 14px;">%pcbNum%</span>
                            </div>
						</div>
						<div class="row">
							<p class="col-sm-4 text-muted prog-card-subtitle">%progFullName%</p>
                            <p class="col-sm text-muted prog-card-subtitle"><i class="fas fa-calendar-plus"></i> %dateCreated%</p>
                            <p class="col-sm text-muted prog-card-subtitle"><i class="fas fa-calendar-check"></i> %dateUpdated%</p>
                            <p class="col-sm text-muted prog-card-subtitle"><i class="fas fa-folder"></i> %progLibName%</p>
						</div>
					</div>
					<div class="col-md-2" style="">
                        <img id="prog-card-brand-logo" src="%brandLogoPath%" class="rounded mx-auto d-block img-fluid z-depth-1" style="margin-top: -7px; z-index: 80;" width="65" height="65">
					</div>
				</div> 
            </div>
            )
            NeutronWebApp.qs("#search-result-container").insertAdjacentHTML("beforeend", html)
            
            ;;;Create modal for each programcard
        }
    }
}

DisplayProgCardModal(neutron, event) {
    NeutronWebApp.wnd.activateProgCardFirstTab()    ;JS function
    ;NeutronWebApp.qs("#prog-card-modal-title").innerHTML := event.id
    
    ;;Get data from DB
    SQL := "SELECT * FROM aoi_programs LEFT JOIN aoi_pcbs ON aoi_pcbs.pcb_number = aoi_programs.prog_pcb_number LEFT JOIN users ON users.user_id = aoi_programs.prog_created_by  LEFT JOIN aoi_builds ON aoi_builds.build_number = aoi_programs.prog_build_number WHERE prog_id=" . event.id
    If !AOI_Pro_DB.GetTable(SQL, ProgCardData) {
        DisplayAlertMsg("Execute SQL statement FAILED!!! Could not get data!", "alert-danger")
    }

    If (!ProgCardData.HasRows) {
        DisplayAlertMsg("Display failed! Got empty Result Set.", "alert-danger")
    }
    
    programData := DataBaseTableToObject(ProgCardData)
    
    ;;;Save data to var
    ;;Table 1
    pcmProgName := programData[1].prog_full_name
    pcmProgStatus := programData[1].prog_status
    pcmProgBuildNum := programData[1].prog_build_number
    pcmProgPcbNum := programData[1].prog_pcb_number
    pcmProgCurntEco := programData[1].prog_current_eco
    pcmProgCurntEcl := programData[1].prog_current_ecl
    pcmProgDateCre := programData[1].prog_date_created
    pcmProgAoiMa := programData[1].prog_aoi_machine
    pcmProgAltType := programData[1].prog_alternate_type
    pcmProgSubsName := programData[1].prog_substitute
    ;;Table 2
    pcmPcbStatus := programData[1].pcb_part_status
    pcmPcbFullName := programData[1].pcb_full_name = "" ? "*No Info In Database*" : programData[1].pcb_full_name
    pcmPcbInsFileName := programData[1].pcb_ins_file_name
    pcmPcbQty := programData[1].pcb_quantity_onhand
    pcmPcbDwg := programData[1].pcb_dwg_number
    ;;Table 3
    pcmUserFn := programData[1].user_firstname
    pcmUserLn := programData[1].user_lastname
    ;;Table 4
    pcmBuildName := programData[1].build_name
    pcmBuildCost := programData[1].build_cost
    pcmBuildQnty := programData[1].build_quantity_onhand
    pcmBuildStatus := programData[1].build_part_status
    
    ;;Get data from _build_eco_history
    SQL := "SELECT * FROM _build_eco_history WHERE build_number='" . pcmProgBuildNum . "' ORDER BY date_effect DESC"
    If !AOI_Pro_DB.GetTable(SQL, ProgCardBuildECOHistData) {
        DisplayAlertMsg("Execute SQL statement FAILED!!! Could not get data from <_build_eco_history>!", "alert-danger")
    }
    
    RegExMatch(pcmProgCurntEcl, "^\w{1}", fstCharEcl)
    pcmProgBuildNumWEcl .= pcmProgBuildNum "" fstCharEcl
    ;;Auto Update Table aoi_pcbs
    
    Run, %ComSpec% /c start C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\aoi-pro-man_autoUpdateDBTable.exe %pcmProgPcbNum% "aoi_pcbs" %MainDBFilePath% %MainSettingsFilePath% %GUID1%, , Hide
    ;;Auto Update Table aoi_builds
    Run, %ComSpec% /c start C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\aoi-pro-man_autoUpdateDBTable.exe %pcmProgBuildNumWEcl% "aoi_builds" %MainDBFilePath% %MainSettingsFilePath% %GUID1%, , Hide
    
    progStatusColor := pcmProgStatus = "USABLE" ? "#00c853" : pcmProgStatus = "NEED UPDATE" ? "#673ab7" : pcmProgStatus = "NOT READY" ? "#ff3d00" : pcmProgStatus = "IN PROGRESS" ? "#fbc02d" : pcmProgStatus = "SUBSTITUTE" ? "#9e9e9e" : "black"
    brandLogoPath := pcmProgAoiMa = "YesTech" ? "yestech-logo.png" : pcmProgAoiMa = "TRI" ? "rti-logo.png" : "default-brand-logo.png"
    If (pcmProgDateCre != "")
        FormatTime, dateCreated, % pcmProgDateCre , MMMM dd, yyyy
    isAlternate := pcmProgAltType = "" ? "" : " <span class='badge black'>Alternative</span>"
    
    ;;Display Data on First Tab
    If (pcmProgSubsName = "") {
        NeutronWebApp.qs("#prog-card-modal-title").innerHTML := pcmProgName . isAlternate
        NeutronWebApp.wnd.getBackOldModalCardProgInfoContent()      ;JS function
    } Else {
        NeutronWebApp.qs("#prog-card-modal-title").innerHTML := pcmProgName . isAlternate . " <span class='red-text'>(USE => " . pcmProgSubsName . ")</span>"
        NeutronWebApp.qs("#prog-card-main-info-group").innerHTML := "<h6 class='prog-card-title red-text'>This program is the same with " . pcmProgSubsName . "<br>So ...Use it instead!</h6> <h6 class='prog-card-title'>Noted that program <span class='red-text'>" . pcmProgSubsName . "</span> might need ECO updates.<br>Make sure to verify that before you use!</h6>"
    }  
    NeutronWebApp.qs("#prog-card-modal-header").style.backgroundColor := progStatusColor
    NeutronWebApp.qs("#prog-card-modal-buildnum").innerHTML := pcmProgBuildNum
    NeutronWebApp.qs("#prog-card-modal-eclnum").innerHTML := pcmProgCurntEcl
    NeutronWebApp.qs("#prog-card-modal-econum").innerHTML := pcmProgCurntEco
    NeutronWebApp.qs("#prog-card-modal-pcbnum").innerHTML := pcmProgPcbNum
    ;NeutronWebApp.qs("#prog-card-modal-pcb-btn").innerHTML := pcmProgPcbNum = "" ? "????????" : pcmProgPcbNum
    NeutronWebApp.qs("#prog-card-stat-label").innerHTML := "<span class='badge' style='background-color: " . progStatusColor . "'>" . pcmProgStatus . "</span>"
    NeutronWebApp.qs("#prog-card-modal-brand-logo").src := brandLogoPath
    NeutronWebApp.qs("#prog-card-rtf-note").innerHTML := "<a href='#' onclick='ahk.OpenRTFNote(event)'>Notes.rtf</a>"
    NeutronWebApp.qs("#prog-card-date-created").innerHTML := dateCreated
    NeutronWebApp.qs("#prog-card-alt-type").innerHTML := isAlternate := pcmProgAltType = "" ? "<span class='badge mdb-color'>ORIGINAL</span>" : "<span class='badge black'>" . pcmProgAltType . "</span>"
    NeutronWebApp.qs("#prog-card-created-by").innerHTML := pcmUserFn . " " . pcmUserLn
    
    ;;Display Data on Second Tab
    buildStatusColor := pcmBuildStatus = "ACTIVE" ? "green" : pcmBuildStatus = "BETA" ? "indigo" : pcmBuildStatus = "OBSOLETE" ? "deep-orange" : pcmBuildStatus = "USE UP" ? "yellow" : pcmBuildStatus = "LAST-TIME BUY" ? "teal" : pcmBuildStatus = "NO DESIGN" ? "brown" : "grey"
    NeutronWebApp.qs("#prog-card-modal-build-name").innerHTML := pcmBuildName . "  <span class='pricetag z-depth-1 default-mouse'>$" . pcmBuildCost . "</span>"
    NeutronWebApp.qs("#prog-card-modal-build").innerHTML := pcmProgBuildNum
    NeutronWebApp.qs("#prog-card-modal-build-status").innerHTML := "Status: <span class='badge " . buildStatusColor . "'>" . pcmBuildStatus . "</span>"
    NeutronWebApp.qs("#prog-card-modal-build-instock").innerHTML := pcmBuildQnty . " (pcs)"
    NeutronWebApp.qs("#prog-card-modal-build-eco-hist").innerHTML := ""     ;Delete all old result before display new result
    
    If (ProgCardBuildECOHistData.HasRows) {
        Loop, % ProgCardBuildECOHistData.RowCount
        {
            progHere := "<i class='fas fa-lg fa-caret-left'></i>&nbsp;<span class='badge' style='background-color: " . progStatusColor . "'>" . pcmProgName . "</span>"
            ProgCardBuildECOHistData.Next(Row)
            Loop, % ProgCardBuildECOHistData.ColumnCount
            {
                If (A_Index = 2)
                    eco := Row[A_Index]
                If (A_Index = 3)
                    ecl := Row[A_Index]
                If (A_Index = 4)
                    dateTimeEfft := Row[A_Index]
            }
            If (eco != pcmProgCurntEco)
                progHere := ""
            If (dateTimeEfft != "") {
                FormatTime, dateEfft, %dateTimeEfft%, MMMM dd, yyyy
                FormatTime, timeEfft, %dateTimeEfft%, hh:mm:ss tt
            } Else {
                dateEfft := "N/A"
            }
            html = 
            (LTrim
            <div class='row no-gutters' style='margin-left: 0.5px; height: 23px;'>
                <p class='col-sm-4 text-muted'>%dateEfft% - %timeEfft%</p>
                <p class='col-sm-3 text-muted'>Added ECO: <span id='eco-%eco%'><a href='#' onclick='ahk.OpenPdfEco(event)'>%eco%</a></span></p>
                <p class='col-sm-5 text-muted'>ECL: <strong>%ecl%</strong> %progHere%</p>
            </div>
            )
            NeutronWebApp.qs("#prog-card-modal-build-eco-hist").insertAdjacentHTML("beforeend", html)
        }
    }
    
    ;;Display Data on Third Tab
    pcbStatusColor := pcmPcbStatus = "ACTIVE" ? "green" : pcmPcbStatus = "BETA" ? "indigo" : pcmPcbStatus = "OBSOLETE" ? "deep-orange" : pcmPcbStatus = "USE UP" ? "yellow" : pcmPcbStatus = "LAST-TIME BUY" ? "teal" : pcmPcbStatus = "NO DESIGN" ? "brown" : "grey"
    NeutronWebApp.qs("#prog-card-modal-pcb-name").innerHTML := pcmPcbFullName " | " pcmProgPcbNum
    NeutronWebApp.qs("#prog-card-modal-pcb").innerHTML := pcmProgPcbNum
    NeutronWebApp.qs("#prog-card-modal-pcb-status").innerHTML := "Status: <span class='badge " . pcbStatusColor . "'>" . pcmPcbStatus . "</span>"
    NeutronWebApp.qs("#prog-card-modal-pcb-dwg").innerHTML := pcmPcbDwg
    NeutronWebApp.qs("#prog-card-modal-pcb-quant").innerHTML := pcmPcbQty . " (pcs)"
    NeutronWebApp.qs("#prog-card-ins-file").innerHTML := "<a href='http://virtu.multitech.prv:4080/Data/PCB_Assembly_Data/" . pcmPcbInsFileName . "' target='_blank'>" . pcmPcbInsFileName . "</a>"
    NeutronWebApp.qs("#prog-card-assem-draw").innerHTML := "<a href='#' onclick='ahk.OpenAssemDraw(event)'>" . pcmProgPcbNum . "_AssemblyDrawing.PDF</a>"
}

OpenRTFNote(neutron, event) {
    MsgBox OPENNING FILE!
}

OpenAssemDraw(neutron, event) {
    MsgBox OPENNING ASSEMBLY DRAWING!
}

OpenPdfEco(neutron, event) {
    ecoToOpen := event.target.innerHTML
    ecoUrl := "http://virtu.multitech.prv:4080/eco/" . ecoToOpen . "/" . ecoToOpen . ".pdf"
    ecoUrlOld := "http://virtu.multitech.prv:4080/eco/ECO'S Prior to 8-16-19/" . ecoToOpen . ".pdf"
    NeutronWebApp.qs("#eco-" . ecoToOpen).innerHTML := "Openning..."
    ecoTempFilePath := A_MyDocuments . "\ecoTemp.pdf"
    If checkIfUrlAvailable(ecoUrl) {
        UrlDownloadToFile, %ecoUrl%, %ecoTempFilePath%
        If (ErrorLevel = 0)
            Run, %ecoTempFilePath%, , Hide
        Else
            DisplayAlertMsg("Could not open ECO file! COMPFIND not connected!", "alert-danger")
    } Else {
        If checkIfUrlAvailable(ecoUrlOld) {
            UrlDownloadToFile, %ecoUrlOld%, %ecoTempFilePath%
            If (ErrorLevel = 0)
                Run, %ecoTempFilePath%, , Hide
            Else
                DisplayAlertMsg("Could not open ECO file! COMPFIND not connected!", "alert-danger")
        } Else {
            DisplayAlertMsg("Could not open ECO file! FILE NOT FOUND!", "alert-danger")
        }
    }
    NeutronWebApp.qs("#eco-" . ecoToOpen).innerHTML := "<a href='#' onclick='ahk.OpenPdfEco(event)'>" . ecoToOpen . "</a>"
}

DisplayTaskCard(Data) {
    If (Data.HasNames) {
        NeutronWebApp.doc.getElementById("task-card-container").innerHTML := ""     ;Delete all old result before display new result
        
        taskData := DataBaseTableToObject(Data)
        
        Loop, % taskData.Length()
        {
            taskId := taskData[A_Index].task_id
            taskType := taskData[A_Index].task_type
            taskStatus := taskData[A_Index].task_status
            taskCreatedBy := taskData[A_Index].task_created_by
            taskDateTimeCreated := taskData[A_Index].task_date_created
            taskDateTimeDue := taskData[A_Index].task_due_date
            taskProgrsJson := taskData[A_Index].task_progress
            progName := taskData[A_Index].prog_full_name
            progAoiMachine := taskData[A_Index].prog_aoi_machine
            
            cardBorderColor := (taskType = "ECO Update") ? "#673ab7" : (taskType = "Create New Program") ? "#ff3d00" : "black"
            taskStatusColorClass := (taskStatus = "IN PROGRESS") ? "yellow darken-2" : (taskStatus = "NOT STARTED") ? "brown lighten-2" : (taskStatus = "FINISHED") ? "green darken-2" : "black"
            taskDateCreated := changeFormatDateTime(taskDateTimeCreated, "Date")
            taskDateDue := changeFormatDateTime(taskDateTimeDue, "Date")
            taskProgrsObj := JSON.Load(taskProgrsJson)
            taskProgrPercentage := calculateTaskProgrPercentage(taskProgrsObj)
            
            ;;;;Display in HTML
            html =
            (LTrim
            <div id="%taskId%" type="button" class="task-card card pt-1 pl-2 mb-2 fast animated bounceInRight hoverable" style="max-width: 99`%; border-top: 12px solid %cardBorderColor%;" data-toggle="modal" data-target="#task-card-modal" onclick="ahk.DisplayTaskCardModal(this)">
                <div class="row">
                    <div class="col-md-10 pl-4">
                        <div class="row">
                            <h6 class="col-sm task-card-title">%taskType%</h6>  
                            <div class="col-sm">
                                <span class="badge %taskStatusColorClass%">%taskStatus%</span>
                            </div>
                            <h6 class="col-sm task-card-title">%progName%</h6>
                        </div>
                        <div class="row">
                            <h6 class="task-date-created col-sm text-muted prog-card-subtitle"><i class="fas fa-calendar-plus"></i> %taskDateCreated%</h6>
                            <h6 class="col-sm text-muted prog-card-subtitle"><i class="fas fa-calendar-day"></i> %taskDateDue%</h6>
                            <h6 class="col-sm text-muted prog-card-subtitle"><i class="fas fa-user-plus"></i> %taskCreatedBy%</h6>
                            <h6 class="col-sm text-muted prog-card-subtitle"><i class="fas fa-chalkboard"></i> %progAoiMachine%</h6>
                        </div>
                        <div class="row">
                            <h6 class="col-sm text-muted prog-card-subtitle"><i class="fas fa-users"></i> <span class="badge badge-pill info-color-dark">VH</span></h6>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="c100 p%taskProgrPercentage% x-small">
                            <span>%taskProgrPercentage%`%</span>
                            <div class="slice">
                                <div class="bar"></div>
                                <div class="fill"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            )
            
            NeutronWebApp.qs("#task-card-container").insertAdjacentHTML("beforeend", html)
        }
    }
}

GetTaskCard(neutron, event, cardType, amountNum := 0) {
    numOfTaskCards := (amountNum == "All") ? -1 : amountNum    ;Number of task cards to be displayed
    NeutronWebApp.qs("#amount-icon-label").innerHTML := amountNum
    sortIconLabel := NeutronWebApp.qs("#sort-icon-label").innerHTML = "Latest" ? "DESC" : NeutronWebApp.qs("#sort-icon-label").innerHTML = "Oldest" ? "ASC" : "DESC"
    
    ;;Get data from DB
    If (cardType == "Active")
        SQL := "SELECT * FROM user_tasks LEFT JOIN users ON task_assigned_by=user_id LEFT JOIN aoi_programs ON task_aoi_program=prog_id WHERE task_status IN ('NOT STARTED','IN PROGRESS') ORDER BY task_date_created " . sortIconLabel . " LIMIT " . numOfTaskCards
    
    If !AOI_Pro_DB.GetTable(SQL, ResultSet) {
        DisplayAlertMsg("Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    DisplayTaskCard(ResultSet)
}

SortTaskCard(neutron, event, action := "", item := "") {
    taskCardListEl := NeutronWebApp.doc.getElementById("task-card-container")
    cardList := taskCardListEl.getElementsByClassName("task-card")
    
    If (action == "sort") {
        NeutronWebApp.qs("#sort-icon-label").innerHTML := item
        cardListArray := []
        Loop, % cardList.length
        {   
            ;cardList[A_Index - 1].classList.remove("animated")
            cardListArray.Push(cardList[A_Index - 1].outerHTML)     ;;Convert JS NodeList to AHK Array
        }
        
        If (item == "Latest") {
            reverseArray(cardListArray)
            NeutronWebApp.qs("#task-card-container").innerHTML := ""
            Loop, % cardListArray.length()
                NeutronWebApp.qs("#task-card-container").insertAdjacentHTML("beforeend", cardListArray[A_Index])
            NeutronWebApp.qs("#drop-item-latest").classList.add("d-none")
            NeutronWebApp.qs("#drop-item-oldest").classList.remove("d-none")
            
        } Else If (item == "Oldest") {
            reverseArray(cardListArray)
            NeutronWebApp.qs("#task-card-container").innerHTML := ""
            Loop, % cardListArray.length()
                NeutronWebApp.qs("#task-card-container").insertAdjacentHTML("beforeend", cardListArray[A_Index])
            NeutronWebApp.qs("#drop-item-latest").classList.remove("d-none")
            NeutronWebApp.qs("#drop-item-oldest").classList.add("d-none")
        }
    }
}

DisplayTaskCardModal(neutron, event) {
    ;;Get data from DB
    SQL := "SELECT * FROM user_tasks LEFT JOIN users ON task_assigned_by=user_id LEFT JOIN aoi_programs ON task_aoi_program=prog_id WHERE task_id=" . event.id
    If !AOI_Pro_DB.GetTable(SQL, TaskCardData) {
        DisplayAlertMsg("Execute SQL statement FAILED!!! Could not get data!", "alert-danger")
    }
    
    If (!TaskCardData.HasRows) {
        DisplayAlertMsg("Display failed! Got empty Result Set.", "alert-danger")
    }
    
    taskTableData := DataBaseTableToObject(TaskCardData)
    
    ;;Save data to variable
    
    ;;Processing data
    titleBarColor := (taskTableData[1].task_type = "ECO Update") ? "#673ab7" : (taskTableData[1].task_type = "Create New Program") ? "#ff3d00" : "black"
    
    ;;Display data in HTML
    NeutronWebApp.qs("#task-card-modal-header").style.backgroundColor := titleBarColor
    NeutronWebApp.qs("#task-card-modal-title").innerHTML := taskTableData[1].task_type
}

UserLogin(neutron, event) {
    ;NeutronWebApp.qs("#loginBttn").innerHTML := "<i class='fas fa-2x fa-spinner fa-pulse'></i>"
    event.preventDefault()  ;Prevent form redirected page!
    formData := NeutronWebApp.GetFormData(event.target)
    
    For elId, value in formData
    {
        If (elId == "inputUserN")
            inputUserName := value
        If (elId == "inputPw")
            inputPassword := value
    }
    
    If (inputUserName = "" || inputPassword = "") {
        If (inputUserName = "") {
            NeutronWebApp.qs("#inputUserN").classList.add("is-invalid")
            NeutronWebApp.qs("#inputUserNFbIn").innerHTML := "Please type username!"
        }
        If (inputPassword = "") {
            NeutronWebApp.qs("#inputPw").classList.add("is-invalid")
            NeutronWebApp.qs("#inputPwFbIn").innerHTML := "Please type password!"
        }
        Return
    }
    
    If (validateUserLogin(inputUserName, inputPassword) == "USER NOT EXIST") {
        NeutronWebApp.qs("#inputUserN").classList.add("is-invalid")
        NeutronWebApp.qs("#inputUserNFbIn").innerHTML := "User is not exist!"
        Return
    }
    If (validateUserLogin(inputUserName, inputPassword) == "WRONG PASSWORD") {
        NeutronWebApp.qs("#inputPw").classList.add("is-invalid")
        NeutronWebApp.qs("#inputPwFbIn").innerHTML := "Wrong password!"
        NeutronWebApp.qs("#inputPw").value := ""
        Return
    }
    If (ResultSet := validateUserLogin(inputUserName, inputPassword)) {
        userData := DataBaseTableToObject(ResultSet)
        IsUserLogin := True
        UserInfo.userFirstName := userData[1].user_firstname
        UserInfo.userRole := userData[1].user_role
    }
    
    DisplayAlertMsg("Welcome " . UserInfo.userFirstName . "!", "alert-success")
    NeutronWebApp.qs("#inputUserN").value := ""
    NeutronWebApp.qs("#inputPw").value := ""
    changeUserLoginDisplay("UNLOCKED")
    GetTaskCard("", "", "Active", 10)
}

UserLogout(neutron, event) {
    IsUserLogin := False
    UserInfo := {userId: "???", userFirstName: "???", userLastName: "???", userInitial: "???", userUserName: "???", userPassword: "???", userRole: "N/A"}
    changeUserLoginDisplay("LOCKED")
    DisplayAlertMsg("You've been logged out. Bye!", "alert-success")
}

validateUserLogin(username, password) {
    ;;Get User from database
    SQL := "SELECT * FROM users WHERE user_username='" . username . "'"
    If !AOI_Pro_DB.Query(SQL, RS)
        DisplayAlertMsg("Failed to connect to Database!", "alert-danger")
    
    If !RS.HasRows
        Return "USER NOT EXIST"
    Else {
        SQL := "SELECT * FROM users WHERE user_username='" . username . "' AND user_password='" . password . "'"
        If !AOI_Pro_DB.GetTable(SQL, RS)
            DisplayAlertMsg("Failed to connect to Database!", "alert-danger")
        If !RS.HasRows
            Return "WRONG PASSWORD"
    }
    Return RS
}

changeUserLoginDisplay(status) {
    If (status = "UNLOCKED") {
        If (IsUserLogin) {
            NeutronWebApp.wnd.hideModal("#auth-container")
            ;NeutronWebApp.qs("#auth-container").style.display := "none"
            loginDivs := NeutronWebApp.qsa(".auth-container")
            for index, loginDiv in NeutronWebApp.Each(loginDivs)
                loginDiv.innerText := ""
            
            NeutronWebApp.qs("#nav-task-tab").classList.remove("left-nav-link-lock")
            NeutronWebApp.qs("#nav-database-tool-tab").classList.remove("left-nav-link-lock")
            
            userRole := UserInfo.userRole
            
            html = 
            (LTrim
			<div class="mr-3" type="button" data-toggle="dropdown"><a class="badge badge-pill badge-default"><i id="userTopBtnLabel" class="fas fa-user mr-1"></i>%userRole%</a></div>
			<div class="dropdown-menu" style='font-size: 14px;'>
			  <a class="dropdown-item pt-0 pb-0" href="#"><i class="fas fa-user-cog"></i> User Settings</a>
			  <div class="dropdown-divider"></div>
			  <a class="dropdown-item pt-0 pb-0" href="#" onclick='ahk.UserLogout(event)'><i class="fas fa-sign-out-alt"></i> Logout</a>
			</div>
            )
            NeutronWebApp.qs("#userTopBtn").innerHTML := ""
            NeutronWebApp.qs("#userTopBtn").insertAdjacentHTML("beforeend", html)
        }
    }
    
    If (status = "LOCKED") {
        If (!IsUserLogin) {
            ;;<div class="mr-3" type="button"><a class="badge badge-pill bg-app-theme-light" onclick="toggleLoginForm()"><i id="userTopBtnLabel" class="fas fa-lock mr-1"></i>Login</a></div>
            html = 
            (LTrim
			<div class="mr-3" type="button"><a class="badge badge-pill bg-app-theme-light" data-toggle="modal" data-target="#auth-container"><i id="userTopBtnLabel" class="fas fa-lock mr-1"></i>Login</a></div>
            )
            NeutronWebApp.qs("#userTopBtn").innerHTML := ""
            NeutronWebApp.qs("#userTopBtn").insertAdjacentHTML("beforeend", html)
        
        
            NeutronWebApp.qs("#nav-task-tab").classList.add("left-nav-link-lock")
            NeutronWebApp.qs("#nav-database-tool-tab").classList.add("left-nav-link-lock")
            NeutronWebApp.qs("#auth-container").style.display := "none"
            
            html =
            (LTrim
            <div class='auth-container'>
                <div class='login-overlay'>
                    <h2 class='text-white pl-3 pt-4'><i class="fas fa-lock"></i> You must login to use this feature!</h2>
                <div>
            </div>
            )
            
            ;NeutronWebApp.qs("#task-tab").insertAdjacentHTML("afterbegin", html)
            NeutronWebApp.qs("#database-tab").insertAdjacentHTML("afterbegin", html)
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
         [Main]
         DllPath=C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\SQLite3.dll
        ), %MainSettingsFilePath%
    }
    IfExist, %MainSettingsFilePath%
    {
        IniRead, out1, %MainSettingsFilePath%, Settings, MainDBFilePath
        MainDBFilePath := out1
    }
}

checkAnURLStatus(url, timeout := 1000) {
    cmd := "ping " . url . " -n 1 -w " . timeout
    RunWait, %cmd%,, Hide
    if (ErrorLevel = 1) {
        return False
    }
    if (ErrorLevel = 0) {
        return True
    }
}

checkIfUrlAvailable(url) {
    tempCheckHtmlFilePath := A_MyDocuments . "\checkHtml.html"
    UrlDownloadToFile, %url%, %tempCheckHtmlFilePath%
    FileRead, outVar, %tempCheckHtmlFilePath%
    IfInString, outVar, 404 - File or Directory not found
        Return False
    Else
        Return True
}

changeFormatDateTime(InDateTime, type := "") {
    returnVar := "N/A"
    if (type == "Date" && InDateTime != 0 && InDateTime != "") {
        FormatTime, returnVar, %InDateTime%, MMM dd, yyyy
    } else if (type == "Time" && InDateTime != "" && InDateTime != 0) {
        FormatTime, returnVar, %InDateTime%, hh:mm:ss tt
    }
    
    return returnVar
}

calculateTaskProgrPercentage(JsonObj) {
    totalItem := JsonObj.items.Length()
    totalItemDone := 0
    
    Loop, % totalItem
    {
        If (JsonObj.items[A_Index].done)
            totalItemDone++
    }
    percentage := (totalItemDone / totalItem) * 100
    
    return Round(percentage)
}

autoUpdatePcbDBTable(pcbNum) {
    ;;Get data from the web
    Try {
        req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;Create request object for http request
        url := "http://virtu.multitech.prv:4080/compfind/partdetails.asp?MTSPN=" . pcbNum
        
        req.open("GET", url, True)
        req.Send()
    } Catch {
        DisplayAlertMsg("Could not connect to CompFind!" . AOI_Pro_DB.ErrorMsg, "alert-danger", 4000)
    }
    
    Loop, 50
    {
        Sleep 1000
        if (A_Index = 50) {
            MsgBox Failed to connect to CompFinder!!
            Return 0
        } else if (req.readyState = 4){
            Break
        }
    }
    
    response := RegExReplace(req.responseText, "<.+?>", "")
    response := RegExReplace(response, "`am)^\s+|\h+$|\R\z")    ;Remove all blank lines
    req.Abort()     ;;Close the request object
    
    Loop, Parse, response, `n
    {
        If (RegExMatch(A_LoopField, "Component Finder cannot find any manufacturer parts") = 1) {
            DisplayAlertMsg("SYS: Update aoi_pcbs table Failed!<br>ERR: Not found or Wrong PCB number parameter!", "alert-danger")
            Return 0
        }
        
        If (RegExMatch(A_LoopField, ".*Rev..*") = 1)
            pcbFullName :=  A_LoopField
        If (A_Index = 15) {
            pcbPartStatus := Format("{:U}", A_LoopField)
            StringReplace, pcbPartStatus, pcbPartStatus, `r,, All   ;;;Get rid of the newline character
        }
            
        If (A_Index = 21)
            pcbQuantity :=  RegExReplace(A_LoopField, ",", "")
        If (RegExMatch(A_LoopField, ".*_INS.TXT") = 1) {
            pcbInsFileName :=  A_LoopField
            RegExMatch(pcbInsFileName, "\d{3}", pcbDwgNum)
        }
            
    }
    MsgBox % pcbPartStatus "--> " StrLen(pcbPartStatus)
    ;;;Update or Insert to Database
    SQL := "SELECT * FROM aoi_pcbs WHERE pcb_number = '" . pcbNum . "'"
    If !AOI_Pro_DB.Query(SQL, ResultSet) {
        DisplayAlertMsg("SYS: Update aoi_pcbs table Failed!<br>Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    If (!ResultSet.HasRows) {    ;If cannot find record in Database then Insert new record
        SQL := "INSERT INTO aoi_pcbs VALUES('" . pcbNum . "', '" . pcbPartStatus . "', '" . pcbFullName . "', '', '" . pcbInsFileName . "', " . pcbQuantity . ", " . pcbDwgNum . ")"
        
        If !AOI_Pro_DB.Exec(SQL)
            DisplayAlertMsg("SYS: Update aoi_pcbs table Failed!<br>Failed to INSERT record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg . " (ErrCODE: " . AOI_Pro_DB.ErrorCode . ")", "alert-danger")
    } Else {
        ;AOI_Pro_DB.Exec("BEGIN TRANSACTION;")
        SQL := "UPDATE aoi_pcbs SET pcb_part_status = '" . pcbPartStatus . "', pcb_quantity_onhand = " . pcbQuantity . " WHERE pcb_number = '" . pcbNum . "'"
        If !AOI_Pro_DB.Exec(SQL)
            DisplayAlertMsg("SYS: Update aoi_pcbs table Failed!<br>Failed to UPDATE record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg . " (ErrCODE: " . AOI_Pro_DB.ErrorCode . ")", "alert-danger", 5000)
        ;AOI_Pro_DB.Exec("COMMIT TRANSACTION;")
    }
}

;;;Convert MM dd, yyyy to YYYYMMDDHH24MISS
DateParse(str) {
	static e2 = "i)(?:(\d{1,2}+)[\s\.\-\/,]+)?(\d{1,2}|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\w*)[\s\.\-\/,]+(\d{2,4})"
	str := RegExReplace(str, "((?:" . SubStr(e2, 42, 47) . ")\w*)(\s*)(\d{1,2})\b", "$3$2$1", "", 1)
	If RegExMatch(str, "i)^\s*(?:(\d{4})([\s\-:\/])(\d{1,2})\2(\d{1,2}))?"
		. "(?:\s*[T\s](\d{1,2})([\s\-:\/])(\d{1,2})(?:\6(\d{1,2})\s*(?:(Z)|(\+|\-)?"
		. "(\d{1,2})\6(\d{1,2})(?:\6(\d{1,2}))?)?)?)?\s*$", i)
		d3 := i1, d2 := i3, d1 := i4, t1 := i5, t2 := i7, t3 := i8
	Else If !RegExMatch(str, "^\W*(\d{1,2}+)(\d{2})\W*$", t)
		RegExMatch(str, "i)(\d{1,2})\s*:\s*(\d{1,2})(?:\s*(\d{1,2}))?(?:\s*([ap]m))?", t)
			, RegExMatch(str, e2, d)
	f = %A_FormatFloat%
	SetFormat, Float, 02.0
	d := (d3 ? (StrLen(d3) = 2 ? 20 : "") . d3 : A_YYYY)
		. ((d2 := d2 + 0 ? d2 : (InStr(e2, SubStr(d2, 1, 3)) - 40) // 4 + 1.0) > 0
			? d2 + 0.0 : A_MM) . ((d1 += 0.0) ? d1 : A_DD) . t1
			+ (t1 = 12 ? t4 = "am" ? -12.0 : 0.0 : t4 = "am" ? 0.0 : 12.0) . t2 + 0.0 . t3 + 0.0
	SetFormat, Float, %f%
	Return, d
}

;;;;;;;;;;;;;;;;;;;;;;;;
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

reverseArray(array)
{
	arrayC := array.Clone()
	tempObj := {}
	for vKey in array
		tempObj.Push(vKey)
	vIndex := tempObj.Length()
	for vKey in array
		array[vKey] := arrayC[tempObj[vIndex--]]
	arrayC := tempObj := ""
    return array
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