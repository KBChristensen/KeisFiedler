using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KeisFiedlerShop
{

    public partial class About : Page
    {
        private string username;
        private string password;
        protected void Page_Load(object sender, EventArgs e)
        {
            KeisFiedlerDbDataContext test = new KeisFiedlerDbDataContext();

            var query = (from variable in test.UserSets where variable.UserId == 1 select variable).ToList();

            foreach (var user in query)
            {
                label1.Text = user.Name;
                label2.Text = user.Password;
            }

        }
    }
}