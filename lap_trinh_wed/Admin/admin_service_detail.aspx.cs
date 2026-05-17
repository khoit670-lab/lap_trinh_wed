using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_service_detail : Page
    {
        private readonly string _conn = ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;
        protected int dichVuId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            // Đọc id từ QueryString
            if (!int.TryParse(Request.QueryString["id"], out dichVuId) || dichVuId <= 0)
            {
                pnlNoData.Visible = true;
                pnlDetail.Visible = false;
                return;
            }

            if (!IsPostBack)
                LoadChiTiet(dichVuId);
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
                            dv.ten_dich_vu,
                            ISNULL(dm.ten_danh_muc, N'Chưa phân loại') AS loai,
                            CAST(dv.thoi_gian AS NVARCHAR) + N' phút' AS thoi_gian,
                            FORMAT(ISNULL(dv.gia_khuyen_mai, dv.gia_goc), N'N0') + N' đ' AS gia_tien,
                            dv.mo_ta,
                            dv.trang_thai
                        FROM dich_vu dv
                        LEFT JOIN danh_muc_dich_vu dm ON dv.danh_muc_id = dm.id
                        WHERE dv.id = @id", conn);

                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    using (var r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            pnlNoData.Visible = true;
                            pnlDetail.Visible = false;
                            return;
                        }

                        // Load dữ liệu
                        ltrServiceName.Text = r["ten_dich_vu"].ToString();
                        ltrType.Text = r["loai"].ToString();
                        ltrTime.Text = r["thoi_gian"].ToString();
                        ltrPrice.Text = r["gia_tien"].ToString();

                        // Xử lý trạng thái
                        bool isActive = Convert.ToBoolean(r["trang_thai"]);
                        lblTrangThai.Attributes["class"] = isActive ? "status-active" : "status-inactive";
                        ltrStatus.Text = isActive ? "Đang hoạt động" : "Đã ngừng hoạt động";

                        // Xử lý mô tả
                        ltrDesc.Text = string.IsNullOrEmpty(r["mo_ta"]?.ToString())
                                     ? "Chưa có mô tả." : r["mo_ta"].ToString();

                        pnlDetail.Visible = true;
                        pnlNoData.Visible = false;
                    }
                }

                Page.Title = ltrServiceName.Text + " - Lily Spa Admin";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadChiTiet Error: " + ex.Message);
                pnlNoData.Visible = true;
                pnlDetail.Visible = false;
            }
        }
    }
}