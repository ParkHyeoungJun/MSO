using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dbUtil
{
    public class DbConxt
    {
        public int ExecuteNonQuery(string database,String spname, string[] param, string[] parameters)
        {
            int result = 0;
            //using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString + "pwd=Open#*(&;Initial Catalog=" + database + ";";
            using (SqlConnection cn = new SqlConnection(con))
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand
                {
                    Connection = cn,
                    CommandType = CommandType.StoredProcedure,
                    CommandText = spname
                };
                for (int i = 0; i < parameters.Length; i++)
                {
                    cmd.Parameters.AddWithValue(param[i], InputCheckWord(parameters[i]));
                }
                result = cmd.ExecuteNonQuery();
                cn.Close();
                cmd.Dispose();
            }
            return result;
        }

        public System.Data.DataTable Dataget(string database,String spname, String[] param, string[] parameters)
        {
            DataTable dataTable = new DataTable("table");
            string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString + "pwd=Open#*(&;Initial Catalog=" + database + ";";
            using (SqlConnection cn = new SqlConnection(con))
            // using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand
                {
                    Connection = cn,
                    CommandType = CommandType.StoredProcedure,
                    CommandText = spname
                };
                for (int i = 0; i < parameters.Length; i++)
                {
                    cmd.Parameters.AddWithValue(param[i], parameters[i]);
                }
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // this will query your database and return the result to your datatable
                da.Fill(dataTable);
                da.Dispose();
                cn.Close();
                cmd.Dispose();
            }
            return dataTable;
        }

        public System.Data.DataTable Dataget(string database,String spname)
        {
            DataTable dataTable = new DataTable("table");
            string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString + "pwd=Open#*(&;Initial Catalog=" + database + ";";
            using (SqlConnection cn = new SqlConnection(con))
            //using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand
                {
                    Connection = cn,
                    CommandType = CommandType.StoredProcedure,
                    CommandText = spname
                };
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                // this will query your database and return the result to your datatable
                da.Fill(dataTable);
                da.Dispose();
                cn.Close();
                cmd.Dispose();
            }
            return dataTable;
        }


        /// <summary>
        ///  리드시에 금지어들을 변환한다.
        /// </summary>
        public string OutputCheckWord(string strCheckValue)
        {
            var data =strCheckValue.Replace("&lt;", "<").Replace("&gt;", ">").Replace("&quot;", "'").Replace("&amp;", "&");
            return data;
        }

        /// <summary>
        /// 입력시에 금지어들을 변환한다.
        /// </summary>
        public  string InputCheckWord(string strCheckValue)
        {
            var data = strCheckValue.Replace("<", "&lt;").Replace(">", "&gt;").Replace("'", "&quot;").Replace("&", "&amp;");

            return data;
        }
    }



}

