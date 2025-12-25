using System.Linq;
using System.Web.Mvc;
using Buoi10.Models;

namespace Buoi10.Areas.Admin.Controllers
{
    public class OrderController : Controller
    {
        FlowerShopEntities db = new FlowerShopEntities();

        // Danh sách đơn hàng
        public ActionResult Index()
        {
            var orders = db.Order
                           .OrderByDescending(o => o.CreatedAt)
                           .ToList();
            return View(orders);
        }

        // Chi tiết đơn hàng
        public ActionResult Detail(int id)
        {
            var items = db.OrderItem
                          .Where(x => x.OrderId == id)
                          .ToList();
            ViewBag.Order = db.Order.Find(id);
            return View(items);
        }

        // Cập nhật trạng thái
        public ActionResult UpdateStatus(int id)
        {
            var order = db.Order.Find(id);
            return View(order);
        }

        [HttpPost]
        public ActionResult UpdateStatus(int id, string status)
        {
            var order = db.Order.Find(id);
            order.Status = status;
            db.SaveChanges();
            return RedirectToAction("Index");
        }


    }
}
