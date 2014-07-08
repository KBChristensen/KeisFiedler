using System;
using System.Collections.Generic;
using System.Data.Entity;
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
            string conString = "Data Source=MORTENLAPTOP\\SQLEXPRESS;Initial Catalog=KeisFiedler;Integrated Security=True;MultipleActiveResultSets=True;Application Name=EntityFramework";
            using (KeisFiedlerDbDataContext keisFiedlerDb = new KeisFiedlerDbDataContext(conString))
            {
                UserSet user = new UserSet();
                user.Username = usernameTextBox.Text;
                user.Name = nameTextBox.Text;
                user.Address = adressTextBox.Text;
                user.Zipcode = int.Parse(zipcodeTextBox.Text);
                user.Password = passwordTextBox.Text;
                user.Email = emailTextBox.Text;
                user.Userlevel = 3;

                keisFiedlerDb.UserSets.InsertOnSubmit(user);
                keisFiedlerDb.SubmitChanges();
            }
        }

            
	}
}