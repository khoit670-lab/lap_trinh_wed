using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace lap_trinh_wed.client
{
    public partial class register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string email = txtEmail.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();

            // CHẶN LỖI GIÁ TRỊ RỖNG: Nếu không lấy được text, dừng ngay lập tức
            if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(phone) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(pass))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Vui lòng nhập đầy đủ thông tin.";
                return;
            }

            // Làm sạch số điện thoại - chỉ giữ lại số
            phone = System.Text.RegularExpressions.Regex.Replace(phone, "[^0-9]", "");

            // Kiểm tra độ dài số điện thoại
            if (phone.Length < 10 || phone.Length > 11)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Số điện thoại không hợp lệ (phải từ 10-11 số).";
                return;
            }

            // Kiểm tra email hợp lệ
            if (!email.Contains("@") || !email.Contains("."))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Email không hợp lệ.";
                return;
            }

            if (pass != confirmPass)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Mật khẩu xác nhận không khớp.";
                return;
            }

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Kiểm tra số điện thoại tồn tại chưa
                    SqlCommand chkPhoneCmd = new SqlCommand("SELECT COUNT(*) FROM khach_hang WHERE LTRIM(RTRIM(so_dien_thoai)) = @sdt", conn);
                    chkPhoneCmd.Parameters.AddWithValue("@sdt", phone);
                    int phoneCount = (int)chkPhoneCmd.ExecuteScalar();

                    if (phoneCount > 0)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = "Số điện thoại này đã tồn tại!";
                        return;
                    }

                    // Kiểm tra email tồn tại chưa
                    SqlCommand chkEmailCmd = new SqlCommand("SELECT COUNT(*) FROM khach_hang WHERE LTRIM(RTRIM(email)) = @email", conn);
                    chkEmailCmd.Parameters.AddWithValue("@email", email);
                    int emailCount = (int)chkEmailCmd.ExecuteScalar();

                    if (emailCount > 0)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = "Email này đã được đăng ký!";
                        return;
                    }

                    // Hash mật khẩu và tạo mã KH duy nhất
                    string hashPass = HashPassword(pass);
                    string maKH = "KH" + DateTime.Now.ToString("yyyyMMddHHmmss") + new Random().Next(10, 99);

                    string sql = @"INSERT INTO khach_hang (ma_khach_hang, ho_va_ten, so_dien_thoai, email, hang_khach_hang, diem_tich_luy, mat_khau, trang_thai) 
                                 VALUES (@ma, @ten, @sdt, @email, N'Đồng', 0, @mk, 1)";

                    using (SqlCommand insCmd = new SqlCommand(sql, conn))
                    {
                        insCmd.Parameters.AddWithValue("@ma", maKH);
                        insCmd.Parameters.AddWithValue("@ten", fullName);
                        insCmd.Parameters.AddWithValue("@sdt", phone);
                        insCmd.Parameters.AddWithValue("@email", email);
                        insCmd.Parameters.AddWithValue("@mk", hashPass);
                        insCmd.ExecuteNonQuery();
                    }
                }

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Đăng ký thành công!";
                btnRegister.Enabled = false;
                Response.Write("<script>setTimeout(function(){ window.location='login.aspx'; }, 2000);</script>");
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                if (ex.Message.Contains("UNIQUE KEY"))
                    lblMessage.Text = "Lỗi DB: Thông tin này đã tồn tại (số điện thoại hoặc email).";
                else
                    lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
            }
        }

        private static string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                var bytes = Encoding.UTF8.GetBytes(password + "LilySpa_Salt_2025");
                byte[] hash = sha.ComputeHash(bytes);
                StringBuilder sb = new StringBuilder();
                foreach (byte b in hash) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
    }
}