using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();
            bool isAccepted = chkTerms.Checked;

            // 1. Kiểm tra rỗng
            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(pass))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Vui lòng điền đầy đủ thông tin.";
                return;
            }

            // 2. Kiểm tra mật khẩu khớp nhau
            if (pass != confirmPass)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Mật khẩu xác nhận không khớp.";
                return;
            }

            // 3. Kiểm tra điều khoản
            if (!isAccepted)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Bạn phải đồng ý với điều khoản để tiếp tục.";
                return;
            }

            // 4. Logic đăng ký (Giả lập)
            // Ở đây bạn sẽ viết code để INSERT dữ liệu vào SQL Server
            try
            {
                // Giả sử đăng ký thành công
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Đăng ký thành công! Đang chuyển hướng...";

                // Chờ 2 giây rồi chuyển sang trang đăng nhập (tùy chọn)
                // Response.Redirect("login.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
            }
        }
    }
}