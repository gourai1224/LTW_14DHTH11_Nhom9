using System.Linq;
using System.Web.Mvc;
using Buoi10.Models;

namespace Buoi10.Areas.Admin.Controllers
{
    public class CategoryGroupController : Controller
    {
        FlowerShopEntities db = new FlowerShopEntities();

        // 1. Danh sách
        public ActionResult Index()
        {
            return View(db.CategoryGroup.OrderBy(x => x.SortOrder).ToList());
        }

        // 2. Tạo mới (GET)
        public ActionResult Create()
        {
            return View();
        }

        // 3. Tạo mới (POST)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(CategoryGroup model)
        {
            if (ModelState.IsValid)
            {
                // Tự động tạo ngày nếu chưa có
                model.CreatedAt = System.DateTime.Now;
                db.CategoryGroup.Add(model);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(model);
        }

        // 4. Sửa (GET)
        public ActionResult Edit(int id)
        {
            var item = db.CategoryGroup.Find(id);
            if (item == null) return HttpNotFound();
            return View(item);
        }

        // 5. Sửa (POST - Cập nhật từng trường cho an toàn)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(CategoryGroup model)
        {
            if (ModelState.IsValid)
            {
                var itemInDb = db.CategoryGroup.Find(model.GroupId);
                if (itemInDb != null)
                {
                    itemInDb.GroupName = model.GroupName;
                    itemInDb.GroupCode = model.GroupCode;
                    itemInDb.SortOrder = model.SortOrder;
                    itemInDb.IsActive = model.IsActive;
                    // Không cập nhật CreatedAt để giữ nguyên ngày tạo cũ

                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            return View(model);
        }

        // 6. Xóa (GET - Hiện bảng xác nhận)
        public ActionResult Delete(int id)
        {
            var item = db.CategoryGroup.Find(id);
            if (item == null) return HttpNotFound();
            return View(item);
        }

        // 7. Xóa (POST - Xóa thật)
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var item = db.CategoryGroup.Find(id);

            // Kiểm tra xem có Danh mục con nào đang bám vào nhóm này không?
            bool hasChild = db.Category.Any(c => c.GroupId == id);
            if (hasChild)
            {
                ViewBag.Error = "Không thể xóa! Nhóm này đang chứa các danh mục con.";
                return View(item);
            }

            db.CategoryGroup.Remove(item);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}