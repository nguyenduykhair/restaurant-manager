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
    }
}