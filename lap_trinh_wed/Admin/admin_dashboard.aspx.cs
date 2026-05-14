using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace lap_trinh_wed.admin
{
    public partial class dashboard : System.Web.UI.Page
    {
        // Khai báo các biến public để file .aspx gọi hiển thị
        public string userGreeting = "Admin";
        public string doanhThuHomNay = "0 đ";
        public string lichHenHomNay = "0";
        public string khachMoiTrongThang = "0";
        public string tongKhachHang = "0";
        public string tyLeHuy = "0%";

        // Lấy chuỗi kết nối từ Web.config (LilySpaDB)
        private string connectionString = ConfigurationManager.ConnectionStrings["LilySpaDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Kiểm tra Session đăng nhập
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            // 2. Lấy tên hiển thị từ Session
            userGreeting = Session["HoVaTen"]?.ToString() ?? "Quản trị viên";

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
                    // SQL này lấy chính xác 3 trạng thái để tính toán
                    string query = @"
                DECLARE @Today DATE = CAST(GETDATE() AS DATE);

                SELECT 
                    -- 1. Tổng khách hàng
                    (SELECT COUNT(*) FROM khach_hang WHERE trang_thai = 1) as TotalKH,

                    -- 2. Khách mới trong tháng
                    (SELECT COUNT(*) FROM khach_hang 
                     WHERE MONTH(created_at) = MONTH(GETDATE()) 
                     AND YEAR(created_at) = YEAR(GETDATE()) AND trang_thai = 1) as NewKH,

                    -- 3. Doanh thu hôm nay (Chỉ tính những ca đã thu tiền/Hoàn thành)
                    ISNULL((SELECT SUM(CAST(tong_tien AS DECIMAL)) FROM lich_hen 
                     WHERE CAST(ngay_hen AS DATE) = @Today AND trang_thai = N'Hoàn thành'), 0) as Revenue,

                    -- 4. LỊCH HẸN HÔM NAY: Chỉ đếm những ca ĐANG CHỜ hoặc ĐANG LÀM
                    -- (Nếu bạn hủy hết, chỗ này sẽ về 0 ngay lập tức)
                    (SELECT COUNT(*) FROM lich_hen 
                     WHERE CAST(ngay_hen AS DATE) = @Today 
                     AND trang_thai NOT IN (N'Hoàn thành', N'Hủy')) as ActiveToday,

                    -- 5. TỔNG TẤT CẢ LỊCH PHÁT SINH TRONG NGÀY (Dùng làm mẫu số tính %)
                    (SELECT COUNT(*) FROM lich_hen 
                     WHERE CAST(ngay_hen AS DATE) = @Today) as TotalAllToday,

                    -- 6. SỐ LỊCH ĐÃ HỦY HÔM NAY
                    (SELECT COUNT(*) FROM lich_hen 
                     WHERE CAST(ngay_hen AS DATE) = @Today AND trang_thai = N'Hủy') as CanceledToday";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                tongKhachHang = rdr["TotalKH"].ToString();
                                khachMoiTrongThang = rdr["NewKH"].ToString();

                                decimal revenue = Convert.ToDecimal(rdr["Revenue"]);
                                doanhThuHomNay = string.Format("{0:N0} đ", revenue);

                                // CẬP NHẬT SỐ LỊCH ĐANG HOẠT ĐỘNG
                                lichHenHomNay = rdr["ActiveToday"].ToString();

                                // CẬP NHẬT TỶ LỆ HỦY
                                int totalAll = Convert.ToInt32(rdr["TotalAllToday"]);
                                int canceled = Convert.ToInt32(rdr["CanceledToday"]);

                                if (totalAll > 0)
                                {
                                    // Công thức chuẩn: (Hủy / Tổng) * 100
                                    double rate = (double)canceled / totalAll * 100;
                                    tyLeHuy = string.Format("{0:0}%", rate);
                                }
                                else
                                {
                                    tyLeHuy = "0%";
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi Dashboard: " + ex.Message);
                tongKhachHang = "Lỗi!"; // Để bạn biết là code bị crash vào catch
            }
        }

        // Sự kiện khi nhấn nút Làm mới
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadDashboardData();
        }
    }
}