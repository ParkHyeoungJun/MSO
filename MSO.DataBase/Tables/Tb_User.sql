CREATE TABLE [dbo].[Tb_User]
(
	Num				Int Identity(1,1) Primary key				,
	[UserId]		Varchar(20)									,   -- 아이디
	[UserName]		Varchar(50)		Not null					,   -- 이름
	[UserPwd]		Varchar(200)	Not null					,  -- 패스워드
	[Email]			Varchar(250)	Not null					,
	LoginDate		SmallDatetime Default(getDate())			-- 로그인한 날,
	,Retired		Bit Default(0)
	,RetiredDay		Varchar(10) Default(null)
)
