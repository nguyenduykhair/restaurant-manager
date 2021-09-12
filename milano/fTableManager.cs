using milano.DAO;
using milano.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Globalization; // add library this if want use CultureInfo 

namespace milano
{
    public partial class fTableManager : Form
    {
        public fTableManager()
        {
            InitializeComponent();

            LoadTable();
            LoadCategory();
        }


        // dành cho phương thức
        #region Method
        // chia  Category ra nhiều lớp
        void LoadCategory()
        {
            List<Category> listCategory = CategoryDAO.Instance.GetListCategory();
            cbCategory.DataSource = listCategory;
            cbCategory.DisplayMember = "Name"; // dùng để chỉ cho nó biết phải hiển thị ở trường nào
        }

        void LoadFoodListByCategoryID(int id)
        {
            List<Food> listFood = FoodDAO.Instance.GetFoodByCategoryID(id);
            cbFood.DataSource = listFood;
            cbFood.DisplayMember = "Name";
        }

        // hiển thị 1 cái button cho người dùng nhìn thấy
        void LoadTable()
        {
            // lấy được danh sách table 
            List<Table> tableList = TableDAO.Instance.LoadTableList();

            foreach (Table item in tableList)
            {
                // điều chỉnh kích cỡ của bàn
                Button btn = new Button() { Width = TableDAO.TableWidth, Height = TableDAO.TableHeight };
                btn.Text = item.Name + Environment.NewLine + item.Status; // hiển thị tên bàn + \n
                btn.Click += btn_Click;  // khi nhấn vào buttun thì nó sẽ gọi 1 hàm khác để xử lý chuyện đó (đó chính là show ra cái hóa đơn)
                btn.Tag = item; // tag: kiểu dữ liệu là object, dùng nó để lưu luôn cái table của bạn vô

                // màu sắc của bàn lúc 'có người' và lúc 'trống'
                switch (item.Status)
                {
                    case "Trống":
                        btn.BackColor = Color.AntiqueWhite;
                        break;
                    default:
                        btn.BackColor = Color.LimeGreen;
                        break;
                }

                flpTable.Controls.Add(btn);
            }
        }

        // lấy hóa đơn ra
        void ShowBill(int id) // đối số này là là dùng để xác định ShowBill cho cái table nào 
        {
            //xóa dữ liệu trở lại ban đầu
            lsvBill.Items.Clear();
            List<milano.DTO.Menu> listBillInfo = MenuDAO.Instance.GetListMenuByTable(id);

            float totalPrice = 0;
            foreach (milano.DTO.Menu item in listBillInfo)
            {
                ListViewItem lsvItem = new ListViewItem(item.FoodName.ToString()); // tên món
                lsvItem.SubItems.Add(item.Count.ToString()); // số lượng
                lsvItem.SubItems.Add(item.Price.ToString()); // đơn giá
                lsvItem.SubItems.Add(item.TotalPrice.ToString()); // thành tiền
                totalPrice += item.TotalPrice;
                lsvBill.Items.Add(lsvItem);

            }
            // add đơn vị đồng điền: đ, $, .....
            // CultureInfo culture = new CultureInfo("en-US"); // tiền Đôla Mỹ
            CultureInfo culture = new CultureInfo("vi-VN"); // tiền Việt

            //Thread.CurrentThread.CurrentCulture = culture;

            // tính tổng tiền
            txbTotalPrice.Text = totalPrice.ToString("c", culture); // "c" này là viết tắt của tiền bạc
        }

        #endregion

        // dành cho các sự kiện
        #region Events
        void btn_Click(object sender, EventArgs e)
        {
            int tableID = ((sender as Button).Tag as Table).ID;
            lsvBill.Tag = (sender as Button).Tag; // btnAddFood_Click
            ShowBill(tableID);
        }
        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void thôngTinCáNhânToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAccountProfile f = new fAccountProfile();
            f.ShowDialog();
        }

        private void adminToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAdmin f = new fAdmin();
            f.ShowDialog();
        }

        private void cbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = 0; // id chỗ này để truyền vào hàm này LoadFoodListByCategoryID(int id)

            ComboBox cb = sender as ComboBox;

            if (cb.SelectedItem == null) // nếu nó chưa có thì sẽ return luôn không chạy nữa
                return;

            Category selected = cb.SelectedItem as Category;
            id = selected.ID;

            LoadFoodListByCategoryID(id);
        }

        // 1 table chỉ có tối đa 1 Bill để cho checkout
        private void btnAddFood_Click(object sender, EventArgs e)
        {
            Table table = lsvBill.Tag as Table; // lấy được cái table hiện tại

            int idBill = BillDAO.Instance.GetUncheckBillIDByTableID(table.ID); // lấy được cái Bill hiện tại
            int foodID = (cbFood.SelectedItem as Food).ID;
            int count = (int)nmFoodCount.Value;


            
            if (idBill == -1) // trường hợp này ko có Bill nào hết
            {
                BillDAO.Instance.InsertBill(table.ID); // thêm mới
                BillInfoDAO.Instance.InsertBillInfo(BillDAO.Instance.GetMaxIDBill(), foodID, count);
            }
            else  // trường hợp Bill đã tồn tại
            {
                BillInfoDAO.Instance.InsertBillInfo(idBill, foodID, count);
            }

            ShowBill(table.ID);

            LoadTable();
        }        
        // button khi nhấn THANH TOÁN
        private void btnCheckOut_Click(object sender, EventArgs e)
        {
            // lấy ra table hiện tại
            Table table = lsvBill.Tag as Table;

            int idBill = BillDAO.Instance.GetUncheckBillIDByTableID(table.ID);

            //  if (idBill == -1)  thì sẽ không làm gì hết
            if (idBill != -1)
            {
                if (MessageBox.Show("Bạn có chắc thanh toán hóa đơn cho bàn " + table.Name, "Thông báo", MessageBoxButtons.OKCancel) == System.Windows.Forms.DialogResult.OK)
                {
                    BillDAO.Instance.CheckOut(idBill);
                    ShowBill(table.ID);

                    LoadTable();
                }
            }
        }

        #endregion        

    }
}