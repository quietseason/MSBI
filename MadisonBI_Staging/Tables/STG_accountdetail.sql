CREATE TABLE [dbo].[STG_accountdetail]
(
	[StagingID] BIGINT NOT NULL IDENTITY(1,1),
	[AccountDetailID] BIGINT NOT NULL,
	[AccountID] BIGINT NOT NULL,
	[AccountType] TINYINT NOT NULL,--账户类型 0：基本帐户，1：收益账户，2：奖励账户，3：活期账户，4：存钱罐账户，5：定期产品收益账户，6：定期产品账户
	[TransactionLogID] BIGINT NULL,
	[Type] TINYINT NULL,--1：充值，11：充值冲正，2：提现，21：提现冲正，3：转出，31：转出冲正，4：转入，41：转入冲正，5：支付，51：支付冲正，9：冻结，91：解冻
	[CustomType] INT NOT NULL,
	[Direction] BIT NOT NULL,--金额加减 0：-，1：+
	[Amount] DECIMAL(18,4) NULL,
	[AfterBalance] DECIMAL(18,4) NULL,
	[RelatedFreezeID] BIGINT NULL,
	[Memo] NVARCHAR(2000) NULL,
	[Created] DATETIME NOT NULL,
	[Source] NVARCHAR(100) NOT NULL, 
    [StagingInsertTime] DATETIME NOT NULL, 
    CONSTRAINT [PK_STG_accountdetail] PRIMARY KEY(StagingID)
)
