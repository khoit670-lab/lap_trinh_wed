using System;

namespace lap_trinh_wed.admin
{
    public partial class admin_service_edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Giả lập tải dữ liệu từ mockup {49903B26-B2D3-4DF6-B922-6B4C41D4D12D}.png
                txtServiceName.Text = "chăm sóc da";
                txtType.Text = "Chăm sóc da.";
                txtDuration.Text = "60'";
                txtPrice.Text = "1.000.000";
                txtDescription.Text = "Làm cho da sáng hơn và mịn màng";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Thực hiện logic lưu dữ liệu vào database tại đây
            // string updatedName = txtServiceName.Text;
            // ... logic UPDATE ...

            // Thông báo và chuyển hướng
            Response.Write("<script>alert('Cập nhật dịch vụ thành công!'); window.location='admin_service.aspx';</script>");
        }
    }
}