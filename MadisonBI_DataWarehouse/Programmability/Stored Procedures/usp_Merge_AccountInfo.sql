CREATE PROCEDURE [dbo].[usp_Merge_AccountInfo]
  @InsertedRows BIGINT = 0 OUTPUT,
  @UpdatedRows BIGINT = 0 OUTPUT
AS
BEGIN
	--Specify ETL Process Time
	DECLARE @ETLProcessTime DATETIME = GETDATE()
	--Drop and re-create merge out table
	IF OBJECT_ID('tempdb..#MergeOut_AccountInfo','U') IS NOT NULL
	DROP TABLE #MergeOut_AccountInfo
	SELECT TOP 0 * INTO #MergeOut_AccountInfo FROM DBO.AccountInfo
	ALTER TABLE #MergeOut_AccountInfo DROP COLUMN [AccountDerivedID]
	ALTER TABLE #MergeOut_AccountInfo ADD [ActionOut] VARCHAR(100)
	--Merge target table in Data Warehouse
	MERGE DBO.AccountInfo AS T
	USING DBO.CLEAN_AccountInfo AS S
	ON (T.AccountID = S.AccountID)
	WHEN NOT MATCHED THEN INSERT--Insert brand new rows
	([AccountID],[Name],[Mobile],[BirthDate],[Gender],[ReferralCode],[InvitedBy],[PasswordSet],[RealNameRegistration],[CardBinding],[ProvinceID],[CityID],[IsCurrent],[EffectiveDate],[ExpiredDate])
	VALUES([AccountID],[Name],[Mobile],[BirthDate],[Gender],[ReferralCode],[InvitedBy],[PasswordSet],[RealNameRegistration],[CardBinding],[ProvinceID],[CityID],1,'1900-01-01','9999-12-31')
	WHEN MATCHED AND T.[IsCurrent] = 1 
	AND (
	  T.[Name] <> S.[Name]
	  OR T.[Mobile] <> S.[Mobile]
	  OR T.[BirthDate] <> S.[BirthDate]
	  OR T.[Gender] <> S.[Gender]
	  OR T.[ReferralCode] <> S.[ReferralCode]
	  OR T.[InvitedBy] <> S.[InvitedBy]
	  OR T.[PasswordSet] <> S.[PasswordSet]
	  OR T.[RealNameRegistration] <> S.[RealNameRegistration]
	  OR T.[CardBinding] <> S.[CardBinding]
	  OR T.[ProvinceID] <> S.[ProvinceID]
	  OR T.[CityID] <> S.[CityID]
	)
	THEN UPDATE--Expire the old rows
	SET
	T.[IsCurrent] = 0,
	T.[ExpiredDate] = @ETLProcessTime
	OUTPUT 
	$Action AS ActionOut,
	S.AccountID,
	S.[Name],
	S.[Mobile],
	S.[BirthDate],
	S.[Gender],
	S.[ReferralCode],
	S.[InvitedBy],
	S.[PasswordSet],
	S.[RealNameRegistration],
	S.[CardBinding],
	S.[ProvinceID],
	S.[CityID],
	1 AS [IsCurrent],
	DATEADD(SECOND,1,@ETLProcessTime) AS [EffectiveDate],
	'9999-12-31' AS [ExpiredDate]
	INTO #MergeOut_AccountInfo(ActionOut,[AccountID],[Name],[Mobile],[BirthDate],[Gender],[ReferralCode],[InvitedBy],[PasswordSet],[RealNameRegistration],[CardBinding],[ProvinceID],[CityID],[IsCurrent],[EffectiveDate],[ExpiredDate]);
	--Insert changed rows
	INSERT INTO DBO.AccountInfo([AccountID],[Name],[Mobile],[BirthDate],[Gender],[ReferralCode],[InvitedBy],[PasswordSet],[RealNameRegistration],[CardBinding],[ProvinceID],[CityID],[IsCurrent],[EffectiveDate],[ExpiredDate])
	SELECT
	  [AccountID],[Name],[Mobile],[BirthDate],[Gender],[ReferralCode],[InvitedBy],[PasswordSet],[RealNameRegistration],[CardBinding],[ProvinceID],[CityID],[IsCurrent],[EffectiveDate],[ExpiredDate]
	FROM #MergeOut_AccountInfo
	WHERE ActionOut = 'UPDATE';
	--Calculate the processed row count
	SELECT @InsertedRows = COUNT(*) FROM #MergeOut_AccountInfo WHERE ActionOut = 'INSERT'
	SELECT @UpdatedRows = COUNT(*) FROM #MergeOut_AccountInfo WHERE ActionOut = 'UPDATE'
	SET @InsertedRows = @InsertedRows + @UpdatedRows
END
