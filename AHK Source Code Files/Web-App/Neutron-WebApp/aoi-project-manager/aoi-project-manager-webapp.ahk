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

FileInstall, C:\MultiTech-Projects\DLL-files\SQLite3.dll, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\SQLite3.dll, 1
FileInstall, C:\MultiTech-Projects\EXE-Files\aoi-pro-man_autoUpdateDBTable.exe, C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\aoi-pro-man_autoUpdateDBTable.exe, 1
;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
Global MainDBFilePath := "C:\MultiTech-Projects\SQLite-DB\AOI_Pro_Manager_DB.DB"
Global MainSettingsFilePath := "C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\app-settings.ini"
Global CompFindUrl := "virtu.multitech.prv"

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
Global AOI_Pro_DB := new SQLiteDB(MainSettingsFilePath)

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

;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, aoi_project_manager_index.html, aoi_project_manager_index.html     ;Main html file
FileInstall, html_msgbox.html, html_msgbox.html     ;MsgBox html file
;;Boostrap components for GUI
FileInstall, jquery.min.js, jquery.min.js
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js
FileInstall, mdb.min.css, mdb.min.css
FileInstall, mdb.min.js, mdb.min.js
FileInstall, popper.min.js, popper.min.js
FileInstall, bootstrap-table.min.css, bootstrap-table.min.css
FileInstall, bootstrap-table.min.js, bootstrap-table.min.js
FileInstall, fontawesome.js, fontawesome.js
FileInstall, solid.js, solid.js
FileInstall, font-googleapi.css, font-googleapi.css

FileInstall, aoi_pro_man_main.css, aoi_pro_man_main.css
FileInstall, aoi_pro_man_main.js, aoi_pro_man_main.js
;;Buit-in Images
FileInstall, default-brand-logo.png, default-brand-logo.png
FileInstall, yestech-logo.png, yestech-logo.png
FileInstall, rti-logo.png, rti-logo.png
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
    ;HtmlMsgBox("WARNING", , , "Test MsgBox", "HELLO! This is a message", 0)
    ;fn := Func("autoUpdatePcbDBTable").Bind("13580620L")
    ;SetTimer, %fn%, -0
    ;autoUpdatePcbDBTable("13580252L")   ;;;DELETE ME!!!
    ;MsgBox HELLO FROM AHK
    ;NeutronWebApp.wnd.alert("Hi")
    ;DisplayAlertMsg("You click the button!!!!", "alert-success")
    ;SQL := "SELECT * FROM Users;"
    ;If !AOI_Pro_DB.GetTable(SQL, Result)
       ;MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    ;MsgBox % Result.ColumnCount
    Run, %ComSpec% /c start C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\aoi-pro-man_autoUpdateDBTable.exe "10000791L" "aoi_pcb" %MainDBFilePath% %MainSettingsFilePath%, , Hide
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
    
    If (!Result.HasRows)
        DisplayAlertMsg("Not found any result!", "alert-warning")
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
    
    Fn := Func("AutoCloseAlertMsg").Bind(randId)
    SetTimer, %Fn%, -%Timeout%
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
                    If (A_Index = 6)
                        currentECO := Row[A_Index]
                    If (A_Index = 7)
                        currentECL := Row[A_Index]
                    If (A_Index = 10)
                        dateTimeCreated := Row[A_Index]
                    If (A_Index = 14)
                        machineBrandName := Row[A_Index]
                    If (A_Index = 15)
                        progAltType := Row[A_Index]
                    If (A_Index = 18)
                        progSubsName := Row[A_Index]
                }
                
                progStatusClass := progStatus = "USABLE" ? "pro-card-status-useable" : progStatus = "NEED UPDATE" ? "pro-card-status-needupdate" : progStatus = "NOT READY" ? "pro-card-status-notready" : progStatus = "IN PROGRESS" ? "pro-card-status-inprogress" : progStatus = "SUBSTITUTE" ? "pro-card-status-substitute" : ""
                brandLogoPath := machineBrandName = "YesTech" ? "yestech-logo.png" : machineBrandName = "TRI" ? "rti-logo.png" : "default-brand-icon.png"
                If (dateTimeCreated != "") {
                    FormatTime, dateCreated, %dateTimeCreated%, MMM dd, yyyy
                    FormatTime, timeCreated, %dateTimeCreated%, hh:mm:ss tt
                } Else {
                    dateCreated := "N/A"
                }
                If (progSubsName != "")
                    progFullName := progFullName . "<span class='red-text'> (USE => " . progSubsName . ")</span>"
                
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
    NeutronWebApp.wnd.activateProgCardFirstTab()    ;JS function
    ;NeutronWebApp.qs("#prog-card-modal-title").innerHTML := event.id
    
    ;;Get data from DB
    SQL := "SELECT * FROM aoi_programs LEFT JOIN aoi_pcb ON aoi_pcb.pcb_number = aoi_programs.prog_pcb_number LEFT JOIN users ON users.user_id = aoi_programs.prog_created_by WHERE prog_id=" . event.id
    If !AOI_Pro_DB.GetTable(SQL, ProgCardData) {
        DisplayAlertMsg("Execute SQL statement FAILED!!! Could not get data!", "alert-danger")
    }
    
    If (!ProgCardData.HasRows) {
        DisplayAlertMsg("Display failed! Got empty Result Set.", "alert-danger")
    }
    
    ;;;Save data to var
    ;;Table 1
    pcmProgName := ProgCardData.Rows[1][2]
    pcmProgStatus := ProgCardData.Rows[1][3]
    pcmProgBuildNum := ProgCardData.Rows[1][4]
    pcmProgPcbNum := ProgCardData.Rows[1][5]
    pcmProgCurntEco := ProgCardData.Rows[1][6]
    pcmProgCurntEcl := ProgCardData.Rows[1][7]
    pcmProgDateCre := ProgCardData.Rows[1][10]
    pcmProgAoiMa := ProgCardData.Rows[1][14]
    pcmProgAltType := ProgCardData.Rows[1][15]
    pcmProgSubsName := ProgCardData.Rows[1][18]
    ;;Table 2
    pcmPcbStatus := ProgCardData.Rows[1][20]
    pcmPcbFullName := ProgCardData.Rows[1][21] = "" ? "*No Info In Database*" : ProgCardData.Rows[1][21]
    pcmPcbQty := ProgCardData.Rows[1][24]
    pcmPcbDwg := ProgCardData.Rows[1][25]
    ;;Table 3
    pcmUserFn := ProgCardData.Rows[1][27]
    pcmUserLn := ProgCardData.Rows[1][28]
    
    ;;Auto Update Table aoi_pcb
    Run, %ComSpec% /c start C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\aoi-pro-man_autoUpdateDBTable.exe %pcmProgPcbNum% "aoi_pcb" %MainDBFilePath% %MainSettingsFilePath%, , Hide
    
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
    NeutronWebApp.qs("#prog-card-modal-pcb-btn").innerHTML := pcmProgPcbNum = "" ? "????????" : pcmProgPcbNum
    NeutronWebApp.qs("#prog-card-stat-label").innerHTML := "<span class='badge' style='background-color: " . progStatusColor . "'>" . pcmProgStatus . "</span>"
    NeutronWebApp.qs("#prog-card-modal-brand-logo").src := brandLogoPath
    NeutronWebApp.qs("#prog-card-rtf-note").innerHTML := "<a href='#' onclick='ahk.OpenRTFNote(event)'>Notes.rtf</a>"
    NeutronWebApp.qs("#prog-card-date-created").innerHTML := dateCreated
    NeutronWebApp.qs("#prog-card-alt-type").innerHTML := isAlternate := pcmProgAltType = "" ? "<span class='badge mdb-color'>ORIGINAL</span>" : "<span class='badge black'>" . pcmProgAltType . "</span>"
    NeutronWebApp.qs("#prog-card-created-by").innerHTML := pcmUserFn . " " . pcmUserLn
    
    ;;Display Data on Second Tab
    pcbStatusColor := pcmPcbStatus = "ACTIVE" ? "green" : pcmPcbStatus = "BETA" ? "indigo" : "black"
    NeutronWebApp.qs("#prog-card-modal-pcb-name").innerHTML := pcmPcbFullName " | " pcmProgPcbNum
    NeutronWebApp.qs("#prog-card-modal-pcb").innerHTML := pcmProgPcbNum
    NeutronWebApp.qs("#prog-card-modal-pcb-status").innerHTML := "Status: <span class='badge " . pcbStatusColor . "'>" . pcmPcbStatus . "</span>"
    NeutronWebApp.qs("#prog-card-modal-pcb-dwg").innerHTML := pcmPcbDwg
    NeutronWebApp.qs("#prog-card-modal-pcb-quant").innerHTML := pcmPcbQty . " (pcs)"
}

OpenRTFNote(neutron, event) {
    MsgBox OPENNING FILE!
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
            DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>ERR: Not found or Wrong PCB number parameter!", "alert-danger")
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
    SQL := "SELECT * FROM aoi_pcb WHERE pcb_number = '" . pcbNum . "'"
    If !AOI_Pro_DB.Query(SQL, ResultSet) {
        DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    If (!ResultSet.HasRows) {    ;If cannot find record in Database then Insert new record
        SQL := "INSERT INTO aoi_pcb VALUES('" . pcbNum . "', '" . pcbPartStatus . "', '" . pcbFullName . "', '', '" . pcbInsFileName . "', " . pcbQuantity . ", " . pcbDwgNum . ")"
        
        If !AOI_Pro_DB.Exec(SQL)
            DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Failed to INSERT record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg . " (ErrCODE: " . AOI_Pro_DB.ErrorCode . ")", "alert-danger")
    } Else {
        ;AOI_Pro_DB.Exec("BEGIN TRANSACTION;")
        SQL := "UPDATE aoi_pcb SET pcb_part_status = '" . pcbPartStatus . "', pcb_quantity_onhand = " . pcbQuantity . " WHERE pcb_number = '" . pcbNum . "'"
        If !AOI_Pro_DB.Exec(SQL)
            DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Failed to UPDATE record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg . " (ErrCODE: " . AOI_Pro_DB.ErrorCode . ")", "alert-danger", 5000)
        ;AOI_Pro_DB.Exec("COMMIT TRANSACTION;")
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