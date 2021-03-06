﻿CREATE TABLE [dbo].[CONNECTION_CONFIG]
(
	[CONNECTION_ID] INT NOT NULL IDENTITY(1,1),
	[DB_CATAGORY] VARCHAR(100) NOT NULL, 
    [SEQUENCE] INT NOT NULL, 
    [SERVER] VARCHAR(100) NOT NULL, 
	[LINKED_SERVER] VARCHAR(100) NULL,
    [DATABASE] VARCHAR(100) NOT NULL, 
    [USER] VARCHAR(100) NULL, 
    [ENCRYPTED_PASSWORD] VARCHAR(200) NULL, 
    [ENVIROMENT_ID] INT NOT NULL, 
    [ENVIROMENT_DESCRIPTION] VARCHAR(100) NULL, 
    [CONNECTION_STRING] VARCHAR(500) NULL, 
    [CREATED] DATETIME NOT NULL, 
    [CREATED_BY] VARCHAR(100) NOT NULL, 
    CONSTRAINT [PK_CONNECTION_CONFIG] PRIMARY KEY(CONNECTION_ID)
)
