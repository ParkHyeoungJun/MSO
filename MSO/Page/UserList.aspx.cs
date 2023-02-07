using dbUtil;
using System;
using System.Data;
using System.Web.UI.WebControls;
using Util;

namespace MSO.Page
{
    public partial class UserList : BasePage
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
                this.pager.CurrentIndex = 1;
                List();
            }
        }


        protected void List()
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_User_Sel",
                new string[] { "@Searchtype", "@Searchtxt", "@pageNum", "@amount" },
                new string[] {

                    ddl_Type.SelectedValue,txt_Search.Text,this.pager.CurrentIndex.ToString(),pager.PageSize.ToString()
                }

                );
            if (dt != null && dt.Rows.Count > 0)
            {
                this.pager.ItemCount = Convert.ToInt32(dt.Rows[0]["cnt"].ToString());
                rpt_List.DataSource = dt;
                rpt_List.DataBind();
                lbl_NoData.Text = "";
            }
            else
            {
                rpt_List.DataSource = null;
                rpt_List.DataBind();
                lbl_NoData.Text = "검색된 데이터가 없습니다";
            }
        }


        protected void btn_Search_Click(object sender, EventArgs e)
        {
            List();
        }

        protected void pager_Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            this.pager.CurrentIndex = currnetPageIndx;
            List();
        }

    }
}