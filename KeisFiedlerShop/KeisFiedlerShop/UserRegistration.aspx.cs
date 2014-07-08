using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KeisFiedlerShop
{
	public partial class UserRegistration : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void registerBtn_OnClick(object sender, EventArgs e)
        {
            using (KeisFiedlerContainer keisFiedlerDb = new KeisFiedlerContainer())
            {
                KeisFiedlerShop.User user = new User();
                user.username = usernameTextBox.Text;
                user.name = nameTextBox.Text;
                user.address = adressTextBox.Text;
                user.zipcode = zipcodeTextBox.Text;
                user.password = passwordTextBox.Text;
                

                // KeisFiedlerShop.User.InsertOnSubmit(user);
                // KeisFiedlerShop.SubmitChanges();

            }
        };

            
	}
}