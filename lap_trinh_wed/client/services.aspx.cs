using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    public partial class services : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
        public string userGreeting = "";

        // Đã đổi thành public để ngoài file .aspx có thể gọi đến dễ dàng để tô màu
        public int selectedDanhMucId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Lời chào header
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }
            if (Session["HoVaTen"] != null)
                userGreeting = "Xin chào, " + Session["HoVaTen"].ToString();
            else
                userGreeting = "Khách";

            if (!IsPostBack)
            {
                LoadDanhMuc();
                LoadDichVu(); // Mặc định load tất cả
            }
            else
            {
                // Lấy lại danh mục đã chọn từ ViewState để giữ màu nút filter
                if (ViewState["SelectedDanhMucId"] != null)
                    int.TryParse(ViewState["SelectedDanhMucId"].ToString(), out selectedDanhMucId);
            }
        }

        private void LoadDanhMuc()
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand("SELECT id, ten_danh_muc FROM danh_muc_dich_vu WHERE trang_thai = 1 ORDER BY thu_tu", conn);
                    conn.Open();
                    var da = new SqlDataAdapter(cmd);
                    var dt = new DataTable();
                    da.Fill(dt);
                    rptDanhMuc.DataSource = dt;
                    rptDanhMuc.DataBind();
                }
            }
            catch (Exception ex) { System.Diagnostics.Debug.WriteLine("Lỗi LoadDanhMuc: " + ex.Message); }
        }

        private void LoadDichVu(int danhMucId = 0, string tuKhoa = "")
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    string where = "WHERE dv.trang_thai = 1";

                    // Nếu có lọc theo danh mục
                    if (danhMucId > 0)
                        where += " AND dv.danh_muc_id = @dmId";

                    // Nếu có lọc theo từ khóa
                    if (!string.IsNullOrWhiteSpace(tuKhoa))
                        where += " AND (dv.ten_dich_vu LIKE @tk OR dv.mo_ta LIKE @tk)";

                    string sql = $@"SELECT dv.id, dv.ten_dich_vu, dv.hinh_anh, dv.gia_goc, dv.gia_khuyen_mai, 
                                    dv.thoi_gian, dv.mo_ta, dm.ten_danh_muc 
                                    FROM dich_vu dv 
                                    JOIN danh_muc_dich_vu dm ON dv.danh_muc_id = dm.id 
                                    {where} 
                                    ORDER BY dv.id DESC";

                    var cmd = new SqlCommand(sql, conn);
                    if (danhMucId > 0)
                        cmd.Parameters.AddWithValue("@dmId", danhMucId);
                    if (!string.IsNullOrWhiteSpace(tuKhoa))
                        cmd.Parameters.AddWithValue("@tk", "%" + tuKhoa.Trim() + "%");

                    conn.Open();
                    var da = new SqlDataAdapter(cmd);
                    var dt = new DataTable();
                    da.Fill(dt);

                    rptDichVu.DataSource = dt;
                    rptDichVu.DataBind();

                    // Hiển thị thông báo nếu không tìm thấy gì
                    lblKhongCoKetQua.Visible = (dt.Rows.Count == 0);
                }
            }
            catch (Exception ex) { System.Diagnostics.Debug.WriteLine("Lỗi LoadDichVu: " + ex.Message); }
        }

        protected void btnLoc_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            int.TryParse(btn.CommandArgument, out selectedDanhMucId);
            ViewState["SelectedDanhMucId"] = selectedDanhMucId;

            // Xóa từ khóa tìm kiếm khi chọn bộ lọc mới
            if (txtSearch != null)
            {
                txtSearch.Text = string.Empty;
            }

            // Chuyển nút Tất Cả sang màu trắng (trạng thái không chọn)
            if (btnTatCa != null)
            {
                btnTatCa.CssClass = "px-6 py-3 bg-white border border-gray-300 rounded-2xl text-sm font-medium hover:bg-pink-50 text-gray-700 transition cursor-pointer";
            }

            LoadDichVu(selectedDanhMucId, "");

            // QUAN TRỌNG: Tải lại danh mục để áp dụng CSS màu hồng cho nút đang được chọn
            LoadDanhMuc();
        }

        protected void btnTatCa_Click(object sender, EventArgs e)
        {
            selectedDanhMucId = 0;
            ViewState["SelectedDanhMucId"] = 0;

            // Xóa trắng ô tìm kiếm khi bấm Tất cả
            if (txtSearch != null)
            {
                txtSearch.Text = string.Empty;
            }

            // Đổi lại nút Tất Cả thành màu hồng
            if (btnTatCa != null)
            {
                btnTatCa.CssClass = "px-6 py-3 bg-pink-600 text-white border border-pink-600 rounded-2xl text-sm font-medium transition cursor-pointer";
            }

            LoadDichVu(0, "");

            // Tải lại danh mục để xóa màu hồng của các nút bộ lọc khác
            LoadDanhMuc();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Khi tìm kiếm, reset danh mục để tìm trên toàn hệ thống
            selectedDanhMucId = 0;
            ViewState["SelectedDanhMucId"] = 0;

            // Chuyển nút Tất Cả sang màu trắng vì đang trong chế độ tìm kiếm
            if (btnTatCa != null)
            {
                btnTatCa.CssClass = "px-6 py-3 bg-white border border-gray-300 rounded-2xl text-sm font-medium hover:bg-pink-50 text-gray-700 transition cursor-pointer";
            }

            string tuKhoa = txtSearch != null ? txtSearch.Text.Trim() : "";
            LoadDichVu(0, tuKhoa);

            // Tải lại danh mục để các nút trở về màu trắng
            LoadDanhMuc();
        }

        protected string FormatGia(object giaGoc, object giaKM)
        {
            try
            {
                decimal gia = (giaKM != DBNull.Value && giaKM != null) ? Convert.ToDecimal(giaKM) : Convert.ToDecimal(giaGoc);
                return string.Format("{0:N0} đ", gia);
            }
            catch { return "Liên hệ"; }
        }

        // ================= CÁC HÀM XỬ LÝ LINK Ở ĐÂY =================

        // 1. Hàm tạo link vào trang Chi tiết
        protected string DetailUrl(object id)
        {
            if (id != null) return "service-detail.aspx?id=" + id.ToString();
            return "#";
        }

        // 2. Hàm tạo link vào trang Đặt lịch
        protected string BookingUrl(object id)
        {
            if (id != null) return "booking.aspx?dichVuId=" + id.ToString();
            return "#";
        }

        // 3. Hàm xử lý đường dẫn ảnh (để tránh lỗi nếu DB không có ảnh)
        protected string AnhUrl(object hinh)
        {
            string ten = hinh?.ToString();
            return string.IsNullOrEmpty(ten)
                ? ResolveUrl("~/assets/anh/default.jpg")
                : ResolveUrl("~/assets/anh/" + ten);
        }
    }
}