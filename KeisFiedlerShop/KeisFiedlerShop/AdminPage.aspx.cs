﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace KeisFiedlerShop
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private IDAL adminDbConnect;
        protected void Page_Load(object sender, EventArgs e)
        {
            adminDbConnect = new DAL();
        }

    }
}