using Buoi10.Models;
using System;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Buoi10.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        FlowerShopEntities db = new FlowerShopEntities();

        public ActionResult Index()
        {
            return View(db.Product.ToList());
        }

        public ActionResult Create()
        {
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CatName");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Product model, HttpPostedFileBase uploadImage)
        {
            if (!ModelState.IsValid)
            {
                ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CatName", model.CategoryId);
                return View(model);
            }

            // ==== GÁN GIÁ TRỊ BẮT BUỘC ====
            model.CreatedAt = DateTime.Now;

            if (string.IsNullOrEmpty(model.SKU))
                model.SKU = "SKU-" + DateTime.Now.Ticks;

            model.Slug = model.ProductName.Trim().ToLower().Replace(" ", "-");

            // ==== UPLOAD ẢNH ====
            if (uploadImage != null && uploadImage.ContentLength > 0)
            {
                string fileName = Guid.NewGuid() + Path.GetExtension(uploadImage.FileName);
                string path = Path.Combine(
     Server.MapPath("~/assets/img"), fileName
 );

                uploadImage.SaveAs(path);
                model.MainImage = fileName; // chỉ lưu tên ảnh


                uploadImage.SaveAs(path);
                model.MainImage = fileName;
            }
            else
            {
                model.MainImage = "no-image.jpg"; // ảnh mặc định
            }

            // Mô tả
            if (string.IsNullOrEmpty(model.Summary))
                model.Summary = "Đang cập nhật";

            db.Product.Add(model);
            db.SaveChanges();

            return RedirectToAction("Index");
        }

        // --- THÊM VÀO ProductController.cs ---

        // 1. Hiện form sửa (GET)
        public ActionResult Edit(int id)
        {
            var product = db.Product.Find(id);
            if (product == null) return HttpNotFound();

            // Load danh mục để chọn lại
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CatName", product.CategoryId);

            return View(product);
        }

        // 2. Lưu dữ liệu sửa (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Product model, HttpPostedFileBase uploadImage)
        {
            if (ModelState.IsValid)
            {
                var productInDb = db.Product.Find(model.ProductId);

                if (productInDb != null)
                {
                    // Cập nhật các thông tin thường
                    productInDb.ProductName = model.ProductName;
                    productInDb.CategoryId = model.CategoryId;
                    productInDb.Price = model.Price;
                    productInDb.Stock = model.Stock;
                    productInDb.IsActive = model.IsActive;
                    productInDb.Summary = model.Summary;
                    productInDb.SKU = model.SKU;

                    // Xử lý Slug (tạo lại nếu tên thay đổi)
                    productInDb.Slug = model.ProductName.Trim().ToLower().Replace(" ", "-");

                    // Xử lý ẢNH: Nếu có chọn ảnh mới thì mới thay đổi
                    if (uploadImage != null && uploadImage.ContentLength > 0)
                    {
                        string fileName = Guid.NewGuid() + Path.GetExtension(uploadImage.FileName);
                        string path = Path.Combine(Server.MapPath("~/assets/img"), fileName);
                        uploadImage.SaveAs(path);

                        productInDb.MainImage = fileName; // Cập nhật tên ảnh mới
                    }
                    // Nếu không chọn ảnh mới thì giữ nguyên productInDb.MainImage cũ

                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }

            // Nếu lỗi thì load lại danh mục
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CatName", model.CategoryId);
            return View(model);
        }


        public ActionResult Delete(int id)
        {
            var p = db.Product.Find(id);
            db.Product.Remove(p);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
