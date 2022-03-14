%dw 2.0
output application/java
---
(payload map (vehicleLoad, indexOfVehicleLoad) -> {
	MS_BULK_REF: vehicleLoad.MS_BULK_REF,
	MS_REF: vehicleLoad.MS_REF,
	INTEGRATION_STAMP: vehicleLoad.INTEGRATION_STAMP,
	LOADID: vehicleLoad.LOADID,
	(vars.deleteudc): 'Y'
  })