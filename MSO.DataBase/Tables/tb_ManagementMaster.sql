/* 경영 계획 마스터*/
CREATE TABLE [dbo].[tb_ManagementMaster]
(
	[Idx]				INT NOT NULL	Identity(1,1)	 PRIMARY KEY		, 
	UserId				varchar(20)		 									,
	UserName			Varchar(20)											,
	CusttomerCode		Varchar(10)		 									,	
	CusttomerName		Varchar(50)		 									,	
	[YYYY]				Char(4)			 									,
	[Ip]				Varchar(15)											,
	RegDate				SmallDatetime Default(getDate())					,	
	ModDate				SmallDatetime Default(Null)										
)
