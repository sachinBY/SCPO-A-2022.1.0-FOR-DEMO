%dw 2.0
output application/json
---
using (
    sql = "select ITEM,SKULOC,DMDGROUP,TYPE,STARTDATE,DUR,sum(TOTFCST) as TOTFCST from DFUTOSKUFCST GROUP BY ITEM,SKULOC,DMDGROUP,TYPE,STARTDATE,DUR"
)
if (vars.filterCondition != null)
   sql ++ " WHERE " ++ vars.filterCondition ++ " ORDER BY ITEM,SKULOC,DMDGROUP,STARTDATE,DUR,TYPE" ++ " OFFSET " ++ vars.offset ++ " ROWS FETCH NEXT " ++ vars.next ++ " ROWS ONLY"
  else 
  	sql ++ " ORDER BY ITEM,SKULOC,DMDGROUP,STARTDATE,DUR,TYPE" ++ " OFFSET " ++ vars.offset ++ " ROWS FETCH NEXT " ++ vars.next ++ " ROWS ONLY"