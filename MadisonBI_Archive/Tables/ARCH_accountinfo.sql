﻿CREATE TABLE [dbo].[ARCH_accountinfo]
(
	[ArchiveID] BIGINT NOT NULL IDENTITY(1,1),
	[StagingID] BIGINT NOT NULL,
	[AccountID] BIGINT NOT NULL, --账户ID, Source Key
    [Name] NVARCHAR(200) NULL, --用户名
    [Mobile] NVARCHAR(50) NULL, 
    [IDType] TINYINT NULL, --证件类型 0：身份证
    [IDNumber] NVARCHAR(100) NULL, --证件号
    [ReferralCode] NVARCHAR(20) NULL, --推荐代码
    [InvitedBy] NVARCHAR(20) NULL, --推荐人代码
    [Status] NVARCHAR(100) NULL, --账户状态 0：未激活 1：激活
	[CustomStatus] TINYINT NULL, --自定义状态 1：密码已设置 2：已实名认证(包含1) 3：银行卡已绑定(包含1和2)
    [Created] DATETIME NOT NULL, 
    [Modified] DATETIME NOT NULL, 
    [Source] NVARCHAR(100) NOT NULL, 
    [StagingInsertTime] DATETIME NOT NULL, 
	[ArchiveInsertTime] DATETIME NOT NULL, 
    CONSTRAINT [PK_ARCH_accountinfo] PRIMARY KEY(ArchiveID,[Modified])
) ON [sch_Partition]([Modified])
/*
Create a partition for every 2 months data(Pre-defined partition for next 2 months)
Truncate the partition for 6 months ago and remove the partition before that
*/