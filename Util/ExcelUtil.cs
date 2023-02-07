using ClosedXML.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Util
{
    public static class ExcelUtil
    {



        /// <summary>
        /// 
        /// </summary>
        /// <param name="page">화면</param>
        /// <param name="sheetName">시트명</param>
        /// <param name="ofile">저장되는 파일</param>
        /// <param name="downfile">다운로드할 파일명</param>
        /// <param name="dt">데이터 테이블</param>
        /// <param name="down">다운로드 여부</param>
        public static void Export(System.Web.UI.Page page, string sheetName, string ofile, string downfile, DataTable dt, bool down)
        {
            var workbook = new XLWorkbook();  //  엑셀 열기

            // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
            int rows = 1;
            int cols = 1;
            var worksheet = workbook.Worksheets.Add(sheetName);


            //헤더 컬럼 지정 
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                DataColumn colName = dt.Columns[i];
                var cell = worksheet.Cell(1, i + 1); // 첫번째 행에 각 컬럼마다 지정
                // 셀의 문자의 수평 방향의 배치 위치를 중앙으로 설정
                cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                // 셀의 문자의 수직 정렬 위치를 중앙으로 설정
                cell.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
                cell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;
                // 셀 주위의 테두리 색을 검은 색으로 설정
                cell.Style.Border.OutsideBorderColor = XLColor.Black;
                //cell.Style.Font.FontName= 
                cell.Style.Fill.BackgroundColor = XLColor.FromColor(System.Drawing.Color.Gray);
                cell.DataType = XLDataType.Text; // 문자 형식 지정 
                cell.Value = colName.ColumnName;


                cols += 1;
                //.AdjustToContents();
            }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    var celldata = worksheet.Cell(i + 2, j + 1);
                    celldata.Value = OutputCheckWord(dr[j].ToString());
                }
                rows += +1;
            }


            var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, cols - 1));


            // SetAutoFilter ()에서 자동 필터를 설정한다

            //filterrange.SetAutoFilter();


            //SetColumnFormatToText(worksheet, cols, rows);

            // 볼 수 있도록 범위의 셀 테두리 설정

            filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;

            filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            // 테두리 설정 



            worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

            workbook.SaveAs(ofile);  // 새로운 이름으로 저장하기
            if (down)
            {
                DownloadExcelFile(page, ofile, downfile);
            }
        }

        /// <summary>
      
        public static void Export2(System.Web.UI.Page page, string sheetName, string ofile, string sfile,string dfile, DataTable dt, bool down)
        {
            var workbook = new XLWorkbook(ofile);  //  엑셀 열기

            // 새 워크 시트 "Sample Sheet"를 만들고 방금 만든 통합 문서에 추가
            int rows = 1;
            int cols = 1;
            var worksheet = workbook.Worksheet(1);


            //헤더 컬럼 지정 
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                //DataColumn colName = dt.Columns[i];
                //var cell = worksheet.Cell(1, i + 1); // 첫번째 행에 각 컬럼마다 지정
                //// 셀의 문자의 수평 방향의 배치 위치를 중앙으로 설정
                //cell.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                //// 셀의 문자의 수직 정렬 위치를 중앙으로 설정
                //cell.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
                //cell.Style.Border.OutsideBorder = XLBorderStyleValues.Medium;
                //// 셀 주위의 테두리 색을 검은 색으로 설정
                //cell.Style.Border.OutsideBorderColor = XLColor.Black;
                ////cell.Style.Font.FontName= 
                //cell.Style.Fill.BackgroundColor = XLColor.FromColor(System.Drawing.Color.Gray);
                //cell.DataType = XLDataType.Text; // 문자 형식 지정 
                //cell.Value = colName.ColumnName;


                cols += 1;
                //.AdjustToContents();
            }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    var celldata = worksheet.Cell(i + 2, j + 1);
                    celldata.Value = dr[j].ToString();
                }
                rows += +1;
            }


            var filterrange = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(rows, cols - 1));


            // SetAutoFilter ()에서 자동 필터를 설정한다

            //filterrange.SetAutoFilter();


            //SetColumnFormatToText(worksheet, cols, rows);

            // 볼 수 있도록 범위의 셀 테두리 설정

            filterrange.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;

            filterrange.Style.Border.InsideBorder = XLBorderStyleValues.Thin;
            // 테두리 설정 



            worksheet.Columns().AdjustToContents(); // 칸틀 자동으로 사이트 조정 데이터 많을시 조심해야한다 

            workbook.SaveAs(sfile);  // 새로운 이름으로 저장하기
            if (down)
            {
                DownloadExcelFile(page, ofile, dfile);
            }
        }








        private static void SetColumnFormatToText(IXLWorksheet worksheet, int rowcount, int colcount)
        {
            var wholeSheet = worksheet.Range(1, 1, rowcount, colcount);
            wholeSheet.Style.NumberFormat.Format = "@";
        }


        /// <summary>
        /// web     
        /// </summary>
        /// <param name="page"></param>
        /// <param name="filename">   ，   </param>
        public static void DownloadExcelFile(System.Web.UI.Page page, string FileName, string downfile)
        {

            FileInfo f = new FileInfo(FileName);
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + downfile);
            HttpContext.Current.Response.AddHeader("Content-Length", f.Length.ToString());
            HttpContext.Current.Response.AddHeader("Content-Transfer-Encoding", "binary");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.WriteFile(f.FullName);
            HttpContext.Current.Response.End();
        }





        /// <summary>
        /// 서버에 올려진 엑셀파일을 빠르게 읽기 
        /// </summary>
        /// <param name="sheetName">시트명</param>
        /// <param name="path">서버파일경로</param>
        /// <returns></returns>
        private static DataTable ReadExcelFile(string sheetName, string path)
        {

            using (OleDbConnection conn = new OleDbConnection())
            {
                DataTable dt = new DataTable();
                string Import_FileName = path;
                string fileExtension = Path.GetExtension(Import_FileName);
                if (fileExtension == ".xls")
                    conn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Import_FileName + ";" + "Extended Properties='Excel 8.0;HDR=YES;'";
                if (fileExtension == ".xlsx")
                    conn.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Import_FileName + ";" + "Extended Properties='Excel 12.0 Xml;HDR=YES;'";
                using (OleDbCommand comm = new OleDbCommand())
                {
                    comm.CommandText = "Select * from [" + sheetName + "$]";
                    comm.Connection = conn;
                    using (OleDbDataAdapter da = new OleDbDataAdapter())
                    {
                        da.SelectCommand = comm;
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }


        /// <summary>
        ///  리드시에 금지어들을 변환한다.
        /// </summary>
        public static string OutputCheckWord(string strCheckValue)
        {
            var data = strCheckValue.Replace("&lt;", "<").Replace("&gt;", ">").Replace("&quot;", "'").Replace("&amp;", "&");
            return data;
        }

        /// <summary>
        /// 입력시에 금지어들을 변환한다.
        /// </summary>
        public static string InputCheckWord(string strCheckValue)
        {
            var data = strCheckValue.Replace("<", "&lt;").Replace(">", "&gt;").Replace("'", "&quot;").Replace("&", "&amp;");

            return data;
        }
    }



}
