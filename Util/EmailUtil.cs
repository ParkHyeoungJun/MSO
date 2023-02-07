using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace Util
{
   public static  class EmailUtil
    {
        /// <summary>
        ///  이메일을 발송한다 
        /// </summary>
        /// <param name="to">보내는 사람 주소</param>
        /// <param name="subject">제목</param>
        /// <param name="body">내용</param>
        /// <returns></returns>
        public static string Send(string to,string subject,string body)
        {
            string msg = "매일 발송 되었습니다";
            #region 메일 발송 

            try
            {
                MailMessage mail = new MailMessage();

                // 보내는 사람 메일, 이름, 인코딩(UTF-8)
                mail.From = new MailAddress(ConfigurationManager.AppSettings["SmtpUser"], ConfigurationManager.AppSettings["SmtpName"], System.Text.Encoding.UTF8);
                // 받는 사람 메일
                mail.To.Add(to);
                // 참조 사람 메일
                //mail.CC.Add("nowonbun@gmail.com");
                // 비공개 참조 사람 메일
                //mail.Bcc.Add("nowonbun@gmail.com");
                // 메일 제목
                mail.Subject = subject;

                string meta = "<meta name='format - detection' content='telephone = no', email=no, address=no'>";

                // 본문 내용
                mail.Body = meta +"<html><body>" + body + "</body></html>";
                // 본문 내용 포멧의 타입 (true의 경우 Html 포멧으로)
                mail.IsBodyHtml = true;
                // 메일 제목과 본문의 인코딩 타입(UTF-8)
                mail.SubjectEncoding = System.Text.Encoding.UTF8;
                mail.BodyEncoding = System.Text.Encoding.UTF8;
                // 첨부 파일 (Stream과 파일 이름)
                //mail.Attachments.Add(new Attachment(new FileStream(@"D:\test1.zip", FileMode.Open, FileAccess.Read), "test1.zip"));
                //mail.Attachments.Add(new Attachment(new FileStream(@"D:\test2.zip", FileMode.Open, FileAccess.Read), "test2.zip"));
                // smtp 서버 주소 SmtpServer
                SmtpClient SmtpServer = new SmtpClient(ConfigurationManager.AppSettings["SmtpServer"]);
                // smtp 포트
                SmtpServer.Port = Convert.ToInt32(ConfigurationManager.AppSettings["Port"]);
                // smtp 인증
                SmtpServer.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["SmtpId"], ConfigurationManager.AppSettings["SmtpPwd"]);
                // SSL 사용 여부
                SmtpServer.EnableSsl = true;
                // 발송
                SmtpServer.Send(mail);
            }
            catch (Exception e)
            {
                msg = e.Message;
            }

            #endregion


            return msg;


        }
    }
}
