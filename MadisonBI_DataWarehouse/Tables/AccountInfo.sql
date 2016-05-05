CREATE TABLE [dbo].[AccountInfo]
(
	[AccountDerivedID] BIGINT NOT NULL IDENTITY(1,1),
	[AccountID] BIGINT NOT NULL, --账户ID
	[Name] NVARCHAR(200) NOT NULL, --用户名
	[Mobile] NVARCHAR(50) NOT NULL, --UNKNOWN：未知
	[BirthDate] DATE NOT NULL,---9999-12-31表示出生日期未知
	[Gender] SMALLINT NOT NULL,---1:未知，0：女，1：男
	[ReferralCode] NVARCHAR(20) NOT NULL, --推荐代码
	[InvitedBy] NVARCHAR(20) NOT NULL, --推荐人代码,UNKNOWN表示无人推荐
	[PasswordSet] BIT NOT NULL,--0：密码未设置 1：密码已设置
	[RealNameRegistration] BIT NOT NULL,--0：非实名注册，1：实名注册
	[CardBinding] BIT NOT NULL,--0：未绑定银行卡，1：已绑定银行卡
	[ProvinceID] INT NOT NULL,--户籍所在省对应ID，-1：未知
	[CityID] INT NOT NULL,--户籍所在市对应ID，-1：未知
	[IsCurrent] BIT NOT NULL, --0：历史记录，1：当前记录
    [EffectiveDate] DATETIME NOT NULL, --记录生效时间
    [ExpiredDate] DATETIME NOT NULL, --记录失效时间
    CONSTRAINT [PK_AccountInfo] PRIMARY KEY([AccountDerivedID])
)

GO

CREATE INDEX [UX_AccountInfo] ON [dbo].[AccountInfo] ([AccountID],[IsCurrent])
