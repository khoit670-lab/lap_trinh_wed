using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;

namespace lap_trinh_wed.client
{
    public partial class login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load cookie nếu người dùng chọn "Ghi nhớ" trước đó
                if (Request.Cookies["LilySpa_User"] != null)
                {
                    txtName.Text = HttpUtility.UrlDecode(Request.Cookies["LilySpa_User"]["Name"]);
                    txtPhone.Text = Request.Cookies["LilySpa_User"]["Phone"];
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string fullName = txtName.Text.Trim();
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

                    // --- BƯỚC 1: KIỂM TRA BẢNG NHAN_SU (ADMIN/QUẢN LÝ/NHÂN VIÊN) ---
                    // Sử dụng mật khẩu thuần vì DB của bạn đang lưu '12345678'
                    string sqlAdmin = "SELECT id, ho_va_ten, vai_tro FROM nhan_su WHERE ho_va_ten=@ten AND so_dien_thoai=@sdt AND mat_khau=@mk AND trang_thai=N'Đang làm'";
                    SqlCommand cmdAdmin = new SqlCommand(sqlAdmin, conn);
                    cmdAdmin.Parameters.AddWithValue("@ten", fullName);
                    cmdAdmin.Parameters.AddWithValue("@sdt", phone);
                    cmdAdmin.Parameters.AddWithValue("@mk", password);

                    using (SqlDataReader rAdmin = cmdAdmin.ExecuteReader())
                    {
                        if (rAdmin.Read())
                        {
                            string role = rAdmin["vai_tro"].ToString().ToLower();

                            // PHÂN QUYỀN: Chỉ Admin và Quản lý mới được vào trang admin
                            if (role == "admin" || role == "quản lý" || role == "quan_ly")
                            {
                                Session["HoVaTen"] = rAdmin["ho_va_ten"];
                                Session["VaiTro"] = role;
                                Response.Redirect("../admin/admin_dashboard.aspx");
                                return;
                            }
                            else
                            {
                                lblMessage.Text = "Bạn không có quyền truy cập vào trang quản trị.";
                                return;
                            }
                        }
                    }

                    // --- BƯỚC 2: KIỂM TRA BẢNG KHACH_HANG (KHÁCH HÀNG) ---
                    // Sử dụng mật khẩu HASH (Mã hóa) theo logic bài tập của bạn
                    string hashInput = HashPassword(password);
                    string sqlKhach = "SELECT id, ho_va_ten FROM khach_hang WHERE ho_va_ten=@ten AND so_dien_thoai=@sdt AND mat_khau=@mk AND trang_thai = 1";
                    SqlCommand cmdKhach = new SqlCommand(sqlKhach, conn);
                    cmdKhach.Parameters.AddWithValue("@ten", fullName);
                    cmdKhach.Parameters.AddWithValue("@sdt", phone);
                    cmdKhach.Parameters.AddWithValue("@mk", hashInput);

                    using (SqlDataReader rKhach = cmdKhach.ExecuteReader())
                    {
                        if (rKhach.Read())
                        {
                            Session["KhachHangId"] = rKhach["id"];
                            Session["HoVaTen"] = rKhach["ho_va_ten"];
                            Session["VaiTro"] = "khach_hang";
                            Response.Redirect("Default.aspx");
                            return;
                        }
                    }

                    lblMessage.Text = "Thông tin đăng nhập không chính xác.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
            }
        }

        // Hàm mã hóa mật khẩu SHA256 cho khách hàng
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