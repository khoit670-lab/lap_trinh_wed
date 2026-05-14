using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_customer : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCustomers();
            }
        }

        private void LoadCustomers(string searchTerm = "")
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Query lấy thông tin khách hàng kèm thống kê chi tiêu và số lần hủy
                    string sql = @"
                        SELECT 
                            kh.id, 
                            kh.ho_va_ten, 
                            kh.so_dien_thoai,
                            ISNULL((SELECT SUM(tong_tien) FROM lich_hen WHERE khach_hang_id = kh.id AND trang_thai = N'Hoàn thành'), 0) as tong_chi_tieu,
                            (SELECT COUNT(*) FROM lich_hen WHERE khach_hang_id = kh.id AND trang_thai = N'Hủy') as so_lan_huy
                        FROM khach_hang kh
                        WHERE (@search = '' OR kh.ho_va_ten LIKE @search OR kh.so_dien_thoai LIKE @search)
                        ORDER BY tong_chi_tieu DESC";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@search", "%" + searchTerm + "%");
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
                Response.Write("<script>alert('Lỗi: " + ex.Message + "');</script>");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadCustomers(txtSearch.Text.Trim());
        }

        // Helper phân hạng khách hàng dựa trên chi tiêu
        protected string GetRankName(object spend)
        {
            decimal s = Convert.ToDecimal(spend);
            if (s >= 50000000) return "Kim cương";
            if (s >= 10000000) return "Vàng";
            if (s >= 5000000) return "Bạc";
            return "Đồng";
        }

        protected string GetRankClass(object spend)
        {
            decimal s = Convert.ToDecimal(spend);
            if (s >= 10000000) return "rank-badge rank-gold";
            if (s >= 5000000) return "rank-badge rank-silver";
            return "rank-badge rank-bronze";
        }
    }
}