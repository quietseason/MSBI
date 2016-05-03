CREATE PROCEDURE [dbo].[usp_DropEarliestPartition]
	@TableSchema VARCHAR(20) = 'DBO',
	@TableName VARCHAR(100)
AS
BEGIN
	--Get the partition number of the earliest partition
	DECLARE @EarliestPartitionNo INT
	SELECT @EarliestPartitionNo = MIN(partition_number) FROM SYS.partitions WHERE object_id = OBJECT_ID(@TableSchema + '.' + @TableName)
	--Truncate the partition
	EXEC [dbo].[usp_TruncatePartition] @SchemaName = @TableSchema, @TabName = @TableName, @PartitionNo = @EarliestPartitionNo
	--Get the partition scheme
	DECLARE @PartitionScheme NVARCHAR(100)
	EXEC [dbo].[usp_GetPartitionScheme] @TableName, @Scheme = @PartitionScheme OUTPUT
	--Get the function and range
	DECLARE @PartitionFunction NVARCHAR(100), @RangeValue NVARCHAR(100)
	SELECT @PartitionFunction = CONVERT(NVARCHAR(100),PF.name), @RangeValue = CONVERT(NVARCHAR(100),MIN(PRV.Value),121)
	FROM SYS.PARTITION_SCHEMES PS
	INNER JOIN SYS.PARTITION_FUNCTIONS PF ON PS.function_id = PF.function_id
	INNER JOIN SYS.PARTITION_RANGE_VALUES PRV ON PRV.function_id = PF.function_id
	WHERE PS.name = @PartitionScheme
	GROUP BY PF.name
	--Drop the partition
	DECLARE @DropPartition NVARCHAR(300) = N'ALTER PARTITION FUNCTION ' + @PartitionFunction + N'() MERGE RANGE(''' + @RangeValue + N''')'
	EXEC(@DropPartition)
END
