CREATE PROCEDURE [dbo].[usp_Merge_DeletedAccount]
	@InsertedRows BIGINT OUTPUT,
	@UpdatedRows BIGINT OUTPUT
AS
BEGIN
	SET @UpdatedRows = -1
	INSERT INTO DBO.DeletedAccount
	SELECT 
		A.AccountID AS DeletedAccountID,
		GETDATE() AS ETLInsertTime
	FROM DBO.AccountInfo A WITH(NOLOCK)
	WHERE A.IsCurrent = 1
	AND NOT EXISTS(
		SELECT 1 FROM DBO.CLEAN_DeletedAccount CD WITH(NOLOCK)
		WHERE A.AccountID = CD.DeletedAccountID
	)
	AND NOT EXISTS(
		SELECT 1 FROM DBO.DeletedAccount D WITH(NOLOCK)
		WHERE A.AccountID = D.DeletedAccountID
	)
	SET @InsertedRows = @@ROWCOUNT
END
