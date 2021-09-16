using milano.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace milano.DAO
{
    public class BillInfoDAO
    {
        private static BillInfoDAO instance;

        public static BillInfoDAO Instance
        {
            get { if (instance == null) instance = new BillInfoDAO(); return BillInfoDAO.instance; }
            private set { BillInfoDAO.instance = value; }
        }

        private BillInfoDAO() { }


        // bất cứ BillInfo nào dính tới FoodID thì đều phải xóa hết
        public void DeleteBillInfoByFoodID(int id)
        {
            DataProvider.Instance.ExecuteQuery("delete dbo.BillInfo WHERE idFood = " + id);
        }

        public List<BillInfo> GetListBillInfo(int id) // đối số id này là của thằng bill
        {
            List<BillInfo> listBillInfo = new List<BillInfo>();


            // viết câu query
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.BillInfo WHERE idBill = " + id);

            // duyệt từng cái row
            foreach (DataRow item in data.Rows)
            {
                BillInfo info = new BillInfo(item); // info bằng ngay chính cái item đưa vô
                listBillInfo.Add(info); 
            }

            return listBillInfo;
        }

        public void InsertBillInfo(int idBill, int idFood, int count)
        {
            DataProvider.Instance.ExecuteNonQuery("USP_InsertBillInfo @idBill , @idFood , @count", new object[] { idBill, idFood, count });
        }
    }
}



