CREATE PROCEDURE [dbo].[usp_RemoveDuplicate_AccountInfo]
AS
BEGIN
	DELETE T
	FROM DBO.CLEAN_AccountInfo T
	WHERE EXISTS(
	  SELECT 1 FROM DBO.CLEAN_AccountInfo C
	  WHERE T.AccountID = C.AccountID
	  AND T.[Name] = C.[Name]
	  AND T.[Mobile] = C.[Mobile]
	  AND T.[BirthDate] = C.[BirthDate]
	  AND T.[Gender] = C.[Gender]
	  AND T.[ReferralCode] = C.[ReferralCode]
	  AND T.[InvitedBy] = C.[InvitedBy]
	  AND T.[PasswordSet] = C.[PasswordSet]
	  AND T.[RealNameRegistration] = C.[RealNameRegistration]
	  AND T.[CardBinding] = C.[CardBinding]
	  AND T.[ProvinceID] = C.[ProvinceID]
	  AND T.[CityID] = C.[CityID]
	  AND T.AccountDerivedID > C.AccountDerivedID
	)
END
