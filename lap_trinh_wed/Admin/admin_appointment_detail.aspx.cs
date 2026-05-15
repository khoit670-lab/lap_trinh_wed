using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace lap_trinh_wed.admin
{
    public partial class admin_appointment_detail : Page
    {
        private readonly string _connString = ConfigurationManager.ConnectionStrings["LilySpaDB"]?.ConnectionString
            ?? throw new Exception("❌ Không tìm thấy connection string 'LilySpaDB'");

        protected int lichHenId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Cache control
            Response.Cache.SetNoStore();
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            if (Session["VaiTro"] == null || !(bool)(Session["IsAdmin"] ?? false))
            {
                Response.Redirect("../client/Default.aspx?noaccess=1");
                return;
            }
            // ✅ Kiểm tra đăng nhập
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            // ✅ Parse ID
            if (!int.TryParse(Request.QueryString["id"], out lichHenId) || lichHenId <= 0)
            {
                ShowNoData();
                return;
            }

            if (!IsPostBack)
            {
                LoadAppointmentDetail(lichHenId);
            }
        }

        private void ShowNoData()
        {
            pnlDetail.Visible = false;
            pnlNoData.Visible = true;
        }

        private void LoadAppointmentDetail(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_connString))
                {
                    string sql = @"
                        SELECT 
                            lh.id, lh.ma_lich_hen, lh.ngay_hen, lh.gio_hen, lh.trang_thai, lh.updated_at,
                            ISNULL(kh.ho_va_ten, N'Khách vãng lai') AS ten_khach_hang,
                            ISNULL(kh.so_dien_thoai, N'Chưa có') AS so_dien_thoai,
                            ISNULL(ns.ho_va_ten, N'Chưa phân công') AS ten_nhan_su,
                            ISNULL(SUM(lhct.thanh_tien), 0) AS tong_tien,
                            STRING_AGG(COALESCE(dv.ten_dich_vu, gd.ten_goi), N', ') AS dich_vu
                        FROM lich_hen lh
                        LEFT JOIN khach_hang kh ON lh.khach_hang_id = kh.id
                        LEFT JOIN nhan_su ns ON lh.nhan_su_id = ns.id
                        LEFT JOIN lich_hen_chi_tiet lhct ON lhct.lich_hen_id = lh.id
                        LEFT JOIN dich_vu dv ON lhct.dich_vu_id = dv.id
                        LEFT JOIN goi_dich_vu gd ON lhct.goi_dich_vu_id = gd.id
                        WHERE lh.id = @id
                        GROUP BY 
                            lh.id, lh.ma_lich_hen, lh.ngay_hen, lh.gio_hen, lh.trang_thai, lh.updated_at,
                            kh.ho_va_ten, kh.so_dien_thoai, ns.ho_va_ten";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        conn.Open();

                        using (var r = cmd.ExecuteReader())
                        {
                            if (!r.Read())
                            {
                                ShowNoData();
                                return;
                            }

                            // ✅ CAST an toàn cho ngày giờ
                            DateTime ngayHen = r["ngay_hen"] != DBNull.Value
                                ? Convert.ToDateTime(r["ngay_hen"])
                                : DateTime.Now.Date;

                            string gioHen = r["gio_hen"]?.ToString() ?? "00:00";

                            // ✅ Bind tất cả controls
                            lblThoiGian.InnerText = $"{ngayHen:dd/MM/yyyy} - {gioHen}";
                            lblKhachHang.InnerText = r["ten_khach_hang"]?.ToString() ?? "Khách vãng lai";
                            lblSoDienThoai.InnerText = r["so_dien_thoai"]?.ToString() ?? "Chưa có";
                            lblDichVu.InnerText = r["dich_vu"]?.ToString() ?? "Chưa có dịch vụ";
                            lblNhanVien.InnerText = r["ten_nhan_su"]?.ToString() ?? "Chưa phân công";

                            decimal tongTien = r["tong_tien"] != DBNull.Value
                                ? Convert.ToDecimal(r["tong_tien"])
                                : 0m;
                            lblTongTien.InnerText = $"{tongTien:N0}đ";

                            string trangThai = r["trang_thai"]?.ToString()?.Trim() ?? "Chờ xác nhận";
                            lblTrangThaiText.InnerText = trangThai;  // ✅ Cho icon + text
                            lblTrangThai.Attributes["class"] = $"status-badge status-{GetStatusClass(trangThai)}";

                            string updatedAt = r["updated_at"] != DBNull.Value
                                ? Convert.ToDateTime(r["updated_at"]).ToString("dd/MM/yyyy HH:mm")
                                : "Chưa cập nhật";
                            lblUpdatedAt.InnerText = updatedAt;

                            // ✅ Ẩn nút theo trạng thái
                            HideButtonsByStatus(trangThai);

                            pnlDetail.Visible = true;
                            pnlNoData.Visible = false;

                            System.Diagnostics.Debug.WriteLine($"✅ Loaded Appointment ID={id}, Status={trangThai}");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ LoadAppointmentDetail Error ID={id}: {ex.Message}");
                ShowNoData();
            }
        }

        private void HideButtonsByStatus(string trangThai)
        {
            try
            {
                switch (trangThai?.Trim())
                {
                    case "Hoàn thành":
                    case "Hủy":
                    case "Không đến":
                        btnCheckin.Visible = btnCancel.Visible = btnComplete.Visible = false;
                        break;
                    case "Đang thực hiện":
                        btnCheckin.Visible = false;
                        btnCancel.Visible = btnComplete.Visible = true;
                        break;
                    default:
                        btnCheckin.Visible = btnCancel.Visible = true;
                        btnComplete.Visible = false;
                        break;
                }
            }
            catch { /* Ignore hide errors */ }
        }

        private string GetStatusClass(string trangThai)
        {
            if (string.IsNullOrEmpty(trangThai)) return "cho";

            string lowerStatus = trangThai.Trim().ToLowerInvariant();
            switch (lowerStatus)
            {
                case "chờ xác nhận":
                case "cho xac nhan":
                    return "cho";
                case "đã xác nhận":
                case "da xac nhan":
                    return "xac";
                case "đang thực hiện":
                case "dang thuc hien":
                    return "dang";
                case "hoàn thành":
                case "hoan thanh":
                    return "hoan";
                case "hủy":
                case "không đến":
                case "da huy":
                    return "huy";
                default:
                    return "cho";
            }
        }

        // ✅ Event handlers cho LinkButton
        protected void btnCheckin_Click(object sender, EventArgs e)
        {
            UpdateStatus("Đang thực hiện", "✅ Check-in thành công!");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            UpdateStatus("Hủy", "✅ Hủy lịch hẹn thành công!");
        }

        protected void btnComplete_Click(object sender, EventArgs e)
        {
            UpdateStatus("Hoàn thành", "✅ Hoàn thành lịch hẹn!");
        }

        private void UpdateStatus(string newStatus, string successMsg)
        {
            try
            {
                using (var conn = new SqlConnection(_connString))
                {
                    string sql = @"
                        UPDATE lich_hen 
                        SET trang_thai = @status, 
                            updated_at = GETDATE()
                        WHERE id = @id";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@status", newStatus);
                        cmd.Parameters.AddWithValue("@id", lichHenId);
                        conn.Open();

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            System.Diagnostics.Debug.WriteLine($"✅ Updated ID={lichHenId} → {newStatus}");
                            ClientScript.RegisterStartupScript(this.GetType(), "success",
                                $"alert('{successMsg}'); window.location.href='admin_appointment.aspx';", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "warning",
                                "alert('⚠️ Không tìm thấy lịch hẹn để cập nhật!');", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"❌ UpdateStatus Error: {ex.Message}");
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('❌ Lỗi cập nhật: {ex.Message.Replace("'", "\\'")}');", true);
            }
        }
    }
}