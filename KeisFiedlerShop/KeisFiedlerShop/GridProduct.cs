using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using Microsoft.SqlServer.Server;
using System.Web.UI.WebControls;

namespace KeisFiedlerShop
{
    public class GridProduct
    {
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public Nullable<long> SerialNumber { get; set; }
        public double Price { get; set; }
        public string CategoryName { get; set; }
    }
}