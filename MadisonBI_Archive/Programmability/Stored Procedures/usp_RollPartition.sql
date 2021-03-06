﻿CREATE PROCEDURE [dbo].[usp_RollPartition]
	@TableName NVARCHAR(100),
	@MaxPartitionValue NVARCHAR(100),
	@IncrementStep INT = 2,
	@RemovePartition BIT = 0
AS
BEGIN
	DECLARE @PartitionStart DATETIME, @MaxPartitionDate DATETIME, @PartitionScheme NVARCHAR(100), @ParitionFunction NVARCHAR(100)
	IF @MaxPartitionValue IS NOT NULL
	BEGIN
		--Set variables for loop
		SET @MaxPartitionDate = CONVERT(DATETIME,@MaxPartitionValue,112)
		EXEC [dbo].[usp_GetPartitionScheme] @TableName, @Scheme = @PartitionScheme OUTPUT
		SELECT @PartitionStart = CONVERT(DATETIME,MAX(PRV.value),121), @ParitionFunction = CONVERT(NVARCHAR(100),PF.name)
		FROM SYS.PARTITION_SCHEMES PS
		INNER JOIN SYS.PARTITION_FUNCTIONS PF ON PS.function_id = PF.function_id
		INNER JOIN SYS.PARTITION_RANGE_VALUES PRV ON PRV.function_id = PF.function_id
		WHERE PS.name = @PartitionScheme
		GROUP BY PF.name
		--Loop
		WHILE @PartitionStart <= @MaxPartitionDate
		BEGIN
			--Increase @PartitionStart
			SET @PartitionStart = DATEADD(MONTH,@IncrementStep,@PartitionStart)
			--Create a new partition
			DECLARE @AlterScheme NVARCHAR(300) = N'ALTER PARTITION SCHEME ' + @PartitionScheme + N' NEXT USED ''Primary'''
			DECLARE @AlterFunction NVARCHAR(300) = N'ALTER PARTITION FUNCTION ' + @ParitionFunction + N'() SPLIT RANGE(''' + CONVERT(NVARCHAR(100),@PartitionStart,121) + N''')'
			EXEC(@AlterScheme)
			EXEC(@AlterFunction)
			--Truncate and remove the earliest partition
			IF @RemovePartition = 1
			EXEC [dbo].[usp_DropEarliestPartition] @TableName = @TableName
		END
	END
END
/*
EXEC [dbo].[usp_RollPartition]
	@TableName = ?,
	@MaxPartitionValue = ?
*/