using System;

namespace lap_trinh_wed.client
{
    public partial class service_detail : System.Web.UI.Page
    {
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