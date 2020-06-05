list=
(
1,2,3,4
5,6,7,8
9,10,11,12
99,98,97,96
)

Gui, Add, ListView, r12 w425 Grid vMyListView gcalculateTotal, C1|C2|C3|C4|Total|
loop, parse, list, `n, `r
{
  stringsplit, temp, A_LoopField, `,
  {
    LV_Add("", temp1, temp2, temp3, temp4)
  }
}
LV_ModifyCol(1, 70)
LV_ModifyCol(1, "float +Left sort")
LV_ModifyCol(2, 70)
LV_ModifyCol(3, 70)
LV_ModifyCol(4, 70)

Gosub calculateTotal

gui, show, y100, My List


return

;---------------------------------------------------------------------------------------
^q::
Gui, 2:Destroy
Gui, 2:Add, Text, x16 y10 w80, C1 value
Gui, 2:Add, Edit, x105 y6 w75 vC1, 
Gui, 2:Add, Text, x16 y45 w80, C2 value
Gui, 2:Add, Edit, x105 y41 w75 vC2,
Gui, 2:Add, Text, x16 y80 w80, C3 value
Gui, 2:Add, Edit, x105 y76 w75 vC3,
Gui, 2:Add, Text, x16 y115 w80, C4 value
Gui, 2:Add, Edit, x105 y111 w75 vC4,
 
Gui, 2: Add, Button, x50 y150 w100 Default, OK
 
Gui, 2:Show, Autosize, Enter values
Return 

2ButtonOk: 
Gui, 2:Submit

list .= "`n" . C1 . "," . C2 . "," . C3 . "," . C4 ; I want to have the entered values added to the list and the ListView GUI "refreshed"
Gui, 1:Default
LV_Add("", C1, C2, C3, C4)
LV_ModifyCol(1, "sort")

Gosub calculateTotal

 
Return

;---------------------------------------------------------------------------------------

guiclose:
exitapp

calculateTotal:

C4RunningTotal=0

; Loop through all the rows
Loop % LV_GetCount()
{
  ; Save the value of each cell in the row
  LV_GetText(C1val, A_Index, 1)
  LV_GetText(C2val, A_Index, 2)
  LV_GetText(C3val, A_Index, 3)
  LV_GetText(C4val, A_Index, 4)
  LV_GetText(this_value, A_Index, 4)

  ; Add the value of the fourth cell to a running total
  C4RunningTotal += this_value

  ; Modify each row putting back their original values and adding the running total to the 5th column.
  LV_Modify(A_Index, "",C1val,C2val,C3val, C4val, C4RunningTotal)
}
return