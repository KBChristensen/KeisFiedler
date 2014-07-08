using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace KeisFiedlerShop
{
    public class EncryptSHA256 : IEncryption
    {
        public string EncryptString(string str)
        {
            SHA256 temp256 = SHA256.Create();
            byte[] byteArr = Encoding.UTF8.GetBytes(str);
            byte [] hashBytes = temp256.ComputeHash(byteArr);

            return Encoding.UTF8.GetString(hashBytes);


        }
    }
}