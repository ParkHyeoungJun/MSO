using dbUtil;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using Util;

namespace MSO.WebService
{
    /// <summary>
    /// UserWebService의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    [System.Web.Script.Services.ScriptService]
    public class UserWebService : System.Web.Services.WebService
    {

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_User_Ins
        (
            string UserId,
            string UserName,
            string UserPwd,
            string Email,
            string Retired,
            string RetiredDay
        )
        {
            DbConxt dbConxt = new DbConxt();
            string json = new JavaScriptSerializer().Serialize(
       new
       {
           Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_User_Ins",
           new string[] {"@UserId", "@UserName", "@UserPwd", "@Email","@Retired", "@RetiredDay" },
            new string[] {
                     UserId         ,
                     UserName       ,
                     UserPwd        ,
                     Email          ,
                     Retired.ToString(),
                     RetiredDay
            }
           ) });
            return json;
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_User_Del
        (
            string UserId
         )
        {
            DbConxt dbConxt = new DbConxt();
            string json = new JavaScriptSerializer().Serialize(
       new
       {
           Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_User_Del",
           new string[] { "@UserId" },
            new string[] {
                     UserId
            }
           )
       });
            return json;
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]

        public string sp_User_Sel
        (
            string  Searchtype   ,
            string  Searchtxt    ,
            int     pageNum      ,
            int     amount
        )
        {
            DbConxt dbConxt = new DbConxt();
            string json = new JavaScriptSerializer().Serialize(
       new
       {
           Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_User_Sel",
           new string[] { "@Searchtype", "@Searchtxt", "@pageNum","@amount" },
            new string[] {
                     Searchtype ,
                     Searchtxt  ,
                     pageNum.ToString()    ,
                     amount.ToString()
            }
           )
       });
            return json;
        }


        // 삭제
        //[WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]

    }


}
