using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;

namespace MSO.WebService
{
    /// <summary>
    /// EmilWebService의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
     [System.Web.Script.Services.ScriptService]
    public class EmilWebService : System.Web.Services.WebService
    {

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string Send(string From, string Name, string To,  string Subject)
        {

            string json = "";// EmailUtil.Send(From, Name, To, Subject, Body);
            return new JavaScriptSerializer().Serialize(json);
        }



    }
}
