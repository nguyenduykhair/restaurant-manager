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
using milano.DAO;

namespace milano
{
    public partial class fAdmin : Form
    {
        public fAdmin()
        {
            InitializeComponent();

            LoadAccountList();
        }

        void LoadFoodList()
        {
            string query = "select * from food";

            dtgvFood.DataSource = DataProvider.Instance.ExecuteQuery(query);
        }

        void LoadAccountList()
        {

            string query = "EXEC dbo.USP_GetAccountByUserName @userName";

            dtgvAccount.DataSource = DataProvider.Instance.ExecuteQuery(query, new object[] { "staff" }); // { "staff" }: chỗ này có thể có nhiều parameter
        }
    }
}