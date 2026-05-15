using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    public partial class payment : System.Web.UI.Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
        protected BookingInfo bookingInfo;
        protected string userGreeting = "Khách hàng";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }
            if (Session["HoVaTen"] != null)
                userGreeting = "Xin chào, " + Session["HoVaTen"].ToString();

            bookingInfo = Session["BookingInfo"] as BookingInfo;

            if (bookingInfo == null || string.IsNullOrEmpty(bookingInfo.FullName))
            {
                Response.Redirect("booking.aspx?error=missing_data");
                return;
            }

            if (!IsPostBack)
            {
                LoadPageData();
                LoadPaymentMethods();
                rblPaymentMethod.SelectedIndex = 0;
            }
        }

        private void LoadPageData()
        {
            try
            {
                // ✅ THÔNG TIN KHÁCH HÀNG - ĐÚNG VỚI DB
                lblCustomerInfo.Text = $@"
                    <div class='space-y-2 text-sm'>
                        <div class='flex items-center'><i class='fa-solid fa-user-circle text-pink-400 mr-2'></i><strong>{bookingInfo.FullName}</strong></div>
                        <div class='flex items-center'><i class='fa-solid fa-phone text-pink-400 mr-2'></i>{bookingInfo.Phone}</div>
                        {(!string.IsNullOrEmpty(bookingInfo.VoucherCode) ? $"<div class='flex items-center'><i class='fa-solid fa-ticket text-green-400 mr-2'></i><span class='font-semibold text-green-600'>Mã: {bookingInfo.VoucherCode}</span></div>" : "")}
                        {(!string.IsNullOrEmpty(bookingInfo.Note) ? $"<div class='flex items-center'><i class='fa-solid fa-sticky-note text-blue-400 mr-2'></i>{bookingInfo.Note}</div>" : "")}
                    </div>";

                lblServiceInfo.Text = $"<strong>{bookingInfo.ServiceName}</strong>";
                lblDateTimeInfo.Text = $"<i class='fa-solid fa-calendar-days mr-2'></i>{DateTime.Parse(bookingInfo.Date):dd/MM/yyyy} | <i class='fa-solid fa-clock mr-2'></i>{bookingInfo.Time}";

                // ✅ LẤY LỊCH HẸN ID - TƯƠNG ỨNG BẢNG lich_hen
                int lichHenId = GetLichHenId();
                if (lichHenId == 0)
                {
                    ClientScript.RegisterStartupScript(GetType(), "error", "alert('❌ Không tìm thấy lịch hẹn! Vui lòng đặt lại.');", true);
                    btnConfirmPayment.Enabled = false;
                    return;
                }

                Session["LichHenId"] = lichHenId;

                // ✅ TÍNH GIÁ - ĐÚNG VỚI dich_vu.gia_khuyen_mai, gia_goc
                decimal servicePrice = GetServicePrice(bookingInfo.ServiceId);
                decimal discount = 0;
                decimal finalPrice = servicePrice;

                if (!string.IsNullOrEmpty(bookingInfo.VoucherCode))
                {
                    discount = ValidateVoucher(bookingInfo.VoucherCode, servicePrice);
                    finalPrice = servicePrice - discount;

                    lblDiscount.Visible = true;
                    lblDiscount.InnerHtml = $"<span>Giảm giá:</span><span class='font-bold text-green-600'>-{discount:N0}₫</span>";
                    lblOriginalPrice.Visible = true;
                    lblOriginalPrice.InnerHtml = $"<span>Giá gốc:</span><span class='line-through text-gray-500'>{servicePrice:N0}₫</span>";
                }

                lblServicePrice.Text = $"{servicePrice:N0}₫";
                lblTotalAmount.Text = $"{finalPrice:N0}₫";

                Session["FinalPrice"] = finalPrice;
                Session["DiscountAmount"] = discount;
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "error", $"alert('❌ Lỗi: {ex.Message}');", true);
            }
        }

        // ✅ TÌM LỊCH HẸN THEO ma_lich_hen HOẶC so_dien_thoai + ngay_hen + gio_hen
        private int GetLichHenId()
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string query = @"
                        SELECT TOP 1 lh.id 
                        FROM lich_hen lh
                        LEFT JOIN khach_hang kh ON lh.khach_hang_id = kh.id
                        WHERE lh.ma_lich_hen = @maLichHen 
                           OR (kh.so_dien_thoai = @sdt 
                               AND lh.ngay_hen = @ngayHen 
                               AND lh.gio_hen = @gioHen
                               AND lh.trang_thai IN (N'Chờ xác nhận', N'Đã xác nhận'))
                        ORDER BY lh.id DESC";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@maLichHen", bookingInfo.AppointmentCode ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@sdt", bookingInfo.Phone);
                        cmd.Parameters.AddWithValue("@ngayHen", DateTime.Parse(bookingInfo.Date));
                        cmd.Parameters.AddWithValue("@gioHen", bookingInfo.Time);

                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        return result != null ? Convert.ToInt32(result) : 0;
                    }
                }
            }
            catch { return 0; }
        }

        // ✅ PHƯƠNG THỨC THANH TOÁN - ĐÚNG CHECK CONSTRAINT
        private void LoadPaymentMethods()
        {
            rblPaymentMethod.Items.Clear();
            rblPaymentMethod.Items.Add(new ListItem("💳 Tiền mặt", "Tiền mặt"));
            rblPaymentMethod.Items.Add(new ListItem("🏦 Chuyển khoản", "Chuyển khoản"));
            rblPaymentMethod.Items.Add(new ListItem("💳 Thẻ", "Thẻ"));
            rblPaymentMethod.Items.Add(new ListItem("📱 Ví điện tử", "Ví điện tử"));
        }

        // ✅ LẤY GIÁ DỊCH VỤ - ƯU TIÊN gia_khuyen_mai
        private decimal GetServicePrice(int serviceId)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string query = @"
                        SELECT ISNULL(gia_khuyen_mai, gia_goc) as gia 
                        FROM dich_vu 
                        WHERE id = @serviceId AND trang_thai = 1";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@serviceId", serviceId);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        return result != DBNull.Value ? Convert.ToDecimal(result) : 0;
                    }
                }
            }
            catch { return 0; }
        }

        // ✅ KIỂM TRA VOUCHER - GỌI SP_KIEM_TRA_VOUCHER
        private decimal ValidateVoucher(string voucherCode, decimal totalAmount)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    using (var cmd = new SqlCommand("sp_kiem_tra_voucher", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@p_ma_voucher", voucherCode);
                        cmd.Parameters.AddWithValue("@p_tong_tien", totalAmount);

                        // OUTPUT parameters - ĐÚNG VỚI SP
                        var pHopLe = new SqlParameter("@p_hop_le", SqlDbType.TinyInt) { Direction = ParameterDirection.Output };
                        var pTienGiam = new SqlParameter("@p_tien_giam", SqlDbType.Decimal, 12) { Direction = ParameterDirection.Output };
                        var pThongBao = new SqlParameter("@p_thong_bao", SqlDbType.NVarChar, 300) { Direction = ParameterDirection.Output };

                        cmd.Parameters.Add(pHopLe);
                        cmd.Parameters.Add(pTienGiam);
                        cmd.Parameters.Add(pThongBao);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        return (int)pHopLe.Value == 1 ? Convert.ToDecimal(pTienGiam.Value) : 0;
                    }
                }
            }
            catch { return 0; }
        }

        protected void rblPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPaymentInstructions(rblPaymentMethod.SelectedValue);
        }

        private void LoadPaymentInstructions(string method)
        {
            paymentInstructions.Visible = true;
            string apptCode = bookingInfo?.AppointmentCode ?? "LHXXXX";

            switch (method)
            {
                case "Tiền mặt":
                    litPaymentInstructions.Text = "<div class='bg-green-50 p-4 rounded-lg border-l-4 border-green-500'><strong>✅ Tiền mặt</strong><br>Thanh toán trực tiếp tại spa</div>";
                    break;
                case "Chuyển khoản":
                    litPaymentInstructions.Text = $"<div class='bg-blue-50 p-4 rounded-lg border-l-4 border-blue-500'><strong>🏦 Chuyển khoản</strong><br><code>Nội dung: {apptCode}</code></div>";
                    break;
                case "Thẻ":
                    litPaymentInstructions.Text = "<div class='bg-orange-50 p-4 rounded-lg border-l-4 border-orange-500'><strong>💳 Thẻ ATM</strong><br>Thanh toán bằng thẻ tại quầy</div>";
                    break;
                case "Ví điện tử":
                    litPaymentInstructions.Text = "<div class='bg-purple-50 p-4 rounded-lg border-l-4 border-purple-500'><strong>📱 Ví điện tử</strong><br>Momo, ZaloPay, ViettelPay</div>";
                    break;
            }
        }

        // ✅ XÁC NHẬN THANH TOÁN - ĐÚNG 100% VỚI DATABASE
        protected void btnConfirmPayment_Click(object sender, EventArgs e)
        {
            // 1. VALIDATION
            if (!chkTerms.Checked)
            {
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('❌ Vui lòng đồng ý điều khoản dịch vụ!');", true);
                return;
            }

            string paymentMethod = rblPaymentMethod.SelectedValue;
            if (string.IsNullOrEmpty(paymentMethod))
            {
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('❌ Vui lòng chọn phương thức thanh toán!');", true);
                return;
            }

            int lichHenId = (int)(Session["LichHenId"] ?? 0);
            if (lichHenId == 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('❌ Không tìm thấy lịch hẹn!');", true);
                return;
            }

            decimal finalPrice = Convert.ToDecimal(Session["FinalPrice"] ?? 0);
            if (finalPrice <= 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('❌ Giá dịch vụ không hợp lệ!');", true);
                return;
            }

            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Sử dụng Open() thay vì OpenAsync()
                    conn.Open();
                    using (var trans = conn.BeginTransaction())
                    {
                        try
                        {
                            decimal discount = Convert.ToDecimal(Session["DiscountAmount"] ?? 0);
                            int khachHangId = GetKhachHangIdByPhone(bookingInfo.Phone);

                            // 1. CẬP NHẬT bảng lich_hen
                            var cmdLH = new SqlCommand(@"
                        UPDATE lich_hen SET 
                            tien_giam = @tienGiam,
                            tien_thanh_toan = @tienThanhToan,
                            phuong_thuc_tt = @phuongThucTT,
                            trang_thai = N'Đã xác nhận',
                            updated_at = GETDATE()
                        WHERE id = @lichHenId", conn, trans);

                            cmdLH.Parameters.AddWithValue("@tienGiam", discount);
                            cmdLH.Parameters.AddWithValue("@tienThanhToan", finalPrice);
                            cmdLH.Parameters.AddWithValue("@phuongThucTT", paymentMethod);
                            cmdLH.Parameters.AddWithValue("@lichHenId", lichHenId);
                            cmdLH.ExecuteNonQuery();

                            // 2. TẠO hoa_don (Theo cấu trúc bảng của bạn)
                            var cmdHD = new SqlCommand(@"
                        INSERT INTO hoa_don (
                            lich_hen_id, khach_hang_id, tong_tien_goc, 
                            tien_giam, tien_thanh_toan, da_thanh_toan, 
                            con_no, phuong_thuc_tt, trang_thai
                        ) VALUES (
                            @lichHenId, @khachHangId, @tongTienGoc, 
                            @tienGiam, @tienThanhToan, 0, 
                            @tienThanhToan, @phuongThucTT, N'Chờ thanh toán'
                        )", conn, trans);

                            cmdHD.Parameters.AddWithValue("@lichHenId", lichHenId);
                            cmdHD.Parameters.AddWithValue("@khachHangId", khachHangId);
                            cmdHD.Parameters.AddWithValue("@tongTienGoc", finalPrice + discount);
                            cmdHD.Parameters.AddWithValue("@tienGiam", discount);
                            cmdHD.Parameters.AddWithValue("@tienThanhToan", finalPrice);
                            cmdHD.Parameters.AddWithValue("@phuongThucTT", paymentMethod);
                            cmdHD.ExecuteNonQuery();

                            // 3. XỬ LÝ VOUCHER (Nếu có)
                            if (!string.IsNullOrEmpty(bookingInfo.VoucherCode) && discount > 0)
                            {
                                int voucherId = GetVoucherId(bookingInfo.VoucherCode);
                                if (voucherId > 0)
                                {
                                    var cmdVoucher = new SqlCommand(@"
                                INSERT INTO voucher_su_dung (voucher_id, khach_hang_id, lich_hen_id, so_tien_giam)
                                VALUES (@voucherId, @khachHangId, @lichHenId, @tienGiam)", conn, trans);
                                    cmdVoucher.Parameters.AddWithValue("@voucherId", voucherId);
                                    cmdVoucher.Parameters.AddWithValue("@khachHangId", khachHangId);
                                    cmdVoucher.Parameters.AddWithValue("@lichHenId", lichHenId);
                                    cmdVoucher.Parameters.AddWithValue("@tienGiam", discount);
                                    cmdVoucher.ExecuteNonQuery();
                                }
                            }

                            trans.Commit();

                            // ✅ THÀNH CÔNG - CHUYỂN HƯỚNG
                            Session["PaymentSuccess"] = true;
                            string script = $"alert('🎉 ĐẶT LỊCH THÀNH CÔNG!\\nMã lịch hẹn: {bookingInfo.AppointmentCode}'); window.location='services.aspx';";
                            ClientScript.RegisterStartupScript(GetType(), "success", script, true);
                        }
                        catch (Exception ex)
                        {
                            trans.Rollback();
                            throw ex; // Để catch bên ngoài xử lý alert
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string errorMsg = ex.Message.Replace("'", "\\'");
                ClientScript.RegisterStartupScript(GetType(), "error", $"alert('❌ Lỗi: {errorMsg}');", true);
            }
        }

        // ✅ HELPER FUNCTIONS
        private int GetKhachHangIdByPhone(string phone)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string query = "SELECT id FROM khach_hang WHERE so_dien_thoai = @phone AND trang_thai = 1";
                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@phone", phone);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        return result != null ? Convert.ToInt32(result) : 0;
                    }
                }
            }
            catch { return 0; }
        }

        private int GetVoucherId(string maVoucher)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string query = "SELECT id FROM voucher WHERE ma_voucher = @maVoucher AND trang_thai = 1";
                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@maVoucher", maVoucher);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        return result != null ? Convert.ToInt32(result) : 0;
                    }
                }
            }
            catch { return 0; }
        }
    }
}