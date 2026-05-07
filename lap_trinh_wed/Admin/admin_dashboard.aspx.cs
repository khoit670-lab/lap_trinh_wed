using System;
using System.Web.UI;

namespace lap_trinh_wed.admin
{
    // Đảm bảo tên class là 'dashboard' khớp với thuộc tính Inherits trong file .aspx
    public partial class dashboard : Page
    {
        // Khai báo biến userGreeting duy nhất tại đây
        public string userGreeting { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Gán giá trị hiển thị dưới tên Lily Spa
                userGreeting = "Quản trị viên";
            }
        }
    }
}