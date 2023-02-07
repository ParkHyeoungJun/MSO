using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Util
{
   public static class UserInfo
    {
        /// <summary>
        /// 사용자 로그인 아이디 정보
        /// </summary>
        public static String ID
        {
            get { return getCookies("ID"); }
            set { setCookies("ID", value); }
        }

        /// <summary>
        /// 사용자 패스워드 
        /// </summary>
        public static String PWD
        {
            get { return getCookies("PWD"); }
            set { setCookies("PWD", value); }
        }

        /// <summary>
        /// 데이터베이스 
        /// </summary>
        public static String DBNAME
        {
            get { return getCookies("DBNAME"); }
            set { setCookies("DBNAME", value); }
        }



        public static string getCookies(string name)
        {
            if (HttpContext.Current.Request.Cookies[name] != null)
            {
                return HttpContext.Current.Request.Cookies[name].Value;//.ToString();
            }
            else return "";
        }

        public static void setCookies(string name, string val)
        {
            HttpContext.Current.Response.Cookies[name].Value = val;//.Value = val;
        }
    }
}
