using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace Util
{
    public class BasePage : System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            if (Request["id"] != null)
            {
                UserInfo.ID = Request["id"].ToString();
            }
            if (Request["pwd"] != null)
            {
                UserInfo.PWD = Request["pwd"].ToString();
            }
            if (Request["dbname"] != null)
            {
                UserInfo.DBNAME = Request["dbname"].ToString();
            }
            else
            {
               UserInfo.DBNAME = "UATCOM";
            }


            base.InitializeCulture();
        }


    }
}

