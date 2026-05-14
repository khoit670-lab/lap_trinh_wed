using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace lap_trinh_wed.client
{
    public partial class Default : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
        protected string userGreeting = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra đăng nhập để hiện lời chào
            if (Session["HoVaTen"] != null)
                userGreeting = "Xin chào, " + Session["HoVaTen"].ToString();
            else
                userGreeting = "Khách";

            if (!IsPostBack)
            {
                // ✅ LOAD DỊCH VỤ NỔI BẬT TỪ DB
                LoadDichVuNoiBat();
            }
        }

        private void LoadDichVuNoiBat()
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Lấy 4 dịch vụ nổi bật (có thể thêm cột "noi_bat = 1" trong DB sau)
                    string sql = @"
                        SELECT TOP 4 
                            id, ten_dich_vu, mo_ta, hinh_anh, gia_goc, gia_khuyen_mai, thoi_gian
                        FROM dich_vu 
                        WHERE trang_thai = 1 
                        ORDER BY id DESC";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        rptBottomServices.DataSource = dt;
                        rptBottomServices.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi LoadDichVuNoiBat: " + ex.Message);
                // Nếu lỗi thì Repeater sẽ trống, không crash
            }
        }
    }
}