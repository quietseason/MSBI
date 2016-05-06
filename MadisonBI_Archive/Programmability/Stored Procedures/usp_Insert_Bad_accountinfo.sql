CREATE PROCEDURE [dbo].[usp_Insert_Bad_accountinfo]
AS
BEGIN
  INSERT INTO DBO.BAD_accountinfo(
	[StagingID],
	[AccountID],
    [Name],
    [Mobile],
    [IDType],
    [IDNumber],
    [ReferralCode],
    [InvitedBy],
    [Status],
	[CustomStatus],
    [Created],
    [Modified],
    [Source],
    [StagingInsertTime],
	[RecordInsertTime]
  )
  SELECT 
	[StagingID],
	[AccountID],
    [Name],
    [Mobile],
    [IDType],
    [IDNumber],
    [ReferralCode],
    [InvitedBy],
    [Status],
	[CustomStatus],
    [Created],
    [Modified],
    [Source],
    [StagingInsertTime],
	[RecordInsertTime]
  FROM DBO.DELTA_BAD_accountinfo S
  WHERE NOT EXISTS(
	SELECT 1 FROM DBO.BAD_accountinfo T
	WHERE S.StagingID = T.StagingID
	AND S.[StagingInsertTime] = T.[StagingInsertTime]
  )
END