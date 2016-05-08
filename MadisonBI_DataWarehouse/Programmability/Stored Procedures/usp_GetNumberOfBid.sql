CREATE PROCEDURE [dbo].[usp_GetNumberOfBid]
AS
BEGIN
	IF OBJECT_ID('tempdb..#GetNumberOfBid','U') IS NOT NULL
	DROP TABLE #GetNumberOfBid
	SELECT 
		T.ProductBidID,
		T.NumberOfBid,
		ROW_NUMBER() OVER(PARTITION BY T.AccountID ORDER BY T.BidTime) AS calc
	INTO #GetNumberOfBid
	FROM DBO.ProductBid T WITH(NOLOCK)
	WHERE T.IsCurrent = 1
	AND EXISTS(
		SELECT 1 FROM DBO.ProductBid DELTA WITH(NOLOCK)
		WHERE T.AccountID = DELTA.AccountID
		AND DELTA.NumberOfBid = 0
	)
	UPDATE T
	SET T.NumberOfBid = C.calc
	FROM DBO.ProductBid T
	INNER JOIN #GetNumberOfBid C ON T.ProductBidID = C.ProductBidID AND T.IsCurrent = 1
	WHERE T.NumberOfBid = 0
END