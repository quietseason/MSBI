﻿CREATE VIEW [dbo].[vETLProcessDetail]
AS
SELECT 
	L.ETL_PROCESS_LOG_ID,
	A.ETL_PROCESS_AUDIT_ID,
	P.ETL_PACKAGE_NAME,
	T.ETL_TYPE_NAME,
	L.MACHINE_NAME,
	L.EXECUTE_USER,
	L.START_TIME AS PackageStartTime,
	L.END_TIME AS PackageEndTime,
	S.ETL_STATUS_NAME AS PackageStatus,
	A.ETL_COMPONENT_NAME,
	A.SOURCE_DB,
	A.SOURCE_NAME,
	A.TARGET_DB,
	A.TARGET_NAME,
	A.INCREMENTAL_FLAG,
	A.INSERTED_ROWS,
	A.UPDATED_ROWS,
	A.DELETED_ROWS,
	A.START_TIME AS ComponentStartTime,
	A.END_TIME AS ComponentEndTime,
	SA.ETL_STATUS_NAME AS ComponentStatus
FROM DBO.ETL_PACKAGE P WITH(NOLOCK)
INNER JOIN DBO.ETL_PROCESS_LOG L WITH(NOLOCK) ON L.ETL_PACKAGE_ID = P.ETL_PACKAGE_ID
INNER JOIN DBO.ETL_PROCESS_AUDIT A WITH(NOLOCK) ON L.ETL_PROCESS_LOG_ID = A.ETL_PROCESS_LOG_ID
INNER JOIN DBO.ETL_STATUS S WITH(NOLOCK) ON L.ETL_STATUS_ID = S.ETL_STATUS_ID
INNER JOIN DBO.ETL_TYPE T WITH(NOLOCK) ON P.ETL_TYPE_ID = T.ETL_TYPE_ID
INNER JOIN DBO.ETL_STATUS SA WITH(NOLOCK) ON A.ETL_STATUS_ID = SA.ETL_STATUS_ID
