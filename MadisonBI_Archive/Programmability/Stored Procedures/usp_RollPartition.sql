CREATE PROCEDURE [dbo].[usp_RollPartition]
	@NextPartitionStart DATETIME,
	@param2 int
AS
BEGIN
	ALTER PARTITION SCHEME sch_Partition NEXT USED 'Primary'
	ALTER PARTITION FUNCTION fn_Partition()
	SPLIT RANGE(@NextPartitionStart)
END
