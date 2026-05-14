using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace lap_trinh_wed.admin
{
    public partial class admin_customer_detail : System.Web.UI.Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Lấy ID khách hàng từ URL (ví dụ: admin_customer_detail.aspx?id=10)
                if (Request.QueryString["id"] != null)
                {
                    int khId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadCustomerDetail(khId);
                    LoadServiceHistory(khId);
                }
            }
        }

        private void LoadCustomerDetail(int id)
        {
            using (SqlConnection conn = new SqlConnection(_conn))
            {
                string sql = "SELECT * FROM khach_hang WHERE id = @id";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    ltrFullName.Text = rdr["ho_va_ten"].ToString();
                    ltrPhone.Text = rdr["so_dien_thoai"].ToString();
                    ltrPoints.Text = rdr["diem_tich_luy"].ToString();
                    ltrHealthInfo.Text = rdr["ghi_chu"] != DBNull.Value ? rdr["ghi_chu"].ToString() : "Chưa có thông tin";

                    // Logic phân hạng dựa trên điểm hoặc chi tiêu (Ví dụ)
                    int points = Convert.ToInt32(rdr["diem_tich_luy"]);
                    if (points > 1000) ltrRank.Text = "Vàng";
                    else if (points > 500) ltrRank.Text = "Bạc";
                    else ltrRank.Text = "Đồng";

                    if (rdr["avatar"] != DBNull.Value)
                        imgAvatar.ImageUrl = "../assets/anh/" + rdr["avatar"].ToString();
                }
            }
        }

        private void LoadServiceHistory(int id)
        {
            using (SqlConnection conn = new SqlConnection(_conn))
            {
                // Query lấy lịch sử dịch vụ đã hoàn thành
                string sql = @"
                    SELECT lh.ngay_hen, lh.tong_tien, 
                    (SELECT TOP 1 dv.ten_dich_vu 
                     FROM lich_hen_chi_tiet ct 
                     JOIN dich_vu dv ON ct.dich_vu_id = dv.id 
                     WHERE ct.lich_hen_id = lh.id) as ten_dich_vu
                    FROM lich_hen lh 
                    WHERE lh.khach_hang_id = @id AND lh.trang_thai = N'Hoàn thành'
                    ORDER BY lh.ngay_hen DESC";

                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.SelectCommand.Parameters.AddWithValue("@id", id);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptHistory.DataSource = dt;
                rptHistory.DataBind();
            }
        }
    }
}