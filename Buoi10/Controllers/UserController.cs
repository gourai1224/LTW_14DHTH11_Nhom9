using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Common.CommandTrees;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Buoi10.Models;

namespace Buoi10.Controllers
{
    public class UserController : Controller
    {
        private FlowerShopEntities db = new FlowerShopEntities();
        // GET: User
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(Buoi10.Models.AppUser model)
        {
            // --- BƯỚC 1: CHECK BẢNG ADMIN TRƯỚC ---
            // (Lưu ý: Bảng Admin cột mật khẩu tên là MatKhau, còn form gửi lên là PasswordHash)
            var admin = db.Admins.FirstOrDefault(a => a.Email == model.Email && a.MatKhau == model.PasswordHash.ToString());

            if (admin != null)
            {
                // Nếu tìm thấy trong bảng Admin -> Lưu Session Admin -> Chuyển hướng vào khu Admin
                Session["Admin"] = admin;

                // Chuyển hướng sang Area Admin (Controller: HomeAdmin, Action: Index)
                return RedirectToAction("Index", "HomeAdmin", new { area = "Admin" });
            }

            // --- BƯỚC 2: NẾU KHÔNG PHẢI ADMIN THÌ CHECK BẢNG KHÁCH (Code cũ của bạn) ---
            var user = db.AppUser.FirstOrDefault(us => us.Email == model.Email && us.PasswordHash == model.PasswordHash);
            if (user != null)
            {
                Session["user"] = user;
                return RedirectToAction("Index", "Products"); // Hoặc trang chủ tùy bạn
            }

            // --- BƯỚC 3: KHÔNG THẤY Ở ĐÂU HẾT ---
            ViewBag.Msg = "Đăng nhập thất bại! Sai email hoặc mật khẩu.";
            return View();
        }
        public ActionResult DangXuat()
        {
            Session["user"] = null;
            return RedirectToAction("Index", "Products");
        }

        public ActionResult DangKy()
        {
            return View();
        }


        [HttpPost]
        public ActionResult DangKy(AppUser model)
        {
            var check = db.AppUser.FirstOrDefault(u => u.Email == model.Email);
            if (check != null)
            {
                ViewBag.Msg = "Email đã tồn tại!";
                return View();
            }

            model.CreatedAt = DateTime.Now;
            model.IsActive = true;

            db.AppUser.Add(model);
            db.SaveChanges();

            ViewBag.Msg = "Đăng ký thành công! Vui lòng đăng nhập.";
            return RedirectToAction("DangNhap");
        }


    }
}