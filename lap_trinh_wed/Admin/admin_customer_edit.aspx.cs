using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.admin
{
    public partial class admin_customer_edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Sửa lỗi HttpCachePolicy (CS1061)
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
                // Nếu có ID truyền vào thì load dữ liệu (tạm thời để dữ liệu mẫu)
                LoadCustomerData();
            }
        }

        private void LoadCustomerData()
        {
            // Tạm thời gán dữ liệu giống như trong ảnh mockup của bạn
            txtName.Text = "ABCDDD";
            txtPhone.Text = "0000000009";
            txtRank.Text = "Vàng";
            txtPoints.Text = "1250";
            txtHealth.Text = "Da hỗn hợp, dễ bị mụn viêm, dị ứng với một số loại tinh dầu";
            txtInternalNote.Text = "Khách VIP, thích dịch vụ collagen và massage vai gáy";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ các TextBox để xử lý
            string hoTen = txtName.Text;
            string sdt = txtPhone.Text;
            string hang = txtRank.Text;
            string diem = txtPoints.Text;
            string sucKhoe = txtHealth.Text;
            string ghiChu = txtInternalNote.Text;

            // Chỗ này sau này bạn sẽ viết lệnh SQL UPDATE vào Database
            // Ví dụ: UPDATE khach_hang SET ho_va_ten = N'...' WHERE id = ...

            // Thông báo tạm thời
            string script = "alert('Đã lưu thông tin khách hàng: " + hoTen + "'); window.location='admin_customer.aspx';";
            ClientScript.RegisterStartupScript(this.GetType(), "SaveSuccess", script, true);
        }
    }
}