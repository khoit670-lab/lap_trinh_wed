using System;

namespace lap_trinh_wed.client
{
    public partial class promotions : System.Web.UI.Page
    {
        // Phải có dòng này và phải là public hoặc protected
        public string userGreeting = "xin chào!";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserName"] != null)
                {
                    userGreeting = "xin chào, " + Session["UserName"].ToString() + "!";
                }
            }
        }
    }
}