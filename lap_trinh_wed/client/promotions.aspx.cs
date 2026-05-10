using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    public partial class promotions : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected string userGreeting = "";
        protected string bannerTenVoucher = "Ưu đãi đặc biệt dành cho thành viên";
        protected string bannerMoTa = ""; // Để trống để lấy từ database

        protected void Page_Load(object sender, EventArgs e)
        {
            // Hiển thị lời chào
            if (Session["HoVaTen"] != null && !string.IsNullOrEmpty(Session["HoVaTen"].ToString()))
            {
                userGreeting = "Xin chào, " + Session["HoVaTen"].ToString();
            }
            else
            {
                userGreeting = "Tài khoản";
            }
            litUserGreeting.Text = userGreeting;

            if (!IsPostBack)
            {
                LoadBannerVoucher();
                LoadDanhSachVoucher();
            }
        }

        private void LoadBannerVoucher()
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Lấy voucher có giá trị giảm cao nhất đang còn hạn
                    var cmd = new SqlCommand(@"
                        SELECT TOP 1 ten_voucher, ngay_het_han 
                        FROM voucher 
                        WHERE trang_thai = 1 
                        AND CAST(GETDATE() AS DATE) <= ngay_het_han
                        ORDER BY gia_tri_giam DESC", conn);
                    conn.Open();
                    using (var r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            bannerTenVoucher = r["ten_voucher"].ToString();
                            // SỬA LỖI NGÀY Ở BANNER: Lấy ngày từ database
                            bannerMoTa = "Hạn đến " + Convert.ToDateTime(r["ngay_het_han"]).ToString("dd/MM/yyyy");
                        }
                    }
                }
            }
            catch (Exception ex) { System.Diagnostics.Debug.WriteLine(ex.Message); }
        }

        private void LoadDanhSachVoucher(string loaiLoc = "tat_ca")
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string whereExtra = "";
                    if (loaiLoc == "dang_ap_dung") whereExtra = " AND CAST(GETDATE() AS DATE) <= ngay_het_han";
                    else if (loaiLoc == "sap_het_han") whereExtra = " AND ngay_het_han BETWEEN GETDATE() AND DATEADD(day, 7, GETDATE())";
                    else if (loaiLoc == "thanh_vien") whereExtra = " AND dieu_kien_ap_dung LIKE N'%Thành viên%'";

                    var cmd = new SqlCommand($"SELECT * FROM voucher WHERE trang_thai = 1 {whereExtra} ORDER BY gia_tri_giam DESC", conn);
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptVoucher.DataSource = dt;
                    rptVoucher.DataBind();
                }
            }
            catch (Exception ex) { System.Diagnostics.Debug.WriteLine(ex.Message); }
        }

        protected void btnTatCa_Click(object sender, EventArgs e) { ResetButtonClasses(); btnTatCa.CssClass = "filter-btn active"; LoadDanhSachVoucher("tat_ca"); }
        protected void btnDangApDung_Click(object sender, EventArgs e) { ResetButtonClasses(); btnDangApDung.CssClass = "filter-btn active"; LoadDanhSachVoucher("dang_ap_dung"); }
        protected void btnThanhVien_Click(object sender, EventArgs e) { ResetButtonClasses(); btnThanhVien.CssClass = "filter-btn active"; LoadDanhSachVoucher("thanh_vien"); }
        protected void btnSapHetHan_Click(object sender, EventArgs e) { ResetButtonClasses(); btnSapHetHan.CssClass = "filter-btn active"; LoadDanhSachVoucher("sap_het_han"); }

        private void ResetButtonClasses()
        {
            btnTatCa.CssClass = "filter-btn";
            btnDangApDung.CssClass = "filter-btn";
            btnThanhVien.CssClass = "filter-btn";
            btnSapHetHan.CssClass = "filter-btn";
        }

        protected void rptVoucher_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "NhanUuDai")
            {
                // PHẦN THAY ĐỔI: Chuyển sang trang booking kèm mã thay vì copy clipboard
                string ma = e.CommandArgument.ToString();
                Response.Redirect("booking.aspx?code=" + ma);
            }
        }

        protected string FormatGiamGia(object loai, object gia)
        {
            return loai.ToString() == "Phần trăm" ? gia.ToString() + "%" : string.Format("{0:N0} đ", gia);
        }

        protected string FormatDieuKien(object dk, object moTa)
        {
            return !string.IsNullOrEmpty(moTa?.ToString()) ? moTa.ToString() : "Mọi dịch vụ";
        }

        // HÀM HIỂN THỊ NGÀY TRONG REPEATER: Trả về chuỗi có chữ HSD
        protected string FormatNgayHH(object ngay)
        {
            if (ngay == DBNull.Value || ngay == null) return "Không thời hạn";
            return "HSD: " + Convert.ToDateTime(ngay).ToString("dd/MM/yyyy");
        }
    }
}