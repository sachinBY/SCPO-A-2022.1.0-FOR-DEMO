%dw 2.0
import * from dw::core::URL
import * from dw::core::Strings
output application/json
// enable and use below variable if need access of payload
// var originalPayload = payload[0]
var entity = attributes.queryParams.entity
---
{

	// Enable bulkNotificationId attribute from the below in order to override the bulkId or customize the bulkId. 
    // Please make sure this must generate unique for each request else keep as uuid().
            
    // Some Examples
    // bulkNotificationId: if(attributes.headers.'content-encoding' != 'gzip') 'lct_' ++ entity ++ '_' ++ (originalPayload.xxx default '') ++ '_' ++ now() as String{format: "yyyyMMddhhmmssSSS"} else 'default_' ++ entity ++ now() as String{format: "yyyyMMddhhmmssSSS"}
     bulkNotificationId: 'default_' ++ entity ++ now() as String{format: "yyyyMMddhhmmssSSS"},
}