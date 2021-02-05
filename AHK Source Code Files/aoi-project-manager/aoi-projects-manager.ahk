/*
    Author: Viet Ho
*/
;=======================================================================================;
SetTitleMatchMode, RegEx
#SingleInstance Force
#NoEnv
SetBatchLines -1

;;;Other libraries
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\Class_SQLiteDB.ahk
#Include C:\MultiTech-Projects\AHK Source Code Files\lib\JSON.ahk
;=======================================================================================;
;;;;;;;;;;Installs Folder Location and Files;;;;;;;;;;

;=======================================================================================;
;;;;;;;;;;;;;Global Variables Definition;;;;;;;;;;;;;;;;
Global mainHtmlFile := "index.html"
;=======================================================================================;
;;;;;;;;;;;;;Main Gui;;;;;;;;;;;;;;;;
Gui, Main: +Resize +MaximizeBox +Minsize900x600
Gui, Main: Margin, 0, 0
Gui, Main: Add, ActiveX, vWB w900 h600, about:blank
WB.Silent := true
WB.Navigate("about:blank")
Loop
   Sleep 10
Until   (WB.readyState=4 && WB.document.readyState="complete" && !WB.busy)
If A_IsCompiled
	url := "res://" this.wnd.encodeURIComponent(A_ScriptFullPath) "/10/" mainHtmlFile
Else
	url := A_WorkingDir "/" mainHtmlFile
WB.Navigate(url)

;;;;Functions run BEFORE Gui Started

Gui, Main: Show, w900 h600, AOI Projects Manager

;;;;Functions run AFTER Gui Started
Return ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;Make Gui contents resizeable
MainGuiSize:
	If (A_EventInfo = 1) ; The window has been minimized.
		Return
	AutoXYWH("wh", "WB")
Return
;=======================================================================================;
;;;Must include FileInstall to work on EXE file (All nessesary files must be in the same folder!)
FileInstall, index.html, index.html
;=======================================================================================;
;;;;;;;;;;;;;Main Functions;;;;;;;;;;;;;;;;

;=======================================================================================;
;;;;;;;;;;;;;Third-Party Functions;;;;;;;;;;;;;;;;
AutoXYWH(DimSize, cList*){       ; http://ahkscript.org/boards/viewtopic.php?t=1079
  static cInfo := {}
 
  If (DimSize = "reset")
    Return cInfo := {}
 
  For i, ctrl in cList {
    ctrlID := A_Gui ":" ctrl
    If ( cInfo[ctrlID].x = "" ){
        GuiControlGet, i, %A_Gui%:Pos, %ctrl%
        MMD := InStr(DimSize, "*") ? "MoveDraw" : "Move"
        fx := fy := fw := fh := 0
        For i, dim in (a := StrSplit(RegExReplace(DimSize, "i)[^xywh]")))
            If !RegExMatch(DimSize, "i)" dim "\s*\K[\d.-]+", f%dim%)
              f%dim% := 1
        cInfo[ctrlID] := { x:ix, fx:fx, y:iy, fy:fy, w:iw, fw:fw, h:ih, fh:fh, gw:A_GuiWidth, gh:A_GuiHeight, a:a , m:MMD}
    }Else If ( cInfo[ctrlID].a.1) {
        dgx := dgw := A_GuiWidth  - cInfo[ctrlID].gw  , dgy := dgh := A_GuiHeight - cInfo[ctrlID].gh
        For i, dim in cInfo[ctrlID]["a"]
            Options .= dim (dg%dim% * cInfo[ctrlID]["f" dim] + cInfo[ctrlID][dim]) A_Space
        GuiControl, % A_Gui ":" cInfo[ctrlID].m , % ctrl, % Options
} } }