CREATE TABLE [dbo].[Tb_Holiday]
(
	Num			INT identity(1,1)	NOT NULL PRIMARY KEY		,
	YN			Bit		Default(1)							,
	Title		Varchar(100)								,
	HoliDay		Varchar(10)									,
	RegDate		SmallDatetime Default(getDate())			,	
	ModDate		SmallDatetime Default(Null)
)
