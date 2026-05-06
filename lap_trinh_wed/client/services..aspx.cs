using System;

namespace lap_trinh_wed.client
{
    public partial class services : System.Web.UI.Page
    {
        public string userGreeting = "xin chào!"; // Giá trị mặc định[cite: 7]

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra xem người dùng đã đăng nhập chưa từ Session
                if (Session["UserName"] != null)
                {
                    userGreeting = "xin chào, " + Session["UserName"].ToString() + "!";
                }
            }
        }
    }
}