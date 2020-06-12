
TestArray := [  {refID: "C1", pn: "1234"}
        ,       {refID: "C20", pn: "1234"}
        ,       {refID: "C3", pn: "1234"}
        ,       {refID: "C2", pn: "1234"}
        ,       {refID: "C50", pn: "1234"}
        ,       {refID: "C11", pn: "1234"}
        ,       {refID: "B1", pn: "1234"}
        ,       {refID: "B20", pn: "1234"}
        ,       {refID: "B12", pn: "1234"}
        ,       {refID: "B2", pn: "1234"}
        ,       {refID: "C12", pn: "1234"}
        ,       {refID: "FB11", pn: "1234"}
        ,       {refID: "FB9", pn: "1234"}
        ,       {refID: "FB15", pn: "1234"}
        ,       {refID: "FB122", pn: "1234"}
        ,       {refID: "C19", pn: "1234"} ]


Sort2DArray(TestArray, "refID")
For index, obj in TestArray
   list3 .= TestArray[index].refID . "`n"
msgbox % list3



Sort2DArray(Byref TDArray, KeyName, Order=1) {
   ;TDArray : a two dimensional TDArray
   ;KeyName : the key name to be sorted
   ;Order: 1:Ascending 0:Descending
 
    For index2, obj2 in TDArray {           
        For index, obj in TDArray {
            if (lastIndex = index)
                break
            RegExMatch(TDArray[index][KeyName], "[A-Z]+", letter)
            RegExMatch(TDArray[prevIndex][KeyName], "[A-Z]+", prevLetter)
            RegExMatch(TDArray[index][KeyName], "\d+", number)
            RegExMatch(TDArray[prevIndex][KeyName], "\d+", prevnumber)
            if !(A_Index = 1) &&  ((Order=1) ? (prevLetter > letter) && (prevnumber > number) : (prevLetter < letter)) {    
               tmp := TDArray[index][KeyName] 
               TDArray[index][KeyName] := TDArray[prevIndex][KeyName]
               TDArray[prevIndex][KeyName] := tmp
            }         
            prevIndex := index
        }     
        lastIndex := prevIndex
    }
}


^q::
    ExitApp