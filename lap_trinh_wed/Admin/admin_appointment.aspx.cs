using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.admin
{
    public partial class appointment : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"]?.ConnectionString
                                     ?? throw new Exception("Không tìm thấy connection string LilySpaDB");

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetNoStore();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoServerCaching();
            if (Session["VaiTro"] == null || !(bool)(Session["IsAdmin"] ?? false))
            {
                Response.Redirect("../client/Default.aspx?noaccess=1");
                return;
            }
            

            string role = Session["VaiTro"].ToString().ToLower();
            lblUserGreeting.InnerText = Session["HoVaTen"]?.ToString() ?? "Quản trị viên";

            if (role != "admin" && role != "quan_ly" && role != "le_tan" && role != "nhan_vien")
            {
                Session.Abandon();
                Response.Redirect("../client/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadAppointments("Tất cả");
            }
        }

        private void LoadAppointments(string trangThai)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // ✅ QUERY TỐI ƯU - HIỂN THỊ DỊCH VỤ ĐÚNG
                    string sql = @"
                        SELECT TOP 100
                            lh.id,
                            lh.ma_lich_hen,
                            lh.ngay_hen,
                            lh.gio_hen,
                            lh.updated_at,
                            ISNULL(kh.ma_khach_hang, 'N/A') AS ma_khach_hang,
                            ISNULL(kh.ho_va_ten, N'Khách vãng lai') AS ten_khach_hang,
                            lh.trang_thai,
                            ISNULL(ns.ho_va_ten, N'Chưa phân công') AS ten_nhan_su,
                            -- ✅ DỊCH VỤ: ưu tiên dv.ten_dich_vu > gd.ten_goi
                            ISNULL(
                                STUFF((
                                    SELECT ', ' + COALESCE(dv.ten_dich_vu, gd.ten_goi)
                                    FROM lich_hen_chi_tiet lhct2
                                    LEFT JOIN dich_vu dv ON lhct2.dich_vu_id = dv.id
                                    LEFT JOIN goi_dich_vu gd ON lhct2.goi_dich_vu_id = gd.id
                                    WHERE lhct2.lich_hen_id = lh.id
                                    FOR XML PATH('')
                                ), 1, 2, ''), 
                                N'Chưa chọn dịch vụ'
                            ) AS dich_vu
                        FROM lich_hen lh
                        LEFT JOIN khach_hang kh ON lh.khach_hang_id = kh.id
                        LEFT JOIN nhan_su ns ON lh.nhan_su_id = ns.id
                        WHERE (@trangThai = N'Tất cả' OR lh.trang_thai = @trangThai)
                        ORDER BY lh.ngay_hen DESC, lh.gio_hen ASC, lh.id DESC";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@trangThai", trangThai ?? "Tất cả");
                        cmd.CommandTimeout = 30;
                        conn.Open();

                        var da = new SqlDataAdapter(cmd);
                        var dt = new DataTable();
                        da.Fill(dt);

                        System.Diagnostics.Debug.WriteLine($"✅ Load {dt.Rows.Count} lịch hẹn | Filter: '{trangThai}'");

                        rptAppointments.DataSource = dt.Rows.Count > 0 ? dt : null;
                        rptAppointments.DataBind();
                        pnlNoData.Visible = dt.Rows.Count == 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("❌ Lỗi LoadAppointments: " + ex.Message);
                pnlNoData.Visible = true;
            }
        }

        // ✅ GetStatusClass - ĐÃ CÓ "Đang thực hiện" -> màu tím
        protected string GetStatusClass(string trangThai)
        {
            switch (trangThai?.Trim())
            {
                case "Chờ xác nhận": return "cho";
                case "Đã xác nhận": return "xac";
                case "Đang thực hiện": return "dang";  // ✅ MÀU TÍM #8b5cf6
                case "Hoàn thành": return "hoan";
                case "Hủy": return "huy";
                case "Không đến": return "huy";
                default: return "cho";
            }
        }

        protected void rptAppointments_ItemDataBound(object sender, RepeaterItemEventArgs e) { }

        // Filter buttons
        protected void btnTatCa_Click(object sender, EventArgs e)
        {
            ResetFilterButtons();
            btnTatCa.CssClass = "btn-filter active";
            LoadAppointments("Tất cả");
        }

        protected void btnChoXacNhan_Click(object sender, EventArgs e)
        {
            ResetFilterButtons();
            btnChoXacNhan.CssClass = "btn-filter active";
            LoadAppointments("Chờ xác nhận");
        }

        protected void btnDaXacNhan_Click(object sender, EventArgs e)
        {
            ResetFilterButtons();
            btnDaXacNhan.CssClass = "btn-filter active";
            LoadAppointments("Đã xác nhận");
        }

        protected void btnHoanThanh_Click(object sender, EventArgs e)
        {
            ResetFilterButtons();
            btnHoanThanh.CssClass = "btn-filter active";
            LoadAppointments("Hoàn thành");
        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            ResetFilterButtons();
            btnHuy.CssClass = "btn-filter active";
            LoadAppointments("Hủy");
        }

        private void ResetFilterButtons()
        {
            btnTatCa.CssClass = "btn-filter";
            btnChoXacNhan.CssClass = "btn-filter";
            btnDaXacNhan.CssClass = "btn-filter";
            btnHoanThanh.CssClass = "btn-filter";
            btnHuy.CssClass = "btn-filter";
        }
    }
}