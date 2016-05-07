CREATE TABLE [dbo].[BAD_productbid]
(
	[BadRecordID] BIGINT NOT NULL IDENTITY(1,1),
	[StagingID] BIGINT,
	[ProductBidID] BIGINT NOT NULL, --产品购买ID
	[ProductID] BIGINT NULL,--购买产品ID
	[ProductType] TINYINT NOT NULL, --产品类型 1：活期，2：定期先息后本，3：定期本息一次性偿还，4：定期等额本息，5：弹升月产品，6：弹升季产品，7：弹升半年产品，8：弹升长产品，99：特殊定期本息一次偿还（新手专享）
	[ProductRate] FLOAT NULL,--年化收益率*100
	[ProductDuration] INT NULL,--产品持有时长(天)
	[ProductTitle] NVARCHAR(200) NULL,--产品名称
    [AccountID] BIGINT NOT NULL, --购买账户ID
	[Status] TINYINT NOT NULL, --产品投资状态 0:申请中，1：预约中，2：在投中，3：还款结束，4：提前赎回，5：提前赎回且还款结束，9：已删除
    [BidAmount] DECIMAL(18, 4) NOT NULL, --投资金额
	[RemainingAmount] DECIMAL(18,4) NOT NULL,--剩余本金
    [CouponID] BIGINT NULL, --使用理财红包ID
	[CouponAmount] DECIMAL(18,4) NULL,--使用红包金额
	[Interest] DECIMAL(18,4) NOT NULL,--总利息
	[RemainingInterest] DECIMAL(18,4) NOT NULL,--剩余利息
	[Penalty] DECIMAL(18,4) NOT NULL,--罚金
	[NextRepayDay] DATE NULL,--下次还款日
	[StartDate] DATE NULL,--起息日
	[EndDate] DATE NULL,--计息结束日期
    [Created] DATETIME NOT NULL, 
    [Modified] DATETIME NULL, 
    [Source] NVARCHAR(100) NOT NULL, 
    [StagingInsertTime] DATETIME NOT NULL, 
	[RecordInsertTime] DATETIME NOT NULL, 
    CONSTRAINT [PK_BAD_productbid] PRIMARY KEY([BadRecordID])
)
