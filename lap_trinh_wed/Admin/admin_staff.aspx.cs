using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_staff : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Kiểm tra quyền ────────────────────────────────────
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }
            string role = Session["VaiTro"].ToString().ToLower();
            if (role != "admin" && role != "quan_ly")
            {
                Session.Abandon();
                Response.Redirect("../client/login.aspx");
                return;
            }

            if (!IsPostBack)
                LoadStaff();
        }

        // ── Load danh sách nhân sự từ bảng nhan_su ───────────────
        private void LoadStaff(string search = "")
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string sql = @"
                        SELECT
                            id,
                            ho_va_ten   AS ho_ten,
                            so_dien_thoai AS sdt,
                            chuc_vu,
                            ISNULL(ca_lam_viec, N'Chưa phân ca') AS ca_lam,
                            trang_thai
                        FROM nhan_su
                        WHERE (@search = ''
                               OR ho_va_ten     LIKE @search
                               OR so_dien_thoai LIKE @search
                               OR chuc_vu       LIKE @search)
                        ORDER BY ho_va_ten";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add("@search", SqlDbType.NVarChar).Value =
                            string.IsNullOrEmpty(search) ? "" : "%" + search + "%";

                        conn.Open();
                        var da = new SqlDataAdapter(cmd);
                        var dt = new DataTable();
                        da.Fill(dt);

                        rptStaff.DataSource = dt;
                        rptStaff.DataBind();

                        // Hiển thị/ẩn panel không có dữ liệu
                        pnlNoData.Visible = dt.Rows.Count == 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadStaff Error: " + ex.Message);
                pnlNoData.Visible = true;
            }
        }

        // ── Sự kiện: nút Tìm kiếm ────────────────────────────────
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadStaff(txtSearch.Text.Trim());
        }

        // ── Sự kiện: TextBox tìm kiếm (AutoPostBack) ────────────
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadStaff(txtSearch.Text.Trim());
        }

        // ── ✅ THÊM MỚI: CSS class cho trạng thái (dùng cho frontend mới)
        protected string GetStatusClass(object status)
        {
            string statusStr = status?.ToString() ?? "";
            return statusStr.Contains("Đang") || statusStr.Contains("làm")
                ? "status-active"
                : "status-inactive";
        }

        // ── Giữ lại method cũ nếu cần (tương thích code cũ) ─────
        protected string MauTrangThai(object tt)
        {
            switch (tt?.ToString())
            {
                case "Đang làm": return "color:#0a3622;background:#d1e7dd;padding:4px 12px;border-radius:15px;font-size:13px;font-weight:600;";
                case "Tạm nghỉ": return "color:#856404;background:#fff3cd;padding:4px 12px;border-radius:15px;font-size:13px;font-weight:600;";
                case "Nghỉ việc": return "color:#842029;background:#f8d7da;padding:4px 12px;border-radius:15px;font-size:13px;font-weight:600;";
                default: return "color:#666;background:#f0f0f0;padding:4px 12px;border-radius:15px;font-size:13px;font-weight:600;";
            }
        }
    }
}