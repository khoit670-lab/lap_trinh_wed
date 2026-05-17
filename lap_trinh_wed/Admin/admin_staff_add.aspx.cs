using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_staff_add : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            // Fix cache
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu form
            string hoTen = txtName.Text.Trim();
            string sdt = txtPhone.Text.Trim().Replace(" ", "").Replace("-", "").Replace(".", "");
            string chucVu = txtPosition.Text.Trim();
            string trangThai = ddlStatus.SelectedValue;
            string caLam = txtShift.Text.Trim();
            string ghiChu = txtNote.Text.Trim();

            // ── Validation ────────────────────────────────────────
            if (string.IsNullOrEmpty(hoTen))
            {
                ShowAlert("Họ và tên không được để trống.");
                return;
            }
            if (string.IsNullOrEmpty(sdt) || sdt.Length < 10 || sdt.Length > 11 || !long.TryParse(sdt, out _))
            {
                ShowAlert("Số điện thoại không hợp lệ (10–11 chữ số).");
                return;
            }
            if (string.IsNullOrEmpty(trangThai))
            {
                ShowAlert("Vui lòng chọn trạng thái.");
                return;
            }

            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Kiểm tra SĐT đã tồn tại chưa
                    var cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM nhan_su WHERE so_dien_thoai = @sdt", conn);
                    cmdCheck.Parameters.AddWithValue("@sdt", sdt);
                    conn.Open();

                    if (Convert.ToInt32(cmdCheck.ExecuteScalar()) > 0)
                    {
                        ShowAlert("Số điện thoại này đã được sử dụng.");
                        return;
                    }

                    // INSERT nhân sự mới
                    var cmdInsert = new SqlCommand(@"
                        INSERT INTO nhan_su (
                            ho_va_ten, so_dien_thoai, chuc_vu, trang_thai, 
                            ca_lam_viec, ghi_chu, created_at
                        ) VALUES (
                            @ten, @sdt, @cv, @tt, @cl, @gc, GETDATE()
                        )", conn);

                    cmdInsert.Parameters.AddWithValue("@ten", hoTen);
                    cmdInsert.Parameters.AddWithValue("@sdt", sdt);
                    cmdInsert.Parameters.AddWithValue("@cv", string.IsNullOrEmpty(chucVu) ? (object)DBNull.Value : chucVu);
                    cmdInsert.Parameters.AddWithValue("@tt", trangThai);
                    cmdInsert.Parameters.AddWithValue("@cl", string.IsNullOrEmpty(caLam) ? (object)DBNull.Value : caLam);
                    cmdInsert.Parameters.AddWithValue("@gc", string.IsNullOrEmpty(ghiChu) ? (object)DBNull.Value : ghiChu);

                    cmdInsert.ExecuteNonQuery();
                }

                string script = "alert('Thêm nhân sự mới thành công!');"
                              + "window.location='admin_staff.aspx';";
                ClientScript.RegisterStartupScript(GetType(), "add_success", script, true);
            }
            catch (Exception ex)
            {
                ShowAlert("Lỗi hệ thống: " + ex.Message);
            }
        }

        private void ShowAlert(string msg)
        {
            string js = $"alert('{msg.Replace("'", "\\'")}');";
            ClientScript.RegisterStartupScript(GetType(), "alert", js, true);
        }
    }
}