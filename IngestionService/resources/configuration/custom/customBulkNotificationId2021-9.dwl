%dw 2.0
import * from dw::core::URL
import * from dw::core::Strings
output application/json

var path = vars.fileStorePath ++ "/" ++ vars.bulkMessageId ++ ".gz"
var fullFilePath = if(path != null) (path replace "\\\\" with "/") else null

---
{
    header: {
        sender: vars.service,
        receiver: vars.receivers default "" splitBy ",",
        model: "BYDM",
        messageVersion: "BYDM 2021.9.0",
        messageId: vars.messageId,
        "type": "bulkNotification",
        creationDateAndTime: now()
   },
   bulkNotification: [
       {
            lastUpdateDateTime: now(),
            documentStatusCode: "ORIGINAL",
            documentActionCode: "ADD",
            bulkNotificationId: if (vars.bulkMessageId contains("/records")) substringBefore(vars.bulkMessageId, "/records") else vars.bulkMessageId,
            sourceOfBulkMessage: vars.bulkMessageSource default vars.service,
            bulkType: vars.bulkType,
            bulkTypeVersion: vars.bulkTypeVersion,
            bulkContentType: vars.bulkContentType,
            bulkFormat: vars.bulkFormat,
            configurationName: vars.configurationName,
            bulkUri: if (vars.callbackProtocol == "FILE") decodeURI (compose `$(lower(vars.callbackProtocol))://$(fullFilePath)`)
                    else if (vars.callbackProtocol == "AzureBlob") decodeURI (compose `$(lower(vars.callbackProtocol))://$(vars.containerName)/$(fullFilePath)`)
                    else if (vars.callbackProtocol == "JDA_MS") decodeURI (compose `$(lower(vars.callbackProtocol))://$(vars.bulkMessageId)`)
                    else if (vars.storeType == "Object Store") decodeURI (compose `$(lower(vars.callbackProtocol))://$(vars.callbackHost):$(vars.callbackPort)/$(fullFilePath)/$(vars.bulkMessageId)`)
                    else if (vars.callbackProtocol contains("HTTP")) decodeURI (compose `$(lower(vars.callbackProtocol))://$(vars.callbackHost):$(vars.callbackPort)/$(vars.callbackPath)`)
                    else decodeURI (compose `$(lower(vars.callbackProtocol))://$(vars.callbackHost):$(vars.callbackPort)$(fullFilePath)`)
       }
    ]
}