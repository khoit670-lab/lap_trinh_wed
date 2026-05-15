using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_customer_detail : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

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
                LoadThongTin(khachHangId);
                LoadLichSu(khachHangId);
            }

            // 🔥 FIX NÚT CHỈNH SỬA
            Page.DataBind();
        }

        private void LoadThongTin(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT
                            ho_va_ten, so_dien_thoai,
                            hang_khach_hang, diem_tich_luy,
                            ghi_chu, trang_thai
                        FROM khach_hang
                        WHERE id = @id", conn);

                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    using (var r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            pnlDetail.Visible = false;
                            pnlNoData.Visible = true;
                            return;
                        }

                        ltrFullName.Text = r["ho_va_ten"].ToString();
                        ltrPhone.Text = r["so_dien_thoai"].ToString();
                        ltrRank.Text = r["hang_khach_hang"].ToString();
                        ltrPoints.Text = string.Format("{0:N0} điểm", Convert.ToInt32(r["diem_tich_luy"]));
                        ltrStatus.Text = r["trang_thai"].ToString() == "1" ? "Hoạt động" : "Không hoạt động";

                        lblTrangThaiKH.Attributes["class"] = r["trang_thai"].ToString() == "1"
                            ? "status-badge status-active"
                            : "status-badge status-inactive";

                        string ghiChu = r["ghi_chu"].ToString();
                        ltrInternalNote.Text = string.IsNullOrEmpty(ghiChu) ? "Không có ghi chú" : ghiChu;

                        pnlDetail.Visible = true;
                        pnlNoData.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadThongTin Error: " + ex.Message);
                pnlDetail.Visible = false;
                pnlNoData.Visible = true;
            }
        }

        private void LoadLichSu(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT TOP 10
                            lh.ngay_hen,
                            STRING_AGG(CAST(dv.ten_dich_vu AS NVARCHAR(MAX)), N', ') AS ten_dich_vu,
                            SUM(lhct.thanh_tien) AS tong_tien
                        FROM lich_hen lh
                        LEFT JOIN lich_hen_chi_tiet lhct ON lhct.lich_hen_id = lh.id
                        LEFT JOIN dich_vu dv ON lhct.dich_vu_id = dv.id
                        WHERE lh.khach_hang_id = @id AND lh.trang_thai = N'Hoàn thành'
                        GROUP BY lh.id, lh.ngay_hen
                        ORDER BY lh.ngay_hen DESC", conn);

                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    var da = new SqlDataAdapter(cmd);
                    var dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptHistory.DataSource = dt;
                        rptHistory.DataBind();
                        pnlHistory.Visible = true;
                        pnlNoHistory.Visible = false;
                    }
                    else
                    {
                        pnlHistory.Visible = false;
                        pnlNoHistory.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadLichSu Error: " + ex.Message);
                pnlNoHistory.Visible = true;
            }
        }
    }
}