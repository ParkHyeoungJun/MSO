Create Table tb_Work
(
	Num				Int	Primary Key Identity(1,1)			, 
	UserId			Varchar(20)								, 
	AttenDay		Varchar(10)								,
	AttenTime		Varchar(10)								,
	LeaveTime		varchar(10)								,
	Overtime		varchar(10)							,
	WorkOvertime	varchar(10)							,
	WoorkTime		Varchar(2)							,
	Regdate			date Default(Getdate()) ,
	Moddate			date	Default(Null)
)