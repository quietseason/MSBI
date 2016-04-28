CREATE FUNCTION [dbo].[fn_DecryptString]
(
	@Ciphertext VARCHAR(1200)
)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @PosCurr INT = 2, @MaxLen INT, @Plaintext VARCHAR(500) = '', @Code INT
	SELECT @MaxLen = LEN(@Ciphertext)
	WHILE @PosCurr < @MaxLen
	BEGIN
		SET @Code = CONVERT(INT,CONVERT(VARBINARY(3),'0x' + SUBSTRING(@Ciphertext,@PosCurr,2),1))
		SET @Plaintext = @Plaintext + CHAR(@Code)
		SET @PosCurr = @PosCurr + 2
	END
	RETURN @Plaintext
END
