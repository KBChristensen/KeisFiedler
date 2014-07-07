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
            KeisFiedlerContainer test = new KeisFiedlerContainer();

            var query = (from variable in test.UserSet where variable.Id == 1 select variable).ToList();

            foreach (var user in query)
            {
                label1.Text = user.name;
                label2.Text = user.password;
            }

        }
    }
}