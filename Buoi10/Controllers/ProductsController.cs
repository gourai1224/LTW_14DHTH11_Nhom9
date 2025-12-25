using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Buoi10.Models;

namespace Buoi10.Controllers
{
    public class ProductsController : Controller
    {
        private FlowerShopEntities db = new FlowerShopEntities();

        // GET: Products
        public ActionResult Index()
        {
            var product = db.Product.Include(p => p.Category);
            return View(product.ToList());
        }
        public ActionResult DanhMuc()
        {
            return PartialView(db.CategoryGroup.ToList());
        }

        public ActionResult List(int? MaDM, string keyword, int? price)
        {
            var product = db.Product.Include(p => p.Category.CategoryGroup).AsQueryable();

            ViewBag.TenHienThi = "Tất cả sản phẩm";

            if (MaDM.HasValue)
            {
                product = product.Where(p => p.Category.CategoryId == MaDM);

                var currnetCategory = db.Category.Include(c => c.CategoryGroup)
                    .FirstOrDefault(c => c.CategoryId==MaDM);

                if (currnetCategory != null)
                {
                    ViewBag.TenHienThi = currnetCategory.CategoryGroup.GroupName + "/" + currnetCategory.CatName;
                }    
            }    

            if (!string.IsNullOrEmpty(keyword))
            {
                product = product.Where(p => p.ProductName.Contains(keyword));
            }

            if (price.HasValue)
            {
                switch (price)
                {
                    case 1:
                        product = product.Where(p => p.Price < 300000);
                        break;
                    case 2:
                        product = product.Where(p => p.Price >= 300000 && p.Price <= 600000);
                        break;
                    case 3:
                        product = product.Where(p => p.Price > 600000);
                        break;
                }
            }

            return View(product.ToList());
        }


        // GET: Products/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Product.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // GET: Products/Create
        public ActionResult Create()
        {
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CatSlug");
            return View();
        }

        // POST: Products/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProductId,CategoryId,SKU,ProductName,Slug,MainImage,Summary,Price,Stock,IsActive,CreatedAt")] Product product)
        {
            if (ModelState.IsValid)
            {
                db.Product.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CatSlug", product.CategoryId);
            return View(product);
        }

        // GET: Products/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Product.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CatSlug", product.CategoryId);
            return View(product);
        }

        // POST: Products/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProductId,CategoryId,SKU,ProductName,Slug,MainImage,Summary,Price,Stock,IsActive,CreatedAt")] Product product)
        {
            if (ModelState.IsValid)
            {
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CategoryId = new SelectList(db.Category, "CategoryId", "CatSlug", product.CategoryId);
            return View(product);
        }

        // GET: Products/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Product.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Product.Find(id);
            db.Product.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult ThemGioHang(GioHangModel model)
        {
            if (Session["GioHang"] == null)
            {
                Session["GioHang"] = new List<GioHangModel>();
            }
            List<GioHangModel> giohang = (List<GioHangModel>)Session["GioHang"];
            giohang.Add(model);
            Session["GioHang"] = giohang;

            return RedirectToAction("List");
        }

        public ActionResult XoaGioHang(int ProductID)
        {
            if (Session["GioHang"] == null)
            {
                Session["GioHang"] = new List<GioHangModel>();
            }
            List<GioHangModel> giohang = (List<GioHangModel>)Session["GioHang"];

            var model = giohang.SingleOrDefault(gh => gh.ProductID == ProductID);

            giohang.Remove(model);

            Session["GioHang"] = giohang;

            return RedirectToAction("GioHang");
        }

        public ActionResult GioHang()
        {
            if (Session["GioHang"] == null)
            {
                Session["GioHang"] = new List<GioHangModel>();
            }
            List<GioHangModel> giohang = (List<GioHangModel>)Session["GioHang"];

            var idsTrongGioHang = giohang.Select(gh => gh.ProductID);
            var products = db.Product.Where(sp => idsTrongGioHang.Contains(sp.ProductId)).Include(p => p.Category);

            return View(products.ToList());
        }

        [HttpPost]
        public ActionResult CapNhatSoLuong(int ProductID, int Quantity)
        {
            List<GioHangModel> giohang = (List<GioHangModel>)Session["GioHang"];
            if (giohang != null)
            {
                var item = giohang.FirstOrDefault(gh => gh.ProductID == ProductID);
                if (item != null)
                {
                    // Cập nhật số lượng mới (đảm bảo ít nhất là 1)
                    item.Quantity = Quantity > 0 ? Quantity : 1;
                }
            }
            Session["GioHang"] = giohang;
            return RedirectToAction("GioHang");
        }
        public ActionResult CheckOut()
        {
            if (Session["GioHang"] == null)
            {
                Session["GioHang"] = new List<GioHangModel>();
            }
            List<GioHangModel> giohang = (List<GioHangModel>)Session["GioHang"];

            var idsTrongGioHang = giohang.Select(gh => gh.ProductID);
            var products = db.Product.Where(sp => idsTrongGioHang.Contains(sp.ProductId)).Include(p => p.Category);

            return View(products.ToList());
        }
        [HttpPost]
        public ActionResult CheckOut(Order model)
        {
            if (Session["User"] == null)
            {
                return RedirectToAction("DangNhap", "User");
            }    
            if (Session["GioHang"] == null)
            {
                Session["GioHang"] = new List<GioHangModel>();
            }
            List<GioHangModel> giohang = (List<GioHangModel>)Session["GioHang"];
            AppUser user = (AppUser)Session["User"];
            var idsTrongGioHang = giohang.Select(gh => gh.ProductID);
            var products = db.Product.Where(sp => idsTrongGioHang.Contains(sp.ProductId)).Include(p => p.Category);


            model.Status = "PENDING";
            decimal tongtien = 0;
            model.OrderItem = new List<OrderItem>();

            foreach (var item in products)
            {
                var soluong = giohang.FirstOrDefault(gh => gh.ProductID == item.ProductId).Quantity;
                var note = giohang.FirstOrDefault(gh => gh.ProductID == item.ProductId).Note;

                tongtien += soluong * item.Price;
                model.OrderItem.Add(new OrderItem
                {
                    ProductId = item.ProductId,
                    ProductName = item.ProductName,
                    Quantity = soluong,
                    UnitPrice = item.Price,
                    Note = note
                });

            }
            model.TotalAmount = tongtien;
            model.CreatedAt = DateTime.Now;


            db.Order.Add(model);
            db.SaveChanges();

            return RedirectToAction("Success", new {id =  model.OrderId});
        }
        public ActionResult Success(int id)
        {

            return View(db.Order.Find(id));
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
