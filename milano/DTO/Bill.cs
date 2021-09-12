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
        public Bill(int id, DateTime? dateCheckin, DateTime? dateCheckOut, int status)
        {
            this.ID = id;
            this.DateCheckIn = dateCheckin;
            this.DateCheckOut = dateCheckOut;
            this.Status = status;

        }


        // hàm này để lấy được cái row đưa vô xác định
        public Bill(DataRow row)
        {
            this.ID = (int)row["id"];
            this.DateCheckIn = (DateTime?)row["dateCheckin"]; // với tình hình = null, thì bạn ko thể nào check ra được
           
            var dateCheckOutTemp = row["dateCheckOut"];
            if (dateCheckOutTemp.ToString() != "")
                this.DateCheckOut = (DateTime?)dateCheckOutTemp;

            this.Status = (int)row["status"]; 
        }

        private int status;

        public int Status 
        { 
            get => status; 
            set => status = value; 
        }

        private DateTime? dateCheckOut;  // đóng gói

        public DateTime? DateCheckOut//DateTime ở đây là vì kiểu dữ liệu này nó ko cho phép null, ? cho phép nó null
        {
            get => dateCheckOut;
            set => dateCheckOut = value;
        }

        private DateTime? dateCheckIn; 

        public DateTime? DateCheckIn
        {
            get => dateCheckIn;
            set => dateCheckIn = value;
        }

        private int iD;
      
        public int ID 
        { 
            get => iD; 
            set => iD = value; 
        }
       
    }
}
