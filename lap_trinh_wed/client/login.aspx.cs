using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Code thực thi khi trang được load
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ các ô nhập liệu
            string fullName = txtName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text.Trim();

            // 1. Kiểm tra rỗng
            if (string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Vui lòng nhập đầy đủ Số điện thoại và Mật khẩu!";
                return;
            }

            // 2. Giả lập logic kiểm tra đăng nhập
            // Trong thực tế, bạn sẽ truy vấn Database tại đây
            if (phone == "0987654321" && password == "admin123")
            {
                // Lưu thông tin vào Session để dùng ở các trang sau
                Session["UserPhone"] = phone;
                Session["UserName"] = fullName;

                // Chuyển hướng sang trang chủ hoặc trang cá nhân
                Response.Redirect("Default.aspx");
            }
            else
            {
                // Hiển thị lỗi nếu sai thông tin
                lblMessage.Text = "Số điện thoại hoặc mật khẩu không đúng.";
            }
        }
    }
}