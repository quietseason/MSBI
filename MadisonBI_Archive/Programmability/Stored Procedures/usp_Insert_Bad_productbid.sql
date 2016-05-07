CREATE PROCEDURE [dbo].[usp_Insert_Bad_productbid]
AS
BEGIN
  INSERT INTO DBO.BAD_productbid(
	[StagingID],
	[ProductBidID],
	[ProductID],
	[ProductType],
	[ProductRate],
	[ProductDuration],
	[ProductTitle],
    [AccountID],
	[Status],
    [BidAmount],
	[RemainingAmount],
    [CouponID],
	[CouponAmount],
	[Interest],
	[RemainingInterest],
	[Penalty],
	[NextRepayDay],
	[StartDate],
	[EndDate],
    [Created],
    [Modified],
    [Source],
    [StagingInsertTime],
	[RecordInsertTime]
  )
  SELECT 
	[StagingID],
	[ProductBidID],
	[ProductID],
	[ProductType],
	[ProductRate],
	[ProductDuration],
	[ProductTitle],
    [AccountID],
	[Status],
    [BidAmount],
	[RemainingAmount],
    [CouponID],
	[CouponAmount],
	[Interest],
	[RemainingInterest],
	[Penalty],
	[NextRepayDay],
	[StartDate],
	[EndDate],
    [Created],
    [Modified],
    [Source],
    [StagingInsertTime],
	[RecordInsertTime]
  FROM DBO.DELTA_Bad_productbid S
  WHERE NOT EXISTS(
	SELECT 1 FROM DBO.BAD_productbid T
	WHERE S.StagingID = T.StagingID
	AND S.[StagingInsertTime] = T.[StagingInsertTime]
  )
END