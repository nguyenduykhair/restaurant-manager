using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace milano.DAO
{
    public class DataProvider
    {
        // tạo ra 1 đối tượng Instance là thể hiện của lớp DataProvider thông qua từ khóa static là suy nhất vì static chỉ có thể tạo 1 lần và dùng siêng suốt chương trình
        private static DataProvider instance; // Ctrl + R + E: phím tắt đóng gói 

        public static DataProvider Instance
        {
            get { if (instance == null) instance = new DataProvider(); return DataProvider.instance; }
            private set { DataProvider.instance = value; }  // nội bộ trong class này được phép sử dụng thôi 
        }

        private DataProvider() { } // đảm bảo bên ngoài ko tác động vào được

        private string connectionSTR = "Data Source=DESKTOP-RNOPI29\\SQLEXPRESS;Initial Catalog=milano;Integrated Security=True";

        public DataTable ExecuteQuery(string query, object[] parameter = null) // 1 mảng parameter
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionSTR))// kết nối từ client xuống server || using: khi kết thúc khối lệnh bên trong thì đối số truyền vào sẽ tự giải phóng
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection); // câu truy vấn sẽ thực thi

                if (parameter != null)
                {
                    string[] listPara = query.Split(' '); // nó sẽ Split theo khoảng chắn 
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))  // nếu Contains('@') có chứa dấu @ thì có nghĩa thằng này chứa parameter
                        {
                            command.Parameters.AddWithValue(item, parameter[i]); // thêm parameter
                            i++;
                        }
                    }
                }

                SqlDataAdapter adapter = new SqlDataAdapter(command);  // thằng này là trung gian để lấy dữ liệu lên

                adapter.Fill(data);

                connection.Close();
            }

            return data;
        }

        public int ExecuteNonQuery(string query, object[] parameter = null) // trả ra số dòng thành công
        {
            int data = 0; // trả ra là int vì đây là số

            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);

                if (parameter != null)
                {
                    string[] listPara = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }

                data = command.ExecuteNonQuery();

                connection.Close();
            }

            return data;
        }

        public object ExecuteScalar(string query, object[] parameter = null) // đếm số lượng COUNT(*), trả ra ô đầu tiên của bảng kết quả
        {
            object data = 0;  // trả ra phải là object

            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);

                if (parameter != null)
                {
                    string[] listPara = query.Split(' ');
                    int i = 0;
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameter[i]);
                            i++;
                        }
                    }
                }

                data = command.ExecuteScalar();

                connection.Close();
            }

            return data;
        }
    }
}
