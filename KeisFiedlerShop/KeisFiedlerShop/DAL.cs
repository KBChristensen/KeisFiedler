using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Sockets;
using System.Web;

namespace KeisFiedlerShop
{
    public class DAL : IDAL
    {
        private KeisFiedlerDbDataContext DbContext;
        private List<UserSet> UserList;
        private List<Category> CategoryList;
        private List<OrderSet> OrderList; 
        DAL()
        {
            DbContext = new KeisFiedlerDbDataContext("Data Source=MORTENLAPTOP\\SQLEXPRESS;Initial Catalog=KeisFiedler;Integrated Security=True;MultipleActiveResultSets=True;Application Name=EntityFramework");
        }

        ~DAL()
        {
            DbContext.Dispose();
        }
        public List<UserSet> GetAllUsers()
        {
            List<UserSet> queryList = (from user in DbContext.UserSets select user).ToList();
            return queryList;
        }

        public UserSet GetSpecificUser(long id)
        {
            UserSet tempUser = new UserSet();
            List<UserSet> queryList = (from user in DbContext.UserSets select user).ToList();

            foreach (var user in queryList)
            {
                if (user.UserId == id)
                {
                    tempUser = user;
                }
            }

            return tempUser;
        }

        public List<Category> GetAllCategories()
        {
            List<Category> queryList = (from category in DbContext.Categories select category).ToList();
            return queryList;
        }

        public List<Product> GetAllProductsFromCategory(string catName)
        {
            List<Category> queryList = (from category in DbContext.Categories select category).ToList();
            List<Product> productList = (from product in DbContext.Products select product).ToList();

            Category tempCategory = queryList.Find(cat => cat.CategoryName == catName);
            List<Product> tempProdList = productList.FindAll(prod => prod.CategoryId == tempCategory.CategoryId);

            return tempProdList;

        }

        public Product GetSpecificProduct(long id)
        {
            Product tempProduct = (from product in DbContext.Products select product).ToList().Find(prod => prod.ProductId == id);

            return tempProduct;
        }

        public List<Product> GetAllProducts()
        {
            List<Product> productList = (from product in DbContext.Products select product).ToList();

            return productList;
        }

        public List<OrderSet> GetUserOrders(long userId)
        {
            List<OrderSet> tempOrderList = (from order in DbContext.OrderSets where order.UserId == userId select order).ToList();

            return tempOrderList;
        }

        public List<OrderSet> GetAllOrders()
        {
            List<OrderSet> tempOrderList = (from order in DbContext.OrderSets select order).ToList();

            return tempOrderList;
        }

        public OrderSet GetSpecificOrder(long id)
        {
            OrderSet tempOrder = (from order in DbContext.OrderSets where order.OrderId == id select order) as OrderSet;

            return tempOrder;
        }

        public void CreateUser(UserSet user)
        {
            DbContext.UserSets.InsertOnSubmit(user);
            DbContext.SubmitChanges();
        }

        public void CreateCategory(Category cat)
        {
            DbContext.Categories.InsertOnSubmit(cat);
            DbContext.SubmitChanges();
        }

        public void CreateProduct(Product prod)
        {
            DbContext.Products.InsertOnSubmit(prod);
            DbContext.SubmitChanges();
        }

        public void CreateOrder(OrderSet order)
        {
            DbContext.OrderSets.InsertOnSubmit(order);
            DbContext.SubmitChanges();
        }
    }
}