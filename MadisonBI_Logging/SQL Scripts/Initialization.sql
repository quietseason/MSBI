INSERT INTO dbo.ETL_STATUS VALUES(1,N'IN PROGRESS',NULL);
INSERT INTO dbo.ETL_STATUS VALUES(2,N'SUCCEEDED',NULL);
INSERT INTO dbo.ETL_STATUS VALUES(3,N'FAILED',NULL);
GO

INSERT dbo.ETL_TYPE(ETL_TYPE_ID,ETL_TYPE_NAME,ETL_TYPE_SHORT_NAME,ETL_TYPE_DESCRIPTION) VALUES(1,'SOURCE TO STAGING','STG','Direct move data from data source to staging layer');
INSERT dbo.ETL_TYPE(ETL_TYPE_ID,ETL_TYPE_NAME,ETL_TYPE_SHORT_NAME,ETL_TYPE_DESCRIPTION) VALUES(2,'STAGING TO DATA WAREHOUSE','DW','Make transformation on staging data and then load into data warehouse');
INSERT dbo.ETL_TYPE(ETL_TYPE_ID,ETL_TYPE_NAME,ETL_TYPE_SHORT_NAME,ETL_TYPE_DESCRIPTION) VALUES(3,'DATA WAREHOUSE TO OLAP','CUBE','Process the cube using data in data warehouse');
INSERT dbo.ETL_TYPE(ETL_TYPE_ID,ETL_TYPE_NAME,ETL_TYPE_SHORT_NAME,ETL_TYPE_DESCRIPTION) VALUES(4,'AUDITING','AUDIT','Audit the ETL process');
INSERT dbo.ETL_TYPE(ETL_TYPE_ID,ETL_TYPE_NAME,ETL_TYPE_SHORT_NAME,ETL_TYPE_DESCRIPTION) VALUES(5,'STAGING TO ARCHIVE','ARCH','Archive the staging data');
GO

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	1,
	'120.27.144.251',
	'rdsc309f26u4v49pyi30',
	'madison_konto_001',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	2,
	'120.27.144.251',
	'rdsc309f26u4v49pyi30',
	'madison_konto_002',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	3,
	'120.27.144.251',
	'rdsc309f26u4v49pyi30',
	'madison_konto_003',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	4,
	'120.55.191.90',
	'rdsmc9si86h305765bz5',
	'madison_konto_004',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	5,
	'120.55.191.90',
	'rdsmc9si86h305765bz5',
	'madison_konto_005',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	6,
	'120.55.191.90',
	'rdsmc9si86h305765bz5',
	'madison_konto_006',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	7,
	'120.55.191.90',
	'rdsmc9si86h305765bz5',
	'madison_konto_007',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	8,
	'120.55.191.90',
	'rdsmc9si86h305765bz5',
	'madison_konto_008',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	9,
	'120.55.191.90',
	'rdsmc9si86h305765bz5',
	'madison_konto_009',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	10,
	'120.55.191.90',
	'rdsmc9si86h305765bz5',
	'madison_konto_010',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_00x',
	11,
	'120.55.191.90',
	'rdsmc9si86h305765bz5',
	'madison_konto_011',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)

INSERT INTO DBO.CONNECTION_CONFIG(
	[DB_CATAGORY], 
    [SEQUENCE], 
    [SERVER], 
	[LINKED_SERVER],
    [DATABASE], 
    [USER], 
    [ENCRYPTED_PASSWORD], 
    [ENVIROMENT_ID], 
    [ENVIROMENT_DESCRIPTION], 
    [CONNECTION_STRING], 
    [CREATED], 
    [CREATED_BY]
)
VALUES(
	'madison_konto_000',
	1,
	'120.27.144.251',
	'rdsc309f26u4v49pyi30',
	'madison_konto_000',
	NULL,--Windows Authentication
	NULL,--Windows Authentication
	1,--PROD
	'Production',
	NULL,--No Connection String Specified
	GETDATE(),
	SYSTEM_USER
)
GO

INSERT INTO [dbo].[SSIS Configurations] VALUES('MadisonBI_Archive','False','\Package.Variables[User::ConfigRemovePartition].Properties[Value]','Boolean')