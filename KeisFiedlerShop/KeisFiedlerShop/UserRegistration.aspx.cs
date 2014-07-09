using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KeisFiedlerShop
{
    public partial class UserRegistration : System.Web.UI.Page
    {
        private IDAL DbConnection;

        protected void Page_Load(object sender, EventArgs e)
        {
            DbConnection = new DAL();
        }

        protected void registerBtn_OnClick(object sender, EventArgs e)
        {

            UserSet user = new UserSet();
            user.Username = usernameTextBox.Text;
            user.Name = nameTextBox.Text;
            user.Address = adressTextBox.Text;
            user.Zipcode = int.Parse(zipcodeTextBox.Text);
            user.Password = passwordTextBox.Text;
            user.Email = emailTextBox.Text;
            user.Userlevel = 3;

            DbConnection.CreateUser(user);


        }

    }
}
