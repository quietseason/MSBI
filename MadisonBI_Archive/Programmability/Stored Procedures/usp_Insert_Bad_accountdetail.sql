CREATE PROCEDURE [dbo].[usp_Insert_Bad_accountdetail]
AS
BEGIN
	INSERT INTO BAD_accountdetail(
		[StagingID],
		[AccountDetailID],
		[AccountID],
		[AccountType],
		[TransactionLogID],
		[Type],
		[CustomType],
		[Direction],
		[Amount],
		[AfterBalance],
		[RelatedFreezeID],
		[Memo],
		[Created],
		[Source], 
		[StagingInsertTime],
		[RecordInsertTime]
	)
	SELECT
		[StagingID],
		[AccountDetailID],
		[AccountID],
		[AccountType],
		[TransactionLogID],
		[Type],
		[CustomType],
		[Direction],
		[Amount],
		[AfterBalance],
		[RelatedFreezeID],
		[Memo],
		[Created],
		[Source], 
		[StagingInsertTime],
		[RecordInsertTime]
	FROM DBO.DELTA_Bad_accountdetail S
	WHERE NOT EXISTS(
	SELECT 1 FROM DBO.BAD_accountdetail T
	WHERE S.StagingID = T.StagingID
	AND S.[StagingInsertTime] = T.[StagingInsertTime]
	)
END
