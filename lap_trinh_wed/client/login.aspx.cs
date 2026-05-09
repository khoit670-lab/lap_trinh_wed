using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace lap_trinh_wed.client
{
    public partial class login : Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Vui lòng nhập đầy đủ thông tin.";
                return;
            }

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string hashInput = HashPassword(password); // Băm mật khẩu nhập vào để so sánh

                    string sql = "SELECT * FROM khach_hang WHERE so_dien_thoai = @sdt AND mat_khau = @mk AND trang_thai = 1";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@sdt", phone);
                    cmd.Parameters.AddWithValue("@mk", hashInput);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Lưu thông tin vào Session
                            Session["KhachHangId"] = reader["id"];
                            Session["HoVaTen"] = reader["ho_va_ten"];
                            Response.Redirect("Default.aspx");
                        }
                        else
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = "Số điện thoại hoặc mật khẩu không đúng.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
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