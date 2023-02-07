using ClosedXML.Excel;
using dbUtil;
using System;
using System.Data;
using System.IO;
using System.Web;
using Util;

namespace MSO.Page
{
    public partial class WorkUserView : BasePage
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
                hid_Userid.Value = Request["userid"];
                hid_UserName.Value = Request["username"];
                sdate.Value = Request["sday"];
                edate.Value = Request["eday"];
                List();
            }
           
        }

        private void List()
        {
            DbConxt db = new DbConxt();
            DataTable dt = db.Dataget(UserInfo.DBNAME, "sp_Work_UserSel"
                , new string[] { "@sDay", "@eDay", "@UserId" }
                , new string[] { sdate.Value + "-01", edate.Value + "-01", hid_Userid.Value }
                );

            //HashSet<int> getmm = new HashSet<int>(); // 월별 통계
            //HashSet<int> getww = new HashSet<int>(); // 주별 통계

            //#region 통계위한 데이터 및 변수 
            ////sp_Work_GetWW
            //DataTable wwdt = db.Dataget(UserInfo.DBNAME, "sp_Work_UserGetWW"
            //    , new string[] { "@sDay", "@eDay", "@UserId" }
            //    , new string[] { sdate.Value + "-01", edate.Value + "-01", hid_Userid.Value }
            //    );

            //DataTable mmdt = db.Dataget(UserInfo.DBNAME, "sp_Work_UserGetMM"
            //   , new string[] { "@sDay", "@eDay", "@UserId" }
            //   , new string[] { sdate.Value + "-01", edate.Value + "-01", hid_Userid.Value }
            //   );
            //// 주별 통계 
            //foreach (DataRow dr in wwdt.Rows)
            //{
            //    getww.Add(Convert.ToInt32(dr[0].ToString()));
            //}
            //// 월별 통계 
            //foreach (DataRow dr in mmdt.Rows)
            //{
            //    getmm.Add(Convert.ToInt32(dr[0].ToString()));
            //}

            //// 헤시은 반복문 돌리수 없어 List으로 넣는다 
            //List<int> wwlist = new List<int>(getww.Count);
            //List<int> mmlist = new List<int>(getmm.Count);
            //wwlist = getww.ToList();
            //mmlist = getmm.ToList();
            //#endregion
            //#region 주간 데이터 통계후 행에 추가 알고리즘
            //double[] Overtime = new double[getww.Count]; //평일 야근 시간 주별 합계
            //double[] WorkOvertime = new double[getww.Count];  // 특근 시간 주별 합계
            //double[] WoorkTime = new double[getww.Count]; // 근무시간 주별 합계
            //int[] insertrow = new int[getww.Count]; // DataTable에 추가 할 행.
            //for (int row = 0; row < dt.Rows.Count; row++)
            //{
            //    DataRow dr = dt.Rows[row];
            //    for (int ww = 0; ww < wwlist.Count; ww++)
            //    {
            //        if (wwlist[ww].ToString().Equals(dr["ww"].ToString()))
            //        {
            //            insertrow[ww] = row;
            //            Overtime[ww] += Convert.ToInt32(dr["Overtime"]);
            //            WorkOvertime[ww] += Convert.ToInt32(dr["WorkOvertime"]);
            //            WoorkTime[ww] += Convert.ToInt32(dr["WoorkTime"]);
            //        }
            //    }
            //}

            //int addrow = 1;

            ////합계 데이터 DataTable에 행 추가 로직 
            //for (int i = 0; i < insertrow.Count(); i++)
            //{
            //    DataRow dr = dt.NewRow();
            //    dr["Overtime"] = Overtime[i];
            //    dr["WorkOvertime"] = WorkOvertime[i];
            //    dr["WoorkTime"] = WoorkTime[i];
            //    dr["UserName"] = "주간 합계";
            //    dr["Email"] = "주간 합계";
            //    insertrow[i] = insertrow[i] + addrow;
            //    dt.Rows.InsertAt(dr, insertrow[i]);
            //    addrow += 1;
            //}
            //#endregion
            //#region 월별 통계 후 행에 추가 
            //Overtime = new double[getmm.Count]; //평일 야근 시간 월별 합계
            //WorkOvertime = new double[getmm.Count];  // 특근 시간 월별 합계
            //WoorkTime = new double[getmm.Count]; // 근무시간 월별 합계
            //insertrow = new int[getmm.Count]; // DataTable에 추가 할 행.


            //for (int row = 0; row < dt.Rows.Count; row++)
            //{
            //    DataRow dr = dt.Rows[row];

            //    for (int mm = 0; mm < mmlist.Count; mm++)
            //    {
            //        if (mmlist[mm].ToString().Equals(dr["mm"].ToString()))
            //        {
            //            insertrow[mm] = row;
            //            Overtime[mm] += Convert.ToInt32(dr["Overtime"]);
            //            WorkOvertime[mm] += Convert.ToInt32(dr["WorkOvertime"]);
            //            WoorkTime[mm] += Convert.ToInt32(dr["WoorkTime"]);
            //        }
            //    }
            //}

            //addrow = 2;
            ////합계 데이터 DataTable에 행 추가 로직 
            //for (int i = 0; i < insertrow.Count(); i++)
            //{
            //    DataRow dr = dt.NewRow();
            //    dr["Overtime"] = Overtime[i];
            //    dr["WorkOvertime"] = WorkOvertime[i];
            //    dr["WoorkTime"] = WoorkTime[i];
            //    dr["UserName"] = "월별 합계";
            //    dr["Email"] = "월별 합계";
            //    insertrow[i] = insertrow[i] + addrow;
            //    dt.Rows.InsertAt(dr, insertrow[i]);
            //    addrow += 1;
            //}
            //#endregion

            #region 총합계
            //int Overtimecnt = 0;
            //int WorkOvertimecnt = 0;
            //int WoorkTimecnt = 0;
            //for (int row = 0; row < dt.Rows.Count; row++)
            //{
            //    DataRow dr = dt.Rows[row];
            //    // 통계 데이터 생성하였기에 총합계는 기존데이터가 있다면 계산
            //    if (!string.IsNullOrEmpty(dr["num"].ToString()))
            //    {
            //        Overtimecnt += Convert.ToInt32(dr["Overtime"]);
            //        WorkOvertimecnt += Convert.ToInt32(dr["WorkOvertime"]);
            //        WoorkTimecnt += Convert.ToInt32(dr["WoorkTime"]);
            //    }
            //}

            //DataRow lastrow = dt.NewRow();
            //lastrow["Overtime"] = Overtimecnt;
            //lastrow["WorkOvertime"] = WorkOvertimecnt;
            //lastrow["WoorkTime"] = WoorkTimecnt;
            //lastrow["UserName"] = "총 합계";
            //lastrow["Email"] = "총 합계";
            //dt.Rows.Add(lastrow);// 마지막행에 넣기 
            #endregion


            if (dt != null && dt.Rows.Count > 0)
            {
                //lbl_NoData.Text = "";
                this.rpt_List.DataSource = dt;
                this.rpt_List.DataBind();
            }
            else
            {
                //lbl_NoData.Text = "검색된 데이터가 존재하지 않습니다";
                this.rpt_List.DataSource = null;
                this.rpt_List.DataBind();
            }

        }

        protected void btn_Search_Click(object sender, EventArgs e)
        {
            List();
        }

        protected void btn_Excel_Click(object sender, EventArgs e)
        {
            DbConxt db = new DbConxt();
            DataTable dt = db.Dataget(UserInfo.DBNAME, "sp_Work_UserSel"
                , new string[] { "@sDay", "@eDay", "@UserId" }
                , new string[] { sdate.Value + "-01", edate.Value + "-01", hid_Userid.Value }
                );

        
            ExportExcel(dt);
        }


        private void ExportExcel(DataTable dt)
        {
            var workbook = new XLWorkbook(Server.MapPath("~/Excel/WORKview.xlsx"));  //  엑셀 열기

            // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
            int rows = 1;
            //int cols = 1;
            var worksheet = workbook.Worksheet(1);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];
                worksheet.Cell(i + 2, "A").SetValue((String)dr["UserName"].ToString());
                worksheet.Cell(i + 2, "B").SetValue((String)dr["DATENA"].ToString());
                worksheet.Cell(i + 2, "C").SetValue((String)dr["AttenDay"].ToString());
                worksheet.Cell(i + 2, "C").DataType = XLDataType.Text;
                worksheet.Cell(i + 2, "D").SetValue((String)dr["AttenTime"].ToString());
                worksheet.Cell(i + 2, "D").DataType = XLDataType.Text;

                worksheet.Cell(i + 2, "E").SetValue((String)dr["LeaveTime"].ToString());
                worksheet.Cell(i + 2, "E").DataType = XLDataType.Text;
                worksheet.Cell(i + 2, "F").SetValue((String)dr["WoorkTime"].ToString());
                worksheet.Cell(i + 2, "F").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "F").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "F").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;


                worksheet.Cell(i + 2, "G").SetValue((String)dr["Overtime"].ToString());
                worksheet.Cell(i + 2, "G").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "G").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "G").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;



                worksheet.Cell(i + 2, "H").SetValue((String)dr["WorkOvertime"].ToString());
                worksheet.Cell(i + 2, "H").DataType = XLDataType.Number;
                worksheet.Cell(i + 2, "H").Style.NumberFormat.Format = "#,##0;";
                worksheet.Cell(i + 2, "H").Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Right;

                rows += 1;
            }

            var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, 8));


            filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;

            filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            // 테두리 설정 



            worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

            workbook.SaveAs(Server.MapPath("~/Excel/result.xlsx"));  // 새로운 이름으로 저장하기


            FileInfo f = new FileInfo(Server.MapPath("~/Excel/result.xlsx"));
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + "사용자별잔업특근현황.xlsx");
            HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
            HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.WriteFile(f.FullName);
            HttpContext.Current.Response.End();

        }

    }
}