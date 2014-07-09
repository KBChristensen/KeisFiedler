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
        public DAL()
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

        public void DeleteUser(long id)
        {
            UserSet delUser = (from user in DbContext.UserSets where user.UserId == id select user).ToList().Find(us => us.UserId == id);
            
            DbContext.UserSets.DeleteOnSubmit(delUser);
        }

        public void DeleteUser(string username)
        {
            UserSet delUser = (from user in DbContext.UserSets where user.Username == username select user).ToList().Find(us => us.Username == username);

            DbContext.UserSets.DeleteOnSubmit(delUser);
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

        public void DeleteCategory(long id)
        {
            Category delCat = (from category in DbContext.Categories where category.CategoryId == id select category).ToList().Find(cat => cat.CategoryId == id);

            DbContext.Categories.DeleteOnSubmit(delCat);
        }

        public void DeleteCategory(string catname)
        {
            Category delCat = (from category in DbContext.Categories where category.CategoryName == catname select category).ToList().Find(cat => cat.CategoryName == catname);

            DbContext.Categories.DeleteOnSubmit(delCat);
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

        public void DeleteProduct(long id)
        {
            Product delProduct = (from product in DbContext.Products where product.ProductId == id select product).ToList().Find(prod => prod.ProductId == id);

            DbContext.Products.DeleteOnSubmit(delProduct);
        }

        public void DeleteProduct(string productname)
        {
            Product delProduct = (from product in DbContext.Products where product.ProductName == productname select product).ToList().Find(prod => prod.ProductName == productname);

            DbContext.Products.DeleteOnSubmit(delProduct);
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

        public void DeleteOrder(long id)
        {
            OrderSet delOrder = (from order in DbContext.OrderSets where order.OrderId == id select order).ToList().Find(order => order.OrderId == id);

            DbContext.OrderSets.DeleteOnSubmit(delOrder);
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