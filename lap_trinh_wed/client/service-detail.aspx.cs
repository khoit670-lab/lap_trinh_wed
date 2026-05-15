using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lap_trinh_wed.client
{
    public partial class service_detail : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        // ── Biến bind lên .aspx bằng <%= ... %> ──────────────────
        protected string userGreeting = "";
        protected string tenDichVu = "";
        protected string hinhAnhUrl = "";
        protected string giaHienThi = "";
        protected string thoiGianHienThi = "";
        protected string moTa = "";
        protected string lamGi = "";
        protected string tenDanhMuc = "";
        protected int dichVuId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Lời chào header ───────────────────────────────────
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }
            if (Session["HoVaTen"] != null)
                userGreeting = "Xin chào, " + Session["HoVaTen"].ToString();

            if (!IsPostBack)
            {
                // Đọc id từ QueryString: service-detail.aspx?id=1
                if (!int.TryParse(Request.QueryString["id"], out dichVuId) || dichVuId <= 0)
                {
                    Response.Redirect("services.aspx");
                    return;
                }

                LoadChiTiet(dichVuId);
                LoadLienQuan(dichVuId);
            }
        }

        // ── Load thông tin 1 dịch vụ từ DB ───────────────────────
        private void LoadChiTiet(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT
                            dv.id,
                            dv.ten_dich_vu,
                            dv.hinh_anh,
                            dv.gia_goc,
                            dv.gia_khuyen_mai,
                            dv.thoi_gian,
                            dv.mo_ta,
                            dv.lam_gi,
                            dm.ten_danh_muc
                        FROM dich_vu dv
                        JOIN danh_muc_dich_vu dm ON dv.danh_muc_id = dm.id
                        WHERE dv.id = @id AND dv.trang_thai = 1", conn);

                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    using (var r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            Response.Redirect("services.aspx");
                            return;
                        }

                        tenDichVu = r["ten_dich_vu"].ToString();
                        tenDanhMuc = r["ten_danh_muc"].ToString();
                        moTa = r["mo_ta"].ToString();
                        lamGi = r["lam_gi"].ToString();

                        // Ảnh
                        string tenAnh = r["hinh_anh"].ToString();
                        hinhAnhUrl = string.IsNullOrEmpty(tenAnh)
                            ? ResolveUrl("~/assets/anh/default.jpg")
                            : ResolveUrl("~/assets/anh/" + tenAnh);

                        // Thời gian
                        thoiGianHienThi = r["thoi_gian"].ToString() + " phút";

                        // Giá (ưu tiên giá khuyến mãi)
                        decimal giaGoc = Convert.ToDecimal(r["gia_goc"]);
                        if (r["gia_khuyen_mai"] != DBNull.Value)
                        {
                            decimal giaKM = Convert.ToDecimal(r["gia_khuyen_mai"]);
                            giaHienThi = string.Format("{0:N0} đ", giaKM)
                                       + $" <s class='text-gray-400 text-base font-normal'>{giaGoc:N0} đ</s>";
                        }
                        else
                        {
                            giaHienThi = string.Format("{0:N0} đ", giaGoc);
                        }
                    }
                }

                Page.Title = tenDichVu + " - Lily Spa";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadChiTiet Error: " + ex.Message);
            }
        }

        // ── Load 3 dịch vụ liên quan (cùng danh mục) ─────────────
        private void LoadLienQuan(int currentId)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    // Ưu tiên cùng danh mục
                    var cmd = new SqlCommand(@"
                        SELECT TOP 3
                            dv.id, dv.ten_dich_vu, dv.hinh_anh,
                            dv.gia_goc, dv.gia_khuyen_mai, dv.thoi_gian
                        FROM dich_vu dv
                        WHERE dv.trang_thai = 1
                          AND dv.id != @id
                          AND dv.danh_muc_id = (
                              SELECT danh_muc_id FROM dich_vu WHERE id = @id
                          )
                        ORDER BY dv.so_luot_dat DESC", conn);

                    cmd.Parameters.AddWithValue("@id", currentId);
                    conn.Open();

                    var da = new SqlDataAdapter(cmd);
                    var dt = new DataTable();
                    da.Fill(dt);

                    // Nếu không đủ 3 → lấy thêm từ danh mục khác
                    if (dt.Rows.Count < 3)
                    {
                        var cmd2 = new SqlCommand(@"
                            SELECT TOP 3
                                id, ten_dich_vu, hinh_anh,
                                gia_goc, gia_khuyen_mai, thoi_gian
                            FROM dich_vu
                            WHERE trang_thai = 1 AND id != @id
                            ORDER BY so_luot_dat DESC", conn);
                        cmd2.Parameters.AddWithValue("@id", currentId);
                        dt.Clear();
                        new SqlDataAdapter(cmd2).Fill(dt);
                    }

                    if (rptLienQuan != null)
                    {
                        rptLienQuan.DataSource = dt;
                        rptLienQuan.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadLienQuan Error: " + ex.Message);
            }
        }

        // ── Sự kiện: nút ĐẶT LỊCH NGAY ──────────────────────────
        protected void btnDatLich_Click(object sender, EventArgs e)
        {
            if (Session["KhachHangId"] == null)
            {
                Response.Redirect("login.aspx?redirect=booking.aspx&dichVuId=" + dichVuId);
                return;
            }
            Response.Redirect("booking.aspx?dichVuId=" + dichVuId);
        }

        // ── Helpers dùng trong Repeater rptLienQuan ──────────────
        protected string FormatGia(object giaGoc, object giaKM)
        {
            if (giaKM != DBNull.Value && giaKM != null)
                return string.Format("{0:N0} đ", Convert.ToDecimal(giaKM));
            return string.Format("{0:N0} đ", Convert.ToDecimal(giaGoc));
        }

        protected string DetailUrl(object id) => "service-detail.aspx?id=" + id;

        // ĐÃ BỔ SUNG HÀM BOOKING URL Ở ĐÂY NHÉ:
        protected string BookingUrl(object id)
        {
            if (id != null) return "booking.aspx?dichVuId=" + id.ToString();
            return "#";
        }

        protected string AnhUrl(object hinh)
        {
            string ten = hinh?.ToString();
            return string.IsNullOrEmpty(ten)
                ? ResolveUrl("~/assets/anh/default.jpg")
                : ResolveUrl("~/assets/anh/" + ten);
        }
    }
}