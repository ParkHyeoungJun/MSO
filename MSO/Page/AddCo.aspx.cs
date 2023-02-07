using System;
using Util;

namespace MSO.Page
{
    public partial class AddCo : BasePage
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

            //유저 바인딩 sp_GetEmp , A.EMPL, A.EMPLNAME
            ddl_User.DataTextField = "EMPLNAME";
            ddl_User.DataValueField = "EMPL";
            ddl_User.DataSource =db.Dataget(UserInfo.DBNAME, "sp_GetEmp");
            ddl_User.DataBind();
        }
    }
}