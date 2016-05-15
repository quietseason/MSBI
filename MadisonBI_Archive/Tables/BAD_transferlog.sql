CREATE TABLE [dbo].[BAD_transferlog]
(
	[BadRecordID] BIGINT NOT NULL IDENTITY(1,1),
	[StagingID] BIGINT NOT NULL,
	[TransferLogID] BIGINT NOT NULL,--新浪流水订单号
	[TransactionLogID] BIGINT NULL,--内部交易号，与accountdetail.TransactionLogID关联
	[AccountID] BIGINT NOT NULL,
	[AccountType] TINYINT NOT NULL,--账户类型 0：基本帐户，1：收益账户，(2：奖励账户，)3：活期账户，4：存钱罐账户，(5：定期产品收益账户，6：定期产品账户)
	[TargetAccountID] BIGINT NULL,
	[TargetAccountType] TINYINT NULL,--账户类型 0：基本帐户，1：收益账户，(2：奖励账户，)3：活期账户，4：存钱罐账户，(5：定期产品收益账户，6：定期产品账户)
	[Type] TINYINT NOT NULL,--0：转入 1：转出
	[CustomType] INT NOT NULL,
	[Status] TINYINT NOT NULL,--0：发起，1：申请中，2：交易成功，21：公共账户垫付交易成功但公共账户还未到账，3：交易失败
	[Amount] DECIMAL(18,4) NULL,
	[ErrorCode] INT NULL,
	[Message] NVARCHAR(MAX) NULL,
	[Ext1] NVARCHAR(1000) NULL,
	[Ext2] NVARCHAR(1000) NULL,
	[Ext3] NVARCHAR(1000) NULL,
	[Created] DATETIME NOT NULL,
	[Modified] DATETIME NOT NULL,
	[Source] NVARCHAR(100) NOT NULL, 
    [StagingInsertTime] DATETIME NOT NULL, 
	[RecordInsertTime] DATETIME NOT NULL, 
    CONSTRAINT [PK_BAD_transferlog] PRIMARY KEY([BadRecordID])
)
