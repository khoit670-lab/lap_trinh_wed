using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    public partial class booking : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
        protected string userGreeting = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HoVaTen"] != null)
                userGreeting = "Xin chào, " + Session["HoVaTen"].ToString();

            if (!IsPostBack)
            {
                if (Session["KhachHangId"] != null)
                {
                    txtFullName.Text = Session["HoVaTen"]?.ToString();
                    txtPhone.Text = Session["SoDienThoai"]?.ToString();
                }

                txtDate.Text = DateTime.Today.AddDays(1).ToString("yyyy-MM-dd");
                LoadDichVu();

                if (!string.IsNullOrEmpty(Request.QueryString["dichVuId"]))
                {
                    string dvId = Request.QueryString["dichVuId"];
                    if (ddlService.Items.FindByValue(dvId) != null)
                        ddlService.SelectedValue = dvId;
                }

                // TỰ ĐỘNG ĐIỀN MÃ KHI NHẤN TỪ TRANG KHUYẾN MÃI SANG
                if (!string.IsNullOrEmpty(Request.QueryString["code"]))
                {
                    txtVoucherCode.Text = Request.QueryString["code"];
                }
            }
        }

        private void LoadDichVu()
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT id, ten_dich_vu + ' (' + CAST(ISNULL(gia_khuyen_mai, gia_goc) / 1000 AS NVARCHAR) + 'k)' AS hien_thi
                        FROM dich_vu WHERE trang_thai = 1 ORDER BY ten_dich_vu", conn);
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ddlService.Items.Clear();
                    ddlService.Items.Add(new ListItem("-- Chọn dịch vụ --", ""));
                    foreach (DataRow r in dt.Rows)
                        ddlService.Items.Add(new ListItem(r["hien_thi"].ToString(), r["id"].ToString()));
                }
            }
            catch (Exception ex) { System.Diagnostics.Debug.WriteLine(ex.Message); }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string hoTen = txtFullName.Text.Trim();
            string phone = txtPhone.Text.Trim().Replace(" ", "").Replace("-", "");
            string dvId = ddlService.SelectedValue;
            string ngay = txtDate.Text.Trim();
            string gio = txtTime.Text.Trim();
            string ghiChu = txtNote.Text.Trim();

            // LẤY MÃ VOUCHER
            string voucherCode = txtVoucherCode.Text.Trim();

            if (string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(dvId))
            {
                ShowThongBao("Vui lòng điền đủ thông tin.", false);
                return;
            }

            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    conn.Open();
                    int khachHangId = LayHoacTaoKhachHang(conn, hoTen, phone, "");
                    string maLH = "LH" + DateTime.Now.ToString("yyyyMMddHHmmss");

                    // Khi Insert, ta đưa mã Voucher vào Ghi chú (hoặc cột voucher_id nếu bạn đã có logic tính tiền)
                    string ghiChuLuu = ghiChu + (string.IsNullOrEmpty(voucherCode) ? "" : " [Mã KM: " + voucherCode + "]");

                    var cmdLH = new SqlCommand(@"
                        INSERT INTO lich_hen (ma_lich_hen, khach_hang_id, thoi_gian, ngay_hen, gio_hen, ghi_chu, trang_thai, nguon_dat)
                        VALUES (@ma, @kh, @tg, @ngay, @gio, @gc, N'Chờ xác nhận', N'Website')", conn);

                    cmdLH.Parameters.AddWithValue("@ma", maLH);
                    cmdLH.Parameters.AddWithValue("@kh", khachHangId);
                    cmdLH.Parameters.AddWithValue("@tg", DateTime.Parse(ngay).Add(TimeSpan.Parse(gio)));
                    cmdLH.Parameters.AddWithValue("@ngay", ngay);
                    cmdLH.Parameters.AddWithValue("@gio", gio);
                    cmdLH.Parameters.AddWithValue("@gc", ghiChuLuu);
                    cmdLH.ExecuteNonQuery();
                }

                ShowThongBao("Đặt lịch thành công!", true);

                // RESET FORM
                txtVoucherCode.Text = "";
                txtNote.Text = "";
            }
            catch (Exception ex) { ShowThongBao("Lỗi: " + ex.Message, false); }
        }

        private int LayHoacTaoKhachHang(SqlConnection conn, string hoTen, string phone, string email)
        {
            var cmdFind = new SqlCommand("SELECT id FROM khach_hang WHERE so_dien_thoai = @sdt", conn);
            cmdFind.Parameters.AddWithValue("@sdt", phone);
            var obj = cmdFind.ExecuteScalar();
            if (obj != null) return Convert.ToInt32(obj);

            var cmdIns = new SqlCommand("INSERT INTO khach_hang (ho_va_ten, so_dien_thoai, trang_thai) VALUES (@ten, @sdt, 1); SELECT SCOPE_IDENTITY();", conn);
            cmdIns.Parameters.AddWithValue("@ten", hoTen);
            cmdIns.Parameters.AddWithValue("@sdt", phone);
            return Convert.ToInt32(cmdIns.ExecuteScalar());
        }

        private void ShowThongBao(string msg, bool isSuccess)
        {
            string js = $"alert('{msg.Replace("'", "\\'")}');";
            Page.ClientScript.RegisterStartupScript(GetType(), "thongbao", js, true);
        }
    }
}