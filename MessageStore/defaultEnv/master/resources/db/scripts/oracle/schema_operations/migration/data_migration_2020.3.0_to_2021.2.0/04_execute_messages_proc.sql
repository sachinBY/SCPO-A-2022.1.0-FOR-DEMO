-- Run this script under CONNECT_MS_APP user

DECLARE
    P_RETENTIONDAYS NUMBER;
    P_BATCHSIZE NUMBER;
BEGIN
  P_RETENTIONDAYS := 3;
  P_BATCHSIZE := 10200;

  dataMigrationFrom2020300To2021200_Messages(P_RETENTIONDAYS, P_BATCHSIZE);    
--rollback; 
END;
    