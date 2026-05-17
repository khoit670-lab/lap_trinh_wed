using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_staff_edit : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
        protected int nhanSuId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            if (!int.TryParse(Request.QueryString["id"], out nhanSuId) || nhanSuId <= 0)
            {
                Response.Redirect("admin_staff.aspx");
                return;
            }

            if (!IsPostBack)
                LoadChiTiet(nhanSuId);
        }

        private void LoadChiTiet(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT ho_va_ten, so_dien_thoai, chuc_vu, 
                               ISNULL(trang_thai, N'Đang làm') AS trang_thai,
                               ISNULL(ghi_chu, N'') AS ghi_chu,
                               ISNULL(ca_lam_viec, N'') AS ca_lam_viec
                        FROM nhan_su WHERE id = @id", conn);

                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    using (var r = cmd.ExecuteReader())
                    {
                        if (!r.Read()) return;

                        txtName.Text = r["ho_va_ten"].ToString();
                        txtPhone.Text = r["so_dien_thoai"].ToString();
                        txtPosition.Text = r["chuc_vu"].ToString();
                        ddlStatus.SelectedValue = r["trang_thai"].ToString();
                        txtShift.Text = r["ca_lam_viec"].ToString();
                        txtNote.Text = r["ghi_chu"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadChiTiet Error: " + ex.Message);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string hoTen = txtName.Text.Trim();
            string sdt = txtPhone.Text.Trim().Replace(" ", "").Replace("-", "").Replace(".", "");
            string chucVu = txtPosition.Text.Trim();
            string trangThai = ddlStatus.SelectedValue;
            string caLam = txtShift.Text.Trim();
            string ghiChu = txtNote.Text.Trim();

            // Validate
            if (string.IsNullOrEmpty(hoTen))
            {
                ShowAlert("Tên nhân sự không được để trống.");
                return;
            }
            if (sdt.Length < 10 || sdt.Length > 11 || !long.TryParse(sdt, out _))
            {
                ShowAlert("Số điện thoại không hợp lệ (10–11 chữ số).");
                return;
            }

            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Check duplicate phone
                    var cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM nhan_su WHERE so_dien_thoai=@sdt AND id!=@id", conn);
                    cmdCheck.Parameters.AddWithValue("@sdt", sdt);
                    cmdCheck.Parameters.AddWithValue("@id", nhanSuId);
                    conn.Open();

                    if (Convert.ToInt32(cmdCheck.ExecuteScalar()) > 0)
                    {
                        ShowAlert("Số điện thoại này đã được sử dụng.");
                        return;
                    }

                    // Update
                    var cmdUpd = new SqlCommand(@"
                        UPDATE nhan_su SET 
                            ho_va_ten=@ten, so_dien_thoai=@sdt, chuc_vu=@cv,
                            trang_thai=@tt, ca_lam_viec=@cl, ghi_chu=@gc, updated_at=GETDATE()
                        WHERE id=@id", conn);

                    cmdUpd.Parameters.AddWithValue("@ten", hoTen);
                    cmdUpd.Parameters.AddWithValue("@sdt", sdt);
                    cmdUpd.Parameters.AddWithValue("@cv", string.IsNullOrEmpty(chucVu) ? (object)DBNull.Value : chucVu);
                    cmdUpd.Parameters.AddWithValue("@tt", trangThai);
                    cmdUpd.Parameters.AddWithValue("@cl", string.IsNullOrEmpty(caLam) ? (object)DBNull.Value : caLam);
                    cmdUpd.Parameters.AddWithValue("@gc", string.IsNullOrEmpty(ghiChu) ? (object)DBNull.Value : ghiChu);
                    cmdUpd.Parameters.AddWithValue("@id", nhanSuId);

                    cmdUpd.ExecuteNonQuery();
                }

                string script = $"alert('✅ Cập nhật thành công!');window.location='admin_staff_detail.aspx?id={nhanSuId}';";
                ClientScript.RegisterStartupScript(GetType(), "save_ok", script, true);
            }
            catch (Exception ex)
            {
                ShowAlert("Lỗi: " + ex.Message);
            }
        }

        private void ShowAlert(string msg)
        {
            ClientScript.RegisterStartupScript(GetType(), "alert", $"alert('{msg.Replace("'", "\\'")}');", true);
        }
    }
}