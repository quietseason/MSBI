﻿CREATE TABLE [dbo].[ETL_PROCESS_AUDIT]
(
	[ETL_PROCESS_AUDIT_ID] BIGINT NOT NULL,
	[ETL_PROCESS_LOG_ID] BIGINT NOT NULL, 
	ETL_COMPONENT_NAME NVARCHAR(500) NOT NULL,
    [SOURCE_NAME] NVARCHAR(100) NULL, 
    [TARGET_NAME] NVARCHAR(100) NOT NULL, 
	[INCREMENTAL_FLAG] NVARCHAR(100) NULL,
	[INSERTED_ROWS] BIGINT NULL, 
    [UPDATED_ROWS] BIGINT NULL, 
    [DELETED_ROWS] BIGINT NULL, 
    [START_TIME] DATETIME NOT NULL,
    [END_TIME] DATETIME NULL, 
    [ETL_STATUS_ID] INT NOT NULL, 
    CONSTRAINT [PK_ETL_PROCESS_AUDIT] PRIMARY KEY([ETL_PROCESS_AUDIT_ID]),
	CONSTRAINT [FK_ETL_PROCESS_AUDIT_ETL_PROCESS_LOG_ID] FOREIGN KEY(ETL_PROCESS_LOG_ID) REFERENCES DBO.ETL_PROCESS_LOG(ETL_PROCESS_LOG_ID),
	CONSTRAINT [FK_ETL_PROCESS_AUDIT_ETL_STATUS_ID] FOREIGN KEY(ETL_STATUS_ID) REFERENCES DBO.ETL_STATUS(ETL_STATUS_ID)
)
