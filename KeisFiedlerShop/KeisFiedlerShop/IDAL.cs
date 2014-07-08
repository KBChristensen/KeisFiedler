using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KeisFiedlerShop
{
    interface IDAL
    {
        List<UserSet> GetAllUsers();
        UserSet GetSpecificUser(long id);
        void CreateUser(UserSet user);
        List<Category> GetAllCategories();
        List<Product> GetAllProductsFromCategory(string catName);
        void CreateCategory(Category cat);
        Product GetSpecificProduct(long id);
        List<Product> GetAllProducts();
        void CreateProduct(Product prod);
        List<OrderSet> GetUserOrders(long userId);
        List<OrderSet> GetAllOrders();
        OrderSet GetSpecificOrder(long id);
        void CreateOrder(OrderSet order);


    }
}
