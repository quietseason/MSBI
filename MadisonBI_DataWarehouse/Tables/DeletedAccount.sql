CREATE TABLE [dbo].[DeletedAccount]
(
	[DeletedAccountID] BIGINT NOT NULL,--被删除的账户ID
	[ETLInsertTime] DATETIME NOT NULL, 
	CONSTRAINT [PK_DeletedAccount] PRIMARY KEY([DeletedAccountID])
)
