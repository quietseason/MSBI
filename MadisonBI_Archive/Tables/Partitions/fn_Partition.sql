﻿CREATE PARTITION FUNCTION [fn_Partition]
	(
		DATETIME
	)
	AS RANGE RIGHT
	FOR VALUES ('2015-05-01','2015-07-01','2015-09-01','2015-11-01','2016-01-01','2016-03-01','2016-05-01')
