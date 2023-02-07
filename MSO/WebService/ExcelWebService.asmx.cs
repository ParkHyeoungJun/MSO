using ClosedXML.Excel;
using Newtonsoft.Json;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;

namespace MSO.WebService
{
    /// <summary>
    /// ExcelWebService의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
     [System.Web.Script.Services.ScriptService]
    public class ExcelWebService : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetExcelData(string filename)
        {
            DataTable dt = new DataTable();
            #region 화면에 바인딩할 컬럼 지정
            dt.Columns.Add("UserId");
            dt.Columns.Add("UserName");
            dt.Columns.Add("CusttomerCode");
            dt.Columns.Add("CusttomerName");
            dt.Columns.Add("Num");
            // 1월 계획 실적
            dt.Columns.Add("p1");
            dt.Columns.Add("r1");

            // 2월 계획 실적
            dt.Columns.Add("p2");
            dt.Columns.Add("r2");

            // 3월 계획 실적
            dt.Columns.Add("p3");
            dt.Columns.Add("r3");

            // 1/4 분기 계획 실적
            dt.Columns.Add("q1p");
            dt.Columns.Add("q1r");

            // 4월 계획실적
            dt.Columns.Add("p4");
            dt.Columns.Add("r4");

            // 5월 계획실적
            dt.Columns.Add("p5");
            dt.Columns.Add("r5");

            // 6월 계획실적
            dt.Columns.Add("p6");
            dt.Columns.Add("r6");

            // 2/4 분기 계획실적
            dt.Columns.Add("q2p");
            dt.Columns.Add("q2r");

            // 상반기 계획실적
            dt.Columns.Add("s1p");
            dt.Columns.Add("s1r");


            // 7월 계획실적
            dt.Columns.Add("p7");
            dt.Columns.Add("r7");

            // 8월 계획실적
            dt.Columns.Add("p8");
            dt.Columns.Add("r8");


            // 9월 계획실적
            dt.Columns.Add("p9");
            dt.Columns.Add("r9");

            // 3/4 분기 계획실적
            dt.Columns.Add("q3p");
            dt.Columns.Add("q3r");

            // 10월 계획실적
            dt.Columns.Add("p10");
            dt.Columns.Add("r10");

            // 11월 계획실적
            dt.Columns.Add("p11");
            dt.Columns.Add("r11");

            // 12월 계획실적
            dt.Columns.Add("p12");
            dt.Columns.Add("r12");

            // 4/4 분기 계획실적
            dt.Columns.Add("q4p");
            dt.Columns.Add("q4r");

            // 하반기 계획실적
            dt.Columns.Add("s2p");
            dt.Columns.Add("s2r");

            // 연간 계획실적
            dt.Columns.Add("yp");
            dt.Columns.Add("yr");

            // 재료비 
            dt.Columns.Add("raw");
            // 조립비
            dt.Columns.Add("ass");

            // 영업이익 계획 실적
            dt.Columns.Add("plp");
            dt.Columns.Add("plr");

            // 매출 달성율
            dt.Columns.Add("rusult");

            #endregion


            string filePath = Path.Combine(Server.MapPath(filename));
            var wb = new XLWorkbook(filePath);  //  엑셀 열기
            var ws = wb.Worksheet(1);
            var totalRows = ws.RowsUsed().Count(); // 활성화된 마지막 행 알아오기 
            for (int row = 2; row <= totalRows; row++)
            {
                DataRow dr = dt.NewRow();
                dr["UserId"]= ws.Cell(row, 1).Value.ToString();
                dr["UserName"] = ws.Cell(row, 2).Value.ToString();
                dr["CusttomerCode"] = ws.Cell(row, 3).Value.ToString();
                dr["CusttomerName"] = ws.Cell(row, 4).Value.ToString();
                dr["p1"] = ws.Cell(row, "E").Value.ToString(); 
                    //getColums(ws,row,5);
                dr["r1"] = ws.Cell(row, "F").Value.ToString();
                dr["p2"] = ws.Cell(row, "G").Value.ToString();
                dr["r2"] = ws.Cell(row, "H").Value.ToString();
                dr["p3"] = ws.Cell(row, "I").Value.ToString();
                dr["r3"] = ws.Cell(row, "J").Value.ToString();
                dr["q1p"] = ws.Cell(row, "K").Value.ToString();
                dr["q1r"] = ws.Cell(row, "L").Value.ToString();
                dr["p4"] = ws.Cell(row, "M").Value.ToString();
                dr["r4"] = ws.Cell(row, "N").Value.ToString();
                dr["p5"] = ws.Cell(row, "O").Value.ToString();
                dr["r5"] = ws.Cell(row, "P").Value.ToString();
                dr["p6"] = ws.Cell(row, "Q").Value.ToString();
                dr["r6"] = ws.Cell(row, "R").Value.ToString();
                dr["q2p"] = ws.Cell(row, "S").Value.ToString();
                dr["q2r"] = ws.Cell(row, "T").Value.ToString();
                dr["s1p"] = ws.Cell(row, "U").Value.ToString();
                dr["s1r"] = ws.Cell(row, "V").Value.ToString();
                dr["p7"] = ws.Cell(row, "W").Value.ToString();
                dr["r7"] = ws.Cell(row, "X").Value.ToString();
                dr["p8"] = ws.Cell(row, "Y").Value.ToString();
                dr["r8"] = ws.Cell(row, "Z").Value.ToString();
                dr["p9"] = ws.Cell(row, "AA").Value.ToString();
                dr["r9"] = ws.Cell(row, "AB").Value.ToString();
                dr["q3p"] = ws.Cell(row, "AC").Value.ToString();
                dr["q3r"] = ws.Cell(row, "AD").Value.ToString();
                dr["p10"] = ws.Cell(row, "AE").Value.ToString();
                dr["r10"] = ws.Cell(row, "AF").Value.ToString();
                dr["p11"] = ws.Cell(row, "AG").Value.ToString();
                dr["r11"] = ws.Cell(row, "AH").Value.ToString(); ;
                dr["p12"] = ws.Cell(row, "AI").Value.ToString();
                dr["r12"] = ws.Cell(row, "AJ").Value.ToString();
                dr["q4p"] = ws.Cell(row, "AK").Value.ToString();
                dr["q4r"] = ws.Cell(row, "AL").Value.ToString();
                dr["s2p"] = ws.Cell(row, "AM").Value.ToString();
                dr["s2r"] = ws.Cell(row, "AN").Value.ToString();
                dr["yp"] = ws.Cell(row, "AO").Value.ToString();
                dr["yr"] = ws.Cell(row, "AP").Value.ToString();
                dr["raw"] = ws.Cell(row, "AQ").Value.ToString();
                dr["ass"] = ws.Cell(row, "AR").Value.ToString();
                dr["plp"] = ws.Cell(row, "AS").Value.ToString();
                dr["plr"] = ws.Cell(row, "AT").Value.ToString();
                dr["rusult"] = ws.Cell(row, "AU").Value.ToString();


                dt.Rows.Add(dr);
            }
            wb.Dispose();

            return JsonConvert.SerializeObject(dt);
        }


        public string getColums(IXLWorksheet ws,int row ,int col)
        {
            return ws.Cell(row, col).Value as string;
        }


    }
}
