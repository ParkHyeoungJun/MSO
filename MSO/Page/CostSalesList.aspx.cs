using ClosedXML.Excel;
using dbUtil;
using System;
using System.Data;
using System.IO;
using System.Web;
using Util;

namespace MSO.Page
{
    public partial class CostSalesList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                hid_DBNAME.Value = Request["dbname"];
                if (!string.IsNullOrEmpty(hid_DBNAME.Value))
                {
                    UserInfo.DBNAME = hid_DBNAME.Value;
                }
                txt_sdate.Value = DateTime.Now.ToString("yyyy-MM");
                txt_edate.Value = DateTime.Now.ToString("yyyy-MM");


                //ddl_CustCode
                DbConxt dbConxt = new DbConxt();
                ddl_CustCode.DataTextField = "CARRIERNAME";
                ddl_CustCode.DataValueField = "CARRIER";
                ddl_CustCode.DataSource = dbConxt.Dataget(UserInfo.DBNAME, "sp_GetCARRIER");
                ddl_CustCode.DataBind();
            }
        }

        protected void btn_Search_Click(object sender, EventArgs e)
        {
            string sDay = txt_sdate.Value + "-01";
            string eDay = txt_edate.Value + "-01";
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_CostSales_Sel"
                ,new string[] {"@sDay",@"eDay"
                }
                , new string[] {sDay,eDay }
                );

            if (dt.Rows.Count > 0)
            {
                rpt_List.DataSource = dt;
                rpt_List.DataBind();
                lbl_NoData.Text = string.Empty;
               
            }
            else
            {
                rpt_List.DataSource = null;
                rpt_List.DataBind();
                lbl_NoData.Text = "검색된 데이터가 없습니다.";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "DataAvg();", true);
        }

        protected void btn_Excel_Click(object sender, EventArgs e)
        {
            string sDay = txt_sdate.Value + "-01";
            string eDay = txt_edate.Value + "-01";
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_CostSales_Sel"
                , new string[] {"@sDay",@"eDay"
                }
                , new string[] { sDay, eDay }
                );

            double sumSupply = 0;
            double sumSurtax = 0;
            double sumTotal = 0;
            foreach (DataRow row in dt.Rows)
            {
                if (!string.IsNullOrEmpty(row["Supply"].ToString()))
                {
                    sumSupply += Convert.ToInt32(row["Supply"].ToString().Replace(",", ""));
                }
                if (!string.IsNullOrEmpty(row["Surtax"].ToString()))
                {
                    sumSurtax += Convert.ToInt32(row["Surtax"].ToString().Replace(",", ""));
                }
                if (!string.IsNullOrEmpty(row["Total"].ToString()))
                {
                    sumTotal += Convert.ToInt32(row["Total"].ToString().Replace(",", ""));
                }
            }
            DataRow dr = dt.NewRow();
            dr["DateDay"] = "합계";
            dr["Supply"] = String.Format("{0:#,0}", sumSupply); // 천단위마다 콤마
            dr["Surtax"] = String.Format("{0:#,0}", sumSurtax);// 천단위마다 콤마
            dr["Total"] = String.Format("{0:#,0}", sumTotal);// 천단위마다 콤마
            dr["Note"] = "";   
            dt.Rows.Add(dr);
            ExportExcel(dt);
        }


        private void ExportExcel(DataTable dt)
        {
            var workbook = new XLWorkbook(Server.MapPath("~/Excel/Cost.xlsx"));  //  엑셀 열기

            // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
            int rows = 1;
            var worksheet = workbook.Worksheet(1);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];
                worksheet.Cell(i + 2, "A").SetValue(dr["DateDay"].ToString());
                worksheet.Cell(i + 2, "A").DataType = XLDataType.Text;
                worksheet.Cell(i + 2, "B").SetValue(dr["CARRIERNAME"].ToString());
                worksheet.Cell(i + 2, "B").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "C").SetValue(dr["CarNum"].ToString());
                worksheet.Cell(i + 2, "C").DataType = XLDataType.Text;

               
                worksheet.Cell(i + 2, "D").SetValue(dr["Supply"].ToString().Replace(",", ""));
                worksheet.Cell(i + 2, "D").DataType =(XLDataType.Number);// =(dr["Supply"].ToString());
                worksheet.Cell(i + 2, "D").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "D").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "E").Value = (dr["Surtax"].ToString().Replace(",", ""));
                worksheet.Cell(i + 2, "E").DataType = (XLDataType.Number);
                worksheet.Cell(i + 2, "E").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "E").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "F").Value =((dr["Total"].ToString().Replace(",","")));
                worksheet.Cell(i + 2, "F").DataType = (XLDataType.Number);
                worksheet.Cell(i + 2, "F").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
                worksheet.Cell(i + 2, "F").Style.NumberFormat.Format = "#,##0;";

                worksheet.Cell(i + 2, "G").SetValue(dr["Note"].ToString());
                worksheet.Cell(i + 2, "G").DataType = XLDataType.Text;
                rows += 1;
            }

            var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, 7));


            filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;

            filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            // 테두리 설정 



            worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

            workbook.SaveAs(Server.MapPath("~/Excel/result.xlsx"));  // 새로운 이름으로 저장하기


            FileInfo f = new FileInfo(Server.MapPath("~/Excel/result.xlsx"));
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + "판매부대비용관리.xlsx");
            HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
            HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.WriteFile(f.FullName);
            HttpContext.Current.Response.End();

        }


        /// <summary>
        ///  리드시에 금지어들을 변환한다.
        /// </summary>
        protected string OutputCheckWord(string strCheckValue)
        {
            var data = strCheckValue.Replace("&lt;", "<").Replace("&gt;", ">").Replace("&quot;", "'").Replace("&amp;", "&");
            return data;
        }
    }
}