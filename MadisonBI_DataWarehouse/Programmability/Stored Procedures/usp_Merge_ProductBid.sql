CREATE PROCEDURE [dbo].[usp_Merge_ProductBid]
  @InsertedRows BIGINT = 0 OUTPUT,
  @UpdatedRows BIGINT = 0 OUTPUT
AS
BEGIN
	--Specify ETL Process Time
	DECLARE @ETLProcessTime DATETIME = GETDATE()
	--Drop and re-create merge out table
	IF OBJECT_ID('tempdb..#MergeOut_ProductBid','U') IS NOT NULL
	DROP TABLE #MergeOut_ProductBid
	SELECT TOP 0 * INTO #MergeOut_ProductBid FROM DBO.ProductBid
	ALTER TABLE #MergeOut_ProductBid DROP COLUMN [ProductBidDerivedID]
	ALTER TABLE #MergeOut_ProductBid ADD [ActionOut] VARCHAR(100)
	--Merge target table in Data Warehouse
	MERGE DBO.ProductBid AS T
	USING DBO.CLEAN_ProductBid AS S
	ON (T.ProductBidID = S.ProductBidID)
	WHEN NOT MATCHED THEN INSERT--Insert brand new rows
	([ProductID],[ProductType],[AnnualizedReturn],[HoldingPeriod],[ProductTitle],[AccountID],[Status],[BidAmount],[RemainingCapital],[CouponID],[CouponAmount],[Interest],[RemainingInterest],[Penalty],[NextRepayDay],[StartDate],[EndDate],[BidTime],[NumberOfBid],[IsCurrent],[EffectiveDate],[ExpiredDate])
	VALUES([ProductID],[ProductType],[AnnualizedReturn],[HoldingPeriod],[ProductTitle],[AccountID],[Status],[BidAmount],[RemainingCapital],[CouponID],[CouponAmount],[Interest],[RemainingInterest],[Penalty],[NextRepayDay],[StartDate],[EndDate],[BidTime],0,1,'1900-01-01','9999-12-31')
	WHEN MATCHED AND T.[IsCurrent] = 1 
	AND (
	  T.[ProductID] <> S.[ProductID]
	  OR T.[ProductType] <> S.[ProductType]
	  OR T.[AnnualizedReturn] <> S.[AnnualizedReturn]
	  OR T.[HoldingPeriod] <> S.[HoldingPeriod]
	  OR T.[ProductTitle] <> S.[ProductTitle]
      OR T.[AccountID] <> S.[AccountID]
	  OR T.[Status] <> S.[Status]
      OR T.[BidAmount] <> S.[BidAmount]
	  OR T.[RemainingCapital] <> S.[RemainingCapital]
      OR T.[CouponID] <> S.[CouponID]
	  OR T.[CouponAmount] <> S.[CouponAmount]
	  OR T.[Interest] <> S.[Interest]
	  OR T.[RemainingInterest] <> S.[RemainingInterest]
	  OR T.[Penalty] <> S.[Penalty]
	  OR T.[NextRepayDay] <> S.[NextRepayDay]
	  OR T.[StartDate] <> S.[StartDate]
	  OR T.[EndDate] <> S.[EndDate]
	  OR T.[BidTime] <> S.[BidTime]
	)
	THEN UPDATE--Expire the old rows
	SET
	T.[IsCurrent] = 0,
	T.[ExpiredDate] = @ETLProcessTime
	OUTPUT 
	$Action AS ActionOut,
	S.[ProductID],
	S.[ProductType],
	S.[AnnualizedReturn],
	S.[HoldingPeriod],
	S.[ProductTitle],
    S.[AccountID],
	S.[Status],
    S.[BidAmount],
	S.[RemainingCapital],
    S.[CouponID],
	S.[CouponAmount],
	S.[Interest],
	S.[RemainingInterest],
	S.[Penalty],
	S.[NextRepayDay],
	S.[StartDate],
	S.[EndDate],
	S.[BidTime],
	0 AS [NumberOfBid],
	1 AS [IsCurrent],
	DATEADD(SECOND,1,@ETLProcessTime) AS [EffectiveDate],
	'9999-12-31' AS [ExpiredDate]
	INTO #MergeOut_ProductBid(ActionOut,[ProductID],[ProductType],[AnnualizedReturn],[HoldingPeriod],[ProductTitle],[AccountID],[Status],[BidAmount],[RemainingCapital],[CouponID],[CouponAmount],[Interest],[RemainingInterest],[Penalty],[NextRepayDay],[StartDate],[EndDate],[BidTime],[NumberOfBid],[IsCurrent],[EffectiveDate],[ExpiredDate]);
	--Insert changed rows
	INSERT INTO DBO.ProductBid([ProductID],[ProductType],[AnnualizedReturn],[HoldingPeriod],[ProductTitle],[AccountID],[Status],[BidAmount],[RemainingCapital],[CouponID],[CouponAmount],[Interest],[RemainingInterest],[Penalty],[NextRepayDay],[StartDate],[EndDate],[BidTime],[NumberOfBid],[IsCurrent],[EffectiveDate],[ExpiredDate])
	SELECT
	  [ProductID],[ProductType],[AnnualizedReturn],[HoldingPeriod],[ProductTitle],[AccountID],[Status],[BidAmount],[RemainingCapital],[CouponID],[CouponAmount],[Interest],[RemainingInterest],[Penalty],[NextRepayDay],[StartDate],[EndDate],[BidTime],[NumberOfBid],[IsCurrent],[EffectiveDate],[ExpiredDate]
	FROM #MergeOut_ProductBid
	WHERE ActionOut = 'UPDATE';
	--Calculate the processed row count
	SELECT @InsertedRows = COUNT(*) FROM #MergeOut_ProductBid WHERE ActionOut = 'INSERT'
	SELECT @UpdatedRows = COUNT(*) FROM #MergeOut_ProductBid WHERE ActionOut = 'UPDATE'
	SET @InsertedRows = @InsertedRows + @UpdatedRows
END
