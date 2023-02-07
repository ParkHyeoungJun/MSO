using dbUtil;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Util;

namespace MSO.Page
{
    public partial class FindItem : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hid_DBNAME.Value = Request["dbname"];
            if (!string.IsNullOrEmpty(hid_DBNAME.Value))
            {
                UserInfo.DBNAME = hid_DBNAME.Value;
            }
            this.pager.CurrentIndex = 1;
            List();
        }

        protected void Command(object sender, CommandEventArgs e)
        {
            int currnetPageIndx = Convert.ToInt32(e.CommandArgument);
            pager.CurrentIndex = currnetPageIndx;
            List();
        }
        private void List()
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_ItemFind", new string[]
            {
                "@Searchtype"   ,
                "@Searchtxt"    ,
                "@pageNum"      ,
                "@amount"
            }, new string[]
            {
                ddl_Type.SelectedValue,
                tb_Search.Text,
                pager.CurrentIndex.ToString(),
                pager.PageSize.ToString()
            });
            if (dt.Rows.Count > 0)
            {
                lbl_nodata.Text = "";
                this.rep_List.DataSource = dt;
                this.rep_List.DataBind();
                this.pager.ItemCount = Convert.ToUInt32(dt.Rows[0]["cnt"].ToString());
            }
            else
            {
                this.rep_List.DataSource = null;
                this.rep_List.DataBind();
                lbl_nodata.Text = "검색된 데이터가 없습니다";
            }
        }

        protected void btn_List_Click(object sender, EventArgs e)
        {
            this.pager.CurrentIndex = 1;
            List();
        }
    }
}