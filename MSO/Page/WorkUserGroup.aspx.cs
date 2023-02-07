using ClosedXML.Excel;
using dbUtil;
using System;
using System.Collections;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;
using Util;

namespace MSO.Page
{
    public partial class WorkUserGroup : BasePage
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
                sdate.Value = DateTime.Now.ToString("yyyy-MM");
                edate.Value = DateTime.Now.ToString("yyyy-MM");
                // this.pager.CurrentIndex = 1;


                List();
            }
        }

        protected void Btn_Excel_Click(object sender, EventArgs e)
        {
            DbConxt db = new dbUtil.DbConxt();
            DataTable dt = db.Dataget(UserInfo.DBNAME, "sp_Work_GroupSel"
                , new string[] { "@sDay", "@eDay" }
                , new string[] { sdate.Value + "-01", edate.Value + "-01" }
                );
            //dt.Columns.Remove("rownum");

            //dt.Columns.Remove("UserId");
            //dt.Columns["UserId"].ColumnName = "사번";


            //dt.Columns["UserName"].ColumnName = "이름";
            //dt.Columns["Overtime"].ColumnName = "야근시간";
            //dt.Columns["WorkOvertime"].ColumnName = "특근시간";
            //dt.Columns["WoorkTime"].ColumnName = "근무시간";
            //dt.Columns["YY"].ColumnName = "년도";
            //dt.Columns["MM"].ColumnName = "월";
            ExportExcel(dt);
            //ExcelUtil.Export2(this.Page, "잔업특근 관리", Server.MapPath("~/Excel/WORK.xlsx"), Server.MapPath("~/Excel/result.xlsx"), "특근관리.xlsx", dt, true);
        }

        private void ExportExcel(DataTable dt)
        {
            var workbook = new XLWorkbook(Server.MapPath("~/Excel/WORK.xlsx"));  //  엑셀 열기

            // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
            int rows = 1;
            var worksheet = workbook.Worksheet(1);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];
                worksheet.Cell(i + 2, "A").Value = dr["UserName"].ToString();
                worksheet.Cell(i + 2, "B").Value = dr["email"].ToString();
                worksheet.Cell(i + 2, "C").Value = dr["YY"].ToString();
                worksheet.Cell(i + 2, "C").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "C").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "C").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;
                //worksheet.Cell(i + 2, "C")

                worksheet.Cell(i + 2, "D").Value = dr["WoorkTime"].ToString();
                worksheet.Cell(i + 2, "D").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "D").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "D").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                worksheet.Cell(i + 2, "E").Value = dr["Overtime"].ToString();
                worksheet.Cell(i + 2, "E").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "E").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "E").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                worksheet.Cell(i + 2, "F").Value = dr["WorkOvertime"].ToString();
                worksheet.Cell(i + 2, "F").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "F").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "F").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                rows += 1;
            }

            var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, 6));


            filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;

            filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            // 테두리 설정 



            worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

            workbook.SaveAs(Server.MapPath("~/Excel/result.xlsx"));  // 새로운 이름으로 저장하기


            FileInfo f = new FileInfo(Server.MapPath("~/Excel/result.xlsx"));
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" +"잔업특근.xlsx");
            HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
            HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.WriteFile(f.FullName);
            HttpContext.Current.Response.End();

        }

        protected void List()
        {
            DbConxt db = new dbUtil.DbConxt();
            DataTable dt = db.Dataget(UserInfo.DBNAME, "sp_Work_GroupSel"
                , new string[] { "@sDay", "@eDay" }
                , new string[] { sdate.Value + "-01", edate.Value + "-01" }
                );



            if (dt != null && dt.Rows.Count > 0)
            {
                lbl_NoData.Text = "";
                this.rpt_List.DataSource = dt;
                this.rpt_List.DataBind();
            }
            else
            {
                lbl_NoData.Text = "검색된 데이터가 존재하지 않습니다";
                this.rpt_List.DataSource = null;
                this.rpt_List.DataBind();
            }
            // ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "DataAvg();", true);
        }

        protected void btn_Search_Click(object sender, EventArgs e)
        {
            List();
        }

        protected void Btn_Import_Click(object sender, EventArgs e)
        {
            if (this.fileUpload.HasFile)
            {
                string filename = Guid.NewGuid().ToString() + "_" + this.fileUpload.FileName;
                string filePath = Path.Combine(Server.MapPath("~/"), "Uploads", filename);
                this.fileUpload.SaveAs(filePath);
                ReadExcelFile(filePath);
                FileInfo fileInfo = new FileInfo(filePath);
                if (fileInfo.Exists)
                {
                    fileInfo.Delete();
                }
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "ExcelComplt('저장되었습니다');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "alert('선택된 파일이 존재하지 않습니다');", true);
            }
        }

        protected void ReadExcelFile(string path)
        {
            //DataTable dt = new DataTable();
            using (var excelWorkbook = new XLWorkbook(path))
            {
                var worksheet = excelWorkbook.Worksheet(1);  // 첫번째 sheet열기
                var nonEmptyDataRows = excelWorkbook.Worksheet(1).RowsUsed();
                int row = 1;
                DbConxt dbConxt = new DbConxt();
                foreach (var dataRow in nonEmptyDataRows)
                {
                    if (row != 1)
                    {
                        worksheet.Cell(row, "B").DataType = XLDataType.Text;
                        worksheet.Cell(row, "D").DataType = XLDataType.Text;
                        worksheet.Cell(row, "D").DataType = XLDataType.Text;
                        var UserId = worksheet.Cell(row, "E").Value.ToString();
                        var AttenDay = worksheet.Cell(row, "B").Value.ToString().Substring(0, 10);
                        var stats = worksheet.Cell(row, "D").Value.ToString().Substring(0, 2);
                        var AttenTime = "";
                        var LeaveTime = "";
                        if (stats == "출근")
                        {
                            AttenTime = dataRow.Cell(2).Value.ToString().Substring(11, 5);
                            dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_Work_ExcelIns"
                                , new string[] { "@UserId", "@AttenDay", "@AttenTime" }
                                , new string[] { UserId.ToString(), AttenDay.ToString(), AttenTime.ToString() }
                                );
                        }
                        else if (stats == "퇴근")
                        {
                            if (UserId == "0103836163800")
                            {
                                int a = 0;
                            }
                            LeaveTime = dataRow.Cell(2).Value.ToString().Substring(11, 5);

                            dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_Work_ExcelUp"
                               , new string[] { "@UserId", "@AttenDay", "@LeaveTime" }
                               , new string[] { UserId.ToString(), AttenDay.ToString(), LeaveTime.ToString() }
                               );
                        }
                    }
                    row += 1;
                }
            }
        }

        protected void Btn_Email_Click(object sender, EventArgs e)
        {


            //EmailUtil.Send(hid_Userid.Value, hid_Userid.Value, hid_Userid.Value, "메일 발송", body);
            int cnt = 0;
            foreach (RepeaterItem item in rpt_List.Items)
            {
                CheckBox cb_check = (CheckBox)item.FindControl("cb_check");
                Label lbl_UserName = (Label)item.FindControl("lbl_UserName");
                Label lbl_Email = (Label)item.FindControl("lbl_Email");
                Label lbl_YY = (Label)item.FindControl("lbl_YY");
                Label lbl_MM = (Label)item.FindControl("lbl_MM");
                Label lbl_Overtime = (Label)item.FindControl("lbl_Overtime");
                Label lbl_WorkOvertime = (Label)item.FindControl("lbl_WorkOvertime");
                Label lbl_WoorkTime = (Label)item.FindControl("lbl_WoorkTime");
                HiddenField hid_UserID = (HiddenField)item.FindControl("hid_UserID");
                HiddenField hid_Email = (HiddenField)item.FindControl("hid_Email");
                if (cb_check.Checked)
                {
                    cnt += 1;
                    EmailSend(hid_Email.Value, lbl_UserName.Text, lbl_YY.Text, lbl_MM.Text, lbl_WoorkTime.Text, lbl_Overtime.Text, lbl_WorkOvertime.Text, hid_UserID.Value);
                }
            }
            if (cnt > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "alert('" + cnt + "건 메일 발송 되었습니다');", true);
            }
            else
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", "alert('메일 발송된 건수가 0건입니다');", true);
        }


        protected void EmailSend(string to, string name, string yy, string mm, string woorktime, string overtime, string workovertime,string userid)
        {

            var body = "<meta name='format - detection' content='telephone = no', email=no, address=no'> "; 
               body += "<h1>" + "(" + name + ")직원님의 " + yy + "년도 " + mm + "월 근무현황</h1>";

            DbConxt db = new DbConxt();
            DataTable dt = db.Dataget(UserInfo.DBNAME, "sp_Work_UserSel"
                , new string[] { "@sDay", "@eDay", "@UserId" }
                , new string[] { yy + "-" + mm + "-01", yy + "-" + mm + "-01", userid }
                );

            
            body += "<table style='border:1px'>";
            body += "<thead>";
            body += "<tr>";
            body += "<th style=' text-align: center;background-color: #f5f9fb;color: #31799c;padding: 8px;font-size: 15px;border: 1px solid #cad4d9;white-space: nowrap;'>직원</th>";
            body += "<th style=' text-align: center;background-color: #f5f9fb;color: #31799c;padding: 8px;font-size: 15px;border: 1px solid #cad4d9;white-space: nowrap;'>요일</th>";
            body += "<th style=' text-align: center;background-color: #f5f9fb;color: #31799c;padding: 8px;font-size: 15px;border: 1px solid #cad4d9;white-space: nowrap;'>날자</th>";
            body += "<th style=' text-align: center;background-color: #f5f9fb;color: #31799c;padding: 8px;font-size: 15px;border: 1px solid #cad4d9;white-space: nowrap;'>출근</th>";
            body += "<th style=' text-align: center;background-color: #f5f9fb;color: #31799c;padding: 8px;font-size: 15px;border: 1px solid #cad4d9;white-space: nowrap;'>퇴근</th>";
            body += "<th style=' text-align: center;background-color: #f5f9fb;color: #31799c;padding: 8px;font-size: 15px;border: 1px solid #cad4d9;white-space: nowrap;'>근무시간</th>";
            body += "<th style=' text-align: center;background-color: #f5f9fb;color: #31799c;padding: 8px;font-size: 15px;border: 1px solid #cad4d9;white-space: nowrap;'>야근시간</th>";
            body += "<th style=' text-align: center;background-color: #f5f9fb;color: #31799c;padding: 8px;font-size: 15px;border: 1px solid #cad4d9;white-space: nowrap;'>특근시간</th>";
            body += "</tr>";
            body += "</thead>";
           

            body += "<tbody>";
            foreach (DataRow dr in dt.Rows)
            {
                body += "<tr>";
                body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>" + dr["UserName"].ToString() + " </td>";
                if (!string.IsNullOrEmpty(dr["DATENA"].ToString()))
                {
                    body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>" + dr["DATENA"].ToString() + " </td>";
                }
                else
                {
                    body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>&nbsp; </td>";
                }
                if (!string.IsNullOrEmpty(dr["AttenDay"].ToString()))
                {
                    body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>" + dr["AttenDay"].ToString() + " </td>";
                }
                else
                {
                    body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>&nbsp; </td>";
                }
                if (!string.IsNullOrEmpty(dr["AttenTime"].ToString()))
                {
                    body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>" + dr["AttenTime"].ToString() + " </td>";
                }
                else
                {
                    body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>&nbsp; </td>";
                }
                if (!string.IsNullOrEmpty(dr["LeaveTime"].ToString()))
                {
                    body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>" + dr["LeaveTime"].ToString() + " </td>";
                }
                else
                {
                    body += "<td style='border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>&nbsp; </td>";
                }

                body += "<td style='text-align: right;border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>" + dr["WoorkTime"].ToString() + " </td>";
                body += "<td style='text-align: right;border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>" + dr["Overtime"].ToString() + " </td>";
                body += "<td style='text-align: right;border-bottom: 1px solid #cad4d9;border-left: 1px solid #cad4d9;border-right: 1px solid #cad4d9;padding-bottom: 3px;padding-right: 5px;padding-top: 3px;padding-left: 5px;margin-left: 3px;white-space: nowrap'>" + dr["WorkOvertime"].ToString() + " </td>";

                body += "</tr>";
            }



            body += "</tbody>";
            body += "</table>";
            EmailUtil.Send(to,"(" + name + ") 직원님의 " + yy + "년도 " + mm + "월 근무현황", body);
        }




        protected void Rpt_List_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item)
            {
                ArrayList arr = e.Item.DataItem as ArrayList;
                CheckBox cb_check = (CheckBox)e.Item.FindControl("cb_check");
                // cb_check.Attributes.Add("class", "ckeckbox");
            }
        }
    }
}