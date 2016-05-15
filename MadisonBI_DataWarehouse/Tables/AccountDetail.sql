CREATE TABLE [dbo].[AccountDetail]
(
	[AccountDetailDerivedID] BIGINT NOT NULL IDENTITY(1,1),
	[AccountDetailID] BIGINT NOT NULL,
	[AccountID] BIGINT NOT NULL,
	[AccountType] TINYINT NOT NULL,--账户类型 0：基本帐户，1：收益账户，(2：奖励账户，)3：活期账户，4：存钱罐账户，(5：定期产品收益账户，6：定期产品账户)
	[TransactionLogID] BIGINT NOT NULL,--DEFAULT -1
	[TransactionType] TINYINT NOT NULL,--1：充值，11：充值冲正，2：提现，21：提现冲正，3：转出，31：转出冲正，4：转入，41：转入冲正，5：支付，51：支付冲正，9：冻结，91：解冻
	[CustomTransactionType] INT NOT NULL,
	[Direction] BIT NOT NULL,--金额加减 0：-，1：+
	[Amount] DECIMAL(18,4) NOT NULL,--DEFAULT 0
	[AfterBalance] DECIMAL(18,4) NOT NULL,--DEFAULT 0
	[RelatedFreezeID] BIGINT NOT NULL,--DEFAULT 0
	[Memo] NVARCHAR(2000) NOT NULL,--DEFAULT 'UNKNOWN'
	[TransactionTime] DATETIME NOT NULL,
	[IsCurrent] BIT NOT NULL, --0：历史记录，1：当前记录
    [EffectiveDate] DATETIME NOT NULL, --记录生效时间
    [ExpiredDate] DATETIME NOT NULL, --记录失效时间
    CONSTRAINT [PK_AccountDetail] PRIMARY KEY([AccountDetailDerivedID])
)

GO

CREATE UNIQUE INDEX [FX_AccountDetail] ON DBO.[AccountDetail]([AccountDetailID])
WHERE [IsCurrent] = 1
GO

CREATE NONCLUSTERED INDEX [IX_AccountDetail] ON DBO.[AccountDetail]([AccountID],[AccountType],[Direction])
GO