package vn.nganj.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.nganj.laptopshop.service.OrderService;
import vn.nganj.laptopshop.service.ProductService;
import vn.nganj.laptopshop.service.UserService;

@Controller
public class DashboardController {
    private final OrderService orderService;
    private final ProductService productService;
    private final UserService userService;

    public DashboardController(OrderService orderService, ProductService productService, UserService userService) {
        this.orderService = orderService;
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/admin")
    public String getDashboardPage(Model model){
        model.addAttribute("totalOrders", orderService.getTotalOrders());
        model.addAttribute("totalRevenue", orderService.getTotalRevenue());
        model.addAttribute("totalProducts", productService.countProduct());
        model.addAttribute("totalUsers", userService.countUser());

        // Dữ liệu cho biểu đồ doanh thu theo tuần (7 ngày gần đây)
        model.addAttribute("weeklyRevenue", orderService.getWeeklyRevenueLastSevenDays());

        // Dữ liệu cho biểu đồ trạng thái đơn hàng
        // [số_chờ_xử_lý, số_đã_xác_nhận, số_đang_giao, số_hoàn_thành, số_đã_hủy]
        model.addAttribute("orderStatusData", orderService.getOrderStatusData());

        // Danh sách đơn hàng gần đây (10 đơn mới nhất)
        model.addAttribute("recentOrders", orderService.getRecentOrders(10));

//        // Top 5 sản phẩm bán chạy nhất
        model.addAttribute("topSellingProducts", productService.getTopSellingProducts(5));
//
//        // 5 sản phẩm sắp hết hàng (quantity < 10)
        model.addAttribute("lowStockProducts", productService.getLowStockProducts(5));
        return "admin/dashboard/show";
    }
}
