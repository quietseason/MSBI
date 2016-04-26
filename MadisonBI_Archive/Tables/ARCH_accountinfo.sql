CREATE TABLE [dbo].[ARCH_accountinfo]
(
	[ArchiveID] BIGINT NOT NULL IDENTITY(1,1),
	[StagingID] BIGINT NOT NULL,
	[AccountID] BIGINT NOT NULL, 
    [Name] NVARCHAR(200) NULL, 
    [Mobile] NVARCHAR(50) NULL, 
    [Age] INT NULL, 
    [Gender] VARCHAR(20) NULL, 
    [ReferralCode] VARCHAR(20) NULL, 
    [InvitedBy] VARCHAR(20) NULL, 
    [Channel] VARCHAR(100) NULL, 
    [IsPWDSet] BIT NULL, 
    [IsRealName] BIT NULL, 
    [IsCardBinded] BIT NULL, 
    [Created] DATETIME NOT NULL, 
    [Modified] DATETIME NULL, 
    [Source] VARCHAR(100) NOT NULL, 
    [StagingInsertTime] DATETIME NOT NULL, 
	[ArchiveInsertTime] DATETIME NOT NULL, 
    CONSTRAINT [PK_ARCH_accountinfo] PRIMARY KEY(ArchiveID)
)
