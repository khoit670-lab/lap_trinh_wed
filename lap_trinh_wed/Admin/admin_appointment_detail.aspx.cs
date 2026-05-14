using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class appointment_detail : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"]?.ConnectionString
                                     ?? throw new Exception("Không tìm thấy connection string LilySpaDB");

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ NGANH CACHE
            Response.Cache.SetNoStore();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (string.IsNullOrEmpty(id) || !int.TryParse(id, out int lichHenId))
                {
                    pnlNoData.Visible = true;
                    return;
                }

                LoadAppointmentDetail(lichHenId);
            }
        }

        private void LoadAppointmentDetail(int lichHenId)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // ✅ SỬA THEO DB: thoi_gian → ngay_hen + gio_hen
                    string sql = @"
                        SELECT 
                            lh.id, lh.ma_lich_hen, lh.ngay_hen, lh.gio_hen, lh.trang_thai, lh.updated_at,
                            ISNULL(kh.ho_va_ten, N'Khách vãng lai') AS ten_khach_hang,
                            ISNULL(kh.so_dien_thoai, N'Chưa có') AS so_dien_thoai,
                            ISNULL(kh.ma_khach_hang, 'N/A') AS ma_khach_hang,
                            ISNULL(ns.ho_va_ten, N'Chưa phân công') AS ten_nhan_su,
                            ISNULL(STRING_AGG(CAST(COALESCE(dv.ten_dich_vu, gd.ten_goi) AS NVARCHAR(MAX)), N', '), 
                                   N'Chưa chọn dịch vụ') AS dich_vu
                        FROM lich_hen lh
                        LEFT JOIN khach_hang kh ON lh.khach_hang_id = kh.id
                        LEFT JOIN lich_hen_chi_tiet lhct ON lh.id = lhct.lich_hen_id
                        LEFT JOIN dich_vu dv ON lhct.dich_vu_id = dv.id
                        LEFT JOIN goi_dich_vu gd ON lhct.goi_dich_vu_id = gd.id
                        LEFT JOIN nhan_su ns ON lh.nhan_su_id = ns.id
                        WHERE lh.id = @id
                        GROUP BY 
                            lh.id, lh.ma_lich_hen, lh.ngay_hen, lh.gio_hen, lh.trang_thai, lh.updated_at,
                            kh.ho_va_ten, kh.so_dien_thoai, kh.ma_khach_hang, ns.ho_va_ten";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = lichHenId;
                        conn.Open();

                        var reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            lblThoiGian.InnerText = $"{Convert.ToDateTime(reader["ngay_hen"]).ToString("dd/MM/yyyy")} - {reader["gio_hen"]}";
                            lblKhachHang.InnerText = reader["ten_khach_hang"].ToString();
                            lblSoDienThoai.InnerText = reader["so_dien_thoai"].ToString();
                            lblDichVu.InnerText = reader["dich_vu"].ToString();
                            lblNhanVien.InnerText = reader["ten_nhan_su"].ToString();

                            string trangThai = reader["trang_thai"]?.ToString().Trim() ?? "";
                            lblTrangThai.InnerText = trangThai;
                            lblTrangThai.Attributes["class"] = $"status-badge status-{GetStatusClass(trangThai)}";

                            System.Diagnostics.Debug.WriteLine($"✅ Load ID={lichHenId}, Status='{trangThai}'");

                            pnlDetail.Visible = true;
                        }
                        else
                        {
                            pnlNoData.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("❌ Lỗi LoadAppointmentDetail: " + ex.Message);
                pnlNoData.Visible = true;
            }
        }

        private string GetStatusClass(string trangThai)
        {
            switch (trangThai?.Trim())
            {
                case "Chờ xác nhận": return "cho";
                case "Đã xác nhận": return "xac";
                case "Đang thực hiện": return "dang";
                case "Hoàn thành": return "hoan";
                case "Hủy": return "huy";
                case "Không đến": return "huy";
                default: return "cho";
            }
        }

        protected void btnCheckin_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            if (int.TryParse(id, out int lichHenId))
            {
                UpdateStatus(lichHenId, "Đang thực hiện");
                ClientScript.RegisterStartupScript(this.GetType(), "success",
                    $"alert('✅ Check-in thành công!'); window.location='admin_appointment.aspx';", true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            if (int.TryParse(id, out int lichHenId))
            {
                UpdateStatus(lichHenId, "Hủy");
                ClientScript.RegisterStartupScript(this.GetType(), "success",
                    $"alert('✅ Hủy lịch hẹn thành công!'); window.location='admin_appointment.aspx';", true);
            }
        }

        private void UpdateStatus(int lichHenId, string trangThaiMoi)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // ✅ SỬA: updated_at thay vì thoi_gian_cap_nhat
                    string sql = @"
                        UPDATE lich_hen 
                        SET trang_thai = @trangThaiMoi,
                            updated_at = GETDATE()
                        WHERE id = @id";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add("@trangThaiMoi", SqlDbType.NVarChar, 50).Value = trangThaiMoi;
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = lichHenId;
                        conn.Open();

                        int rowsAffected = cmd.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine($"🔄 UPDATE ID={lichHenId}: {rowsAffected} rows, Status='{trangThaiMoi}'");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("❌ Lỗi UpdateStatus: " + ex.Message);
            }
        }
    }
}