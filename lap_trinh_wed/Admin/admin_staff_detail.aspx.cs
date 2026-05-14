using System;
using System.Web;

namespace lap_trinh_wed.admin
{
    public partial class admin_staff_detail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Sửa lỗi HttpCachePolicy (SetNoCache)
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
                // Logic lấy ID từ URL để đổ dữ liệu từ SQL Server
                if (Request.QueryString["id"] != null)
                {
                    string staffId = Request.QueryString["id"];
                    // LoadStaffDetail(staffId);
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string staffId = Request.QueryString["id"];
            // Chuyển sang trang chỉnh sửa nhân viên (bạn có thể làm tương tự trang chỉnh sửa khách hàng)
            Response.Redirect("admin_staff_edit.aspx?id=" + staffId);
        }
    }
}