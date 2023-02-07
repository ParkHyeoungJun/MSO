using dbUtil;
using System;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using Util;

namespace MSO.WebService
{
    /// <summary>
    /// CostSalesWebService의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
     [System.Web.Script.Services.ScriptService]
    public class CostSalesWebService : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_CostSales_Del(String Num)
        {
            DbConxt dbConxt = new DbConxt();
        //    Management m = new Management();
        string json = new JavaScriptSerializer().Serialize(
        new
        {
            Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_CostSales_Del",
            new string[] { "@Num"},
             new string[] {
                     Num.ToString()
             }
            )

                //m.sp_Management_Ins(Util.UserInfo.DBNAME, Idx, UserId, CusttomerCode, CusttomerName, yyyy, localIP)//user.sp_User_Upd(UserId, UserName, UserPwd)
            });
            return json;
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_CostSales_Ins
        (
                int    Num      ,
                string CustCode ,
                string CarNum   ,
                string DateDay  ,
                string Supply   ,
                string Surtax   ,
                string Total    ,
                string Note
        )
        {
            DbConxt dbConxt = new DbConxt();
            //    Management m = new Management();
            string json = new JavaScriptSerializer().Serialize(
            new
            {
                Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_CostSales_Ins",
                new string[] { "@Num", "@CustCode", "@CarNum", "@DateDay", "@Supply", "@Surtax", "@Total", "@Note" },
                 new string[] {
                     Num.ToString()         ,
                     CustCode               ,
                     CarNum                 ,
                     DateDay                ,
                     Supply                 ,
                     Surtax                 ,
                     Total                  ,
                     Note
                 }
                )

            //m.sp_Management_Ins(Util.UserInfo.DBNAME, Idx, UserId, CusttomerCode, CusttomerName, yyyy, localIP)//user.sp_User_Upd(UserId, UserName, UserPwd)
        });
            return json;

        }
    }
}
