using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.admin
{
    public partial class admin_service : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra quyền
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
                LoadServices();
        }

        private void LoadServices(string search = "")
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string sql = @"
                        SELECT
                            dv.id,
                            dv.ten_dich_vu AS TenDichVu,
                            ISNULL(dm.ten_danh_muc, N'Chưa phân loại') AS Loai,
                            CAST(dv.thoi_gian AS NVARCHAR) + N' phút' AS ThoiGian,
                            FORMAT(ISNULL(dv.gia_khuyen_mai, dv.gia_goc), N'N0') + N' đ' AS GiaTien,
                            dv.hinh_anh AS HinhAnh
                        FROM dich_vu dv
                        LEFT JOIN danh_muc_dich_vu dm ON dv.danh_muc_id = dm.id
                        WHERE (@search = ''
                               OR dv.ten_dich_vu LIKE @search
                               OR dm.ten_danh_muc LIKE @search)
                        ORDER BY dv.danh_muc_id, dv.ten_dich_vu";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add("@search", SqlDbType.NVarChar).Value =
                            string.IsNullOrEmpty(search) ? "" : "%" + search + "%";

                        conn.Open();
                        var da = new SqlDataAdapter(cmd);
                        var dt = new DataTable();
                        da.Fill(dt);

                        rptServices.DataSource = dt;
                        rptServices.DataBind();

                        pnlNoData.Visible = dt.Rows.Count == 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadServices Error: " + ex.Message);
                pnlNoData.Visible = true;
            }
        }

        // Tìm kiếm
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadServices(txtSearch.Text.Trim());
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadServices(txtSearch.Text.Trim());
        }

        // Xóa dịch vụ
        protected void rptServices_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int dichVuId = Convert.ToInt32(e.CommandArgument);
                try
                {
                    using (var conn = new SqlConnection(_conn))
                    {
                        var cmd = new SqlCommand(
                            "UPDATE dich_vu SET trang_thai = 0, updated_at = GETDATE() WHERE id = @id", conn);
                        cmd.Parameters.AddWithValue("@id", dichVuId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    LoadServices(txtSearch.Text.Trim());
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Delete Error: " + ex.Message);
                }
            }
        }

        // Helper ảnh
        protected string HinhAnhUrl(object hinhAnh)
        {
            string tenFile = hinhAnh?.ToString();
            if (string.IsNullOrEmpty(tenFile))
                return "";
            return "~/assets/anh/" + tenFile;
        }
    }
}