﻿using milano.DAO;
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

namespace milano
{
    public partial class fTableManager : Form
    {
        public fTableManager()
        {
            InitializeComponent();

            LoadTable();
        }

        #region Method

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
                btn.Click += btn_Click;  // khi nhấn vào buttun thì nó sẽ gọi 1 hàm khác để xử lý chuyện đó
                btn.Tag = item;

                // màu sắc của bàn lúc 'có người' và lúc 'trống'
                switch (item.Status)
                {
                    case "Trống":
                        btn.BackColor = Color.Aqua;
                        break;
                    default:
                        btn.BackColor = Color.LightPink;
                        break;
                }

                flpTable.Controls.Add(btn);
            }
        }

        void ShowBill(int id)
        {
            lsvBill.Items.Clear();
            List<milano.DTO.Menu> listBillInfo = MenuDAO.Instance.GetListMenuByTable(id);

            foreach (milano.DTO.Menu item in listBillInfo)
            {
                ListViewItem lsvItem = new ListViewItem(item.FoodName.ToString());
                lsvItem.SubItems.Add(item.Count.ToString());
                lsvItem.SubItems.Add(item.Price.ToString());
                lsvItem.SubItems.Add(item.TotalPrice.ToString());

                lsvBill.Items.Add(lsvItem);
            }
        }

        #endregion


        #region Events
        void btn_Click(object sender, EventArgs e)
        {
            int tableID = ((sender as Button).Tag as Table).ID;
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
        #endregion
    }
}