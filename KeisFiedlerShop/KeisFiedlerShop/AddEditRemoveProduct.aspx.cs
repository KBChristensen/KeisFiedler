using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KeisFiedlerShop
{
    public partial class AddEditRemoveProduct : System.Web.UI.Page
    {
        private IDAL adminDbConnect;
        private List<Product> productList;
        private List<Category> categoryList;
        private List<GridProduct> gridProductList; 
        protected void Page_Load(object sender, EventArgs e)
        {
            adminDbConnect = new DAL();

            productList = adminDbConnect.GetAllProducts();
            categoryList = adminDbConnect.GetAllCategories();

          

            GridProduct gridProduct = new GridProduct();
            gridProductList = new List<GridProduct>();
            

            foreach (var product in productList)
            {
                gridProduct.ProductName = product.ProductName;
                gridProduct.Price = product.Price;
                gridProduct.ProductImage = product.ProductImage;
                gridProduct.CategoryName = categoryList.Find(cat => product.CategoryId == cat.CategoryId).CategoryName;
                gridProduct.SerialNumber = product.SerialNumber;

                gridProductList.Add(gridProduct);
            }

            CreateDataSource();
        }

        

        protected void CreateDataSource()
        {
            adminProductDataGrid.DataSource = gridProductList;
            adminProductDataGrid.DataBind();
        } 
    }
}