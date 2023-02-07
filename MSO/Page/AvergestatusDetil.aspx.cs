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
    public partial class AvergestatusDetil : BasePage
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
                hid_sAR.Value = Request["ap"] as string;
                hid_POsDocNo.Value = Request["ponumber"] as string; 
                hid_INVsDocNo.Value = Request["invoicenumber"] as string;

                HeaderBind();
                DetailBind();
            }
        }

        private void HeaderBind()
        {
            string sDocNo = string.Empty;
            if (hid_sAR.Value == "No" && hid_POsDocNo != null)
            {
                sDocNo = hid_POsDocNo.Value;
            }
            else if(hid_sAR.Value == "Yes" && hid_INVsDocNo != null)
            {
                sDocNo = hid_INVsDocNo.Value;
            }
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Header", new string[]
            {
                "@sAP"   ,
                "@sDocNo" ,
                "@iDocType"     
            }, new string[]
            {
                hid_sAR.Value.ToString(),
                sDocNo,
                hid_iDocType.Value.ToString()

            });
            if (dt.Rows.Count > 0)
            {
                                
                lbl_InvNum.Text=dt.Rows[0]["INVNUMBER"].ToString();
                lbl_VendNum.Text=dt.Rows[0]["VDCODE"].ToString();
                lbl_VendName.Text = dt.Rows[0]["VDNAME"].ToString();
                lbl_RcpNum.Text = dt.Rows[0]["RCPNUMBER"].ToString();
                lbl_InvDate.Text = SetDate(dt.Rows[0]["INVDATE"].ToString());
                lbl_Location.Text = dt.Rows[0]["LOCATION"].ToString();
                lbl_Description.Text = dt.Rows[0]["DESCRIPTIO"].ToString();
                lbl_Reference.Text = dt.Rows[0]["REFERENCE"].ToString();
            }

        }

        private void DetailBind()
        {
            string sDocNo = string.Empty;
            if (hid_sAR.Value == "No" && hid_POsDocNo != null)
            {
                sDocNo = hid_POsDocNo.Value;
            }
            else if (hid_sAR.Value == "Yes" && hid_INVsDocNo != null)
            {
                sDocNo = hid_INVsDocNo.Value;
            }
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "SP_PZ3120_Vend_Detail", new string[]
            {
                "@sAP"   ,
                "@sDocNo" ,
                "@iDocType"
            }, new string[]
            {
                hid_sAR.Value.ToString(),
                sDocNo,
                hid_iDocType.Value.ToString()

            });
            if (dt.Rows.Count > 0)
            {
                td_nodata.Visible = false;
                lbl_nodata.Visible = false;
                lbl_nodata.Text = "";
                rep_List1.DataSource = dt;
                rep_List1.DataBind();
            }
            else
            {
                td_nodata.Visible = true;
                lbl_nodata.Visible = true;
                lbl_nodata.Text = "검색된 데이터가 없습니다";
                rep_List1.DataSource = null;
                rep_List1.DataBind();
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
    }
}