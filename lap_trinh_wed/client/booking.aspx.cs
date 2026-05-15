using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    // ✅ THÊM CLASS NÀY VÀO ĐẦU FILE
    [Serializable]
    public class BookingInfo
    {
        public string FullName { get; set; }
        public string Phone { get; set; }
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public string Date { get; set; }
        public string Time { get; set; }
        public string VoucherCode { get; set; }
        public string Note { get; set; }
        public string AppointmentCode { get; set; }
        public int? AppointmentId { get; set; }
        public int? LichHenId { get; set; }
    }

    public partial class booking : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
        protected string userGreeting = "";
        protected string selectedServiceInfo = ""; // ✅ THÔNG TIN DỊCH VỤ ĐÃ CHỌN

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }
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

                // ✅ EVENT SELECT DỊCH VỤ - HIỂN THỊ INFO
                ddlService.SelectedIndexChanged += DdlService_SelectedIndexChanged;

                // ✅ NHẬN VÀ TỰ ĐỘNG CHỌN DỊCH VỤ TỪ LINK SERVICES
                if (!string.IsNullOrEmpty(Request.QueryString["dichVuId"]))
                {
                    string dvId = Request.QueryString["dichVuId"];

                    // 1. Tự động chọn trong dropdown
                    if (ddlService.Items.FindByValue(dvId) != null)
                    {
                        ddlService.SelectedValue = dvId;

                        // 2. Load thông tin chi tiết dịch vụ để hiển thị
                        LoadDichVuSelectedInfo(dvId);
                    }
                }

                if (!string.IsNullOrEmpty(Request.QueryString["code"]))
                {
                    txtVoucherCode.Text = Request.QueryString["code"];
                }
            }
        }

        // ✅ EVENT KHI CHỌN DỊCH VỤ TRONG DROPDOWN
        protected void DdlService_SelectedIndexChanged(object sender, EventArgs e)
        {
            string dvId = ddlService.SelectedValue;
            if (!string.IsNullOrEmpty(dvId) && dvId != "")
            {
                LoadDichVuSelectedInfo(dvId);
            }
            else
            {
                lblSelectedService.Visible = false;
            }
        }

        // ✅ LOAD THÔNG TIN CHI TIẾT DỊCH VỤ ĐÃ CHỌN
        private void LoadDichVuSelectedInfo(string dvId)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string sql = @"
                        SELECT dv.ten_dich_vu, dv.gia_goc, dv.gia_khuyen_mai, 
                               dv.thoi_gian, dv.hinh_anh, dv.mo_ta,
                               dm.ten_danh_muc
                        FROM dich_vu dv 
                        JOIN danh_muc_dich_vu dm ON dv.danh_muc_id = dm.id
                        WHERE dv.id = @id AND dv.trang_thai = 1";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", dvId);
                        conn.Open();
                        var reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            string tenDV = reader["ten_dich_vu"].ToString();
                            decimal giaKM = reader["gia_khuyen_mai"] != DBNull.Value ?
                                Convert.ToDecimal(reader["gia_khuyen_mai"]) : Convert.ToDecimal(reader["gia_goc"]);
                            decimal giaGoc = Convert.ToDecimal(reader["gia_goc"]);
                            string thoiGian = reader["thoi_gian"].ToString();
                            string hinhAnh = reader["hinh_anh"]?.ToString() ?? "default-service.jpg";
                            string danhMuc = reader["ten_danh_muc"].ToString();

                            // ✅ GÁN VÀO LABEL (SỬA LỖI NÀY)
                            selectedServiceInfo = $@"
                                <div class='selected-service-card bg-gradient-to-r from-emerald-50 to-teal-50 border-2 border-emerald-200 rounded-2xl p-6 mb-6 shadow-lg'>
                                    <div class='flex items-center gap-4'>
                                        <div class='w-20 h-20 bg-gradient-to-br from-emerald-400 to-teal-500 rounded-xl flex items-center justify-center'>
                                            <i class='fa-solid fa-spa text-2xl text-white'></i>
                                        </div>
                                        <div class='flex-1'>
                                            <h4 class='font-black text-xl text-emerald-800 mb-2'>{tenDV}</h4>
                                            <div class='text-2xl font-bold text-emerald-600 mb-2'>
                                                {(giaKM != giaGoc ? $"<span class='line-through text-gray-500 text-lg mr-2'>{giaGoc:N0}đ</span>" : "")}
                                                <span>{giaKM:N0}đ</span>
                                            </div>
                                            <div class='flex items-center gap-4 text-sm text-gray-600 bg-white px-3 py-1 rounded-lg'>
                                                <span><i class='fa-solid fa-clock mr-1'></i>{thoiGian} phút</span>
                                                <span><i class='fa-solid fa-tag mr-1'></i>{danhMuc}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>";

                            lblSelectedService.Text = selectedServiceInfo; // ✅ GÁN VÀO LABEL
                            lblSelectedService.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi LoadDichVuSelectedInfo: " + ex.Message);
            }
        }

        private void LoadDichVu()
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT id, 
                               ten_dich_vu + ' - ' + CAST(ISNULL(gia_khuyen_mai, gia_goc) / 1000 AS NVARCHAR) + 'k' AS hien_thi
                        FROM dich_vu 
                        WHERE trang_thai = 1 
                        ORDER BY ten_dich_vu", conn);
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlService.Items.Clear();
                    ddlService.Items.Add(new ListItem("-- Chọn dịch vụ làm đẹp --", ""));
                    foreach (DataRow r in dt.Rows)
                        ddlService.Items.Add(new ListItem(r["hien_thi"].ToString(), r["id"].ToString()));
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi LoadDichVu: " + ex.Message);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string hoTen = txtFullName.Text.Trim();
            string phone = txtPhone.Text.Trim().Replace(" ", "").Replace("-", "");
            string dvId = ddlService.SelectedValue;
            string ngayStr = txtDate.Text.Trim();
            string gioStr = txtTime.Text.Trim();
            string ghiChu = txtNote.Text.Trim();
            string voucherCode = txtVoucherCode.Text.Trim();

            // ✅ VALIDATION CẢI TIẾN
            if (string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(dvId))
            {
                ShowThongBao("❌ Vui lòng điền đầy đủ: Họ tên, SĐT, Dịch vụ!", false);
                return;
            }

            if (!IsValidPhone(phone))
            {
                ShowThongBao("❌ Số điện thoại không hợp lệ! (VD: 090xxxxxxx)", false);
                return;
            }

            if (!DateTime.TryParse(ngayStr, out DateTime ngayHen) || !TimeSpan.TryParse(gioStr, out TimeSpan gioHen))
            {
                ShowThongBao("❌ Ngày giờ không hợp lệ!", false);
                return;
            }

            if (ngayHen < DateTime.Today.AddDays(1))
            {
                ShowThongBao("❌ Ngày hẹn phải từ ngày mai trở đi!", false);
                return;
            }

            try
            {
                string maLichHen = "LH" + DateTime.Now.ToString("yyyyMMddHHmmssfff");

                // ✅ TẠO OBJECT CHỨA TOÀN BỘ THÔNG TIN
                var bookingInfo = new BookingInfo
                {
                    FullName = hoTen,
                    Phone = phone,
                    ServiceId = Convert.ToInt32(dvId),
                    ServiceName = ddlService.SelectedItem?.Text ?? "",
                    Date = ngayStr,
                    Time = gioStr,
                    VoucherCode = voucherCode,
                    Note = ghiChu,
                    AppointmentCode = maLichHen
                };

                // ✅ LƯU VÀO SESSION ĐỂ TRUYỀN SANG PAYMENT
                Session["BookingInfo"] = bookingInfo;

                using (var conn = new SqlConnection(_conn))
                {
                    conn.Open();

                    int khachHangId = LayHoacTaoKhachHang(conn, hoTen, phone);

                    string ghiChuLuu = ghiChu;
                    if (!string.IsNullOrEmpty(voucherCode))
                    {
                        ghiChuLuu = string.IsNullOrEmpty(ghiChu) ? "[Voucher: " + voucherCode + "]" : ghiChu + " | [Voucher: " + voucherCode + "]";
                    }

                    // INSERT LỊCH HẸN
                    var cmdLH = new SqlCommand(@"
                        INSERT INTO lich_hen (ma_lich_hen, khach_hang_id, thoi_gian, ngay_hen, gio_hen, 
                                            ghi_chu, trang_thai, nguon_dat, created_at, updated_at)
                        OUTPUT INSERTED.id
                        VALUES (@maLH, @khId, @thoiGian, @ngayHen, @gioHen, @ghiChu, N'Chờ xác nhận', 
                               N'Website', GETDATE(), GETDATE())", conn);

                    cmdLH.Parameters.AddWithValue("@maLH", maLichHen);
                    cmdLH.Parameters.AddWithValue("@khId", khachHangId);
                    cmdLH.Parameters.AddWithValue("@thoiGian", ngayHen.Date.Add(gioHen));
                    cmdLH.Parameters.AddWithValue("@ngayHen", ngayHen.Date);
                    cmdLH.Parameters.AddWithValue("@gioHen", gioHen);
                    cmdLH.Parameters.AddWithValue("@ghiChu", string.IsNullOrEmpty(ghiChuLuu) ? (object)DBNull.Value : ghiChuLuu);

                    int lichHenId = Convert.ToInt32(cmdLH.ExecuteScalar());

                    // INSERT DỊCH VỤ CHI TIẾT
                    var cmdChiTiet = new SqlCommand(@"
                        INSERT INTO lich_hen_chi_tiet (lich_hen_id, dich_vu_id, so_luong, don_gia, thanh_tien)
                        SELECT @lichId, id, 1, ISNULL(gia_khuyen_mai, gia_goc), ISNULL(gia_khuyen_mai, gia_goc)
                        FROM dich_vu WHERE id = @dvId", conn);

                    cmdChiTiet.Parameters.AddWithValue("@lichId", lichHenId);
                    cmdChiTiet.Parameters.AddWithValue("@dvId", dvId);
                    cmdChiTiet.ExecuteNonQuery();

                    // CẬP NHẬT TỔNG TIỀN
                    var cmdTongTien = new SqlCommand(@"
                        UPDATE lich_hen SET 
                            tong_tien = (SELECT SUM(thanh_tien) FROM lich_hen_chi_tiet WHERE lich_hen_id = @lichId),
                            tien_thanh_toan = (SELECT SUM(thanh_tien) FROM lich_hen_chi_tiet WHERE lich_hen_id = @lichId) 
                        WHERE id = @lichId", conn);

                    cmdTongTien.Parameters.AddWithValue("@lichId", lichHenId);
                    cmdTongTien.ExecuteNonQuery();

                    // ✅ LƯU THÊM ID LỊCH HẸN VÀO SESSION
                    bookingInfo.AppointmentId = lichHenId;
                    Session["BookingInfo"] = bookingInfo;
                    Session["LichHenId"] = lichHenId;
                }

                // ✅ CHUYỀN SANG TRANG THANH TOÁN
                Response.Redirect("payment.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi btnSubmit_Click: " + ex.Message);
                ShowThongBao("❌ Lỗi hệ thống: " + ex.Message, false);
            }
        }

        private bool IsValidPhone(string phone)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(phone, @"^0[3|5|7|8|9][0-9]{8}$");
        }

        private int LayHoacTaoKhachHang(SqlConnection conn, string hoTen, string phone)
        {
            // ✅ KIỂM TRA KHÁCH HÀNG TỒN TẠI
            var cmdFind = new SqlCommand("SELECT id FROM khach_hang WHERE so_dien_thoai = @phone", conn);
            cmdFind.Parameters.AddWithValue("@phone", phone);
            object existingId = cmdFind.ExecuteScalar();

            if (existingId != null)
                return Convert.ToInt32(existingId);

            // ✅ TẠO KHÁCH HÀNG MỚI
            var cmdInsert = new SqlCommand(@"
                INSERT INTO khach_hang (ho_va_ten, so_dien_thoai, trang_thai, created_at)
                OUTPUT INSERTED.id
                VALUES (@hoTen, @phone, 1, GETDATE())", conn);

            cmdInsert.Parameters.AddWithValue("@hoTen", hoTen);
            cmdInsert.Parameters.AddWithValue("@phone", phone);

            return Convert.ToInt32(cmdInsert.ExecuteScalar());
        }

        private void ShowThongBao(string msg, bool isSuccess)
        {
            string icon = isSuccess ? "✅" : "❌";
            string js = $"alert('{icon} {msg.Replace("'", "\\'")}');";
            Page.ClientScript.RegisterStartupScript(GetType(), "thongbao", js, true);
        }
    }
}