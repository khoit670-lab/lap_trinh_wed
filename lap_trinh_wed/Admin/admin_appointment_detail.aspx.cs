using System;

namespace lap_trinh_wed.admin
{
    public partial class appointment_detail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Sau này bạn có thể dùng QueryString để lấy ID lịch hẹn
                // Ví dụ: string appointmentId = Request.QueryString["id"];
            }
        }

        // Bạn có thể viết thêm code xử lý khi nhấn Check-in hoặc Hủy tại đây
    }
}