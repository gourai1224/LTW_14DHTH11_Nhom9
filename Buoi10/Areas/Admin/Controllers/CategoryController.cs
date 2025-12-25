using System.Linq;
using System.Web.Mvc;
using Buoi10.Models;

namespace Buoi10.Areas.Admin.Controllers
{
    public class CategoryController : Controller
    {
        FlowerShopEntities db = new FlowerShopEntities();

        public ActionResult Index()
        {
            return View(db.Category.ToList());
        }

        public ActionResult Create()
        {
            ViewBag.GroupId = new SelectList(db.CategoryGroup, "GroupId", "GroupName");
            return View();
        }

        [HttpPost]
        public ActionResult Create(Category model)
        {
            db.Category.Add(model);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // --- THÊM VÀO CategoryController.cs ---

        // 1. Chức năng SỬA (GET - Hiển thị form)
        public ActionResult Edit(int id)
        {
            var item = db.Category.Find(id);
            if (item == null) return HttpNotFound();

            // Load danh sách Nhóm để chọn lại (nếu muốn chuyển nhóm)
            ViewBag.GroupId = new SelectList(db.CategoryGroup, "GroupId", "GroupName", item.GroupId);

            return View(item);
        }

        // 2. Chức năng SỬA (POST - Lưu dữ liệu)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Category model)
        {
            if (ModelState.IsValid)
            {
                // Tìm đối tượng cũ trong DB
                var categoryInDb = db.Category.Find(model.CategoryId);
                if (categoryInDb != null)
                {
                    categoryInDb.CatName = model.CatName;
                    categoryInDb.CatSlug = model.CatSlug; // URL SEO
                    categoryInDb.GroupId = model.GroupId; // Đổi nhóm cha
                    categoryInDb.SortOrder = model.SortOrder;
                    categoryInDb.IsActive = model.IsActive;

                    // Lưu ý: Không cập nhật CreatedAt

                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }

            // Nếu lỗi thì load lại Dropdown
            ViewBag.GroupId = new SelectList(db.CategoryGroup, "GroupId", "GroupName", model.GroupId);
            return View(model);
        }

        // 3. Chức năng XÓA (GET - Xác nhận)
        public ActionResult Delete(int id)
        {
            var item = db.Category.Find(id);
            if (item == null) return HttpNotFound();
            return View(item);
        }

        // 4. Chức năng XÓA (POST - Xóa thật)
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var item = db.Category.Find(id);

            // Kiểm tra xem có sản phẩm nào đang thuộc danh mục này không?
            var hasProduct = db.Product.Any(x => x.CategoryId == id);
            if (hasProduct)
            {
                // Nếu có sản phẩm thì không cho xóa, báo lỗi
                ViewBag.Error = "Không thể xóa danh mục này vì đang có sản phẩm bên trong!";
                return View(item);
            }

            db.Category.Remove(item);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
