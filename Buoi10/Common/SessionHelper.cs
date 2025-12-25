using Buoi10.Models;
using System.Web;

namespace Buoi10.Common
{
    public class SessionHelper
    {
        public static void SetAdmin(Admin admin)
        {
            HttpContext.Current.Session["ADMIN"] = admin;
        }

        public static Admin GetAdmin()
        {
            return HttpContext.Current.Session["ADMIN"] as Admin;
        }

        public static void AdminLogout()
        {
            HttpContext.Current.Session["ADMIN"] = null;
        }
    }
}
