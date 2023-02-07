using dbUtil;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using Util;

namespace MSO.WebService
{
    /// <summary>
    /// WorkWebService의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    [System.Web.Script.Services.ScriptService] //ajax 사용시 해제 필수 
    public class WorkWebService : System.Web.Services.WebService
    {

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string HelloWorld()
        {
            return "Hello World";
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_Work_Ins(
            int Num,
                string UserId      ,
                string AttenDay    ,
                string AttenTime   ,
                string LeaveTime

            )
        {
            DbConxt dbConxt = new DbConxt();
            string json = new JavaScriptSerializer().Serialize(
       new
       {
           Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_Work_Ins",
           new string[] { "@Num", "@UserId", "@AttenDay", "@AttenTime", "@LeaveTime" },
            new string[] {
                     Num.ToString(),
                     UserId         ,
                     AttenDay       ,
                     AttenTime      ,
                     LeaveTime
            }
           )

            //m.sp_Management_Ins(Util.UserInfo.DBNAME, Idx, UserId, CusttomerCode, CusttomerName, yyyy, localIP)//user.sp_User_Upd(UserId, UserName, UserPwd)
        });
            return json;

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_Woork_Del
        (
            int Num
        )
        {
            DbConxt dbConxt = new DbConxt();
            string json = new JavaScriptSerializer().Serialize(
       new
       {
           Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_Woork_Del",
           new string[] { "@Num" },
            new string[] {
                     Num.ToString()
            }
           )

           //m.sp_Management_Ins(Util.UserInfo.DBNAME, Idx, UserId, CusttomerCode, CusttomerName, yyyy, localIP)//user.sp_User_Upd(UserId, UserName, UserPwd)
       });
            return json;
        }

    }
}
