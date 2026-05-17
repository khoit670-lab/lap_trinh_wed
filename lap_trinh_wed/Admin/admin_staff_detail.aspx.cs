using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    public partial class admin_staff_detail : Page
    {
        private readonly string _conn =
            ConfigurationManager.ConnectionStrings["LilySpaDB"].ConnectionString;

        protected int nhanSuId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null)
            {
                Response.Redirect("../client/login.aspx");
                return;
            }

            // Đọc id từ QueryString: admin_staff_detail.aspx?id=1
            if (!int.TryParse(Request.QueryString["id"], out nhanSuId) || nhanSuId <= 0)
            {
                Response.Redirect("admin_staff.aspx");
                return;
            }

            if (!IsPostBack)
                LoadChiTiet(nhanSuId);
        }

        // ── Load thông tin nhân sự từ DB ──────────────────────────
        private void LoadChiTiet(int id)
        {
            try
            {
                using (var conn = new SqlConnection(_conn))
                {
                    var cmd = new SqlCommand(@"
                        SELECT
                            ho_va_ten,
                            so_dien_thoai,
                            chuc_vu,
                            trang_thai,
                            ISNULL(ghi_chu, N'Chưa có đánh giá') AS ghi_chu,
                            ISNULL(ca_lam_viec, N'Chưa phân ca')  AS ca_lam_viec
                        FROM nhan_su
                        WHERE id = @id", conn);

                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();

                    using (var r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            Response.Redirect("admin_staff.aspx");
                            return;
                        }

                        // Gán vào đúng Literal ID theo designer.cs
                        ltrFullName.Text = r["ho_va_ten"].ToString();
                        ltrPhone.Text = r["so_dien_thoai"].ToString();
                        ltrPosition.Text = r["chuc_vu"].ToString();
                        ltrStatus.Text = r["trang_thai"].ToString();
                        ltrNote.Text = r["ghi_chu"].ToString();
                        ltrShift.Text = r["ca_lam_viec"].ToString();

                        // Hiển thị panel chi tiết
                        pnlDetail.Visible = true;
                        pnlNoData.Visible = false;
                    }
                }

                Page.Title = ltrFullName.Text + " - Lily Spa Admin";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadChiTiet Error: " + ex.Message);
            }
        }

        // ── Sự kiện: nút Chỉnh sửa → sang trang edit ─────────────
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin_staff_edit.aspx?id=" + nhanSuId);
        }
    }
}