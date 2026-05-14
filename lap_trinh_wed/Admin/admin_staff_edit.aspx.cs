using System;
using System.Web;

namespace lap_trinh_wed.admin
{
    public partial class admin_staff_edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Sửa lỗi HttpCachePolicy
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
                // Logic lấy ID nhân viên từ URL và nạp dữ liệu cũ vào các TextBox
                if (Request.QueryString["id"] != null)
                {
                    string staffId = Request.QueryString["id"];
                    // LoadCurrentStaffData(staffId);
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Lấy thông tin mới từ các ô TextBox
            string updatedName = txtStaffName.Text;
            string updatedPhone = txtStaffPhone.Text;
            string updatedPosition = txtStaffPosition.Text;
            string updatedStatus = txtStaffStatus.Text;
            string updatedNotes = txtStaffEvaluation.Text;

            // Thực hiện SQL UPDATE nhân sự tại đây...

            // Thông báo và quay lại trang danh sách
            Response.Write("<script>alert('Đã cập nhật thông tin nhân sự thành công!'); window.location='admin_staff.aspx';</script>");
        }
    }
}