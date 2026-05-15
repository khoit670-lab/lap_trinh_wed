using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_customer_edit : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
        protected int khachHangId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null || !(bool)(Session["IsAdmin"] ?? false))
            {
                Response.Redirect("../client/Default.aspx?noaccess=1");
                return;
            }
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            if (!int.TryParse(Request.QueryString["id"], out khachHangId) || khachHangId <= 0)
            {
                Response.Redirect("admin_customer.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCustomerData(khachHangId);
            }
        }

        private void LoadCustomerData(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT ho_va_ten, so_dien_thoai, hang_khach_hang, 
                               diem_tich_luy, ghi_chu
                        FROM khach_hang WHERE id = @id", conn);

                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    using (var r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            Response.Redirect("admin_customer.aspx");
                            return;
                        }

                        txtName.Text = r["ho_va_ten"].ToString();
                        txtPhone.Text = r["so_dien_thoai"].ToString();
                        txtRank.Text = r["hang_khach_hang"].ToString();
                        txtPoints.Text = r["diem_tich_luy"].ToString();
                        txtInternalNote.Text = r["ghi_chu"].ToString();
                        txtHealth.Text = r["ghi_chu"].ToString(); // Có thể tách riêng sau
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadCustomerData Error: " + ex.Message);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string hoTen = txtName.Text.Trim();
            string sdt = txtPhone.Text.Trim().Replace(" ", "").Replace("-", "");
            string ghiChu = txtInternalNote.Text.Trim();
            int diemTichLuy;
            string hangKhachHang = txtRank.Text.Trim();

            // Validate
            if (string.IsNullOrEmpty(hoTen))
            {
                ShowAlert("Tên khách hàng không được để trống.");
                return;
            }
            if (sdt.Length < 10 || sdt.Length > 11 || !long.TryParse(sdt, out _))
            {
                ShowAlert("Số điện thoại không hợp lệ (10-11 chữ số).");
                return;
            }
            if (!int.TryParse(txtPoints.Text, out diemTichLuy) || diemTichLuy < 0)
            {
                ShowAlert("Điểm tích lũy phải là số không âm.");
                return;
            }

            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Kiểm tra SĐT trùng
                    var cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM khach_hang WHERE so_dien_thoai=@sdt AND id!=@id", conn);
                    cmdCheck.Parameters.AddWithValue("@sdt", sdt);
                    cmdCheck.Parameters.AddWithValue("@id", khachHangId);
                    conn.Open();

                    if (Convert.ToInt32(cmdCheck.ExecuteScalar()) > 0)
                    {
                        ShowAlert("Số điện thoại này đã được sử dụng.");
                        return;
                    }

                    // UPDATE
                    var cmdUpdate = new SqlCommand(@"
                        UPDATE khach_hang SET 
                            ho_va_ten=@ten, so_dien_thoai=@sdt, 
                            hang_khach_hang=@hang, diem_tich_luy=@diem, 
                            ghi_chu=@ghi_chu, updated_at=GETDATE()
                        WHERE id=@id", conn);

                    cmdUpdate.Parameters.AddWithValue("@ten", hoTen);
                    cmdUpdate.Parameters.AddWithValue("@sdt", sdt);
                    cmdUpdate.Parameters.AddWithValue("@hang", hangKhachHang);
                    cmdUpdate.Parameters.AddWithValue("@diem", diemTichLuy);
                    cmdUpdate.Parameters.AddWithValue("@ghi_chu", string.IsNullOrEmpty(ghiChu) ? (object)DBNull.Value : ghiChu);
                    cmdUpdate.Parameters.AddWithValue("@id", khachHangId);

                    cmdUpdate.ExecuteNonQuery();
                }

                string script = $"alert('Đã cập nhật thông tin khách hàng thành công!');"
                              + $"window.location='admin_customer_detail.aspx?id={khachHangId}';";
                ClientScript.RegisterStartupScript(GetType(), "success", script, true);
            }
            catch (Exception ex)
            {
                ShowAlert("Lỗi hệ thống: " + ex.Message);
            }
        }

        private void ShowAlert(string msg)
        {
            ClientScript.RegisterStartupScript(GetType(), "alert", $"alert('{msg.Replace("'", "\\'")}');", true);
        }
    }
}