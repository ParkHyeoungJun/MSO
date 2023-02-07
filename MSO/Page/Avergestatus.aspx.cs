using ClosedXML.Excel;
using dbUtil;
using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;
using Util;

namespace MSO.Page
{
    public partial class Avergestatus : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {if (!Page.IsPostBack)
            {
                txt_sdate.Value = DateTime.Now.ToString("yyyy-MM") + "-01";
                DateTime lastday = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 01).AddMonths(1).AddDays(-1);
                txt_edate.Value = lastday.ToString("yyyy-MM-dd");

                hid_DBNAME.Value = Request["dbname"];
                if (!string.IsNullOrEmpty(hid_DBNAME.Value))
                {
                    UserInfo.DBNAME = hid_DBNAME.Value;
                }
            }

            if (this.IsPostBack)
            {
                txt_Coustomer1.Text = hid_coustomer1.Value;
                if (!hid_coustomer2.Value.Equals("ZZZZZZZZZZZZ") & !hid_coustomer2.Value.Equals("ZZZZZZZZZZZZZZZZZZZZZZZZ"))
                {
                    txt_Coustomer2.Text = hid_coustomer2.Value;
                }
                TabName.Value = Request.Form[TabName.UniqueID];
            }

        }
        protected void List()
        {
            DbConxt dbConxt = new DbConxt();
            if (hid_Type.Value == "Vendor")
            {


                DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend", new string[]
                {
                       "@sDate_F",
                      "@sDate_T",
                      "@sVend_F",
                      "@sVend_T" ,
                      "@ExcelYN",
                      "@pageNum",
                      "@amount"
                    }
                    , new string[]
                    {
                        txt_sdate.Value.ToString().Replace("-",""),
                        txt_edate.Value.ToString().Replace("-",""),
                        hid_coustomer1.Value,
                        hid_coustomer2.Value,
                        "N",
                        pager.CurrentIndex.ToString(),
                        DL1.SelectedValue.ToString()
                    }
                 );

                DataTable tot_dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Total", new string[]
                {
                      "@sDate_F",
                      "@sDate_T",
                      "@sVend_F",
                      "@sVend_T" 
                    }
                    , new string[]
                    {
                        txt_sdate.Value.ToString().Replace("-",""),
                        txt_edate.Value.ToString().Replace("-",""),
                        hid_coustomer1.Value,
                        hid_coustomer2.Value
                    }
                 );
                if (dt.Rows.Count > 0)
                {
                    lbl_nodata.Text = "";
                    tr_nodata.Visible = false;
                    this.rep_List1.DataSource = dt;
                    this.rep_List1.DataBind();
                    this.pager.ItemCount = Convert.ToUInt32(dt.Rows[0]["cnt"].ToString());

                    tot_Y.Text = SetComma(tot_dt.Rows[0]["INVSUBTOT"]);
                    tot_N.Text = SetComma(tot_dt.Rows[0]["POAMT"]);
                    tot_sum.Text = SetComma(tot_dt.Rows[0]["TOTALAMT"]);
                }
                else
                {
                    this.rep_List1.DataSource = null;
                    this.rep_List1.DataBind();
                    tr_nodata.Visible = true;
                    lbl_nodata.Text = "검색된 데이터가 없습니다";

                    tot_Y.Text = "0";
                    tot_N.Text = "0";
                    tot_sum.Text = "0";
                }
                //   SetComma(dt);
                rep_List1.DataSource = dt;
                rep_List1.DataBind();
                //  HeadList1.Attributes.Add("style", "display:table-row");
                //  HeadList2.Attributes.Add("style", "display:none");
                rep_List1.Visible = true;
                rep_List2.Visible = false;


            }
            else
            {

                DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Items", new string[]
                {
                       "@sDate_F",
                      "@sDate_T",
                      "@sItem_F",
                      "@sItem_T",
                      "@ExcelYN",
                      "@pageNum",
                      "@amount"
                    }
                    , new string[]
                    {
                        txt_sdate.Value.ToString().Replace("-",""),
                        txt_edate.Value.ToString().Replace("-",""),
                        hid_coustomer1.Value,
                        hid_coustomer2.Value,
                        "N",
                        pager.CurrentIndex.ToString(),
                        DL1.SelectedValue.ToString()
                    }
                 );

                DataTable tot_dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Items_Total", new string[]
                {
                       "@sDate_F",
                      "@sDate_T",
                      "@sItem_F",
                      "@sItem_T"
                    }
                    , new string[]
                    {
                        txt_sdate.Value.ToString().Replace("-",""),
                        txt_edate.Value.ToString().Replace("-",""),
                        hid_coustomer1.Value,
                        hid_coustomer2.Value
                    }
                 );
                if (dt.Rows.Count > 0)
                {
                    lbl_nodata.Text = "";
                    tr_nodata.Visible = false;
                    this.rep_List2.DataSource = dt;
                    this.rep_List2.DataBind();
                    this.pager.ItemCount = Convert.ToUInt32(dt.Rows[0]["cnt"].ToString());

                    tot_Y.Text = SetComma(tot_dt.Rows[0]["EXTINVMISC"]);
                    tot_N.Text = SetComma(tot_dt.Rows[0]["POAMT"]);
                    tot_sum.Text = SetComma(tot_dt.Rows[0]["TOTALAMT"]);

                }
                else
                {

                    this.rep_List2.DataSource = null;
                    this.rep_List2.DataBind();
                    tr_nodata.Visible = true;
                    lbl_nodata.Text = "검색된 데이터가 없습니다";

                    tot_Y.Text = "0";
                    tot_N.Text = "0";
                    tot_sum.Text = "0";
                }
                // SetComma(dt);
                rep_List2.DataSource = dt;
                rep_List2.DataBind();
                //   HeadList1.Attributes.Add("style", "display:none");
                //   HeadList2.Attributes.Add("style", "display:table-row");
                rep_List2.Visible = true;
                rep_List1.Visible = false;


            }
            TabName.Value = "employment";
            ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "employment();", true);
        }

        protected void btn_Search_Click(object sender, EventArgs e)
        {
            pager.CurrentIndex = 1;
            DbConxt dbConxt = new DbConxt();
            if (hid_Type.Value == "Vendor")
            {


                DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend"
                    , new string[]
                    { "@sDate_F",
                      "@sDate_T",
                      "@sVend_F",
                      "@sVend_T" ,
                      "@ExcelYN",
                      "@pageNum", 
                      "@amount"
                    }
                    , new string[]
                    {
                    txt_sdate.Value.ToString().Replace("-",""),
                    txt_edate.Value.ToString().Replace("-",""),
                    hid_coustomer1.Value,
                    hid_coustomer2.Value,
                    "N",
                    pager.CurrentIndex.ToString(),
                    DL1.SelectedValue.ToString()
                    }
                    );
                DataTable tot_dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Total", new string[]
                {
                      "@sDate_F",
                      "@sDate_T",
                      "@sVend_F",
                      "@sVend_T"
                    }
                    , new string[]
                    {
                        txt_sdate.Value.ToString().Replace("-",""),
                        txt_edate.Value.ToString().Replace("-",""),
                        hid_coustomer1.Value,
                        hid_coustomer2.Value
                    }
                 );
                if (dt.Rows.Count > 0)
                {
                    lbl_nodata.Text = "";
                    tr_nodata.Visible = false;
                    this.rep_List1.DataSource = dt;
                    this.rep_List1.DataBind();
                    this.pager.ItemCount = Convert.ToUInt32(dt.Rows[0]["cnt"].ToString());

                    tot_Y.Text = SetComma(tot_dt.Rows[0]["INVSUBTOT"]);
                    tot_N.Text = SetComma(tot_dt.Rows[0]["POAMT"]);
                    tot_sum.Text = SetComma(tot_dt.Rows[0]["TOTALAMT"]);
                }
                else
                {
                    this.rep_List1.DataSource = null;
                    this.rep_List1.DataBind();
                    tr_nodata.Visible = true;
                    lbl_nodata.Text = "검색된 데이터가 없습니다";

                    tot_Y.Text = "0";
                    tot_N.Text = "0";
                    tot_sum.Text = "0";
                }
                //   SetComma(dt);
                rep_List1.DataSource = dt;
                rep_List1.DataBind();
              //  HeadList1.Attributes.Add("style", "display:table-row");
              //  HeadList2.Attributes.Add("style", "display:none");
                rep_List1.Visible = true;
                rep_List2.Visible = false;


            }
            else
            {

                DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Items"
                    , new string[]
                    { "@sDate_F",
                      "@sDate_T",
                      "@sItem_F",
                      "@sItem_T",
                      "@ExcelYN",
                      "@pageNum",
                      "@amount"
                    }
                    , new string[]
                    {
                    txt_sdate.Value.ToString().Replace("-",""),
                    txt_edate.Value.ToString().Replace("-",""),
                    hid_coustomer1.Value,
                    hid_coustomer2.Value,
                    "N",
                    pager.CurrentIndex.ToString(),
                    DL1.SelectedValue.ToString()
                    }
                    );
                DataTable tot_dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Items_Total", new string[]
                {
                       "@sDate_F",
                      "@sDate_T",
                      "@sItem_F",
                      "@sItem_T"
                    }
                    , new string[]
                    {
                        txt_sdate.Value.ToString().Replace("-",""),
                        txt_edate.Value.ToString().Replace("-",""),
                        hid_coustomer1.Value,
                        hid_coustomer2.Value
                    }
                 );
                if (dt.Rows.Count > 0)
                {
                    lbl_nodata.Text = "";
                    tr_nodata.Visible = false;
                    this.rep_List2.DataSource = dt;
                    this.rep_List2.DataBind();
                    this.pager.ItemCount = Convert.ToUInt32(dt.Rows[0]["cnt"].ToString());

                    tot_Y.Text = SetComma(tot_dt.Rows[0]["EXTINVMISC"]);
                    tot_N.Text = SetComma(tot_dt.Rows[0]["POAMT"]);
                    tot_sum.Text = SetComma(tot_dt.Rows[0]["TOTALAMT"]);

                }
                else
                {

                    this.rep_List2.DataSource = null;
                    this.rep_List2.DataBind();
                    tr_nodata.Visible = true;
                    lbl_nodata.Text = "검색된 데이터가 없습니다";

                    tot_Y.Text = "0";
                    tot_N.Text = "0";
                    tot_sum.Text = "0";
                }
                // SetComma(dt);
                rep_List2.DataSource = dt;
                rep_List2.DataBind();
             //   HeadList1.Attributes.Add("style", "display:none");
             //   HeadList2.Attributes.Add("style", "display:table-row");
                rep_List2.Visible = true;
                rep_List1.Visible = false;


            }
                TabName.Value = "employment";
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "employment();", true);
        }

        protected void btn_Excel_Click(object sender, EventArgs e)
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = new DataTable();
            if (hid_Type.Value == "Vendor")
            {
                      dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend"
                    , new string[] { "@sDate_F", "@sDate_T", "@sVend_F", "@sVend_T","@ExcelYN" }
                    , new string[] { txt_sdate.Value.ToString().Replace("-", ""), txt_edate.Value.ToString().Replace("-", ""), hid_coustomer1.Value, hid_coustomer2.Value ,"Y"}

                    );
            }
            else if (hid_Type.Value == "Item")
            {
                     dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Items"
                    , new string[] { "@sDate_F", "@sDate_T", "@sItem_F", "@sItem_T" ,"@ExcelYN"}
                    , new string[] { txt_sdate.Value.ToString().Replace("-", ""), txt_edate.Value.ToString().Replace("-", ""), hid_coustomer1.Value, hid_coustomer2.Value ,"Y"}

                    );
            }
          
            ExportExcel(dt);
        }
        private void ExportExcel(DataTable dt)
        {

            if (hid_Type.Value == "Vendor")
            {
                var workbook = new XLWorkbook(Server.MapPath("~/Excel/AvergeVendor.xlsx"));  //  엑셀 열기

                // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
                int rows = 1;
                var worksheet = workbook.Worksheet(1);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];

                    string vdcode = dr["VDCODE"].ToString().Trim();
                    string vendname = dr["VENDNAME"].ToString().Trim();
                    string ponumber = dr["PONUMBER"].ToString().Trim();
                    string podate = SetDate(dr["PODATE"]).ToString().Trim();
                    string poamt = dr["POAMT"].ToString().Trim();
                    string invnumber = dr["INVNUMBER"].ToString().Trim();
                    string invdate = SetDate(dr["INVDATE"]).ToString().Trim();
                    string invsubtot = dr["INVSUBTOT"].ToString().Trim();
                    string ap = dr["AP"].ToString().Trim();





                    worksheet.Cell(i + 2, "A").Value = (vdcode);
                    worksheet.Cell(i + 2, "A").DataType = XLDataType.Text;

                    worksheet.Cell(i + 2, "B").Value = (vendname);
                    worksheet.Cell(i + 2, "B").DataType = XLDataType.Text;

                    worksheet.Cell(i + 2, "C").Value = (ponumber);
                    worksheet.Cell(i + 2, "C").DataType = XLDataType.Text;

                    worksheet.Cell(i + 2, "D").Value = (podate);
                    worksheet.Cell(i + 2, "D").Style.NumberFormat.Format = "YYYY-MM-DD";
                    worksheet.Cell(i + 2, "D").DataType = XLDataType.DateTime;
                    worksheet.Cell(i + 2, "D").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;

                    worksheet.Cell(i + 2, "E").Value = (poamt);
                    worksheet.Cell(i + 2, "E").SetDataType(XLDataType.Number);
                    worksheet.Cell(i + 2, "E").Style.NumberFormat.Format = "#,##0;";
                    worksheet.Cell(i + 2, "E").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                    worksheet.Cell(i + 2, "F").Value = (invnumber);
                    worksheet.Cell(i + 2, "F").DataType = XLDataType.Text;

                    worksheet.Cell(i + 2, "G").Value = (invdate);
                    worksheet.Cell(i + 2, "G").Style.NumberFormat.Format = "YYYY-MM-DD";
                    worksheet.Cell(i + 2, "G").DataType = XLDataType.DateTime;
                    worksheet.Cell(i + 2, "G").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;

                    worksheet.Cell(i + 2, "H").Value = (invsubtot);
                    worksheet.Cell(i + 2, "H").SetDataType(XLDataType.Number);
                    worksheet.Cell(i + 2, "H").Style.NumberFormat.Format = "#,##0;";
                    worksheet.Cell(i + 2, "H").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;



                    worksheet.Cell(i + 2, "I").Value = (ap);
                    worksheet.Cell(i + 2, "I").DataType = XLDataType.Text;





                    //worksheet.Cell(i + 2, "C").Value = ;
                    //worksheet.Cell(i + 2, "C").DataType = XLDataType.Number;
                    //worksheet.Cell(i + 2, "C").Style.NumberFormat.Format = "#,##0;";
                    //worksheet.Cell(i + 2, "C").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                    rows += 1;
                }

                var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, 9));


                filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;

                filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
                // 테두리 설정 



                worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

                workbook.SaveAs(Server.MapPath("~/Excel/result.xlsx"));  // 새로운 이름으로 저장하기


                FileInfo f = new FileInfo(Server.MapPath("~/Excel/result.xlsx"));
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + "구매처별 매입현황.xlsx");
                HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
                HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.WriteFile(f.FullName);
                HttpContext.Current.Response.End();
            }
            else
            {
                var workbook = new XLWorkbook(Server.MapPath("~/Excel/AvergeItems.xlsx"));  //  엑셀 열기

                // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
                int rows = 1;
                var worksheet = workbook.Worksheet(1);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];

                    string itemno = dr["ITEMNO"].ToString().Trim();
                    string itemdesc = dr["ITEMDESC"].ToString().Trim();
                    string poamt = dr["POAMT"].ToString().Trim();
                    string extinvmisc = dr["EXTINVMISC"].ToString().Trim();
                    string ap = dr["AP"].ToString().Trim();






                    worksheet.Cell(i + 2, "A").Value = (itemno);
                    worksheet.Cell(i + 2, "A").DataType = XLDataType.Text;

                    worksheet.Cell(i + 2, "B").Value = (itemdesc);
                    worksheet.Cell(i + 2, "B").DataType = XLDataType.Text;

                    worksheet.Cell(i + 2, "C").Value = (poamt);
                    worksheet.Cell(i + 2, "C").SetDataType(XLDataType.Number);
                    worksheet.Cell(i + 2, "C").Style.NumberFormat.Format = "#,##0;";
                    worksheet.Cell(i + 2, "C").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                    worksheet.Cell(i + 2, "D").Value = (extinvmisc);
                    worksheet.Cell(i + 2, "D").SetDataType(XLDataType.Number);
                    worksheet.Cell(i + 2, "D").Style.NumberFormat.Format = "#,##0;";
                    worksheet.Cell(i + 2, "D").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                    worksheet.Cell(i + 2, "E").Value = (ap);
                    worksheet.Cell(i + 2, "E").DataType = XLDataType.Text;







                    //worksheet.Cell(i + 2, "C").Value = ;
                    //worksheet.Cell(i + 2, "C").DataType = XLDataType.Number;
                    //worksheet.Cell(i + 2, "C").Style.NumberFormat.Format = "#,##0;";
                    //worksheet.Cell(i + 2, "C").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                    rows += 1;
                }

                var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, 5));


                filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;

                filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
                // 테두리 설정 



                worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

                workbook.SaveAs(Server.MapPath("~/Excel/result.xlsx"));  // 새로운 이름으로 저장하기


                FileInfo f = new FileInfo(Server.MapPath("~/Excel/result.xlsx"));
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + "품목별 매입현황.xlsx");
                HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
                HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.WriteFile(f.FullName);
                HttpContext.Current.Response.End();
            }
        }




        protected string SetComma(object obj)
        {

            string reval = string.Empty;
            long o = 0;
            if (Int64.TryParse(obj.ToString().Replace(".000", ""), out o))
            {
                reval = String.Format("{0:#,0}", o);
            }
            else
            {
                reval = "0";
            }
            return reval;
        }
        public string SetDate(object obj)
        {
            string reval = string.Empty;
            if (obj.ToString() == "0")
            {
                return reval;
            }
            else
            {
                reval = obj.ToString().Substring(0, 4) + "-" + obj.ToString().Substring(4, 2) + "-" + obj.ToString().Substring(6, 2);
            }
            return reval;
        }

        protected void Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            pager.CurrentIndex = currnetPageIndx;
            List();
;       }

        protected void DL1_SelectedIndexChanged(object sender, EventArgs e)
        {
            pager.CurrentIndex = 1;
            pager.PageSize = Convert.ToInt32(DL1.SelectedValue.ToString());
            List();
        }
    }
}