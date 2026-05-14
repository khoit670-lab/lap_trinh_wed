using System;
using System.Web;

namespace lap_trinh_wed.admin
{
    public partial class admin_staff_add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Fix lỗi cache
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
        }

        protected void btnAddStaff_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ giao diện
            string name = txtName.Text;
            string phone = txtPhone.Text;
            string position = txtPosition.Text;
            string status = txtStatus.Text;
            string notes = txtNotes.Text;

            // Tại đây bạn sẽ thực hiện lệnh INSERT vào SQL Server
            // string sql = "INSERT INTO NhanVien (Ten, SDT, ChucVu, TrangThai, GhiChu) VALUES (...)";

            // Thông báo và chuyển hướng về danh sách
            Response.Write("<script>alert('Đã thêm nhân sự mới thành công!'); window.location='admin_staff.aspx';</script>");
        }
    }
}