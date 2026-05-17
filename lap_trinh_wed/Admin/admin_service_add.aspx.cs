using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_service_add : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }
        }

        protected void btnAddService_Click(object sender, EventArgs e)
        {
            string tenDV = txtServiceName.Text.Trim();
            string loaiStr = txtServiceType.Text.Trim();
            string tgStr = txtDuration.Text.Trim();
            string giaStr = txtPrice.Text.Trim().Replace(".", "").Replace(",", "").Replace("đ", "").Trim();
            string moTa = txtDescription.Text.Trim();

            // ── Validate đầy đủ ──────────────────────────────────
            if (string.IsNullOrEmpty(tenDV))
            {
                ShowAlert("Tên dịch vụ không được để trống!");
                return;
            }
            if (string.IsNullOrEmpty(loaiStr))
            {
                ShowAlert("Loại dịch vụ không được để trống!");
                return;
            }
            if (!int.TryParse(tgStr, out int thoiGian) || thoiGian <= 0)
            {
                ShowAlert("Thời gian phải là số nguyên dương (phút)!");
                return;
            }
            if (!decimal.TryParse(giaStr, out decimal giaGoc) || giaGoc <= 0)
            {
                ShowAlert("Giá tiền phải lớn hơn 0!");
                return;
            }

            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    conn.Open();

                    // 1. Kiểm tra tên dịch vụ đã tồn tại
                    var cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM dich_vu WHERE ten_dich_vu = @ten AND trang_thai = 1", conn);
                    cmdCheck.Parameters.AddWithValue("@ten", tenDV);
                    if ((int)cmdCheck.ExecuteScalar() > 0)
                    {
                        ShowAlert($"❌ Dịch vụ '{tenDV}' đã tồn tại!");
                        return;
                    }

                    // 2. Lấy hoặc tạo danh mục
                    int danhMucId = GetOrCreateCategory(conn, loaiStr);

                    // 3. Tạo mã dịch vụ tự động DV001, DV002...
                    var cmdMa = new SqlCommand(
                        "SELECT ISNULL(MAX(CAST(SUBSTRING(ma_dich_vu, 3, LEN(ma_dich_vu)) AS INT)), 0) + 1 FROM dich_vu", conn);
                    int soThuTu = (int)cmdMa.ExecuteScalar();
                    string maDV = "DV" + soThuTu.ToString("D3");

                    // 4. INSERT dịch vụ mới
                    var cmdInsert = new SqlCommand(@"
                        INSERT INTO dich_vu (ma_dich_vu, ten_dich_vu, danh_muc_id, gia_goc, 
                                           thoi_gian, mo_ta, trang_thai, created_at)
                        VALUES (@ma, @ten, @dm_id, @gia, @tg, @mo_ta, 1, GETDATE())", conn);

                    cmdInsert.Parameters.AddWithValue("@ma", maDV);
                    cmdInsert.Parameters.AddWithValue("@ten", tenDV);
                    cmdInsert.Parameters.AddWithValue("@dm_id", danhMucId);
                    cmdInsert.Parameters.AddWithValue("@gia", giaGoc);
                    cmdInsert.Parameters.AddWithValue("@tg", thoiGian);
                    cmdInsert.Parameters.AddWithValue("@mo_ta",
                        string.IsNullOrEmpty(moTa) ? (object)DBNull.Value : moTa);

                    int result = cmdInsert.ExecuteNonQuery();

                    if (result > 0)
                    {
                        ClientScript.RegisterStartupScript(GetType(), "success",
                            $"alert('✅ Thêm dịch vụ '{tenDV}' thành công!');window.location='admin_service.aspx';", true);
                    }
                    else
                    {
                        ShowAlert("❌ Không thể thêm dịch vụ!");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("AddService Error: " + ex.Message);
                ShowAlert("Lỗi hệ thống: " + ex.Message);
            }
        }

        // ── Helper: Lấy ID danh mục hoặc tạo mới ────────────────
        private int GetOrCreateCategory(SqlConnection conn, string tenDanhMuc)
        {
            // Tìm danh mục hiện có
            var cmdFind = new SqlCommand(
                "SELECT id FROM danh_muc_dich_vu WHERE ten_danh_muc = @ten AND trang_thai = 1", conn);
            cmdFind.Parameters.AddWithValue("@ten", tenDanhMuc);
            object result = cmdFind.ExecuteScalar();

            if (result != null)
                return (int)result;

            // Tạo danh mục mới
            var cmdCreate = new SqlCommand(@"
                INSERT INTO danh_muc_dich_vu (ten_danh_muc, trang_thai, created_at) 
                VALUES (@ten, 1, GETDATE());
                SELECT SCOPE_IDENTITY();", conn);
            cmdCreate.Parameters.AddWithValue("@ten", tenDanhMuc);
            return Convert.ToInt32(cmdCreate.ExecuteScalar());
        }

        private void ShowAlert(string msg)
        {
            string js = $"alert('{msg.Replace("'", "\\'").Replace("\n", " ")}');";
            ClientScript.RegisterStartupScript(GetType(), "alert", js, true);
        }
    }
}