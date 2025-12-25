using Buoi10.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Buoi10.Areas.Admin.Controllers
{
    public class ReportController : Controller
    {
        FlowerShopEntities db = new FlowerShopEntities();

        public ActionResult Revenue()
        {
            var data = db.Order
                .GroupBy(o => new { o.CreatedAt.Year, o.CreatedAt.Month })
                .Select(g => new RevenueVM
                {
                    Year = g.Key.Year,
                    Month = g.Key.Month,
                    Total = g.Sum(x => x.TotalAmount)
                })
                .ToList();

            return View(data);
        }

    }

}