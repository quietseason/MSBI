CREATE TABLE [dbo].[STG_FULL_accountinfo]
(
	[AccountID] BIGINT NOT NULL, --账户ID, Source Key
    [Created] DATETIME NOT NULL, 
    [Modified] DATETIME NOT NULL, 
    [Source] NVARCHAR(100) NOT NULL, 
    [StagingInsertTime] DATETIME NOT NULL
)
