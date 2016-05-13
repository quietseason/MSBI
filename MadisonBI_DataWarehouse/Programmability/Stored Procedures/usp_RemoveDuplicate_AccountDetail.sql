CREATE PROCEDURE [dbo].[usp_RemoveDuplicate_AccountDetail]
AS
BEGIN
	DELETE T
	FROM DBO.CLEAN_AccountDetail T
	WHERE EXISTS(
	  SELECT 1 FROM DBO.CLEAN_AccountDetail C
	  WHERE T.[AccountDetailID] = C.[AccountDetailID]
	  AND T.[AccountID] = C.[AccountID]
	  AND T.[AccountType] = C.[AccountType]
	  AND T.[TransactionLogID] = C.[TransactionLogID]
	  AND T.[TransactionType] = C.[TransactionType]
	  AND T.[CustomTransactionType] = C.[CustomTransactionType]
	  AND T.[Direction] = C.[Direction]
	  AND T.[Amount] = C.[Amount]
	  AND T.[AfterBalance] = C.[AfterBalance]
	  AND T.[RelatedFreezeID] = C.[RelatedFreezeID]
	  AND T.[Memo] = C.[Memo]
	  AND T.[TransactionTime] = C.[TransactionTime]
	  AND T.[AccountDetailDerivedID] > C.[AccountDetailDerivedID]
	)
END
