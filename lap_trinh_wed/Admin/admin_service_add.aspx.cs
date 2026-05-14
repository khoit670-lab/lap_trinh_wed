using System;
using System.Web;

namespace lap_trinh_wed.admin
{
    public partial class admin_service_add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Fix lỗi cache của trình duyệt
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
        }

        protected void btnAddService_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ các ô nhập liệu
            string tenDV = txtServiceName.Text;
            string loaiDV = txtServiceType.Text;
            string thoiGian = txtDuration.Text;
            string giaTien = txtPrice.Text;
            string moTa = txtDescription.Text;

            // Kiểm tra dữ liệu cơ bản
            if (string.IsNullOrEmpty(tenDV))
            {
                Response.Write("<script>alert('Vui lòng nhập tên dịch vụ!');</script>");
                return;
            }

            // --- Tại đây bạn sẽ viết code SQL INSERT để lưu vào Database ---
            // Ví dụ: INSERT INTO DichVu(Ten, Loai, ThoiGian, Gia, MoTa) VALUES (...)

            // Thông báo thành công và quay lại trang danh sách dịch vụ
            string script = "alert('Đã thêm dịch vụ: " + tenDV + " thành công!'); window.location='admin_service.aspx';";
            ClientScript.RegisterStartupScript(this.GetType(), "SaveSuccess", script, true);
        }
    }
}