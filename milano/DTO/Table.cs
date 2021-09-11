using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace milano.DTO
{
    public class Table
    {
        public Table(int id, string name, string status)
        {
            this.ID = id;
            this.Name = name;
            this.Status = status;
        }


        // row được hiểu là từng dòng trong csdl
        public Table(DataRow row) // là hàm dựng để DataRow đưa về
        {
            // lấy ra các trường trong csdl
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.Status = row["status"].ToString();
        }

        private string status;  // đóng gói 

        public string Status
        {
            get { return status; }
            set { status = value; }
        }


        private string name; // đóng gói 

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private int iD; // đóng gói 

        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }
    }
}
