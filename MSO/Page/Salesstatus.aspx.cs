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
    public partial class Salesstatus : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                pager.CurrentIndex = 1;
                hid_DBNAME.Value = Request["dbname"];
                txt_sdate.Value = DateTime.Now.ToString("yyyy-MM") + "-01";
                DateTime lastday = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 01).AddMonths(1).AddDays(-1);
                txt_edate.Value = lastday.ToString("yyyy-MM-dd");
                if (!string.IsNullOrEmpty(hid_DBNAME.Value))
                {
                    UserInfo.DBNAME = hid_DBNAME.Value;
                }
            }

            if (this.IsPostBack)
            {
                TabName.Value = Request.Form[TabName.UniqueID];



                if (!string.IsNullOrEmpty(hid_coustomer1.Value))
                {
                    txt_Coustomer1.Text = hid_coustomer1.Value;
                }
                if (!string.IsNullOrEmpty(hid_coustomer2.Value) && hid_coustomer2.Value != "ZZZZZZZZZZZZ" && hid_coustomer2.Value != "ZZZZZZZZZZZZZZZZZZZZZZZZ")
                {
                    txt_Coustomer2.Text = hid_coustomer2.Value;
                }

                pager.PageSize = Convert.ToInt32(ddl_PageSize.SelectedValue);

               
                //string rb1 = Request.Form[rb1.UniqueID];
            }
        }




        protected void btn_Search_Click(object sender, EventArgs e)
        {
            pager.CurrentIndex = 1;
            List();
        }

        private void List()
        {
            DbConxt dbConxt = new DbConxt();
            if (tbList.SelectedIndex == 0)
            {
                DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_OZ3120_Cust", new string[]
               {
                    "@sDate_F"   ,
                    "@sDate_T"    ,
                    "@sCust_F"      ,
                    "@sCust_T",
                    "@pageNum",
                    "@amount",
                    "@ExcelYn"
               }, new string[]
               {
                    txt_sdate.Value.Replace("-",""),
                    txt_edate.Value.Replace("-",""),
                    hid_coustomer1.Value,
                    hid_coustomer2.Value,
                    pager.CurrentIndex.ToString(),
                    ddl_PageSize.SelectedValue,
                    "N"
                    //Page
               });

                DataTable tot_dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_OZ3120_Cust_Total", new string[]
                {
                                    "@sDate_F"   ,
                                    "@sDate_T"    ,
                                    "@sCust_F"      ,
                                    "@sCust_T",

                }, new string[]
                {
                                    txt_sdate.Value.Replace("-",""),
                                    txt_edate.Value.Replace("-",""),
                                    hid_coustomer1.Value,
                                    hid_coustomer2.Value,
                });


                rep_List1.Visible = true;
                rep_List2.Visible = false;
                if (dt.Rows.Count > 0)
                {
                    pager.ItemCount= Convert.ToInt32(dt.Rows[0]["cnt"].ToString());
                    lbl_nodata.Text = "";
                    norow.Visible = false;
                    this.rep_List1.DataSource = dt;
                    this.rep_List1.DataBind();
                    btn_Excel.Visible = true;
                  
                    tot_COGS.Text = SetComma(tot_dt.Rows[0]["COGS"]);
                    tot_Y.Text = SetComma(tot_dt.Rows[0]["INVSUBTOT"]);
                    tot_N.Text = SetComma(tot_dt.Rows[0]["ORDAMT"]);                        
                    tot_sum.Text = SetComma(tot_dt.Rows[0]["TOTALAMT"]);
                }
                else
                {
                    pager.ItemCount = 1;
                    this.rep_List1.DataSource = null;
                    this.rep_List1.DataBind();
                    lbl_nodata.Text = "검색된 데이터가 없습니다";
                    btn_Excel.Visible = false;
                    tot_COGS.Text = "0";
                    tot_Y.Text = "0";
                    tot_N.Text = "0";
                    tot_sum.Text = "0";

                }
            }
            else
            {
                DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_OZ3120_Cust_Items", new string[]
                  {
                        "@sDate_F"      ,
                        "@sDate_T"      ,
                        "@sItem_F"      ,
                        "@sItem_T"      ,
                        "@pageNum"      ,
                        "@amount"       ,
                        "@ExcelYn"
                  }, new string[]
                  {
                        txt_sdate.Value.Replace("-","") ,
                        txt_edate.Value.Replace("-","") ,
                        hid_coustomer1.Value            ,
                        hid_coustomer2.Value            ,
                        pager.CurrentIndex.ToString()   ,
                        ddl_PageSize.SelectedValue      ,
                        "N"
                  });

                DataTable tot_dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_OZ3120_Cust_Items_Total", new string[]
                 {
                        "@sDate_F"      ,
                        "@sDate_T"      ,
                        "@sItem_F"      ,
                        "@sItem_T"      ,
                 }, new string[]
                 {
                        txt_sdate.Value.Replace("-","") ,
                        txt_edate.Value.Replace("-","") ,
                        hid_coustomer1.Value            ,
                        hid_coustomer2.Value            ,
                 });

                rep_List1.Visible = false;
                rep_List2.Visible = true;
                if (dt.Rows.Count > 0)
                {
                    lbl_nodata.Text = "";
                    norow.Visible = false;
                    this.rep_List2.DataSource = dt;
                    this.rep_List2.DataBind();
                    btn_Excel.Visible = true;
                    this.pager.ItemCount = Convert.ToUInt32(dt.Rows[0]["cnt"].ToString());

                    tot_COGS.Text = SetComma(tot_dt.Rows[0]["COGS"]);
                    tot_Y.Text = SetComma(tot_dt.Rows[0]["EXTINVMISC"]);
                    tot_N.Text = SetComma(tot_dt.Rows[0]["ORDAMT"]);
                    tot_sum.Text = SetComma(tot_dt.Rows[0]["TOTALAMT"]);
                }
                else
                {
                    this.rep_List2.DataSource = null;
                    this.rep_List2.DataBind();
                    lbl_nodata.Text = "검색된 데이터가 없습니다";
                    btn_Excel.Visible = false;
                    tot_COGS.Text = "0";
                    tot_Y.Text = "0";
                    tot_N.Text = "0";
                    tot_sum.Text = "0";
                }
            }
            TabName.Value = "employment";
            ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "employment();", true);
        }

        protected void btn_Excel_Click(object sender, EventArgs e)
        {
            DbConxt dbConxt = new DbConxt();
            if (tbList.SelectedIndex==0)
            {
                DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_OZ3120_Cust", new string[]
           {
                "@sDate_F"      ,
                "@sDate_T"      ,
                "@sCust_F"      ,
                "@sCust_T"      ,
                "@pageNum"      ,
                "@amount"       ,
                "@ExcelYn"
           }, new string[]
           {
                txt_sdate.Value.Replace("-","") ,
                txt_edate.Value.Replace("-","") ,
                hid_coustomer1.Value            ,
                hid_coustomer2.Value            ,
                pager.CurrentIndex.ToString()   ,
                ddl_PageSize.SelectedValue      ,
                "Y"
           });
                CUSTOMERExcel(dt);
            }
            else
            {
                DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_OZ3120_Cust_Items", new string[]
          {
                "@sDate_F"      ,
                "@sDate_T"      ,
                "@sItem_F"      ,
                "@sItem_T"      ,
                "@pageNum"      ,
                "@amount"       ,
                "@ExcelYn"
          }, new string[]
          {
                txt_sdate.Value.Replace("-","") ,
                txt_edate.Value.Replace("-","") ,
                hid_coustomer1.Value            ,
                hid_coustomer2.Value            ,
                pager.CurrentIndex.ToString()   ,
                ddl_PageSize.SelectedValue      ,
                "Y"
          });
                ItemExcel(dt);
            }
            TabName.Value = "employment";
        }

        protected void CUSTOMERExcel(DataTable dt)
        {
            var workbook = new XLWorkbook(Server.MapPath("~/Excel/SalesCustomer.xlsx"));  //  엑셀 열기

            // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
            int rows = 1;
            var worksheet = workbook.Worksheet(1);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                rows += 1;
                DataRow dr = dt.Rows[i];

                worksheet.Cell(i + 2, "A").Value = (dr["CUSTOMER"].ToString());
                worksheet.Cell(i + 2, "A").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "B").Value = (dr["NAMECUST"].ToString());
                worksheet.Cell(i + 2, "B").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "C").Value = (dr["PONUMBER"].ToString());
                worksheet.Cell(i + 2, "C").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "D").Value = (dr["ORDNUMBER"].ToString());
                worksheet.Cell(i + 2, "D").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "E").Value = SetDate(dr["ORDDATE"].ToString());
                worksheet.Cell(i + 2, "E").Style.NumberFormat.Format = "yyyy-mm-dd;";
                worksheet.Cell(i + 2, "E").DataType = XLDataType.DateTime;

                worksheet.Cell(i + 2, "F").Value = (dr["ORDAMT"].ToString());
                worksheet.Cell(i + 2, "F").SetDataType(XLDataType.Number);
                worksheet.Cell(i + 2, "F").Style.NumberFormat.Format = "#,##0_;";
                worksheet.Cell(i + 2, "F").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "G").Value = (dr["INVNUMBER"].ToString());
                worksheet.Cell(i + 2, "G").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "H").Value = SetDate(dr["INVDATE"].ToString());
                worksheet.Cell(i + 2, "H").Style.NumberFormat.Format = "yyyy-mm-dd;";
                worksheet.Cell(i + 2, "H").DataType = XLDataType.DateTime;

                worksheet.Cell(i + 2, "I").Value = (dr["INVSUBTOT"].ToString());
                worksheet.Cell(i + 2, "I").SetDataType(XLDataType.Number);
                worksheet.Cell(i + 2, "I").Style.NumberFormat.Format = "#,##0_;";
                worksheet.Cell(i + 2, "I").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "J").Value = (dr["COGS"].ToString());
                worksheet.Cell(i + 2, "J").SetDataType(XLDataType.Number);
                worksheet.Cell(i + 2, "J").Style.NumberFormat.Format = "#,##0_;";
                worksheet.Cell(i + 2, "J").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "K").Value = (dr["AR"].ToString());
                worksheet.Cell(i + 2, "K").DataType = XLDataType.Text;
                worksheet.Cell(i + 2, "K").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

                worksheet.Cell(i + 2, "L").Value = (dr["ARTYPE"].ToString().Trim());
                worksheet.Cell(i + 2, "L").DataType = XLDataType.Text;
                worksheet.Cell(i + 2, "L").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            }

            var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, 12));


            filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            filterrange.Style.Border.LeftBorder = XLBorderStyleValues.Thin;
            filterrange.Style.Border.RightBorder = XLBorderStyleValues.Thin;

            filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            // 테두리 설정 



            worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

            workbook.SaveAs(Server.MapPath("~/Excel/result.xlsx"));  // 새로운 이름으로 저장하기


            FileInfo f = new FileInfo(Server.MapPath("~/Excel/result.xlsx"));
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + "판매처별 매출현황.xlsx");
            HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
            HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.WriteFile(f.FullName);
            HttpContext.Current.Response.End();

        }


        protected void ItemExcel(DataTable dt)
        {
            var workbook = new XLWorkbook(Server.MapPath("~/Excel/SalesItem.xlsx"));  //  엑셀 열기

            // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
            int rows = 1;
            var worksheet = workbook.Worksheet(1);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                rows += 1;
                DataRow dr = dt.Rows[i];
                worksheet.Cell(i + 2, "A").Value = (dr["ITEMNO"].ToString());
                worksheet.Cell(i + 2, "A").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "B").Value = (dr["ITEMDESC"].ToString());
                worksheet.Cell(i + 2, "B").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "C").Value = (dr["ORDAMT"].ToString());
                worksheet.Cell(i + 2, "C").SetDataType(XLDataType.Number);
                worksheet.Cell(i + 2, "C").Style.NumberFormat.Format = "#,##0_;";
                worksheet.Cell(i + 2, "C").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "D").Value = (dr["EXTINVMISC"].ToString());
                worksheet.Cell(i + 2, "D").SetDataType(XLDataType.Number);
                worksheet.Cell(i + 2, "D").Style.NumberFormat.Format = "#,##0_;";
                worksheet.Cell(i + 2, "D").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "E").Value = (dr["COGS"].ToString());
                worksheet.Cell(i + 2, "E").SetDataType(XLDataType.Number);
                worksheet.Cell(i + 2, "E").Style.NumberFormat.Format = "#,##0_;";
                worksheet.Cell(i + 2, "E").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                worksheet.Cell(i + 2, "F").Value = (dr["AR"].ToString());
                worksheet.Cell(i + 2, "F").DataType = XLDataType.Text;
                worksheet.Cell(i + 2, "F").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

                worksheet.Cell(i + 2, "G").Value = (dr["ARTYPE"].ToString().Trim());
                worksheet.Cell(i + 2, "G").DataType = XLDataType.Text;
                worksheet.Cell(i + 2, "G").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            }

            var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, 7));


            filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
            filterrange.Style.Border.LeftBorder = XLBorderStyleValues.Thin;
            filterrange.Style.Border.RightBorder = XLBorderStyleValues.Thin;

            filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            // 테두리 설정 



            worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

            workbook.SaveAs(Server.MapPath("~/Excel/result.xlsx"));  // 새로운 이름으로 저장하기


            FileInfo f = new FileInfo(Server.MapPath("~/Excel/result.xlsx"));
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + "품목별 매출현황.xlsx");
            HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
            HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.WriteFile(f.FullName);
            HttpContext.Current.Response.End();
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
                reval = "";
            }
            return reval;
        }

        protected void Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            pager.CurrentIndex = currnetPageIndx;
            List();
        }

        protected void ddl_PageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            pager.CurrentIndex = 1;
            pager.PageSize= Convert.ToInt32(ddl_PageSize.SelectedValue);
            List();
        }
    }


}
