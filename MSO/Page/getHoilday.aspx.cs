using dbUtil;
using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Net;
using Util;

namespace MSO.Page
{
    public partial class getHoilday : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txt_date.Text = DateTime.Now.ToString("yyyy");
                hid_DBNAME.Value = Request["dbname"];
                if (!string.IsNullOrEmpty(hid_DBNAME.Value))
                {
                    UserInfo.DBNAME = hid_DBNAME.Value;
                }
               // txt_sdate.Value = DateTime.Now.ToString("yyyy-MM");
            }
        }

        protected void btn_Save_Click(object sender, EventArgs e)
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("dateKind");
            dataTable.Columns.Add("YN");
            dataTable.Columns.Add("HoliDay");
            dataTable.Columns.Add("seq");
            dataTable.Columns.Add("item_id");
            dataTable.Columns.Add("title");
            for (int i = 1; i <= 12; i++)
            {               
              
                String url = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?solYear=" + txt_date.Text + "&solMonth=" + i.ToString("00") + "&ServiceKey=" + ConfigurationManager.AppSettings["ServiceKey"];
                string responseText = string.Empty;

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "GET";
                request.Timeout = 30 * 1000; // 30초
                request.Headers.Add("Authorization", "BASIC SGVsbG8="); // 헤더 추가 방법

                using (HttpWebResponse resp = (HttpWebResponse)request.GetResponse())
                {
                    HttpStatusCode status = resp.StatusCode;
                    Console.WriteLine(status);  // 정상이면 "OK"

                    Stream respStream = resp.GetResponseStream();
                    using (StreamReader sr = new StreamReader(respStream))
                    {
                        responseText = sr.ReadToEnd();
                    }
                }
                //
                responseText = responseText.Split(new string[] { "?>" }, StringSplitOptions.None)[1];

                StringReader srr = new StringReader(responseText);

                DataSet ds = new DataSet();
                ds.ReadXml(srr);
                DataTable dt = ds.Tables["item"];
                if (dt != null)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        DataRow dataRow = dataTable.NewRow();
                        dataRow[0] = dr["dateKind"];
                        dataRow["YN"] = dr["isHoliday"];
                        dataRow["HoliDay"] = dr["locdate"].ToString().Substring(0, 4) + "-" + dr["locdate"].ToString().Substring(4, 2) + "-" + dr["locdate"].ToString().Substring(6, 2); //dr["locdate"];
                        dataRow[3] = dr["seq"];
                        dataRow[4] = dr[5];
                        dataRow["title"] = dr["dateName"];
                        dataTable.Rows.Add(dataRow);
                    }
                }
                
            }


            
            
            DbConxt dbConxt = new DbConxt();

            if (dataTable != null && dataTable.Rows.Count > 0)
            {
                foreach (DataRow dr in dataTable.Rows)
                {
                    string title = dr["title"].ToString();
                   string YN = dr["YN"].ToString().ToUpper() == "Y" ? "true" : "false";
                    string HoliDay = dr["HoliDay"].ToString();
                    dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_Holiday_Ins"
                        , new string[] { "@YN", "@Title", "@HoliDay" }
                        , new string[] { YN, title, HoliDay }
                        );

                }
            }


            btn_List_Click(null, null);


        }

        protected void btn_List_Click(object sender, EventArgs e)
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dataTable = dbConxt.Dataget(UserInfo.DBNAME, "sp_Holiday_GetYear"
                , new string[] { "@yyyy" }
                , new string[] { txt_date.Text }
                );

            if (dataTable != null && dataTable.Rows.Count > 0)
            {
                lbl_NoData.Text = "";
                rep_List.DataSource = dataTable;
                rep_List.DataBind();
            }
            else
            {
                lbl_NoData.Text = "검색된 데이터가 없습니다";
                rep_List.DataSource = null;
                rep_List.DataBind();
            }

        }
    }
}