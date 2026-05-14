using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    public partial class profile : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        // ── Biến bind lên .aspx bằng <%= ... %> ──────────────────
        protected string userGreeting = "";
        protected string tenKhachHang = "Khách hàng";
        protected string sdtEmail = "";
        protected string hangThanhVien = "Đồng";
        protected int diemHienTai = 0;
        protected int diemLenHangTiep = 500;
        protected string tenHangTiep = "Bạc";
        protected int phanTramTienTrinh = 0;
        protected string mauHang = "#cd7f32";

        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Bắt buộc đăng nhập ───────────────────────────────
            if (Session["KhachHangId"] == null)
            {
                Response.Redirect("login.aspx?redirect=profile.aspx");
                return;
            }

            if (Session["HoVaTen"] != null)
                userGreeting = "Xin chào, " + Session["HoVaTen"].ToString();

            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Session["KhachHangId"]);
                LoadThongTinKhach(id);
                LoadLichHenSapToi(id);
                LoadLichSuDichVu(id);
                LoadVoucherUuDai(id);
            }
        }

        // ─────────────────────────────────────────────────────────
        // 1. THÔNG TIN KHÁCH HÀNG + HẠNG + ĐIỂM
        // ─────────────────────────────────────────────────────────
        private void LoadThongTinKhach(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT ho_va_ten, so_dien_thoai, email,
                               hang_khach_hang, diem_tich_luy, ghi_chu
                        FROM   khach_hang
                        WHERE  id = @id AND trang_thai = 1", conn);
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    using (var r = cmd.ExecuteReader())
                    {
                        if (!r.Read()) return;

                        tenKhachHang = r["ho_va_ten"].ToString();
                        hangThanhVien = r["hang_khach_hang"].ToString();
                        diemHienTai = Convert.ToInt32(r["diem_tich_luy"]);

                        string sdt = r["so_dien_thoai"].ToString();
                        string email = r.IsDBNull(r.GetOrdinal("email"))
                                       ? "" : r["email"].ToString();
                        sdtEmail = string.IsNullOrEmpty(email)
                                   ? sdt : sdt + " - " + email;
                    }
                }

                // ── Tính tiến trình lên hạng tiếp theo ───────────
                switch (hangThanhVien)
                {
                    case "Đồng":
                        tenHangTiep = "Bạc"; diemLenHangTiep = 500; mauHang = "#cd7f32";
                        phanTramTienTrinh = Math.Min(100, diemHienTai * 100 / 500);
                        break;
                    case "Bạc":
                        tenHangTiep = "Vàng"; diemLenHangTiep = 2000; mauHang = "#aaa9ad";
                        phanTramTienTrinh = Math.Min(100, (diemHienTai - 500) * 100 / (2000 - 500));
                        break;
                    case "Vàng":
                        tenHangTiep = "Kim Cương"; diemLenHangTiep = 5000; mauHang = "#ffb400";
                        phanTramTienTrinh = Math.Min(100, (diemHienTai - 2000) * 100 / (5000 - 2000));
                        break;
                    default: // Kim Cương — đỉnh cao
                        tenHangTiep = "Kim Cương"; diemLenHangTiep = diemHienTai;
                        mauHang = "#50c8f4"; phanTramTienTrinh = 100;
                        break;
                }

                if (ltrName != null) ltrName.Text = tenKhachHang;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadThongTinKhach: " + ex.Message);
            }
        }

        // ─────────────────────────────────────────────────────────
        // 2. LỊCH HẸN SẮP TỚI
        // ─────────────────────────────────────────────────────────
        private void LoadLichHenSapToi(int khachId)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Nới lỏng điều kiện: Chỉ cần không phải 'Hoàn thành' và 'Hủy' là hiện lên
                    var cmd = new SqlCommand(@"
                SELECT lh.id, lh.ma_lich_hen, lh.ngay_hen, lh.gio_hen, lh.trang_thai,
                       STRING_AGG(dv.ten_dich_vu, N', ') AS ten_dich_vu,
                       ns.ho_va_ten AS ten_nhan_su
                FROM lich_hen lh
                LEFT JOIN lich_hen_chi_tiet lhct ON lhct.lich_hen_id = lh.id
                LEFT JOIN dich_vu dv ON lhct.dich_vu_id = dv.id
                LEFT JOIN nhan_su ns ON lh.nhan_su_id = ns.id
                WHERE lh.khach_hang_id = @id 
                  AND lh.trang_thai NOT IN (N'Hoàn thành', N'Hủy')
                GROUP BY lh.id, lh.ma_lich_hen, lh.ngay_hen, lh.gio_hen, lh.trang_thai, ns.ho_va_ten
                ORDER BY lh.ngay_hen ASC", conn);

                    cmd.Parameters.AddWithValue("@id", khachId);
                    conn.Open();
                    var da = new SqlDataAdapter(cmd);
                    var dt = new DataTable();
                    da.Fill(dt);

                    rptLichHenSapToi.DataSource = dt;
                    rptLichHenSapToi.DataBind();
                    pnlKhongCoLich.Visible = (dt.Rows.Count == 0);
                }
            }
            catch (Exception ex)
            {
                // Log lỗi để kiểm tra nếu STRING_AGG không chạy
                System.Diagnostics.Debug.WriteLine("Lỗi Profile: " + ex.Message);
            }
        }

        // ─────────────────────────────────────────────────────────
        // 3. LỊCH SỬ DỊCH VỤ ĐÃ HOÀN THÀNH
        // ─────────────────────────────────────────────────────────
        private void LoadLichSuDichVu(int khachId)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT TOP 10
                            lh.ngay_hen,
                            STRING_AGG(dv.ten_dich_vu, N', ') AS ten_dich_vu,
                            SUM(lhct.thanh_tien)              AS tong_tien,
                            ns.ho_va_ten                       AS ten_nhan_su,
                            MIN(lhct.dich_vu_id)              AS first_dich_vu_id
                        FROM lich_hen lh
                        LEFT JOIN lich_hen_chi_tiet lhct ON lhct.lich_hen_id = lh.id
                        LEFT JOIN dich_vu dv             ON lhct.dich_vu_id  = dv.id
                        LEFT JOIN nhan_su ns             ON lh.nhan_su_id    = ns.id
                        WHERE lh.khach_hang_id = @id
                          AND lh.trang_thai   = N'Hoàn thành'
                        GROUP BY lh.id, lh.ngay_hen, ns.ho_va_ten
                        ORDER BY lh.ngay_hen DESC", conn);

                    cmd.Parameters.AddWithValue("@id", khachId);
                    conn.Open();

                    var da = new SqlDataAdapter(cmd);
                    var dt = new DataTable();
                    da.Fill(dt);

                    if (rptLichSu != null)
                    {
                        rptLichSu.DataSource = dt;
                        rptLichSu.DataBind();
                    }

                    if (pnlKhongCoLichSu != null)
                        pnlKhongCoLichSu.Visible = (dt.Rows.Count == 0);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadLichSuDichVu: " + ex.Message);
            }
        }

        // ─────────────────────────────────────────────────────────
        // 4. VOUCHER ƯU ĐÃI CÒN HIỆU LỰC
        // ─────────────────────────────────────────────────────────
        private void LoadVoucherUuDai(int khachId)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT TOP 4
                            ma_voucher, ten_voucher,
                            loai_giam, gia_tri_giam, ngay_het_han
                        FROM voucher
                        WHERE trang_thai = 1
                          AND CAST(GETDATE() AS DATE) BETWEEN ngay_bat_dau AND ngay_het_han
                          AND so_luong_da_dung < so_luong_phat
                        ORDER BY gia_tri_giam DESC", conn);

                    conn.Open();
                    var da = new SqlDataAdapter(cmd);
                    var dt = new DataTable();
                    da.Fill(dt);

                    if (rptUuDai != null)
                    {
                        rptUuDai.DataSource = dt;
                        rptUuDai.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadVoucherUuDai: " + ex.Message);
            }
        }

        // ─────────────────────────────────────────────────────────
        // SỰ KIỆN: HỦY LỊCH
        // ─────────────────────────────────────────────────────────
        protected void rptLichHenSapToi_ItemCommand(object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "HuyLich") return;

            int lichHenId = Convert.ToInt32(e.CommandArgument);
            int khachId = Convert.ToInt32(Session["KhachHangId"]);

            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    conn.Open();

                    // Chỉ cho hủy khi còn hơn 2 giờ
                    var cmdCheck = new SqlCommand(@"
                        SELECT DATEDIFF(MINUTE, GETDATE(),
                               CAST(ngay_hen AS DATETIME) + CAST(gio_hen AS DATETIME))
                        FROM lich_hen
                        WHERE id = @id AND khach_hang_id = @kh", conn);
                    cmdCheck.Parameters.AddWithValue("@id", lichHenId);
                    cmdCheck.Parameters.AddWithValue("@kh", khachId);

                    int phutConLai = Convert.ToInt32(cmdCheck.ExecuteScalar());
                    if (phutConLai < 120)
                    {
                        ShowThongBao("Chỉ có thể hủy lịch trước ít nhất 2 giờ.", false);
                        return;
                    }

                    var cmdHuy = new SqlCommand(@"
                        UPDATE lich_hen
                        SET trang_thai = N'Hủy',
                            ly_do_huy  = N'Khách hàng hủy qua website'
                        WHERE id = @id AND khach_hang_id = @kh", conn);
                    cmdHuy.Parameters.AddWithValue("@id", lichHenId);
                    cmdHuy.Parameters.AddWithValue("@kh", khachId);
                    cmdHuy.ExecuteNonQuery();
                }

                ShowThongBao("Hủy lịch hẹn thành công.", true);
                LoadLichHenSapToi(Convert.ToInt32(Session["KhachHangId"]));
            }
            catch (Exception ex)
            {
                ShowThongBao("Lỗi: " + ex.Message, false);
            }
        }

        // ─────────────────────────────────────────────────────────
        // SỰ KIỆN: ĐẶT LẠI TỪ LỊCH SỬ
        // ─────────────────────────────────────────────────────────
        protected void rptLichSu_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "DatLai") return;
            Response.Redirect("booking.aspx?dichVuId=" + e.CommandArgument);
        }

        // ─────────────────────────────────────────────────────────
        // SỰ KIỆN: ĐĂNG XUẤT
        // ─────────────────────────────────────────────────────────
        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("login.aspx");
        }

        // ─────────────────────────────────────────────────────────
        // HELPERS DÙNG TRONG REPEATER
        // ─────────────────────────────────────────────────────────
        protected string NgayHen(object ngay)
            => Convert.ToDateTime(ngay).Day.ToString();

        protected string ThangHen(object ngay)
            => "Tháng " + Convert.ToDateTime(ngay).Month;

        protected string NamHen(object ngay)
            => Convert.ToDateTime(ngay).Year.ToString();

        protected string GioHen(object gio)
        {
            if (gio == null || gio == DBNull.Value) return "";
            return TimeSpan.Parse(gio.ToString()).ToString(@"hh\:mm");
        }

        protected string NgayHienThi(object ngay)
            => Convert.ToDateTime(ngay).ToString("dd/MM/yyyy");

        protected string FormatTien(object tien)
            => string.Format("{0:N0} đ", Convert.ToDecimal(tien));

        protected string FormatVoucher(object loai, object gia)
        {
            if (loai == null || gia == null) return "";
            return loai.ToString() == "Phần trăm"
                ? "Giảm " + Convert.ToDecimal(gia).ToString("0") + "% cho lần đặt lịch tiếp theo"
                : "Giảm " + Convert.ToDecimal(gia).ToString("N0") + "đ cho đơn từ cửa hàng";
        }

        protected string MauTrangThai(object tt)
        {
            switch (tt?.ToString())
            {
                case "Chờ xác nhận": return "background:#fff3cd;color:#856404;";
                case "Đã xác nhận": return "background:#d1e7dd;color:#0a3622;";
                case "Đang thực hiện": return "background:#cfe2ff;color:#084298;";
                default: return "background:#f8f9fa;color:#6c757d;";
            }
        }

        private void ShowThongBao(string msg, bool isSuccess)
        {
            string js = $"alert('{msg.Replace("'", "\\'")}');";
            Page.ClientScript.RegisterStartupScript(GetType(), "tb", js, true);
        }
    }
}