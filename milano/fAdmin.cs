using milano.DAO;
using milano.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace milano
{
    public partial class fAdmin : Form
    {
        // này dùng để bắt sự kiện khi nhắn 'Xem'
        BindingSource foodList = new BindingSource();
        public fAdmin()
        {
            InitializeComponent();
            Load();
        }

        #region methods

        void Load()
        {

            dtgvFood.DataSource = foodList;

            LoadDateTimePickerBill();
            LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
            LoadListFood();
            LoadCategoryIntoCombobox(cbFoodCategory);
            AddFoodBinding();
        }

        void LoadDateTimePickerBill()
        {
            DateTime today = DateTime.Now;  // lấy ra thời gian hiện tại
            dtpkFromDate.Value = new DateTime(today.Year, today.Month, 1); // lấy ra đầu tháng
            dtpkToDate.Value = dtpkFromDate.Value.AddMonths(1).AddDays(-1); // lấy ra cuối tháng
        }
        void LoadListBillByDate(DateTime checkIn, DateTime checkOut)
        {
            dtgvBill.DataSource = BillDAO.Instance.GetBillListByDate(checkIn, checkOut);
        }

        // hàm lấy tên từng loại thức ăn ra
        void AddFoodBinding()  
        {
            txbFoodName.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "Name"));
            txbFoodID.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "ID"));
            nmFoodPrice.DataBindings.Add(new Binding("Value", dtgvFood.DataSource, "Price"));
        }

        void LoadCategoryIntoCombobox(ComboBox cb)
        {
            cb.DataSource = CategoryDAO.Instance.GetListCategory();
            cb.DisplayMember = "Name"; // hiển thị ra tên
        }


        void LoadListFood()
        {
            foodList.DataSource = FoodDAO.Instance.GetListFood();
        }
        #endregion

        #region events
        private void btnViewBill_Click(object sender, EventArgs e)
        {
            LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
        }

        private void btnShowFood_Click(object sender, EventArgs e)
        {
            LoadListFood();
        }

        private void txbFoodID_TextChanged(object sender, EventArgs e)
        {
            
            if (dtgvFood.SelectedCells.Count > 0)
            {
                // cách lấy dữ liệu trong datagitview
                int id = (int)dtgvFood.SelectedCells[0].OwningRow.Cells["CategoryID"].Value; // key cần tìm

                Category cateogory = CategoryDAO.Instance.GetCategoryByID(id);

                cbFoodCategory.SelectedItem = cateogory;

                int index = -1;
                int i = 0;
                foreach (Category item in cbFoodCategory.Items)
                {
                    if (item.ID == cateogory.ID)
                    {
                        index = i;
                        break;
                    }
                    i++;
                }

                cbFoodCategory.SelectedIndex = index;
            }
        }

        #endregion


    }
}