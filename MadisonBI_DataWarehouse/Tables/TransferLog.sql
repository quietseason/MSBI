CREATE TABLE [dbo].[TransferLog]
(
	[TransferLogDerivedID] BIGINT NOT NULL IDENTITY(1,1),
	[SinaPayOrderID] BIGINT NOT NULL,--新浪流水订单号
	[TransactionLogID] BIGINT NULL,--内部交易号，与accountdetail.TransactionLogID关联
	[AccountID] BIGINT NOT NULL,
	[AccountType] TINYINT NOT NULL,--账户类型 0：基本帐户，1：收益账户，(2：奖励账户，)3：活期账户，4：存钱罐账户，(5：定期产品收益账户，6：定期产品账户)
	[TargetAccountID] BIGINT NOT NULL,--DEFAULT -1
	[TargetAccountType] TINYINT NOT NULL,--账户类型 0：基本帐户，1：收益账户，(2：奖励账户，)3：活期账户，4：存钱罐账户，(5：定期产品收益账户，6：定期产品账户) DEFAULT -1
	[Type] TINYINT NOT NULL,--0：转入 1：转出
	[CustomTransactionType] INT NOT NULL,
	[Status] TINYINT NOT NULL,--0：发起，1：申请中，2：交易成功，21：公共账户垫付交易成功但公共账户还未到账，3：交易失败
	[Amount] DECIMAL(18,4) NOT NULL,--DEFAULT 0
	[ErrorCode] INT NOT NULL,--DEFAULT -1
	[Message] NVARCHAR(MAX) NOT NULL,--DEFAULT 'UNKNOWN'
	[Created] DATETIME NOT NULL,
	[Modified] DATETIME NOT NULL,
	[IsCurrent] BIT NOT NULL, --0：历史记录，1：当前记录
    [EffectiveDate] DATETIME NOT NULL, --记录生效时间
    [ExpiredDate] DATETIME NOT NULL, --记录失效时间
    CONSTRAINT [PK_TransferLog] PRIMARY KEY([TransferLogDerivedID])
)

GO

CREATE UNIQUE INDEX [FX_TransferLog] ON DBO.[TransferLog]([SinaPayOrderID])
WHERE [IsCurrent] = 1
GO

