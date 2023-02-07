CREATE TABLE [dbo].[tb_CostSales]
(
	Num				INT NOT NULL PRIMARY KEY	identity(1,1)			,
	CustCode		Varchar(10)								,
	CarNum			Varchar(20)								,
	DateDay			varchar(10)								,
	Supply			Varchar(15)								,
	Surtax			Varchar(15)								,
	Total			Varchar(20)								,
	Note			varchar(8000)							,
	Regdate			Date Default(getdate())					,
	Moddate			Date Default(null)
)
