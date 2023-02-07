using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace MSO.WebService
{
    /// <summary>
    /// testweb의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
     [System.Web.Script.Services.ScriptService]
    public class testweb : System.Web.Services.WebService
    {

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string HelloWorld()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("sdate");
            dt.Columns.Add("edate");
            DataRow dr1 = dt.NewRow();
            dr1["sdate"] = "2022-01-01";
            dr1["edate"] = "2022-01-02";
            DataRow dr2 = dt.NewRow();
            dr2["sdate"] = "2022-01-03";
            dr2["edate"] = "2022-01-04";
            dt.Rows.Add(dr1);
            dt.Rows.Add(dr2);
            return JsonConvert.SerializeObject(dt);
            //  return "Hello World";
        }
    }
}
