using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_customer : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Kiểm tra quyền ────────────────────────────────────
            if (Session["VaiTro"] == null || !(bool)(Session["IsAdmin"] ?? false))
            {
                Response.Redirect("../client/Default.aspx?noaccess=1");
                return;
            }
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }
            string role = Session["VaiTro"].ToString().ToLower();
            if (role != "admin" && role != "quan_ly" && role != "le_tan" && role != "nhan_vien")
            {
                Session.Abandon();
                Response.Redirect("../client/login.aspx");
                return;
            }

            // ── Hiển thị tên đăng nhập ────────────────────────────
            lblUserRole.InnerText = Session["HoVaTen"]?.ToString() ?? "Quản trị viên";

            if (!IsPostBack)
                LoadCustomers();
        }

        // ── Load danh sách khách hàng ─────────────────────────────
        private void LoadCustomers(string search = "")
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string sql = @"
                        SELECT
                            kh.id,
                            kh.ho_va_ten,
                            kh.so_dien_thoai,
                            kh.hang_khach_hang,
                            kh.diem_tich_luy,
                            ISNULL((
                                SELECT SUM(tong_tien)
                                FROM   lich_hen
                                WHERE  khach_hang_id = kh.id
                                  AND  trang_thai    = N'Hoàn thành'
                            ), 0) AS tong_chi_tieu,
                            (
                                SELECT COUNT(*)
                                FROM   lich_hen
                                WHERE  khach_hang_id = kh.id
                                  AND  trang_thai    = N'Hủy'
                            )     AS so_lan_huy
                        FROM khach_hang kh
                        WHERE kh.trang_thai = 1
                          AND (@search = ''
                               OR kh.ho_va_ten    LIKE @search
                               OR kh.so_dien_thoai LIKE @search
                               OR kh.ma_khach_hang LIKE @search)
                        ORDER BY tong_chi_tieu DESC";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add("@search", SqlDbType.NVarChar).Value =
                            string.IsNullOrEmpty(search) ? "" : "%" + search + "%";

                        conn.Open();
                        var da = new SqlDataAdapter(cmd);
                        var dt = new DataTable();
                        da.Fill(dt);

                        rptCustomers.DataSource = dt;
                        rptCustomers.DataBind();
                        pnlNoData.Visible = dt.Rows.Count == 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadCustomers Error: " + ex.Message);
                pnlNoData.Visible = true;
            }
        }

        // ── Sự kiện: nút Tìm kiếm ────────────────────────────────
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadCustomers(txtSearch.Text.Trim());
        }

        // ── Helpers: hạng từ bảng DB ──────────────────────────────
        // Dùng cột hang_khach_hang thay vì tính lại từ chi tiêu
        protected string GetRankName(object hang)
            => hang?.ToString() ?? "Đồng";

        protected string GetRankClass(object hang)
        {
            switch (hang?.ToString())
            {
                case "Kim Cương": return "rank-badge rank-diamond";
                case "Vàng": return "rank-badge rank-gold";
                case "Bạc": return "rank-badge rank-silver";
                default: return "rank-badge rank-bronze";
            }
        }

        protected string FormatTien(object tien)
            => string.Format("{0:N0}đ", Convert.ToDecimal(tien));
    }
}