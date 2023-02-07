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
    public partial class SalesstatusDetil : BasePage
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
                hid_iDocType.Value = Request["doctype"] as string;
                hid_sAR.Value = Request["ar"] as string;

                if(hid_sAR.Value.ToLower() == "no")
                {
                    hid_sDocNo.Value = Request["ordnumber"] as string;
                }
                else 
                {
                    hid_sDocNo.Value = Request["invoicenumber"] as string;
                }

                    DataRead();
            }
        }

        private void DataRead()
        {
            DbConxt dbConxt = new dbUtil.DbConxt();
            DataTable dataTable = dbConxt.Dataget(UserInfo.DBNAME, "SP_OZ3120_Cust_Header",
                new string[] { "@sAR", "@sDocNo", "@iDocType" },
                new string[] { hid_sAR.Value,hid_sDocNo.Value, hid_iDocType.Value }
                );

            if (dataTable != null && dataTable.Rows.Count > 0)
            {
                DataRow dr = dataTable.Rows[0];
                lbl_INVNUMBER.Text = dr["INVNUMBER"].ToString();
                lbl_COSTPO.Text = dr["CUSTPO"].ToString();
                lbl_CUSTOMER.Text = dr["CUSTOMER"].ToString();
                lbl_BILNAME.Text = dr["BILNAME"].ToString();
                lbl_SHINUMBER.Text = dr["SHINUMBER"].ToString();
                lbl_INVDATE.Text = SetDate(dr["INVDATE"]).ToString();
                lbl_LOCATION.Text = dr["LOCATION"].ToString();
                lbl_SHIPTO.Text = dr["SHIPTO"].ToString();
                lbl_SHPNAME.Text = dr["SHPNAME"].ToString();
                lbl_DESCR.Text = dr["DESCR"].ToString();
                lbl_REFERENCE.Text = dr["REFERENCE"].ToString();
            }

            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_OZ3120_Cust_Detail",
                new string[] { "@sAR", "@sDocNo", "@iDocType" },
                new string[] { hid_sAR.Value, hid_sDocNo.Value, hid_iDocType.Value }
                );
            if (dt != null && dt.Rows.Count > 0)
            {
                lbl_nodata.Text = "";
                this.rep_List.DataSource = dt;
                this.rep_List.DataBind();
                tr.Attributes.Remove("style");//.Add("style", "height:30px");
                tr.Visible = false;
            }
            else
            {
                this.rep_List.DataSource = null;
                this.rep_List.DataBind();
                lbl_nodata.Text = "검색된 데이터가 없습니다";
                tr.Attributes.Add("style", "height:30px");
                tr.Visible = true;
            }

        }

        protected string SetComma(object obj)
        {
            string reval = string.Empty;
            int o = 0;
            string str = obj.ToString().Split(new string[] { "." }, StringSplitOptions.None)[0];
            if (Int32.TryParse(str, out o))
            {
                reval = String.Format("{0:#,0}", o);
            }
            else
            {
                reval = "";
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
    }
}