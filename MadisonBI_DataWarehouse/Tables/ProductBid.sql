CREATE TABLE [dbo].[ProductBid]
(
	[ProductBidDerivedID] BIGINT NOT NULL IDENTITY(1,1),
	[ProductBidID] BIGINT NOT NULL, --产品购买ID
	[ProductID] BIGINT NOT NULL,--购买产品ID
	[ProductType] TINYINT NOT NULL, --产品类型 1：活期，2：定期先息后本，3：定期本息一次性偿还，4：定期等额本息，5：弹升月产品，6：弹升季产品，7：弹升半年产品，8：弹升长产品，99：特殊定期本息一次偿还（新手专享）
	[AnnualizedReturn] FLOAT NOT NULL,--年化收益率*100
	[HoldingPeriod] INT NOT NULL,--产品持有时长(天)
	[ProductTitle] NVARCHAR(200) NOT NULL,--产品名称
    [AccountID] BIGINT NOT NULL, --购买账户ID
	[Status] TINYINT NOT NULL, --产品投资状态 0:申请中，1：预约中，2：在投中，3：还款结束，4：提前赎回，5：提前赎回且还款结束，9：已删除
    [BidAmount] DECIMAL(18, 4) NOT NULL, --投资金额
	[RemainingCapital] DECIMAL(18,4) NOT NULL,--剩余本金
    [CouponID] BIGINT NOT NULL, --使用理财红包ID,-1:未使用理财红包
	[CouponAmount] DECIMAL(18,4) NOT NULL,--使用红包金额,0:未使用理财红包
	[Interest] DECIMAL(18,4) NOT NULL,--总利息
	[RemainingInterest] DECIMAL(18,4) NOT NULL,--剩余利息
	[Penalty] DECIMAL(18,4) NOT NULL,--罚金
	[NextRepayDay] DATE NOT NULL,--下次还款日
	[StartDate] DATE NOT NULL,--起息日
	[EndDate] DATE NOT NULL,--计息结束日期
	[BidTime] DATETIME NOT NULL,--投资日期
	[NumberOfBid] INT NOT NULL,--该账户第几次投资
	[IsCurrent] BIT NOT NULL, --0：历史记录，1：当前记录
    [EffectiveDate] DATETIME NOT NULL, --记录生效时间
    [ExpiredDate] DATETIME NOT NULL, --记录失效时间
	CONSTRAINT [PK_ProductBid] PRIMARY KEY([ProductBidDerivedID])
)

GO

CREATE UNIQUE INDEX [UX_ProductBid] ON [dbo].[ProductBid] ([ProductBidID],[IsCurrent])
