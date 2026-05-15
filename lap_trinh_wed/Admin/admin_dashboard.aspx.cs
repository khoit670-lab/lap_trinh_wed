using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace lap_trinh_wed.admin
{
    // PHẢI ĐỔI TÊN CLASS THÀNH admin_dashboard để khớp với file .aspx
    public partial class admin_dashboard : System.Web.UI.Page
    {
        public string doanhThuHomNay = "0 đ";
        public string lichHenHomNay = "0";
        public string khachMoiTrongThang = "0";
        public string tongKhachHang = "0";
        public string tyLeHuy = "0%";
        public string userGreeting = "Admin";

        private string connectionString = ConfigurationManager.ConnectionStrings["LilySpaDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra Session (Bạn có thể điều chỉnh tùy theo logic login của bạn)
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            // Set greeting message từ Session
            if (Session["HoVaTen"] != null)
            {
                userGreeting = Session["HoVaTen"].ToString();
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            if (string.IsNullOrEmpty(connectionString)) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    // SỬA LẠI: Dùng ngay_hen thay vì thoi_gian vì trong DB của bạn là ngay_hen
                    string query = @"
                        DECLARE @Today DATE = CAST(GETDATE() AS DATE);
                        SELECT 
                            (SELECT COUNT(*) FROM khach_hang) as TotalKH,
                            (SELECT COUNT(*) FROM khach_hang WHERE MONTH(created_at) = MONTH(GETDATE()) AND YEAR(created_at) = YEAR(GETDATE())) as NewKH,
                            (SELECT SUM(tong_tien) FROM lich_hen WHERE CAST(ngay_hen AS DATE) = @Today AND trang_thai = N'Hoàn thành') as RevenueToday,
                            (SELECT COUNT(*) FROM lich_hen WHERE CAST(ngay_hen AS DATE) = @Today AND trang_thai IN (N'Chờ xác nhận', N'Đã xác nhận', N'Đang thực hiện')) as LichHenHomNay,
                            (SELECT COUNT(*) FROM lich_hen WHERE CAST(ngay_hen AS DATE) = @Today) as TotalLichHenToday,
                            (SELECT COUNT(*) FROM lich_hen WHERE CAST(ngay_hen AS DATE) = @Today AND trang_thai = N'Hủy') as HuyHomNay";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                tongKhachHang = rdr["TotalKH"].ToString();
                                khachMoiTrongThang = rdr["NewKH"].ToString();

                                decimal rev = rdr["RevenueToday"] != DBNull.Value ? Convert.ToDecimal(rdr["RevenueToday"]) : 0;
                                doanhThuHomNay = string.Format("{0:N0} đ", rev);

                                lichHenHomNay = rdr["LichHenHomNay"].ToString();

                                int totalToday = Convert.ToInt32(rdr["TotalLichHenToday"]);
                                int huyToday = Convert.ToInt32(rdr["HuyHomNay"]);
                                tyLeHuy = totalToday > 0 ? string.Format("{0:0}%", (double)huyToday / totalToday * 100) : "0%";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Nếu lỗi, in ra để debug
                System.Diagnostics.Debug.WriteLine("Lỗi Dashboard: " + ex.Message);
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadDashboardData();
        }
    }
}