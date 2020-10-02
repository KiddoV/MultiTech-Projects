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
Global MainDBFilePath = % A_Args[3]
Global MainSettingsFilePath = % A_Args[4]
;Global ColumnVar := "10000791L"
;Global TableName := "aoi_pcb"

;;;;;Main Logic
If(ColumnVar = "" || TableName = "") {
    MsgBox, 16, Error, This is not a stand-alone application!
    Return
}

;;Connecting to Database
Global AOI_Pro_DB := new SQLiteDB(MainSettingsFilePath)
If !AOI_Pro_DB.OpenDB(MainDBFilePath) {         ;Connect to the main Database
    MsgBox, 16, SQLite Error, % "Failed connecting to Database`nMsg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    Return
}

If (TableName = "aoi_pcb")
    autoUpdatePcbDBTable(ColumnVar)

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
            ;DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>ERR: Not found or Wrong PCB number parameter!", "alert-danger")
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
    SQL := "SELECT * FROM aoi_pcb WHERE pcb_number = '" . PcbNum . "'"
    If !AOI_Pro_DB.Query(SQL, ResultSet) {
        MsgBox % "FAILED DOING DB QUERY!!! Msg: " . AOI_Pro_DB.ErrorMsg . " Code:" . AOI_Pro_DB.ErrorCode
        ;DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Execute SQL statement FAILED!!!", "alert-danger")
        Return
    }
    
    If (!ResultSet.HasRows) {    ;If cannot find record in Database then Insert new record
        SQL := "INSERT INTO aoi_pcb VALUES('" . PcbNum . "', '" . pcbPartStatus . "', '" . pcbFullName . "', '', '" . pcbInsFileName . "', " . pcbQuantity . ", " . pcbDwgNum . ")"
        
        If !AOI_Pro_DB.Exec(SQL)
            Return
            ;DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Failed to INSERT record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg . " (ErrCODE: " . AOI_Pro_DB.ErrorCode . ")", "alert-danger")
    } Else {
        ;AOI_Pro_DB.Exec("BEGIN TRANSACTION;")
        SQL := "UPDATE aoi_pcb SET pcb_part_status = '" . pcbPartStatus . "', pcb_quantity_onhand = " . pcbQuantity . " WHERE pcb_number = '" . PcbNum . "'"
        If !AOI_Pro_DB.Exec(SQL)
            Return
            ;DisplayAlertMsg("SYS: Update aoi_pcb table Failed!<br>Failed to UPDATE record!<br>ErrMsg: " . AOI_Pro_DB.ErrorMsg . " (ErrCODE: " . AOI_Pro_DB.ErrorCode . ")", "alert-danger", 5000)
        ;AOI_Pro_DB.Exec("COMMIT TRANSACTION;")
    }
}

;autoGetPCBInfo(PcbNum) {
    ;;;RunWait, Taskkill /f /im iexplore.exe, , Hide   ;Fix bug where IE open many times
    ;wb := ComObjCreate("InternetExplorer.Application")
    ;wb.Visible := False
    ;url := "http://virtu.multitech.prv:4080/compfind/partdetails.asp?MTSPN=" . PcbNum
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