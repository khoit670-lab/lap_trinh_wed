using System;
using System.Collections.Generic;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    // Tên class phải khớp với thuộc tính Inherits trong file .aspx
    public partial class appointment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra nếu là lần đầu load trang
            if (!IsPostBack)
            {
                // Sau này bạn sẽ viết code lấy dữ liệu từ Database ở đây
                LoadAppointmentData();
            }
        }

        private void LoadAppointmentData()
        {
            // Hiện tại chúng ta đang để dữ liệu cứng (HTML) bên file .aspx 
            // nên hàm này tạm thời để trống để trang web không bị lỗi.
        }

        // Ví dụ: Hàm xử lý khi nhấn nút "Chi tiết"
        protected void btnViewDetail_Click(object sender, EventArgs e)
        {
            // Code chuyển hướng hoặc hiện popup chi tiết
        }
    }
}