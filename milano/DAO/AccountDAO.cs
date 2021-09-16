using milano.DTO;
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
        private static AccountDAO instance;  // tạo ra 1 Singleton có tên là duy nhất 

        public static AccountDAO Instance
        {
            get { if (instance == null) instance = new AccountDAO(); return instance; }
            private set { instance = value; }
        }

        private AccountDAO() { }

        public bool Login(string userName, string passWord) // các xử lý khi đăng nhập
        {
            string query = "USP_Login @userName , @passWord";
            // string query = "SELECT * FROM dbo.Account WHERE UserName = N'" + userName + "' AND PassWord = N'" + passWord +"' ";

            // DataTable result = DataProvider.Instance.ExecuteQuery(query); // ExecuteQuery: sẽ trả ra những dòng kết quả
            // DataTable result = DataProvider.Instance.ExecuteNonQuery(query);  // ExecuteQuery: sẽ trả ra số dòng được thực thi(INSERT, DELECT, UPDATE)

            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { userName, passWord });

            return result.Rows.Count > 0; // số dòng trả ra lớn hơn 0
        }



        // hàm này để cập nhập xem tài khoản mới có tạo được hay không
        public bool UpdateAccount(string userName, string displayName, string pass, string newPass)
        {

            // câu này là câu insert nên dùng ExecuteNonQuery
            int result = DataProvider.Instance.ExecuteNonQuery("exec USP_UpdateAccount @userName , @displayName , @password , @newPassword", new object[] { userName, displayName, pass, newPass });

            return result > 0;
        }

        public DataTable GetListAccount()
        {
            return DataProvider.Instance.ExecuteQuery("SELECT UserName, DisplayName, Type FROM dbo.Account");
        }

        public Account GetAccountByUserName(string userName)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("Select * from account where userName = '" + userName + "'");

            foreach (DataRow item in data.Rows)
            {
                return new Account(item);
            }

            return null;
        }
    }
}