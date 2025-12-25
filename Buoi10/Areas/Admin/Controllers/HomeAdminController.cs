using System.Linq;
using System.Web.Mvc;
using Buoi10.Models; // Nhớ đổi namespace nếu khác

namespace Buoi10.Areas.Admin.Controllers
{
    public class HomeAdminController : Controller
    {
        // 1. Khởi tạo kết nối CSDL
        FlowerShopEntities db = new FlowerShopEntities();

        public ActionResult Index()
        {
            // --- THỐNG KÊ SỐ LIỆU ---

            // A. Tổng số đơn hàng (Đếm tất cả)
            ViewBag.CountOrder = db.Order.Count();

            // B. Doanh thu (Chỉ tính những đơn đã HOÀN THÀNH - Status là "DONE")
            // Dùng (decimal?) để tránh lỗi nếu chưa có đơn nào
            ViewBag.Revenue = db.Order
                .Where(o => o.Status == "DONE")
                .Sum(o => (decimal?)o.TotalAmount)
                .GetValueOrDefault();

            // C. Sản phẩm (Đếm sản phẩm đang kích hoạt)
            ViewBag.CountProduct = db.Product.Where(p => p.IsActive == true).Count();

            // D. Đơn chờ xử lý (Đếm đơn có trạng thái là PENDING hoặc NEW)
            ViewBag.CountPending = db.Order
                .Where(o => o.Status == "PENDING" || o.Status == "NEW")
                .Count();

            // --- LẤY DANH SÁCH ĐƠN HÀNG MỚI NHẤT ---
            // Lấy 5 đơn mới nhất (OrderByDescending) để hiện ra bảng
            var recentOrders = db.Order.OrderByDescending(o => o.CreatedAt).Take(5).ToList();

            return View(recentOrders);
        }
    }
}