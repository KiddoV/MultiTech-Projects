/*
    This script to create additional EXE file for AOI Project Manager app!
    Execute to EXE file to use it!
*/
#NoTrayIcon
SetTitleMatchMode, RegEx

;;;;;Libraries
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Class_SQLiteDB.ahk
;;;;;Variable Definition


;;;;;Get var by parsing using command
Global ColumnVar = % A_Args[1]
Global TableName = % A_Args[2]
;Global GUID1 = % A_Args[3]
;Global MainSettingsFilePath = % A_Args[4]

;;Debugging
;Global ColumnVar := "75582934LB"
;Global TableName := "aoi_builds"
;Global MainDBFilePath := "C:\MultiTech-Projects\SQLite-DB\AOI_Pro_Manager_DB.DB"
;Global MainSettingsFilePath := "C:\V-Projects\WEB-APPLICATIONS\AOI-Project-Manager\app-settings.ini"

;;;;;Main Logic
If(ColumnVar = "" || TableName = "") {
    MsgBox, 16, Error, This is not a stand-alone application!
    Return
}

;;Connecting to Database
;Global AOI_Pro_DB := new SQLiteDB(MainSettingsFilePath)
;If !AOI_Pro_DB.OpenDB(MainDBFilePath) {         ;Connect to the main Database
    ;MsgBox, 16, SQLite Error, % "Failed connecting to Database`nMsg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    ;Return
;}
Global AOI_Pro_DB := ComObjActive(A_Args[3])

If (TableName = "aoi_pcbs")
    autoUpdatePcbDBTable(ColumnVar)
If (TableName = "aoi_builds")
    autoUpdateBuildDBTable(ColumnVar)

Return
;==========================================================================================;
;;;;;Main Functions
autoUpdatePcbDBTable(PcbNum) {
    ;;Get data from the web
    Try {
        req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;Create request object for http request
        url := "http://virtu.multitech.prv:4080/compfind/partdetails.asp?MTSPN=" . PcbNum
        
        req.open("GET", url, True)
        req.Send()
    } Catch {
        MsgBox FAILED TO CONNECT TO COMPFIND!
        ;DisplayAlertMsg("Could not connect to CompFind!" . AOI_Pro_DB.ErrorMsg, "alert-danger", 4000)
        Return
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
        ;MsgBox % A_Index "--> " A_LoopField
        If (RegExMatch(A_LoopField, "Component Finder cannot find any manufacturer parts") = 1) {
            ;DisplayAlertMsg("SYS: Update aoi_pcbs table Failed!<br>ERR: Not found or Wrong PCB number parameter!", "alert-danger")
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
    ;MsgBox % pcbPartStatus "--> " StrLen(pcbPartStatus)
    ;;;Update or Insert to Database
    SQL := "SELECT * FROM aoi_pcbs WHERE pcb_number = '" . PcbNum . "'"
    If !AOI_Pro_DB.Query(SQL, ResultSet) {
        MsgBox % "FAILED DOING DB QUERY!!! Msg: " . AOI_Pro_DB.ErrorMsg . " Code:" . AOI_Pro_DB.ErrorCode
        ;DisplayAlertMsg("SYS: Update aoi_pcbs table Failed!<br>Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    If (!ResultSet.HasRows) {    ;If cannot find record in Database then Insert new record
        SQL := "INSERT INTO aoi_pcbs VALUES('" . PcbNum . "', '" . pcbPartStatus . "', '" . pcbFullName . "', '', '" . pcbInsFileName . "', " . pcbQuantity . ", " . pcbDwgNum . ")"
        
        If !AOI_Pro_DB.Exec(SQL)
            Return
            ;DisplayAlertMsg("SYS: Update aoi_pcbs table Failed!<br>Failed to INSERT record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg . " (ErrCODE: " . AOI_Pro_DB.ErrorCode . ")", "alert-danger")
    } Else {
        ;AOI_Pro_DB.Exec("BEGIN TRANSACTION;")
        SQL := "UPDATE aoi_pcbs SET pcb_part_status = '" . pcbPartStatus . "', pcb_quantity_onhand = " . pcbQuantity . " WHERE pcb_number = '" . PcbNum . "'"
        If !AOI_Pro_DB.Exec(SQL)
            Return
            ;DisplayAlertMsg("SYS: Update aoi_pcbs table Failed!<br>Failed to UPDATE record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg . " (ErrCODE: " . AOI_Pro_DB.ErrorCode . ")", "alert-danger", 5000)
        ;AOI_Pro_DB.Exec("COMMIT TRANSACTION;")
    }
}

autoUpdateBuildDBTable(BuildNumWEcl) {
    RegExMatch(BuildNumWEcl, "[0-9]{8}L", BuildNum)
    ;;;;Get data from the web
    Try {
        req := ComObjCreate("MSXML2.XMLHTTP.6.0")   ;Create request object for http request
        url := "http://virtu.multitech.prv:4080/compfind/partdetails.asp?MTSPN=" . BuildNumWEcl
        
        req.open("GET", url, True)
        req.Send()
    } Catch {
        MsgBox FAILED CONNECTING TO COMPFIND!
        Return
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
    
    buildEcoList := []
    buildIndex := 1
    
    Loop, Parse, response, `n
    {
        ;MsgBox % A_Index "--> " A_LoopField
        If (A_Index < 10 && RegExMatch(A_LoopField, "Component Finder cannot find any manufacturer parts") = 1) {
            Return 0
        }
        
        If (RegExMatch(A_LoopField, "Value") = 1) {
            bnIndex := A_Index + 1
        }
        If (RegExMatch(A_LoopField, "Inventory Status") = 1)
            psIndex := A_Index + 1
        If (RegExMatch(A_LoopField, "Select BOM to open") = 1)
            bomIndex := A_Index + 1
        
        If (A_Index = bnIndex)
            buildName := A_LoopField
        If (A_Index = psIndex) {
            buildPartStatus := Format("{:U}", A_LoopField)
            StringReplace, buildPartStatus, buildPartStatus, `r,, All   ;;;Get rid of the newline character
        }
        If (RegExMatch(A_LoopField, "\$\d.*") = 1) {
            strCost :=  A_LoopField
            RegExMatch(strCost, "\d.*", buildCost)
            buildCost := Round(buildCost, 2)
        }
        If (RegExMatch(A_LoopField, ".*.PDF") = 1) {
            fileName :=  A_LoopField
            RegExMatch(fileName, "\d{5}", cadId)
        }
        
        If (A_Index = bomIndex) {
            If (RegExMatch(A_LoopField, ".*&nbsp;.*") = 1) {
                StringReplace, newString, A_LoopField, &nbsp;, %A_Space%, All
                buildEcoList[buildIndex] := {}
                fullDateTime := ""
                
                Loop, Parse, newString, %A_Space%
                {
                    If (A_LoopField = "")
                        Continue
                    RegExMatch(A_LoopField, "^\d{5}$", eco)
                    If (A_Index > 1)
                        RegExMatch(A_LoopField, "^\w{1,5}$", ecl)
                    RegExMatch(A_LoopField, "^[0-9]{1,2}[- \/.][0-9]{1,2}[- \/.][0-9]{2,4}$", date)
                    RegExMatch(A_LoopField, "^[0-9]{1,2}[- :][0-9]{1,2}[- :][0-9]{1,2}$", time)
                    RegExMatch(A_LoopField, "AM|PM", period)
                    
                    If (eco != "")
                        buildEcoList[buildIndex].eco := eco
                    If (ecl != "") {
                        If (StrLen(ecl) < 2)    ;;Fix ecl where sometime got only 1 character for first ecl
                            ecl .= "00"
                        If (StrLen(ecl) > 3)    ;;Fix ecl where sometime got mor than 3 character
                            RegExMatch(ecl, "^\w{3}", ecl)
                        buildEcoList[buildIndex].ecl := ecl
                    }
                    If (date != "" || time != "" || period != "") {
                        fullDateTime .= date " " time " " period
                    }
                }
                
                fullDateTime := DateParse(fullDateTime)
                buildEcoList[buildIndex].fullDateTime := fullDateTime
                ;buildEcoList[buildIndex] := {eco: eco, ecl: ecl, date: date, time: time, period: period}
                buildIndex++
                bomIndex++
            }
        }
    }
    
    ;;;;Update or Insert to Database
    SQL := "SELECT * FROM aoi_builds WHERE build_number = '" . BuildNum . "'"
    If !AOI_Pro_DB.Query(SQL, ResultSet) {
        MsgBox % "FAILED DOING DB QUERY!!! Msg: " . AOI_Pro_DB.ErrorMsg . " Code:" . AOI_Pro_DB.ErrorCode
        Return
    }
    
    If (!ResultSet.HasRows) {    ;If cannot find record in Database then INSERT new record to <aoi_builds> table
        SQL := "INSERT INTO aoi_builds VALUES('" . BuildNum . "', " . buildEcoList[1].eco . ", '" . buildEcoList[1].ecl . "', '" . buildName . "', '" . buildPartStatus . "', '" . buildCost . "')"
        If !AOI_Pro_DB.Exec(SQL)
            Return
    } Else {        ;If record found then UPDATE nessesary data
        SQL := "UPDATE aoi_builds SET build_part_status ='" . buildPartStatus . "', build_current_eco= " . buildEcoList[1].eco . ", build_current_ecl='" . buildEcoList[1].ecl . "', build_cost='" . buildCost . "' WHERE build_number='" . BuildNum . "'"
        Clipboard := SQL
        If !AOI_Pro_DB.Exec(SQL)
            Return
    }
    ;;;;;;;;;;;;;;;;;;;
    Loop, % buildEcoList.Length()
    {
        SQL := "SELECT * FROM _build_eco_history WHERE build_number='" . BuildNum . "' AND eco=" . buildEcoList[A_Index].eco
        If !AOI_Pro_DB.Query(SQL, ResultSet) {
            MsgBox % "FAILED DOING DB QUERY!!! Msg: " . AOI_Pro_DB.ErrorMsg . " Code:" . AOI_Pro_DB.ErrorCode
            Return
        }
        
        If (!ResultSet.HasRows) {
            SQL := "INSERT INTO _build_eco_history VALUES('" . BuildNum . "', " . buildEcoList[A_Index].eco . ", '" . buildEcoList[A_Index].ecl . "', " . buildEcoList[A_Index].fullDateTime . ")"
            If !AOI_Pro_DB.Exec(SQL)
                Return
        } Else {
            Return
        }
    }
}

;==========================================================================================;
;;;;;Additional Functions
DateParse(str) {    ;;US version -- Convert mm/dd/yyyy hh:mm:ss AA/PM to YYYYMMDDHH24MISS (AHK general date format)
	static e2 = "i)(?:(\d{1,2}+)[\s\.\-\/,]+)?(\d{1,2}|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\w*)[\s\.\-\/,]+(\d{2,4})"
	str := RegExReplace(str, "((?:" . SubStr(e2, 42, 47) . ")\w*)(\s*)(\d{1,2})\b", "$3$2$1", "", 1)
	If RegExMatch(str, "i)^\s*(?:(\d{4})([\s\-:\/])(\d{1,2})\2(\d{1,2}))?"
		. "(?:\s*[T\s](\d{1,2})([\s\-:\/])(\d{1,2})(?:\6(\d{1,2})\s*(?:(Z)|(\+|\-)?"
		. "(\d{1,2})\6(\d{1,2})(?:\6(\d{1,2}))?)?)?)?\s*$", i)
		d3 := i1, d2 := i3, d1 := i4, t1 := i5, t2 := i7, t3 := i8, t4 := t1 >11 ? "pm" : "am"
	Else If !RegExMatch(str, "x)^\W*   (\d{1,2}?)   (\d{2})   (\d{2}+)? (?:\s*([ap]m))?  \W*  $", t)
		RegExMatch(str, "ix)(\d{1,2})  \s*  :  \s*  (\d{1,2})   (?:(?:\s*:\s*) (\d{1,2}))?   (?:\s*([ap]m))?", t)
			, RegExMatch(str, e2, d)
	f = %A_FormatFloat%
	SetFormat, Float, 02.0
	d := (d3 ? (StrLen(d3) = 2 ? 20 : "") . d3 : A_YYYY)
		. ((d2 := d2 + 0 ? d2 : (InStr(e2, SubStr(d2, 1, 3)) - 40) // 4 + 1.0) > 0
			? d2 + 0.0 : A_MM) . ((d1 += 0.0) ? d1 : A_DD) . t1
			+ (((t4 = "pm") && (t1 < 12)) ? +12.0 : 0.0) . t2 +0.0 . t3 + 0.0    ; use this one - defaults to AM

	SetFormat, Float, %f%
	Return, SubStr(d,1,4) SubStr(d,7,2) SubStr(d,5,2) SubStr(d,9)
}