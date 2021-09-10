using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace milano.DAO
{
    public class AccountDAO
    {
        private static AccountDAO instance; // tạo ra 1 Singleton có tên là duy nhất 

        public static AccountDAO Instance
        {
            get { if (instance == null) instance = new AccountDAO(); return instance; }
            private set { instance = value; }
        }

        private AccountDAO() { }

        public bool Login(string userName, string passWord) // các xử lý khi đăng nhập
        {
            string query = "SELECT * FROM dbo.Account WHERE UserName = N'" + userName + "' AND PassWord = N'" + passWord +"' ";

            DataTable result = DataProvider.Instance.ExecuteQuery(query); // ExecuteQuery: sẽ trả ra những dòng kết quả
            // DataTable result = DataProvider.Instance.ExecuteNonQuery(query);  // ExecuteQuery: sẽ trả ra số dòng được thực thi(INSERT, DELECT, UPDATE) 

            return result.Rows.Count > 0; // số dòng trả ra lớn hơn 0
        }
    }
}