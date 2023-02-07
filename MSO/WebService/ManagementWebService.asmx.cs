using dbUtil;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using Util;

namespace MSO.WebService
{
    /// <summary>
    /// ManagementWebService의 요약 설명입니다.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
    [System.Web.Script.Services.ScriptService]
    public class ManagementWebService : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String sp_Management_Ins(int Idx, string UserId, string CusttomerCode, string CusttomerName, string yyyy)
        {
            string localIP = string.Empty;
            using (Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, 0))
            {
                socket.Connect("8.8.8.8", 65530);
                IPEndPoint endPoint = socket.LocalEndPoint as IPEndPoint;
                localIP = endPoint.Address.ToString();
            }
            DbConxt dbConxt = new DbConxt();
            //    Management m = new Management();
            string json = new JavaScriptSerializer().Serialize(
            new
            {
                Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_Management_Ins",
                new string[] { "@Idx", "@UserId", "@CusttomerCode", "@CusttomerName", "@yyyy" },
                 new string[] {
                     Idx.ToString(),
                     UserId ,
                     CusttomerCode,
                     CusttomerName,
                     yyyy
                 }
                )

                //m.sp_Management_Ins(Util.UserInfo.DBNAME, Idx, UserId, CusttomerCode, CusttomerName, yyyy, localIP)//user.sp_User_Upd(UserId, UserName, UserPwd)
            });
            return json;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String sp_ManagementSub_Ins
        (
           string Num,
           string Idx,
           string Servion,
           string P1,
           string R1,
           string P2,
           string R2,
           string P3,
           string R3,
           string Q1p,
           string Q1r,
           string P4,
           string R4,
           string P5,
           string R5,
           string P6,
           string R6,
           string Q2p,
           string Q2r,
           string S1p,
           string S1r,
           string P7,
           string R7,
           string P8,
           string R8,
           string P9,
           string R9,
           string Q3p,
           string Q3r,
           string P10,
           string R10,
           string P11,
           string R11,
           string P12,
           string R12,
           string Q4p,
           string Q4r,
           string S2p,
           string S2r,
           string Yp,
           string Yr,
           string Raw,
           string Ass,
           string Plp,
           string Plr,
           string Rusult
        )
        {
            if (string.IsNullOrEmpty(Servion))
            {
                Servion = "1";
            }
            if (string.IsNullOrEmpty(P1))
            {
                P1 = "0";
            }
            else
            {
                P1 = P1.Replace(",", "");
            }
            if (string.IsNullOrEmpty(R1))
            {
                R1 = "0";
            }
            else
            {
                R1 = R1.Replace(",", "");
            }
            if (string.IsNullOrEmpty(P2))
            {
                P2 = "0";
            }
            else
            {
                P2 = P2.Replace(",", "");
            }
            if (string.IsNullOrEmpty(R2))
            {
                R2 = "0";
            }
            else
            {
                R2 = R2.Replace(",", "");
            }
            if (string.IsNullOrEmpty(P3))
            {
                P3 = "0";
            }
            else
            {
                P3 = P3.Replace(",", "");
            }
            if (string.IsNullOrEmpty(R3))
            {
                R3 = "0";
            }
            else
            {
                R3 = R3.Replace(",", "");
            }

            if (string.IsNullOrEmpty(Q1p))
            {
                Q1p = "0";
            }
            else
            {
                Q1p = Q1p.Replace(",", "");
            }
            if (string.IsNullOrEmpty(Q1r))
            {
                Q1r = "0";
            }
            else
            {
                Q1r = Q1r.Replace(",", "");
            }
            if (string.IsNullOrEmpty(P4))
            {
                P4 = "0";
            }
            else
            {
                P4 = P4.Replace(",", "");
            }

            if (string.IsNullOrEmpty(R4))
            {
                R4 = "0";
            }
            else
            {
                R4 = R4.Replace(",", "");
            }
            //5월
            if (string.IsNullOrEmpty(P5))
            {
                P5 = "0";
            }
            else
            {
                P5 = P5.Replace(",", "");
            }
            if (string.IsNullOrEmpty(R5))
            {
                R5 = "0";
            }
            else
            {
                R5 = R5.Replace(",", "");
            }
            //6월
            if (string.IsNullOrEmpty(P6))
            {
                P6 = "0";
            }
            else
            {
                P6 = P6.Replace(",", "");
            }


            if (string.IsNullOrEmpty(R6))
            {
                R6 = "0";
            }
            else
            {
                R6 = R6.Replace(",", "");
            }

            if (string.IsNullOrEmpty(Q2p))
            {
                Q2p = "0";
            }
            else
            {
                Q2p = Q2p.Replace(",", "");
            }

            if (string.IsNullOrEmpty(Q2r))
            {
                Q2r = "0";
            }
            else
            {
                Q2r = Q2r.Replace(",", "");
            }


            if (string.IsNullOrEmpty(S1p))
            {
                S1p = "0";
            }
            else
            {
                S1p = S1p.Replace(",", "");
            }

            if (string.IsNullOrEmpty(S1r))
            {
                S1r = "0";
            }
            else
            {
                S1r = S1r.Replace(",", "");
            }

            if (string.IsNullOrEmpty(P7))
            {
                P7 = "0";
            }
            else
            {
                P7 = P7.Replace(",", "");
            }


            if (string.IsNullOrEmpty(R7))
            {
                R7 = "0";
            }
            else
            {
                R7 = R7.Replace(",", "");
            }

            if (string.IsNullOrEmpty(P8))
            {
                P8 = "0";
            }
            else
            {
                P8 = P8.Replace(",", "");
            }


            if (string.IsNullOrEmpty(R8))
            {
                R8 = "0";
            }
            else
            {
                R8 = R8.Replace(",", "");
            }
            if (string.IsNullOrEmpty(P9))
            {
                P9 = "0";
            }
            else
            {
                P9 = P9.Replace(",", "");
            }

            if (string.IsNullOrEmpty(R9))
            {
                R9 = "0";
            }
            else
            {
                R9 = R9.Replace(",", "");
            }


            if (string.IsNullOrEmpty(P10))
            {
                P10 = "0";
            }
            else
            {
                P10 = P10.Replace(",", "");
            }



            if (string.IsNullOrEmpty(R10))
            {
                R10 = "0";
            }
            else
            {
                R10 = R10.Replace(",", "");
            }


            if (string.IsNullOrEmpty(P11))
            {
                P11 = "0";
            }
            else
            {
                P11 = P11.Replace(",", "");
            }

            if (string.IsNullOrEmpty(R11))
            {
                R11 = "0";
            }
            else
            {
                R11 = R11.Replace(",", "");
            }


            if (string.IsNullOrEmpty(P12))
            {
                P12 = "0";
            }
            else
            {
                P12 = P12.Replace(",", "");
            }

            if (string.IsNullOrEmpty(R12))
            {
                R12 = "0";
            }
            else
            {
                R12 = R12.Replace(",", "");
            }

            if (string.IsNullOrEmpty(Q3p))
            {
                Q3p = "0";
            }
            else
            {
                Q3p = Q3p.Replace(",", "");
            }

            if (string.IsNullOrEmpty(Q3r))
            {
                Q3r = "0";
            }
            else
            {
                Q3r = Q3r.Replace(",", "");
            }



            if (string.IsNullOrEmpty(Q4p))
            {
                Q4p = "0";
            }
            else
            {
                Q4p = Q4p.Replace(",", "");
            }


            if (string.IsNullOrEmpty(Q4r))
            {
                Q4r = "0";
            }
            else
            {
                Q4r = Q4r.Replace(",", "");
            }


            if (string.IsNullOrEmpty(S2p))
            {
                S2p = "0";
            }
            else
            {
                S2p = S2p.Replace(",", "");
            }

            if (string.IsNullOrEmpty(S2r))
            {
                S2r = "0";
            }
            else
            {
                S2r = S2r.Replace(",", "");
            }


            if (string.IsNullOrEmpty(Yp))
            {
                Yp = "0";
            }
            else
            {
                Yp = Yp.Replace(",", "");
            }

            if (string.IsNullOrEmpty(Yr))
            {
                Yr = "0";
            }
            else
            {
                Yr = Yr.Replace(",", "");
            }


            if (string.IsNullOrEmpty(Raw))
            {
                Raw = "0";
            }
            else
            {
                Raw = Raw.Replace(",", "");
            }


            if (string.IsNullOrEmpty(Ass))
            {
                Ass = "0";
            }
            else
            {
                Ass = Ass.Replace(",", "");
            }
            if (string.IsNullOrEmpty(Plp))
            {
                Plp = "0";
            }
            else
            {
                Plp = Plp.Replace(",", "");
            }

            if (string.IsNullOrEmpty(Plr))
            {
                Plr = "0";
            }
            else
            {
                Plr = Plr.Replace(",", "");
            }


            if (string.IsNullOrEmpty(Rusult))
            {
                Rusult = "0";
            }
            else
            {
                Rusult = Rusult.Replace(",", "");
            }


            double dp1 = Todouble(P1);
            double dp2 = Todouble(P2);
            double dp3 = Todouble(P3);
            double dp4 = Todouble(P4);
            double dp5 = Todouble(P5);
            double dp6 = Todouble(P6);
            double dp7 = Todouble(P7);
            double dp8 = Todouble(P8);
            double dp9 = Todouble(P9);
            double dp10 = Todouble(P10);
            double dp11 = Todouble(P11);
            double dp12 = Todouble(P12);

            double dr1 = Todouble(R1);
            double dr2 = Todouble(R2);
            double dr3 = Todouble(R3);
            double dr4 = Todouble(R4);
            double dr5 = Todouble(R5);
            double dr6 = Todouble(R6);
            double dr7 = Todouble(R7);
            double dr8 = Todouble(R8);
            double dr9 = Todouble(R9);
            double dr10 = Todouble(R10);
            double dr11 = Todouble(R11);
            double dr12 = Todouble(R12);







            DbConxt dbConxt = new DbConxt();
            //    Management m = new Management();
            string json = new JavaScriptSerializer().Serialize(
            new
            {
                Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_ManagementSub_Ins",
                new string[] {
                  "@Num",
                  "@Idx",
                  "@Servion",
                  "@p1",
                  "@r1",
                  "@p2",
                  "@r2",
                  "@p3",
                  "@r3",
                  "@q1p",
                  "@q1r",
                  "@p4",
                  "@r4",
                  "@p5",
                  "@r5",
                  "@p6",
                  "@r6",
                  "@q2p",
                  "@q2r",
                  "@s1p",
                  "@s1r",
                  "@p7",
                  "@r7",
                  "@p8",
                  "@r8",
                  "@p9",
                  "@r9",
                  "@q3p",
                  "@q3r",
                  "@p10",
                  "@r10",
                  "@p11",
                  "@r11",
                  "@p12",
                  "@r12",
                  "@q4p",
                  "@q4r",
                  "@s2p",
                  "@s2r",
                  "@yp",
                  "@yr",
                  "@raw",
                  "@ass",
                  "@plp",
                  "@plr",
                  "@rusult",



                },
                 new string[] {
                     Num.ToString()                ,
                     Idx           .ToString(),
                     Servion       .ToString(),
                     P1            .ToString(),
                     R1            .ToString(),
                     P2            .ToString(),
                     R2            .ToString(),
                     P3            .ToString(),
                     R3            .ToString(),
                     (dp1+dp2+dp3).ToString(),
                     (dr1+dr2+dr3).ToString(),
                     P4            .ToString(),
                     R4            .ToString(),
                     P5            .ToString(),
                     R5            .ToString(),
                     P6            .ToString(),
                     R6            .ToString(),
                     (dp4+dp5+dp6).ToString(),
                     (dr4+dr5+dr6).ToString(),
                     (dp1+dp2+dp3+dp4+dp5+dp6).ToString(),
                     (dr1+dr2+dr3+dr4+dr5+dr6).ToString(),
                     P7            .ToString(),
                     R7            .ToString(),
                     P8            .ToString(),
                     R8            .ToString(),
                     P9            .ToString(),
                     R9            .ToString(),
                     (dp7+dp8+dp9).ToString(),
                     (dr7+dr8+dr9).ToString(),
                     P10           .ToString(),
                     R10           .ToString(),
                     P11           .ToString(),
                     R11           .ToString(),
                     P12           .ToString(),
                     R12           .ToString(),
                     (dp10+dp11+dp12).ToString(),
                     (dr10+dr11+dr12).ToString(),
                     (dp7+dp8+dp9+dp10+dp11+dp12).ToString(),
                     (dr7+dr8+dr9+dr10+dr11+dr12).ToString(),
                     (dp1+dp2+dp3+dp4+dp5+dp6+dp7+dp8+dp9+dp10+dp11+dp12).ToString(),
                     (dr1+dr2+dr3+dr4+dr5+dr6+dr7+dr8+dr9+dr10+dr11+dr12).ToString(),
                     Raw           .ToString(),
                     Ass           .ToString(),
                     Plp           .ToString(),
                     Plr           .ToString(),
                     Rusult        .ToString()
                 }
                )

                //m.sp_Management_Ins(Util.UserInfo.DBNAME, Idx, UserId, CusttomerCode, CusttomerName, yyyy, localIP)//user.sp_User_Upd(UserId, UserName, UserPwd)
            });
            return json;
        }




        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_ManagementMaster_List
        (
            string UserId,
            string YYYY
        )
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_ManagementMaster_List"
                , new string[] { "@UserId", "@YYYY" }
                , new string[] { UserId, YYYY }

                );
            return JsonConvert.SerializeObject(dt);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_ManagementMaster_Del
        (
            string UserId,
            string CusttomerCode,
            string YYYY
        )
        {
            DbConxt dbConxt = new DbConxt();
            string json = new JavaScriptSerializer().Serialize(
       new
       {
           Idx = dbConxt.ExecuteNonQuery(UserInfo.DBNAME, "sp_ManagementMaster_Del",
           new string[] { "@UserId", "@CusttomerCode", "@YYYY" },
            new string[] {
                     UserId,CusttomerCode,YYYY
            }
           )
       });
            return json;
        }
        //sp_ManagementSub_GetVersion
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_ManagementSub_GetVersion
        (
            string YYYY
        )
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_ManagementSub_GetVersion"
                , new string[] { "@YYYY" }
                , new string[] { YYYY }

                );
            return JsonConvert.SerializeObject(dt);
        }


        /// <summary>
        /// 경영 계획 조회 해당 년도와 버전으로  조회
        /// 만약 해당 년도와 버젼이 없다면 초기 년도 세팅으로 보여준다 
        /// </summary>
        /// <param name="YYYY"></param>
        /// <param name="Servion"></param>
        /// <returns></returns>
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string sp_ManagementSub_Sel
        (
            string YYYY,
            string Servion
        )
        {
            DbConxt dbConxt = new DbConxt();
            DataTable dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_ManagementSub_Sel"
                , new string[] { "@YYYY", "@Servion" }
                , new string[] { YYYY, Servion }

                );
            if (dt.Rows.Count == 0 && dt != null)
            {
                //sp_ManagementSub_SelInit
                dt = dbConxt.Dataget(UserInfo.DBNAME, "sp_ManagementSub_SelInit"
               , new string[] { "@YYYY" }
               , new string[] { YYYY }
               );

               // int subcount = 0;
               // DataTable subdt = dbConxt.Dataget(UserInfo.DBNAME, "sp_ManagementSub_GetSubtotal"
               //, new string[] { "@YYYY" }
               //, new string[] { YYYY }
               //);

               // if (subdt.Rows.Count > 0 && subdt != null)
               // {
               //     subcount = Convert.ToInt32(subdt.Rows[0][0].ToString());
               // }
               // if (subcount == 0)
               // {
               //     dt = getSubTotal(dt, YYYY, Servion);
               // }


            }
            #region 총합계 알고리즘
            ///// 
            //double p1 = 0;
            //double r1 = 0;
            //double p2 = 0;
            //double r2 = 0;
            //double p3 = 0;
            //double r3 = 0;
            //double q1p = 0;
            //double q1r = 0;
            //double p4 = 0;
            //double r4 = 0;
            //double p5 = 0;
            //double r5 = 0;
            //double p6 = 0;
            //double r6 = 0;
            //double q2p = 0;
            //double q2r = 0;
            //double s1p = 0;
            //double s1r = 0;
            //double p7 = 0;
            //double r7 = 0;
            //double p8 = 0;
            //double r8 = 0;
            //double p9 = 0;
            //double r9 = 0;
            //double q3p = 0;
            //double q3r = 0;
            //double p10 = 0;
            //double r10 = 0;
            //double p11 = 0;
            //double r11 = 0;
            //double p12 = 0;
            //double r12 = 0;
            //double q4p = 0;
            //double q4r = 0;
            //double s2p = 0;
            //double s2r = 0;
            //double yp = 0;
            //double yr = 0;
            //double raw = 0;
            //double ass = 0;
            //double plp = 0;
            //double plr = 0;
            //foreach (DataRow dr in dt.Rows)
            //{
            //    if (dr["CusttomerName"].ToString() != "Sub Total:")
            //    {

            //        p1 += Todouble(dr["p1"]);
            //        r1 += Todouble(dr["r1"]);
            //        p2 += Todouble(dr["p2"]);
            //        r2 += Todouble(dr["r2"]);
            //        p3 += Todouble(dr["p3"]);
            //        r3 += Todouble(dr["r3"]);
            //        q1p += Todouble(dr["q1p"]);
            //        q1r += Todouble(dr["q1r"]);
            //        p4 += Todouble(dr["p4"]);
            //        r4 += Todouble(dr["r4"]);
            //        p5 += Todouble(dr["p5"]);
            //        r5 += Todouble(dr["r5"]);
            //        p6 += Todouble(dr["p6"]);
            //        r6 += Todouble(dr["r6"]);
            //        q2p += Todouble(dr["q2p"]);
            //        q2r += Todouble(dr["q2r"]);
            //        s1p += Todouble(dr["s1p"]);
            //        s1r += Todouble(dr["s1r"]);
            //        p7 += Todouble(dr["p7"]);
            //        r7 += Todouble(dr["r7"]);
            //        p8 += Todouble(dr["p8"]);
            //        r8 += Todouble(dr["r8"]);
            //        p9 += Todouble(dr["p9"]);
            //        r9 += Todouble(dr["r9"]);
            //        q3p += Todouble(dr["q3p"]);
            //        q3r += Todouble(dr["q3r"]);
            //        p10 += Todouble(dr["p10"]);
            //        r10 += Todouble(dr["r10"]);
            //        p11 += Todouble(dr["p11"]);
            //        r11 += Todouble(dr["r11"]);
            //        p12 += Todouble(dr["p12"]);
            //        r12 += Todouble(dr["r12"]);
            //        q4p += Todouble(dr["q4p"]);
            //        q4r += Todouble(dr["q4r"]);
            //        s2p += Todouble(dr["s2p"]);
            //        s2r += Todouble(dr["s2r"]);
            //        yp += Todouble(dr["yp"]);
            //        yr += Todouble(dr["yr"]);
            //        raw += Todouble(dr["raw"]);
            //        ass += Todouble(dr["ass"]);
            //        plp += Todouble(dr["plp"]);
            //        plr += Todouble(dr["plr"]);
            //    }
            //}
            //DataRow dataRow = dt.NewRow();
            //dataRow["UserId"] = "";
            //dataRow["UserName"] = "";
            //dataRow["CusttomerCode"] = "";
            //dataRow["CusttomerName"] = "Total:";
            //dataRow["p1"] = p1;
            //dataRow["r1"] = r1;
            //dataRow["p2"] = p2;
            //dataRow["r2"] = r2;
            //dataRow["p3"] = p3;
            //dataRow["r3"] = r3;
            //dataRow["q1p"] = q1p;
            //dataRow["q1r"] = q1r;
            //dataRow["p4"] = p4;
            //dataRow["r4"] = r4;
            //dataRow["p5"] = p5;
            //dataRow["r5"] = r5;
            //dataRow["p6"] = p6;
            //dataRow["r6"] = r6;
            //dataRow["q2p"] = q2p;
            //dataRow["q2r"] = q2r;
            //dataRow["s1p"] = s1p;
            //dataRow["s1r"] = s1r;
            //dataRow["p7"] = p7;
            //dataRow["r7"] = r7;
            //dataRow["p8"] = p8;
            //dataRow["r8"] = r8;
            //dataRow["p9"] = p9;
            //dataRow["r9"] = r9;
            //dataRow["q3p"] = q3p;
            //dataRow["q3r"] = q3r;
            //dataRow["p10"] = p10;
            //dataRow["r10"] = r10;
            //dataRow["p11"] = p11;
            //dataRow["r11"] = r11;
            //dataRow["p12"] = p12;
            //dataRow["r12"] = r12;
            //dataRow["q4p"] = q4p;
            //dataRow["q4r"] = q4r;
            //dataRow["s2p"] = s2p;
            //dataRow["s2r"] = s2r;
            //dataRow["yp"] = yp;
            //dataRow["yr"] = yr;
            //dataRow["raw"] = raw;
            //dataRow["ass"] = ass;
            //dataRow["plp"] = plp;
            //dataRow["plr"] = plr;

            //dt.Rows.Add(dataRow); // 마지막에 행 추가  
            #endregion

            return JsonConvert.SerializeObject(dt);
        }



        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]

        public string getServionCheck(int YYYY)
        {
            DataTable datatable = new DataTable("tab");
            datatable.Columns.Add("YN");
            DateTime now = DateTime.Now;
            DateTime dt = new DateTime(YYYY, now.Month, 01);
            //TimeSpan timeDiff = now-dt;
            DataRow dr = datatable.NewRow();
            /// 작년1월까지이나 테스트 위하여 6월까지 오픈 차후 1월으로 변경 해야 한다 
            if ((now.Year - dt.Year <= 1) && now.Month <=6 )
            {
                dr[0] = "Y";
            }
            else
            {
                dr[0] = "N";
            }
                
            datatable.Rows.Add(dr);
            return JsonConvert.SerializeObject(datatable);
            //timeDiff.y
        }


        public bool getMonth(int mm)
        {
            return (1 <= DateTime.Now.Month) && (DateTime.Now.Month <= mm); 
        }









        /// <summary>
        ///  sub Total 없을때만 
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="YYYY"></param>
        /// <param name="Servion"></param>
        /// <returns></returns>
        private DataTable getSubTotal(DataTable dt,string YYYY,string Servion)
        {
            DbConxt dbConxt = new DbConxt();
            

            DataTable dtGroupuserid = dbConxt.Dataget(UserInfo.DBNAME, "sp_ManagementSub_InitUser"
                , new string[] { "@YYYY" }
            , new string[] { YYYY }
                );
            HashSet<string> getUser = new HashSet<string>(); // 아이디 그룹을 알아 온다 통계위한 
            foreach (DataRow dr in dtGroupuserid.Rows)
            {
                getUser.Add(dr["UserId"].ToString());
            }
            List<string> userlist = new List<string>(getUser.Count);
            userlist = getUser.ToList();

            string[] guserid = new string[userlist.Count];
            string[] gusername = new string[userlist.Count];
            string[] gCusttomerCode = new string[userlist.Count];
            double[] gidx = new double[userlist.Count];
            double[] gp1 = new double[userlist.Count];
            double[] gr1 = new double[userlist.Count];
            double[] gp2 = new double[userlist.Count];
            double[] gr2 = new double[userlist.Count];
            double[] gp3 = new double[userlist.Count];
            double[] gr3 = new double[userlist.Count];
            double[] gq1p = new double[userlist.Count];
            double[] gq1r = new double[userlist.Count];
            double[] gp4 = new double[userlist.Count];
            double[] gr4 = new double[userlist.Count];
            double[] gp5 = new double[userlist.Count];
            double[] gr5 = new double[userlist.Count];

            //6월
            double[] gp6 = new double[userlist.Count];
            double[] gr6 = new double[userlist.Count];

            double[] gq2p = new double[userlist.Count];
            double[] gq2r = new double[userlist.Count];
            double[] gs1p = new double[userlist.Count];
            double[] gs1r = new double[userlist.Count];

            double[] gp7 = new double[userlist.Count];
            double[] gr7 = new double[userlist.Count];

            double[] gp8 = new double[userlist.Count];
            double[] gr8 = new double[userlist.Count];

            double[] gp9 = new double[userlist.Count];
            double[] gr9 = new double[userlist.Count];

            double[] gq3p = new double[userlist.Count];
            double[] gq3r = new double[userlist.Count];


            double[] gp10 = new double[userlist.Count];
            double[] gr10 = new double[userlist.Count];

            double[] gp11 = new double[userlist.Count];
            double[] gr11 = new double[userlist.Count];

            double[] gp12 = new double[userlist.Count];
            double[] gr12 = new double[userlist.Count];


            double[] gq4p = new double[userlist.Count];
            double[] gq4r = new double[userlist.Count];

            double[] gs2p = new double[userlist.Count];
            double[] gs2r = new double[userlist.Count];

            double[] gyp = new double[userlist.Count];
            double[] gyr = new double[userlist.Count];
            // 재료비
            double[] graw = new double[userlist.Count];
            // 조립비
            double[] gass = new double[userlist.Count];

            double[] gplp = new double[userlist.Count];
            double[] gplr = new double[userlist.Count];



            int[] insertrow = new int[userlist.Count]; // DataTable에 추가 할 행.
            for (int r = 0; r < dt.Rows.Count; r++)
            {
                DataRow dr = dt.Rows[r];
                for (int c = 0; c < userlist.Count; c++)
                {
                    if (userlist[c].ToString().Equals(dr["UserId"].ToString()))
                    {
                        insertrow[c] = r;
                        gCusttomerCode[c] = dr["CusttomerCode"].ToString();
                        guserid[c] = dr["UserId"].ToString();
                        gusername[c] = dr["username"].ToString();
                        gp1[c] += Todouble(dr["p1"]); ;
                        gr1[c] += Todouble(dr["r1"]);

                        gp2[c] += Todouble(dr["p2"]);
                        gr2[c] += Todouble(dr["r2"]);

                        gp3[c] += Todouble(dr["p3"]);
                        gr3[c] += Todouble(dr["r3"]);

                        gq1p[c] += Todouble(dr["q1p"]);
                        gq1r[c] += Todouble(dr["q1r"]);

                        gp4[c] += Todouble(dr["p4"]);
                        gr4[c] += Todouble(dr["r4"]);

                        gp5[c] += Todouble(dr["p5"]);
                        gr5[c] += Todouble(dr["r5"]);

                        gp6[c] += Todouble(dr["p6"]);
                        gr6[c] += Todouble(dr["r6"]);

                        gq2p[c] += Todouble(dr["q2p"]);
                        gq2r[c] += Todouble(dr["q2r"]);

                        gs1p[c] += Todouble(dr["s1p"]);
                        gs1r[c] += Todouble(dr["s1r"]);


                        gp7[c] += Todouble(dr["p7"]);
                        gr7[c] += Todouble(dr["r7"]);

                        gp8[c] += Todouble(dr["p8"]);
                        gr8[c] += Todouble(dr["r8"]);

                        gp9[c] += Todouble(dr["p9"]);
                        gr9[c] += Todouble(dr["r9"]);

                        gq3p[c] += Todouble(dr["q3p"]);
                        gq3r[c] += Todouble(dr["q3r"]);


                        gp10[c] += Todouble(dr["p10"]);
                        gr10[c] += Todouble(dr["r10"]);

                        gp11[c] += Todouble(dr["p11"]);
                        gr11[c] += Todouble(dr["r11"]);

                        gp12[c] += Todouble(dr["p12"]);
                        gr12[c] += Todouble(dr["r12"]);

                        gq4p[c] += Todouble(dr["q4p"]);
                        gq4r[c] += Todouble(dr["q4r"]);

                        gs2p[c] += Todouble(dr["s2p"]);
                        gs2r[c] += Todouble(dr["s2r"]);

                        gyp[c] += Todouble(dr["yp"]);
                        gyr[c] += Todouble(dr["yr"]);

                        graw[c] += Todouble(dr["raw"]);
                        gass[c] += Todouble(dr["ass"]);

                        gplp[c] += Todouble(dr["plp"]);
                        gplr[c] += Todouble(dr["plr"]);

                    }
                }


            }
            //// 계산된 DataRow에 insert 
            for (int row = 0; row < insertrow.Count(); row++)
            {
                //   DataRow dr = dt.NewRow();
                gidx[row] = Convert.ToDouble(dbConxt.Dataget(UserInfo.DBNAME, "sp_Management_Ins"
                    , new string[] { "@idx", "@UserId", "@CusttomerCode", "@CusttomerName", "@YYYY", "@ip" }
                    , new string[] { "0", guserid[row], gCusttomerCode[row], "Sub Total:", YYYY, "" }
                    ).Rows[0][0].ToString()); // 마스터에 데이터 넣고  가져 오기 

                DataRow dr = dt.NewRow();
                dr["idx"] = gidx[row];
                dr["Num"] = "0"; // 이면 insert 
                dr["UserId"] = guserid[row];
                dr["UserName"] = gusername[row];
                dr["CusttomerCode"] = gCusttomerCode[row];
                dr["CusttomerName"] = "Sub Total:";
                dr["servion"] = Servion;
                dr["p1"] = gp1[row];
                dr["r1"] = gr1[row];
                dr["p2"] = gp2[row];
                dr["r2"] = gr2[row];
                dr["p3"] = gp3[row];
                dr["r3"] = gr3[row];
                dr["q1p"] = gq1p[row];
                dr["q1r"] = gq1r[row];
                dr["p4"] = gp4[row];
                dr["r4"] = gr4[row];
                dr["p5"] = gp5[row];
                dr["r5"] = gr5[row];
                dr["p6"] = gp6[row];
                dr["r6"] = gr6[row];

                dr["q2p"] = gq2p[row];
                dr["q2r"] = gq2r[row];

                dr["s1p"] = gs1p[row];
                dr["q2r"] = gq2r[row];

                dr["p7"] = gp7[row];
                dr["r7"] = gr7[row];

                dr["p8"] = gp8[row];
                dr["r8"] = gr8[row];

                dr["p9"] = gp8[row];
                dr["r9"] = gr8[row];

                dr["q3p"] = gq3p[row];
                dr["q3r"] = gq3r[row];
                // 10월
                dr["p10"] = gp10[row];
                dr["r10"] = gr10[row];

                dr["p11"] = gp11[row];
                dr["r11"] = gr11[row];

                dr["p12"] = gp12[row];
                dr["r12"] = gr12[row];

                dr["q4p"] = gq4p[row];
                dr["q4r"] = gq4r[row];

                dr["s2p"] = gs2p[row];
                dr["s2r"] = gs2r[row];

                dr["yp"] = gyp[row];
                dr["yr"] = gyr[row];
                dr["raw"] = graw[row];
                dr["ass"] = gass[row];
                dr["plp"] = gplp[row];
                dr["plr"] = gplr[row];
                dt.Rows.InsertAt(dr, insertrow[row]);
            }
            return dt;
        }


        private static double Todouble(object v)
        {
            if (string.IsNullOrEmpty(v.ToString()) || v == DBNull.Value)
            {
                return 0;
            }
            else
            {
                return Convert.ToDouble(v.ToString());
            }
        }


    }
}
