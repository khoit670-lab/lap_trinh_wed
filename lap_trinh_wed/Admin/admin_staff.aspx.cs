using System;
using System.Web;
using System.Data;

namespace lap_trinh_wed.admin
{
    public partial class admin_staff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Sửa lỗi CS1061: SetNoCache
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
                // Gọi hàm LoadStaffData() để lấy dữ liệu từ SQL tại đây
            }
        }
    }
}