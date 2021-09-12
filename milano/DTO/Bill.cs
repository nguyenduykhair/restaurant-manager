using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;// add libary of the DataRow



// lấy ra số lượng xem thử nó thành công hay không , sau đó chuyển nó thành 1 cái Bill
namespace milano.DTO
{
    public class Bill
    {
        public Bill(int id, DateTime? dataCheckin, DateTime? dataCheckOut, int status)
        {
            this.ID = id;
            this.DataCheckIn = dataCheckin;
            this.DataCheckOut = dataCheckOut;
            this.Status = status;

        }


        // hàm này để lấy được cái row đưa vô xác định
        public Bill(DataRow row)
        {
            this.ID = (int)row["id"];
            this.DataCheckIn = (DateTime?)row["dataCheckin"]; // với tình hình = null, thì bạn ko thể nào check ra được
            var dataCheckOutTemp = row["dataCheckOut"];
            if (dataCheckOutTemp.ToString() != "")
                this.DataCheckOut = (DateTime?)dataCheckOutTemp;

            this.Status = (int)row["status"]; 
        }

        private int status;

        public int Status 
        { 
            get => status; 
            set => status = value; 
        }

        private DateTime? dataCheckOut;  // đóng gói

        public DateTime? DataCheckOut//DateTime ở đây là vì kiểu dữ liệu này nó ko cho phép null, ? cho phép nó null
        {
            get => dataCheckOut;
            set => dataCheckOut = value;
        }

        private DateTime? dataCheckIn; 

        public DateTime? DataCheckIn
        {
            get => dataCheckIn;
            set => dataCheckIn = value;
        }

        private int iD;

        public int ID 
        { 
            get => iD; 
            set => iD = value; 
        }
       
    }
}
