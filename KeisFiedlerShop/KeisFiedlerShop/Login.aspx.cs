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
        private IEncryption encrypt;
        protected void Page_Load(object sender, EventArgs e)
        {
            encrypt = new EncryptSHA256();
        }

        protected void loginBtn_OnClick(object sender, EventArgs e)
        {
            KeisFiedlerDbDataContext keisFiedlerDb = new KeisFiedlerDbDataContext();

            var query = (from user in keisFiedlerDb.UserSets select user).ToList();

            

            
            if (query.Count > 0)
            {
                foreach (var user in query)
                {
                    if (user.Username == usernameTextBox.Text && user.Password == encrypt.EncryptString(passwordTextBox.Text))
                    {
                        if (user.Userlevel == 3)
                        {
                            Server.Transfer("Mypage.aspx", true);
                        }
                        else if (user.Userlevel == 2)
                        {
                            
                        }
                        else if (user.Userlevel == 1)
                        {
                            Server.Transfer("AdminPage.aspx", true);
                        }
                        
                        
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