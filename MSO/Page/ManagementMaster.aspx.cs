using ClosedXML.Excel;
using dbUtil;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Util;

namespace MSO.Page
{
    public partial class ManagementMaster : BasePage
    {
        public bool bol = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                hid_DBNAME.Value = Request["dbname"];
                if (!string.IsNullOrEmpty(hid_DBNAME.Value))
                {
                    UserInfo.DBNAME = hid_DBNAME.Value;
                }
                DataRead();
            }

        }


        private void DataRead()
        {
            dbUtil.DbConxt db = new dbUtil.DbConxt();
            ddl_Year.DataTextField = "FSCYEAR";
            ddl_Year.DataValueField = "FSCYEAR";
            ddl_Year.DataSource = db.Dataget(UserInfo.DBNAME, "sp_GetYear");
            ddl_Year.DataBind();
        }
        protected void btn_Excel_Click(object sender, EventArgs e)
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_ManagementSub_Sel"
                , new string[] { "@YYYY", "@Servion" }
                , new string[] { ddl_Year.SelectedValue, hid_servion.Value }

                );
            if (dt.Rows.Count == 0 && dt != null)
            {
                //sp_ManagementSub_SelInit
                dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_ManagementSub_SelInit"
                , new string[] { "@YYYY" }
                , new string[] { ddl_Year.SelectedValue }
                );
            }

            ExportExcel(dt);
            //ExcelUtil.Export(this.Page, "경영계획", Server.MapPath("~/Excel/result.xlsx"), "경영계획.xlsx", dt, true);
        }



        /// <summary>
        /// 엑셀 저장 
        /// </summary>
        /// <param name="dt"></param>
        private void ExportExcel(DataTable dt)
        {
            var workbook = new XLWorkbook(Server.MapPath("~/Excel/Management.xlsx"));  //  엑셀 열기

            // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
            int rows = 1;
            var worksheet = workbook.Worksheet(1);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];

                double p1 = Todouble(dr["p1"]);
                double p2 = Todouble(dr["p2"]);
                double p3 = Todouble(dr["p3"]);
                double p4 = Todouble(dr["p4"]);
                double p5 = Todouble(dr["p5"]);
                double p6 = Todouble(dr["p6"]);
                double p7 = Todouble(dr["p7"]);
                double p8 = Todouble(dr["p8"]);
                double p9 = Todouble(dr["p9"]);
                double p10 = Todouble(dr["p10"]);
                double p11 = Todouble(dr["p11"]);
                double p12 = Todouble(dr["p12"]);

                double r1 = Todouble(dr["r1"]);
                double r2 = Todouble(dr["r2"]);
                double r3 = Todouble(dr["r3"]);
                double r4 = Todouble(dr["r4"]);
                double r5 = Todouble(dr["r5"]);
                double r6 = Todouble(dr["r6"]);
                double r7 = Todouble(dr["r7"]);
                double r8 = Todouble(dr["r8"]);
                double r9 = Todouble(dr["r9"]);
                double r10 = Todouble(dr["r10"]);
                double r11 = Todouble(dr["r11"]);
                double r12 = Todouble(dr["r12"]);




                if (dr["CusttomerName"].ToString() != "Sub Total:" && dr["CusttomerName"].ToString() != "Total:")
                {
                    worksheet.Cell(i + 2, "A").Value = (dr["UserId"].ToString());
                    worksheet.Cell(i + 2, "A").DataType = XLDataType.Text;
                }
                else
                {
                    worksheet.Cell(i + 2, "A").Value = "";
                    worksheet.Cell(i + 2, "A").DataType = XLDataType.Text;
                }
                if (dr["UserName"].ToString().ToLower() != "zzz")
                {
                    worksheet.Cell(i + 2, "B").Value = (dr["UserName"].ToString());
                    worksheet.Cell(i + 2, "B").DataType = XLDataType.Text;
                }
               
                if (dr["CusttomerName"].ToString() != "Sub Total:" && dr["CusttomerName"].ToString() != "Total:")
                {
                    worksheet.Cell(i + 2, "C").Value = (dr["CusttomerCode"].ToString());
                    worksheet.Cell(i + 2, "C").DataType = XLDataType.Text;
                }
                else
                {
                    worksheet.Cell(i + 2, "C").Value = "";
                    worksheet.Cell(i + 2, "C").DataType = XLDataType.Text;
                }

                worksheet.Cell(i + 2, "D").Value = (dr["CusttomerName"].ToString());
                worksheet.Cell(i + 2, "D").DataType = XLDataType.Text;

                // 1월
                worksheet.Cell(i + 2, "E").Value = (p1);
                worksheet.Cell(i + 2, "E").SetDataType(XLDataType.Number);
                worksheet.Cell(i + 2, "E").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "E").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                worksheet.Cell(i + 2, "F").Value = (r1);
                worksheet.Cell(i + 2, "F").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "F").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "F").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 2월 
                worksheet.Cell(i + 2, "G").Value = (p2);
                worksheet.Cell(i + 2, "G").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "G").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "G").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "H").Value = (r2);
                worksheet.Cell(i + 2, "H").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "H").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "H").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;



                //3월 
                worksheet.Cell(i + 2, "I").Value = p3;
                worksheet.Cell(i + 2, "I").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "I").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "I").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "J").Value = r3;
                worksheet.Cell(i + 2, "J").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "J").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "J").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;



                // 1/4 계획 실적 
                worksheet.Cell(i + 2, "K").Value = (p1 + p2 + p3);
                worksheet.Cell(i + 2, "K").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "K").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "K").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "L").Value = (r1 + r2 + r3);
                worksheet.Cell(i + 2, "L").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "L").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "L").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 4월 
                worksheet.Cell(i + 2, "M").Value = (p4);
                worksheet.Cell(i + 2, "M").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "M").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "M").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                worksheet.Cell(i + 2, "N").Value = (r4);
                worksheet.Cell(i + 2, "N").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "N").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "N").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 5월 
                worksheet.Cell(i + 2, "O").Value = (p5);
                worksheet.Cell(i + 2, "O").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "O").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "O").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "P").Value = (r5);
                worksheet.Cell(i + 2, "P").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "P").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "P").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                // 6 월
                worksheet.Cell(i + 2, "Q").Value = (p6);
                worksheet.Cell(i + 2, "Q").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "Q").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "Q").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "R").Value = (r6);
                worksheet.Cell(i + 2, "R").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "R").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "R").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                //2/4 
                worksheet.Cell(i + 2, "S").Value = (p4 + p5 + p6);
                worksheet.Cell(i + 2, "S").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "S").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "S").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "T").Value = (r4 + r5 + r6);
                worksheet.Cell(i + 2, "T").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "T").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "T").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 상반기 
                worksheet.Cell(i + 2, "U").Value = (p1 + p2 + p3 + p4 + p5 + p6);
                worksheet.Cell(i + 2, "U").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "U").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "U").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "V").Value = (r1 + r2 + r3 + r4 + r5 + r6);
                worksheet.Cell(i + 2, "V").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "V").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "V").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 7 월
                worksheet.Cell(i + 2, "W").Value = (p7);
                worksheet.Cell(i + 2, "W").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "W").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "W").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "X").Value = (r7);
                worksheet.Cell(i + 2, "X").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "X").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "X").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 8 월
                worksheet.Cell(i + 2, "Y").Value = (p8);
                worksheet.Cell(i + 2, "Y").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "Y").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "Y").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "Z").Value = (r8);
                worksheet.Cell(i + 2, "Z").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "Z").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "Z").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 9 월 
                worksheet.Cell(i + 2, "AA").Value = (p9);
                worksheet.Cell(i + 2, "AA").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AA").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AA").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AB").Value = (r9);
                worksheet.Cell(i + 2, "AB").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AB").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AB").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 3/4 분기 

                worksheet.Cell(i + 2, "AC").Value = (p7 + p8 + p9);
                worksheet.Cell(i + 2, "AC").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AC").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AC").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AD").Value = (r7 + r8 + r9);
                worksheet.Cell(i + 2, "AD").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AD").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AD").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                //10 월 
                worksheet.Cell(i + 2, "AE").Value = (p10);
                worksheet.Cell(i + 2, "AE").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AE").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AE").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AF").Value = (r10);
                worksheet.Cell(i + 2, "AF").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AF").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AF").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                // 11 월 
                worksheet.Cell(i + 2, "AG").Value = (p11);
                worksheet.Cell(i + 2, "AG").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AG").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AG").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AH").Value = (r11);
                worksheet.Cell(i + 2, "AH").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AH").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AH").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                // 12 월 
                worksheet.Cell(i + 2, "AI").Value = (p12);
                worksheet.Cell(i + 2, "AI").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AI").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AI").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AJ").Value = (r12);
                worksheet.Cell(i + 2, "AJ").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AJ").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AJ").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                // 4/4 분기 
                worksheet.Cell(i + 2, "AK").Value = (p10 + p11 + p12);
                worksheet.Cell(i + 2, "AK").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AK").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AK").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AL").Value = (r10 + r11 + r12);
                worksheet.Cell(i + 2, "AL").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AL").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AL").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 하반기 
                worksheet.Cell(i + 2, "AM").Value = (p7 + p8 + p9 + p10 + p11 + p12);
                worksheet.Cell(i + 2, "AM").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AM").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AM").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AN").Value = (r7 + r8 + r9 + r10 + r11 + r12);
                worksheet.Cell(i + 2, "AN").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AN").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AN").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                // 연간 
                worksheet.Cell(i + 2, "AO").Value = (p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9 + p10 + p11 + p12);
                worksheet.Cell(i + 2, "AO").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AO").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AO").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AP").Value = (r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12);
                worksheet.Cell(i + 2, "AP").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AP").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AP").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                //  재료비
                worksheet.Cell(i + 2, "AQ").Value = (dr["raw"].ToString());
                worksheet.Cell(i + 2, "AQ").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AQ").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AQ").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AR").Value = (dr["ass"].ToString());
                worksheet.Cell(i + 2, "AR").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AR").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AR").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 영업 이익 계획 실적
                worksheet.Cell(i + 2, "AS").Value = (dr["plp"].ToString());
                worksheet.Cell(i + 2, "AS").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AS").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AS").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "AT").Value = (dr["plr"].ToString());
                worksheet.Cell(i + 2, "AT").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AT").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AT").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                // 매출 달성율
                worksheet.Cell(i + 2, "AU").Value = (dr["rusult"].ToString());
                worksheet.Cell(i + 2, "AU").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "AU").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "AU").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;









                rows += 1;
            }

            var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, 47));


            filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;

            filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            // 테두리 설정 



            worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

            workbook.SaveAs(Server.MapPath("~/Excel/result.xlsx"));  // 새로운 이름으로 저장하기


            FileInfo f = new FileInfo(Server.MapPath("~/Excel/result.xlsx"));
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + "경영계획.xlsx");
            HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
            HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.WriteFile(f.FullName);
            HttpContext.Current.Response.End();

        }


        /// <summary>
        /// 데이터상 빈  문자열이거나 null시 0으로 초기화
        /// </summary>
        /// <param name="v"></param>
        /// <returns></returns>
        private static double Todouble(object v)
        {
            if (string.IsNullOrEmpty(v.ToString()) || v == DBNull.Value)
            {
                return 0;
            }
            else
            {
                return Convert.ToDouble(v.ToString());
            }
        }
    }
}