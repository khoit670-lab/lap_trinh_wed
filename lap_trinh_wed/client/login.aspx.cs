using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace lap_trinh_wed.client
{
    public partial class login : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["VaiTro"] != null)
                {
                    RedirectByRole();
                }

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
            string phone = txtPhone.Text.Trim().Replace(" ", "").Replace("-", "");
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(password))
            {
                ShowMessage("❌ Vui lòng nhập đầy đủ thông tin!", "error");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(_conn))
                {
                    conn.Open();

                    // ✅ 1. NHÂN SỰ
                    string sqlNhanSu = @"
                        SELECT id, ho_va_ten, vai_tro, trang_thai, mat_khau
                        FROM nhan_su WHERE ho_va_ten = @ten AND so_dien_thoai = @sdt AND trang_thai = N'Đang làm'";

                    SqlCommand cmdNhanSu = new SqlCommand(sqlNhanSu, conn);
                    cmdNhanSu.Parameters.AddWithValue("@ten", fullName);
                    cmdNhanSu.Parameters.AddWithValue("@sdt", phone);

                    using (SqlDataReader reader = cmdNhanSu.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string storedPassword = reader["mat_khau"]?.ToString() ?? "";
                            string vaiTro = reader["vai_tro"].ToString().ToLower();

                            if (storedPassword != password)
                            {
                                ShowMessage("❌ Mật khẩu không chính xác!", "error");
                                return;
                            }

                            // ✅ Lưu Session
                            Session["NhanSuId"] = reader["id"];
                            Session["HoVaTen"] = fullName;
                            Session["VaiTro"] = vaiTro;
                            Session["IsAdmin"] = (vaiTro == "admin" || vaiTro == "quan_ly");

                            SaveRememberMe(fullName, phone);

                            // ✅ ADMIN: Hiển thị lựa chọn
                            if ((bool)Session["IsAdmin"])
                            {
                                ShowAdminChoice(fullName);
                                return;
                            }

                            Response.Redirect("Default.aspx");
                            return;
                        }
                    }

                    // ✅ 2. KHÁCH HÀNG
                    HandleKhachHang(fullName, phone, conn);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Lỗi: " + ex.Message, "error");
            }
        }

        // ✅ HIỂN THỊ LỰA CHỌN CHO ADMIN
        private void ShowAdminChoice(string fullName)
        {
            lblMessage.Text = $@"
                <div class='admin-choice'>
                    <div style='font-size: 28px; margin-bottom: 15px;'>
                        <i class='fa-solid fa-crown' style='font-size: 36px; margin-right: 10px;'></i>
                        Chào {fullName}!
                    </div>
                    <div style='font-size: 18px; margin-bottom: 30px;'>
                        Bạn là <strong>Quản trị viên</strong><br>Chọn chế độ sử dụng:
                    </div>
                </div>";

            btnAdminMode.Visible = true;
            btnClientMode.Visible = true;
            btnLogin.Visible = false;
            lblMessage.Visible = true;
        }

        protected void btnAdminMode_Click(object sender, EventArgs e)
        {
            Session["AdminMode"] = true;
            Response.Redirect("../admin/admin_dashboard.aspx"); // ✅ ĐÚNG: dashboard.aspx
        }

        protected void btnClientMode_Click(object sender, EventArgs e)
        {
            Session.Remove("AdminMode"); // ✅ XÓA AdminMode khi dùng Client
            Response.Redirect("Default.aspx");
        }

        private void HandleKhachHang(string fullName, string phone, SqlConnection conn)
        {
            string sqlKhach = "SELECT id FROM khach_hang WHERE ho_va_ten = @ten AND so_dien_thoai = @sdt AND trang_thai = 1";
            SqlCommand cmdKhach = new SqlCommand(sqlKhach, conn);
            cmdKhach.Parameters.AddWithValue("@ten", fullName);
            cmdKhach.Parameters.AddWithValue("@sdt", phone);

            object khIdObj = cmdKhach.ExecuteScalar();
            if (khIdObj != null)
            {
                Session["KhachHangId"] = khIdObj;
            }
            else
            {
                string sqlTaoKH = "INSERT INTO khach_hang (ho_va_ten, so_dien_thoai, trang_thai, created_at) OUTPUT INSERTED.id VALUES (@ten, @sdt, 1, GETDATE())";
                SqlCommand cmdTaoKH = new SqlCommand(sqlTaoKH, conn);
                cmdTaoKH.Parameters.AddWithValue("@ten", fullName);
                cmdTaoKH.Parameters.AddWithValue("@sdt", phone);
                Session["KhachHangId"] = cmdTaoKH.ExecuteScalar();
            }

            Session["HoVaTen"] = fullName;
            Session["VaiTro"] = "khach_hang";
            Session["IsAdmin"] = false;
            SaveRememberMe(fullName, phone);
            Response.Redirect("Default.aspx");
        }

        private void SaveRememberMe(string name, string phone)
        {
            if (chkRemember.Checked)
            {
                HttpCookie cookie = new HttpCookie("LilySpa_User");
                cookie["Name"] = HttpUtility.UrlEncode(name);
                cookie["Phone"] = phone;
                cookie.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Add(cookie);
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = type == "error" ?
                "block w-full p-4 rounded-2xl text-center font-semibold text-sm bg-red-100 border border-red-300 text-red-800" :
                "block w-full p-4 rounded-2xl text-center font-semibold text-sm bg-green-100 border border-green-300 text-green-800";
            lblMessage.Visible = true;
        }

        private void RedirectByRole()
        {
            Response.Redirect("Default.aspx");
        }
    }
}