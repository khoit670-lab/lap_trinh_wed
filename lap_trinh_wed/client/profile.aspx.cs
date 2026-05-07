using System;

namespace lap_trinh_wed.client
{
    public partial class profile : System.Web.UI.Page
    {
        public string userGreeting = "xin chào!";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra xem user đã đăng nhập chưa từ Session
                if (Session["UserName"] != null)
                {
                    string name = Session["UserName"].ToString();
                    userGreeting = "xin chào, " + name + "!";
                    ltrName.Text = name; // Hiển thị tên lên giao diện
                }

            }
        }
    }
}