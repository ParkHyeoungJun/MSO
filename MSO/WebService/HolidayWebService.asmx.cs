using dbUtil;
using Newtonsoft.Json;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using Util;

namespace MSO.WebService
{
    /// <summary>
    /// HolidayWebService의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
     [System.Web.Script.Services.ScriptService]
    public class HolidayWebService : System.Web.Services.WebService
    {
        /// <summary>
        /// 공휴일 조회 
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_Holiday_Sel(string month)
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_Holiday_Sel"
                ,new string[] {"@month", }
                ,new string[] { month}

                );
            return JsonConvert.SerializeObject(dt);
        }


        /// <summary>
        /// 공휴일 저장
        /// </summary>
        /// <param name="YN"></param>
        /// <param name="Title"></param>
        /// <param name="HoliDay"></param>
        /// <returns></returns>
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_Holiday_Ins
        (
            bool   YN           ,
            string Title        ,
            string HoliDay

        )
        {
            DbConxt dbConxt = new DbConxt();
            string json = new JavaScriptSerializer().Serialize(
       new
       {
           Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_Holiday_Ins",
           new string[] { "@YN", "@Title", "@HoliDay" },
            new string[] {
                     YN.ToString(),Title,HoliDay
            }
           )
        });
            return json;
        }

        /// <summary>
        /// 공휴일 삭제 
        /// </summary>
        /// <param name="HoliDay"></param>
        /// <returns></returns>
        [WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_Holiday_Del
        (
            string HoliDay
        )
        {
            DbConxt dbConxt = new DbConxt();
            string json = new JavaScriptSerializer().Serialize(
       new
       {
           Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_Holiday_Del",
           new string[] { "@HoliDay" },
            new string[] {
                     HoliDay
            }
           )

           //m.sp_Management_Ins(Util.UserInfo.DBNAME, Idx, UserId, CusttomerCode, CusttomerName, yyyy, localIP)//user.sp_User_Upd(UserId, UserName, UserPwd)
       });
            return json;
        }

        ////
        // sp_Holiday_Get
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_Holiday_Get(string HoliDay)
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_Holiday_Get"
                , new string[] { "@HoliDay", }
                , new string[] { HoliDay }

                );
            return JsonConvert.SerializeObject(dt);
        }
    }
}
