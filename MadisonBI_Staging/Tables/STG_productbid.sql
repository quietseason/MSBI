CREATE TABLE [dbo].[STG_productbid]
(
	[StagingID] BIGINT NOT NULL IDENTITY(1,1),
	[ProductBidID] BIGINT NOT NULL, 
    [AccountID] BIGINT NOT NULL, 
    [Amount] DECIMAL(18, 4) NULL, 
    [ProductID] BIGINT NOT NULL, 
    [ProductType] TINYINT NOT NULL, 
    [Status] TINYINT NOT NULL, 
    [CouponID] BIGINT NULL, 
    [Created] DATETIME NOT NULL, 
    [Modified] DATETIME NOT NULL, 
    [Source] VARCHAR(100) NOT NULL, 
    [StagingInsertTime] DATETIME NOT NULL, 
    CONSTRAINT [PK_STG_productbid] PRIMARY KEY(StagingID)
)
