using System;
using System.Configuration;
using System.Data;        // ← THÊM DÒNG NÀY
using System.Data.SqlClient;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_service_edit : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected int dichVuId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            if (!int.TryParse(Request.QueryString["id"], out dichVuId) || dichVuId <= 0)
            {
                Response.Redirect("admin_service.aspx");
                return;
            }

            if (!IsPostBack)
                LoadChiTiet(dichVuId);
        }

        private void LoadChiTiet(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT
                            dv.ten_dich_vu,
                            ISNULL(dm.ten_danh_muc, '') AS loai,
                            dv.thoi_gian,
                            dv.gia_goc,
                            dv.gia_khuyen_mai,
                            dv.mo_ta
                        FROM dich_vu dv
                        LEFT JOIN danh_muc_dich_vu dm ON dv.danh_muc_id = dm.id
                        WHERE dv.id = @id", conn);

                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    using (var r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            Response.Redirect("admin_service.aspx");
                            return;
                        }

                        txtServiceName.Text = r["ten_dich_vu"].ToString();
                        txtType.Text = r["loai"].ToString();
                        txtDuration.Text = r["thoi_gian"].ToString();

                        decimal gia = r["gia_khuyen_mai"] != DBNull.Value &&
                                    Convert.ToDecimal(r["gia_khuyen_mai"]) > 0
                            ? Convert.ToDecimal(r["gia_khuyen_mai"])
                            : Convert.ToDecimal(r["gia_goc"]);
                        txtPrice.Text = gia.ToString("N0");

                        txtDescription.Text = r["mo_ta"] != DBNull.Value
                            ? r["mo_ta"].ToString() : "";
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadChiTiet Error: " + ex.Message);
                ShowAlert("Lỗi tải dữ liệu!");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string tenDV = txtServiceName.Text.Trim();
            string loaiDV = txtType.Text.Trim();
            string tgStr = txtDuration.Text.Trim();
            string giaStr = txtPrice.Text.Trim().Replace(".", "").Replace(",", "").Replace("đ", "").Trim();
            string moTa = txtDescription.Text.Trim();

            // Validate
            if (string.IsNullOrEmpty(tenDV))
            {
                ShowAlert("Tên dịch vụ không được để trống!");
                return;
            }
            if (string.IsNullOrEmpty(loaiDV))
            {
                ShowAlert("Loại dịch vụ không được để trống!");
                return;
            }
            if (!int.TryParse(tgStr, out int thoiGian) || thoiGian <= 0)
            {
                ShowAlert("Thời gian phải là số > 0 (phút)!");
                return;
            }
            if (!decimal.TryParse(giaStr, out decimal giaGoc) || giaGoc <= 0)
            {
                ShowAlert("Giá tiền không hợp lệ!");
                return;
            }

            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    conn.Open();

                    // Kiểm tra tồn tại
                    var checkCmd = new SqlCommand("SELECT COUNT(*) FROM dich_vu WHERE id = @id", conn);
                    checkCmd.Parameters.AddWithValue("@id", dichVuId);
                    if ((int)checkCmd.ExecuteScalar() == 0)
                    {
                        ShowAlert("Dịch vụ không tồn tại!");
                        return;
                    }

                    // UPDATE
                    var cmd = new SqlCommand(@"
                        UPDATE dich_vu SET 
                            ten_dich_vu = @ten,
                            thoi_gian = @tg,
                            gia_goc = @gia,
                            mo_ta = @mo_ta,
                            updated_at = GETDATE()
                        WHERE id = @id", conn);

                    cmd.Parameters.AddWithValue("@ten", tenDV);
                    cmd.Parameters.AddWithValue("@tg", thoiGian);
                    cmd.Parameters.AddWithValue("@gia", giaGoc);
                    cmd.Parameters.AddWithValue("@mo_ta", string.IsNullOrEmpty(moTa) ? (object)DBNull.Value : moTa);
                    cmd.Parameters.AddWithValue("@id", dichVuId);

                    if (cmd.ExecuteNonQuery() > 0)
                    {
                        ClientScript.RegisterStartupScript(GetType(), "success",
                            $"alert('✅ Lưu thành công!');window.location='admin_service.aspx';", true);
                    }
                    else
                    {
                        ShowAlert("Không có thay đổi!");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Lỗi lưu dữ liệu: " + ex.Message);
            }
        }

        private void ShowAlert(string msg)
        {
            ClientScript.RegisterStartupScript(GetType(), "alert",
                $"alert('{msg.Replace("'", "\\'")}');", true);
        }
    }
}