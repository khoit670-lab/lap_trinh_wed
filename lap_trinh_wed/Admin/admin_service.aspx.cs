using System;
using System.Data;
using System.Web;

namespace lap_trinh_wed.admin
{
    public partial class admin_service : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VaiTro"] == null || !(bool)(Session["IsAdmin"] ?? false))
            {
                Response.Redirect("../client/Default.aspx?noaccess=1");
                return;
            }
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ID");
            dt.Columns.Add("TenDichVu");
            dt.Columns.Add("Loai");
            dt.Columns.Add("ThoiGian");
            dt.Columns.Add("GiaTien");

            // Dữ liệu mẫu bám sát mockup
            dt.Rows.Add("1", "Chăm sóc da Collagen Glow", "Chăm sóc da", "60 phút", "1.200.000đ");
            dt.Rows.Add("2", "Massage thư giãn toàn thân", "Massage", "90 Phút", "800.000đ");
            dt.Rows.Add("3", "Trị mụn chuyên sâu", "Trị mụn", "1 giờ 30 phút", "2.000.000đ");
            dt.Rows.Add("4", "Body Detox & Tan Mỡ", "Body", "45 phút", "1.000.000đ");

            rptServices.DataSource = dt;
            rptServices.DataBind();
        }
    }
}