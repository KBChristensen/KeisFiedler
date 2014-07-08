using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KeisFiedlerShop
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginBtn_OnClick(object sender, EventArgs e)
        {
            KeisFiedlerContainer keisFiedlerDb = new KeisFiedlerContainer();

            var query = (from user in keisFiedlerDb.UserSet select user).ToList();

            if (query.Count > 0)
            {
                foreach (var user in query)
                {
                    if (user.username == usernameTextBox.Text && user.password == SHA256.Create(passwordTextBox.Text).ToString())
                    {
                        Server.Transfer("About.aspx", true);
                    }
                }
            }
            else
            {
                loginErrorLabel.Text = "Forkert Brugernavn eller password, prøv igen";
                loginErrorLabel.Visible = true;
            }
            
        }

        protected void registerBtn_OnClick(object sender, EventArgs e)
        {
            Server.Transfer("UserRegistration.aspx", true); ;
        }
    }
}