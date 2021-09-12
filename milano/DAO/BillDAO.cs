using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using milano.DTO;

// class này có nhiệm vụ lấy ra cái Bill từ cái IdTable
namespace milano.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;  // đóng gói

        public static BillDAO Instance
        {
            get { if (instance == null) instance = new BillDAO(); return BillDAO.instance; }
            private set { BillDAO.instance = value; }
        }

        private BillDAO() { }

        /// <summary>
        /// Thành công: bill ID
        /// thất bại: -1
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        /// 
        // hàm này dùng để lấy cái idBill ra
        public int GetUncheckBillIDByTableID(int id) // trả ra cho người ta 1 cái id của Bill dựa vào cái IdTable
        {

            // chỗ này có thể viết hêm store proc nữa
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.Bill WHERE idTable = " + id + " AND status = 0");


            // nếu số trường trả về của nó mà lớn hơn 0 
            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;
            }

            // có nghĩa là không có thằng nào hết
            return -1;
        }

        // chức năng thanh toán
        public void CheckOut(int id)
        {
            string query = "UPDATE dbo.Bill SET status = 1 WHERE id = " + id;
            DataProvider.Instance.ExecuteNonQuery(query);
        }

        public void InsertBill(int id)
        {
            DataProvider.Instance.ExecuteNonQuery("exec USP_InsertBill @idTable", new object[] { id });
        }

        public int GetMaxIDBill()
        {
            try // cố gắng để làm việc này
            {
                return (int)DataProvider.Instance.ExecuteScalar("SELECT MAX(id) FROM dbo.Bill");
            }
            catch
            {
                return 1;
            }
        }
    }
}