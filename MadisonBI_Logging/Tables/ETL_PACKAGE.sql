﻿CREATE TABLE [dbo].[ETL_PACKAGE]
(
	ETL_PACKAGE_ID INT NOT NULL IDENTITY(1,1),
	ETL_PACKAGE_NAME NVARCHAR(255) NOT NULL,--'PKG_<ETL_TYPE_SHORT_NAME>_<TARGET_NAME>'
	ETL_PACKAGE_DESCRIPTION NVARCHAR(800) NULL,
	ETL_TYPE_ID INT NOT NULL,
	[Created] DATETIME NOT NULL, 
    [Modified] DATETIME NOT NULL, 
    CONSTRAINT [PK_ETL_PACKAGE] PRIMARY KEY(ETL_PACKAGE_ID),
	CONSTRAINT [FK_ETL_PACKAGE_ETL_TYPE_ID] FOREIGN KEY(ETL_TYPE_ID) REFERENCES dbo.ETL_TYPE(ETL_TYPE_ID)
)
