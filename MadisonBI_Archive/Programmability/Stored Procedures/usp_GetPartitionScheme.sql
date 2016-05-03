CREATE PROCEDURE [dbo].[usp_GetPartitionScheme]
	@TableName NVARCHAR(100),
	@Scheme NVARCHAR(100) OUTPUT
AS
BEGIN
	SELECT DISTINCT @Scheme = ps.name
	FROM sys.dm_db_partition_stats p
	INNER JOIN sys.indexes i
	ON i.OBJECT_ID = p.OBJECT_ID AND i.index_id = p.index_id
	INNER JOIN sys.partition_schemes ps
	ON ps.data_space_id = i.data_space_id
	WHERE OBJECTPROPERTY(p.OBJECT_ID, 'ISMSSHipped') = 0
	AND p.index_id IN (0,1)
	AND OBJECT_NAME(p.OBJECT_ID) = @TableName
END
