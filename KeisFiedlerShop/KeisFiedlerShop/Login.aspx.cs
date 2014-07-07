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

            foreach (var user in query)
            {
                if (user.name == usernameTextBox.Text && user.password == SHA256.Create(passwordTextBox.Text).ToString())
                {
                    
                }
            }
        }
    }
}