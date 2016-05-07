CREATE PROCEDURE [dbo].[usp_RemoveDuplicate_ProductBid]
AS
BEGIN
	DELETE T
	FROM DBO.CLEAN_ProductBid T
	WHERE EXISTS(
	  SELECT 1 FROM DBO.CLEAN_ProductBid C
	  WHERE T.[ProductBidID] = C.[ProductBidID]
	  AND T.[ProductID] = C.[ProductID]
	  AND T.[ProductType] = C.[ProductType]
	  AND T.[AnnualizedReturn] = C.[AnnualizedReturn]
	  AND T.[HoldingPeriod] = C.[HoldingPeriod]
	  AND T.[ProductTitle] = C.[ProductTitle]
      AND T.[AccountID] = C.[AccountID]
	  AND T.[Status] = C.[Status]
      AND T.[BidAmount] = C.[BidAmount]
	  AND T.[RemainingCapital] = C.[RemainingCapital]
      AND T.[CouponID] = C.[CouponID]
	  AND T.[CouponAmount] = C.[CouponAmount]
	  AND T.[Interest] = C.[Interest]
	  AND T.[RemainingInterest] = C.[RemainingInterest]
	  AND T.[Penalty] = C.[Penalty]
	  AND T.[NextRepayDay] = C.[NextRepayDay]
	  AND T.[StartDate] = C.[StartDate]
	  AND T.[EndDate] = C.[EndDate]
	  AND T.[BidTime] = C.[BidTime]
	  AND T.[ProductBidDerivedID] > C.[ProductBidDerivedID]
	)
END
