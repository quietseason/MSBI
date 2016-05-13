CREATE PROCEDURE [dbo].[usp_Merge_AccountDetail]
  @InsertedRows BIGINT = 0 OUTPUT,
  @UpdatedRows BIGINT = 0 OUTPUT
AS
BEGIN
	--Specify ETL Process Time
	DECLARE @ETLProcessTime DATETIME = GETDATE()
	--Drop and re-create merge out table
	IF OBJECT_ID('tempdb..#MergeOut_AccountDetail','U') IS NOT NULL
	DROP TABLE #MergeOut_AccountDetail
	SELECT TOP 0 * INTO #MergeOut_AccountDetail FROM DBO.AccountDetail
	ALTER TABLE #MergeOut_AccountDetail DROP COLUMN [AccountDetailDerivedID]
	ALTER TABLE #MergeOut_AccountDetail ADD [ActionOut] VARCHAR(100)
	--Merge target table in Data Warehouse
	MERGE DBO.AccountDetail AS T
	USING DBO.CLEAN_AccountDetail AS S
	ON (T.AccountDetailID = S.AccountDetailID)
	WHEN NOT MATCHED THEN INSERT--Insert brand new rows
	([AccountDetailID],[AccountID],[AccountType],[TransactionLogID],[TransactionType],[CustomTransactionType],[Direction],[Amount],[AfterBalance],[RelatedFreezeID],[Memo],[TransactionTime],[IsCurrent],[EffectiveDate],[ExpiredDate])
	VALUES([AccountDetailID],[AccountID],[AccountType],[TransactionLogID],[TransactionType],[CustomTransactionType],[Direction],[Amount],[AfterBalance],[RelatedFreezeID],[Memo],[TransactionTime],1,'1900-01-01','9999-12-31')
	WHEN MATCHED AND T.[IsCurrent] = 1 
	AND (
	  T.[AccountID] <> S.[AccountID]
	  OR T.[AccountType] <> S.[AccountType]
	  OR T.[TransactionLogID] <> S.[TransactionLogID]
	  OR T.[TransactionType] <> S.[TransactionType]
	  OR T.[CustomTransactionType] <> S.[CustomTransactionType]
	  OR T.[Direction] <> S.[Direction]
	  OR T.[Amount] <> S.[Amount]
	  OR T.[AfterBalance] <> S.[AfterBalance]
	  OR T.[RelatedFreezeID] <> S.[RelatedFreezeID]
	  OR T.[Memo] <> S.[Memo]
	  OR T.[TransactionTime] <> S.[TransactionTime]
	)
	THEN UPDATE--Expire the old rows
	SET
	T.[IsCurrent] = 0,
	T.[ExpiredDate] = @ETLProcessTime
	OUTPUT 
	$Action AS ActionOut,
	S.[AccountDetailID],
	S.AccountID,
	S.[AccountType],
	S.[TransactionLogID],
	S.[TransactionType],
	S.[CustomTransactionType],
	S.[Direction],
	S.[Amount],
	S.[AfterBalance],
	S.[RelatedFreezeID],
	S.[Memo],
	S.[TransactionTime],
	1 AS [IsCurrent],
	DATEADD(SECOND,1,@ETLProcessTime) AS [EffectiveDate],
	'9999-12-31' AS [ExpiredDate]
	INTO #MergeOut_AccountDetail(ActionOut,[AccountDetailID],[AccountID],[AccountType],[TransactionLogID],[TransactionType],[CustomTransactionType],[Direction],[Amount],[AfterBalance],[RelatedFreezeID],[Memo],[TransactionTime],[IsCurrent],[EffectiveDate],[ExpiredDate]);
	--Insert changed rows
	INSERT INTO DBO.AccountDetail([AccountDetailID],[AccountID],[AccountType],[TransactionLogID],[TransactionType],[CustomTransactionType],[Direction],[Amount],[AfterBalance],[RelatedFreezeID],[Memo],[TransactionTime],[IsCurrent],[EffectiveDate],[ExpiredDate])
	SELECT
	  [AccountDetailID],[AccountID],[AccountType],[TransactionLogID],[TransactionType],[CustomTransactionType],[Direction],[Amount],[AfterBalance],[RelatedFreezeID],[Memo],[TransactionTime],[IsCurrent],[EffectiveDate],[ExpiredDate]
	FROM #MergeOut_AccountDetail
	WHERE ActionOut = 'UPDATE';
	--Calculate the processed row count
	SELECT @InsertedRows = COUNT(*) FROM #MergeOut_AccountDetail WHERE ActionOut = 'INSERT'
	SELECT @UpdatedRows = COUNT(*) FROM #MergeOut_AccountDetail WHERE ActionOut = 'UPDATE'
	SET @InsertedRows = @InsertedRows + @UpdatedRows
END
