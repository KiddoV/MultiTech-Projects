resUrl := "127.0.0.1/api/"
jsonStr = 
(
    {"firstTimeSetup" : "false"}
)
HttpObj := ComObjCreate("Msxml2.XMLHTTP")
HttpObj.Open("GET", resUrl, 0)
HttpObj.SetRequestHeader("Content-Type", "application/json")
;HttpObj.Send(jsonStr)

MsgBox, % HttpObj.ResponseText