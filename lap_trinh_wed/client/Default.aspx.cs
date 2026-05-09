using System;
using System.Web.UI;

namespace lap_trinh_wed.client
{
    public partial class Default : Page
    {
        protected string userGreeting = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra đăng nhập để hiện lời chào
            if (Session["HoVaTen"] != null)
                userGreeting = "Xin chào, " + Session["HoVaTen"].ToString();
            else
                userGreeting = "Khách";

            // KHÔNG CẦN gọi LoadData() vì HTML đã có sẵn nội dung
        }
    }
}