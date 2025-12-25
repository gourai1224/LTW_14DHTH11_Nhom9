using System.Linq;
using System.Web.Mvc;
using Buoi10.Models;
using Buoi10.Common;

namespace Buoi10.Areas.Admin.Controllers
{
    public class AdminAuthController : Controller
    {
        FlowerShopEntities db = new FlowerShopEntities();

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string email, string password)
        {
            var admin = db.Admins
                .FirstOrDefault(a => a.Email == email && a.MatKhau == password);

            if (admin != null)
            {
                SessionHelper.SetAdmin(admin);
                return RedirectToAction("Index", "HomeAdmin");
            }

            ViewBag.Error = "Sai email hoặc mật khẩu";
            return View();
        }

        public ActionResult Logout()
        {
            SessionHelper.AdminLogout();
            return RedirectToAction("DangNhap", "User", new { area = "" });
        }
    }
}
