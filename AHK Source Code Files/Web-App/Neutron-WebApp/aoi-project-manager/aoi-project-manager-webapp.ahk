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
NeutronWebApp.qs("#title-label").innerHTML := "AOI Project Manager"    ;;;;Set app title
ProcessIniFile()

;;Create instance of Messagebox Gui
Global NeutronMsgBox := new NeutronWindow()
NeutronMsgBox.Load("html_msgbox.html")
NeutronMsgBox.Gui("-Resize +LabelHtmlMsgBox +hWndHtmlMsgBox")

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
SetTimer, CheckWebSourceStatus, 400
autoUpdatePcbDBTable("13580620L")   ;;;DELETE ME!!!
Return  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;=======================================================================================;
;;;Callback Functions
AutoCloseAlertBox:
    ;NeutronWebApp.doc.getElementById("close-alert-btn").click()
    NeutronWebApp.qs("#alert-box").classList.remove("show")
    NeutronWebApp.qs("#alert-box-container").style.zIndex := "-99"
    SetTimer, AutoCloseAlertBox, Off
Return

CheckDataBaseStatus:
    ;ToolTip % NeutronWebApp.qs("#icon-database-status").className
    IfExist, %MainDBFilePath%
    {   
        Check_DB := new SQLiteDB()
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
    if (checkAnURLStatus("192.168.11.62")) {    ;;URL: virtu.multitech.prv
        NeutronWebApp.qs("#icon-web-status").classList.remove("icon-problem")
        NeutronWebApp.qs("#icon-web-status").classList.remove("icon-stopped")
        NeutronWebApp.qs("#icon-web-status").classList.add("icon-working")
    } else {
        NeutronWebApp.qs("#icon-web-status").classList.remove("icon-working")
        NeutronWebApp.qs("#icon-web-status").classList.remove("icon-problem")
        NeutronWebApp.qs("#icon-web-status").classList.add("icon-stopped")
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
    AOI_Pro_DB.CloseDB()
    NeutronWebApp.Destroy()     ;Free memory  
    Gui, Destroy
    ExitApp
Return
;=======================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;MAIN FUNCTION;;;;;;;;;;;;;;;;;;
TestBttn(neutron, event) {
    HtmlMsgBox("WARNING", , , "Test MsgBox", "HELLO! This is a message", 0)
    
    ;MsgBox HELLO FROM AHK
    ;NeutronWebApp.wnd.alert("Hi")
    ;DisplayAlertMsg("You click the button!!!!", "alert-success")
    ;SQL := "SELECT * FROM Users;"
    ;If !AOI_Pro_DB.GetTable(SQL, Result)
       ;MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    ;MsgBox % Result.ColumnCount
}

TestBttn2(neutron, event) {
    HtmlMsgBox("ERROR", , , "Test MsgBox", , 0)
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
    SQL := "SELECT * FROM aoi_programs WHERE prog_build_number LIKE '%" . searchInput . "%' OR prog_full_name LIKE '%" . searchInput . "%' OR prog_pcb_number LIKE '%" . searchInput . "%' OR prog_current_eco LIKE '%" . searchInput . "%' OR prog_current_ecl LIKE '%" . searchInput . "%' ORDER BY prog_pcb_number, prog_build_number ASC"
    
    If !AOI_Pro_DB.GetTable(SQL, Result) {
        DisplayAlertMsg("Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    RowCount := Result.RowCount
    NeutronWebApp.qs("#search-status-label").innerHTML := "Found " . RowCount . " result(s)"
    
    DisplayProgCard(Result)
    
}

OnEnter(neutron, event) {
    if (event.keyCode == 13 && event.srcElement.id == "prog-search-bar") {
        SearchProgram(neutron, event)
    }
}

OnConText(neutron, event) {
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
    
    Global MsgboxIconElId := Icon = "ERROR" ? "#msgbox-icon-error" : Icon = "INFO" ? "#msgbox-icon-info" : Icon = "CHECK" ? "#msgbox-icon-check" : Icon = "QUESTION" ? "#msgbox-icon-question" : Icon = "WARNING" ? "#msgbox-icon-warning" : ""
    
    NeutronMsgBox.qs(MsgboxIconElId).classList.remove("d-none")
    NeutronMsgBox.qs(MsgboxIconElId).classList.add("d-block")
    
    NeutronMsgBox.qs("#title-label").innerHTML := Title     ;;;;Set MsgBox title
    NeutronMsgBox.qs("#msgbox-main-text").innerHTML := MainText
    
    HTMLMsgboxHWND := NeutronMsgBox.HWND
    NeutronMsgBox.Gui("Cancel")
    IfWinNotExist, ahk_id HtmlMsgBox
        NeutronMsgBox.Show(Size)
    
    Return
    
    HtmlMsgBoxClose:
        NeutronMsgBox.qs(MsgboxIconElId).classList.remove("d-block")
        NeutronMsgBox.qs(MsgboxIconElId).classList.add("d-none")
        NeutronMsgBox.Gui("Cancel")
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
                    If (A_Index = 11)
                        dateTimeCreated := Row[A_Index]
                    If (A_Index = 15)
                        machineBrandName := Row[A_Index]
                    If (A_Index = 16)
                        progAltType := Row[A_Index]
                }
                
                progStatusClass := progStatus = "USABLE" ? "pro-card-status-useable" : progStatus = "NEEDUPDATE" ? "pro-card-status-needupdate" : progStatus = "NOTREADY" ? "pro-card-status-notready" : progStatus = "INPROGRESS" ? "pro-card-status-inprogress" : ""
                brandLogoPath := machineBrandName = "YesTech" ? "yestech-logo.png" : machineBrandName = "TRI" ? "rti-logo.png" : ""
                FormatTime, dateCreated, %dateTimeCreated%, MMM dd, yyyy
                FormatTime, timeCreated, %dateTimeCreated%, hh:mm:ss tt
                
                html =
                (Ltrim
                <div id="%progDBId%" type="button" class="prog-card card p-1 pl-2 mb-2 %progStatusClass% fast animated bounceInDown hoverable" style="max-width: 99`%; height: 60px;" data-toggle="modal" data-target="#prog-card-modal" onclick="ahk.DisplayProgCardModal(this)">
                    <div class="row">
                        <div class="col-md-10">
                            <div class="row">
                                <h6 class="col-sm pt-1 prog-card-title">%buildNum%</h6>
                                <div class="col-sm">
                                    <span class="badge badge-dark">%progAltType%</span>
                                </div>
                                <h6 class="col-sm pt-1 prog-card-title">%currentECL%</h6>
								<h6 class="col-sm pt-1 prog-card-title">%currentECO%</h6>
								<h6 class="col-sm pt-1 prog-card-title">%pcbNum%</h6>
							</div>
							<div class="row">
								<p class="col-sm text-muted prog-card-subtitle">%progFullName%</p>
                                <p class="col-sm text-muted prog-card-subtitle"><i class="fas fa-calendar-plus"></i> %dateCreated%</p>
							</div>
						</div>
						<div class="col-md-2" style="">
                            <img id="prog-card-brand-logo" src="%brandLogoPath%" class="rounded mx-auto d-block img-fluid z-depth-1" style="margin-top: -7px; z-index: 80;" width="65" height="65">
						</div>
					</div> 
                </div>
                )
                NeutronWebApp.qs("#search-result-container").insertAdjacentHTML("beforeend", html)
            }
        }
    }
}

DisplayProgCardModal(neutron, event) {
    ;NeutronWebApp.qs("#prog-card-modal-title").innerHTML := event.id
    ;;Get data from DB
    SQL := "SELECT * FROM aoi_programs WHERE prog_id = " . event.id
    If !AOI_Pro_DB.GetTable(SQL, ProgCardData) {
        DisplayAlertMsg("Execute SQL statement FAILED!!! Could not get data!", "alert-danger")
        Return
    }
    
    progStatusColor := ProgCardData.Rows[1][3] = "USABLE" ? "#00c853" : ProgCardData.Rows[1][3] = "NEEDUPDATE" ? "#673ab7" : ProgCardData.Rows[1][3] = "NOTREADY" ? "#ff3d00" : ProgCardData.Rows[1][3] = "INPROGRESS" ? "#fbc02d" : "???"
    
    ;;Display Data
    NeutronWebApp.qs("#prog-card-modal-title").innerHTML := ProgCardData.Rows[1][2]
    NeutronWebApp.qs("#prog-card-modal-header").style.backgroundColor := progStatusColor
    NeutronWebApp.qs("#prog-card-modal-buildnum").innerHTML := ProgCardData.Rows[1][4]
    NeutronWebApp.qs("#prog-card-modal-eclnum").innerHTML := ProgCardData.Rows[1][8]
    NeutronWebApp.qs("#prog-card-modal-econum").innerHTML := ProgCardData.Rows[1][7]
    NeutronWebApp.qs("#prog-card-modal-pcbnum").innerHTML := ProgCardData.Rows[1][5]
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

;autoGetPCBInfo(pcbNum) {
    ;;;RunWait, Taskkill /f /im iexplore.exe, , Hide   ;Fix bug where IE open many times
    ;wb := ComObjCreate("InternetExplorer.Application")
    ;wb.Visible := False
    ;url := "http://virtu.multitech.prv:4080/compfind/partdetails.asp?MTSPN=" . pcbNum
    ;wb.Navigate(url)
    ;IELoad(wb)
    ;
    ;Try 
        ;While (el := wb.document.getElementsByTagName("td")[A_Index]) 
        ;{
            ;if (A_Index = 4)
                ;pcbFullName :=  el.innerHTML
            ;if (A_Index = 10)
                ;pcbPartStatus :=  el.innerHTML
            ;if (A_Index = 16)
                ;pcbQuantity :=  el.innerHTML
            ;if (A_Index = 51) {
                ;pcbInsFileName := RegExReplace(el.innerHTML, "<.+?>")
            ;}
        ;}
    ;wb.Quit
    ;return pcbInfoList := {pcbFullName: pcbFullName, pcbPartStatus: pcbPartStatus, pcbQuantity: pcbQuantity, pcbInsFileName: pcbInsFileName}
;}

autoUpdatePcbDBTable(pcbNum) {
    ;;Get data from the web
    req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;Create request object for http request
    url := "http://virtu.multitech.prv:4080/compfind/partdetails.asp?MTSPN=" . pcbNum
    
    req.open("GET", url, False)
    req.Send()
    
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
            DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>ERR: Not found or Wrong PCB number parameter!", "alert-danger")
            Return 0
        }
        
        If (RegExMatch(A_LoopField, ".*Rev..*") = 1)
            pcbFullName :=  A_LoopField
        If (A_Index = 15)
            pcbPartStatus := Format("{:U}", A_LoopField)
        If (A_Index = 21)
            pcbQuantity :=  RegExReplace(A_LoopField, ",", "")
        If (RegExMatch(A_LoopField, ".*_INS.TXT") = 1)  
            pcbInsFileName :=  A_LoopField
    }
    
    ;;;Update or Insert to Database
    SQL := "SELECT * FROM aoi_pcb WHERE pcb_number = '" . pcbNum . "'"
    If !AOI_Pro_DB.Query(SQL, ResultSet) {
        DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    If (!ResultSet.HasRows) {    ;If cannot find record in Database then Insert new record
        SQL := "INSERT INTO aoi_pcb VALUES('" . pcbNum . "', '" . pcbPartStatus . "', '" . pcbFullName . "', '', '" . pcbInsFileName . "', " . pcbQuantity . ")"
        If !AOI_Pro_DB.Exec(SQL)
            DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Failed to INSERT record!", "alert-danger")
    } Else {
        SQL := "UPDATE aoi_pcb SET pcb_part_status = '" . pcbPartStatus . "', pcb_quantity_onhand = " . pcbQuantity . " WHERE pcb_number = '" . pcbNum . "'"
        Clipboard := SQL
        If !AOI_Pro_DB.Exec(SQL)
            DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Failed to UPDATE record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg, "alert-danger", 5000)
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;
;;;Function to print out JSON format From SQLite DB
BuildJson(obj) {
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
IsNumber(Num) {
    if Num is number
        return true
    else
        return false
}

;IELoad(wb) {  ;You need to send the IE handle to the function unless you define it as global.
    ;If !wb    ;If wb is not a valid pointer then quit
        ;Return False
    ;Loop    ;Otherwise sleep for .1 seconds untill the page starts loading
        ;Sleep,100
    ;Until (wb.busy)
    ;Loop    ;Once it starts loading wait until completes
        ;Sleep,100
    ;Until (!wb.busy)
    ;Loop    ;optional check to wait for the page to completely load
        ;Sleep,100
    ;Until (wb.Document.Readystate = "Complete")
    ;
    ;Return True
;}