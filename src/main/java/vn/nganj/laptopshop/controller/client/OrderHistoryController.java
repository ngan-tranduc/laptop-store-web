package vn.nganj.laptopshop.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.nganj.laptopshop.domain.Order;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.service.OrderService;
import vn.nganj.laptopshop.service.UserService;

@Controller
public class OrderHistoryController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    /**
     * Hiển thị trang lịch sử đặt hàng
     */
    @GetMapping("/order-history")
    public String showOrderHistory(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String status,
            Model model,
            HttpServletRequest request) {

        // Lấy user hiện tại
        User currentUser = getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/login";
        }

        // Tạo Pageable với sắp xếp theo ngày tạo (mới nhất trước)
        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());

        // Lấy danh sách đơn hàng
        Page<Order> orderPage;
        if (status != null && !status.isEmpty()) {
            orderPage = orderService.getOrdersByUserAndStatus(currentUser, status, pageable);
        } else {
            orderPage = orderService.getOrdersByUser(currentUser, pageable);
        }

        // Thêm attributes vào model
        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("pageSize", size);
        model.addAttribute("totalElements", orderPage.getTotalElements());
        model.addAttribute("selectedStatus", status);

        return "client/order/history";
    }

    /**
     * Xem chi tiết đơn hàng
     */
    @GetMapping("/order-details/{orderId}")
    public String viewOrderDetails(@PathVariable Long orderId, Model model, HttpServletRequest request) {

        // Lấy user hiện tại
        User currentUser = getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/login";
        }

        // Lấy thông tin đơn hàng
        Order order = orderService.findById(orderId);

        // Kiểm tra quyền truy cập
        if (order == null || !order.getUser().getId().equals(currentUser.getId())) {
            return "redirect:/order-history?error=access-denied";
        }

        model.addAttribute("order", order);
        return "client/order/details";
    }

    /**
     * API: Hủy đơn hàng
     */
    @PutMapping("/api/orders/{orderId}/cancel")
    @ResponseBody
    public ResponseEntity<?> cancelOrder(@PathVariable Long orderId, HttpServletRequest request) {
        try {
            // Lấy user hiện tại
            User currentUser = getCurrentUser(request);
            if (currentUser == null) {
                return ResponseEntity.status(401).body("Unauthorized");
            }

            // Lấy thông tin đơn hàng
            Order order = orderService.findById(orderId);

            // Kiểm tra quyền và trạng thái
            if (order == null || !order.getUser().getId().equals(currentUser.getId())) {
                return ResponseEntity.status(403).body("Access denied");
            }

            if (!"PENDING".equals(order.getStatus())) {
                return ResponseEntity.status(400).body("Không thể hủy đơn hàng này");
            }

            // Cập nhật trạng thái
            orderService.updateOrderStatus(orderId, "CANCELLED", "Khách hàng hủy đơn hàng");

            return ResponseEntity.ok().body("Đơn hàng đã được hủy thành công");

        } catch (Exception e) {
            return ResponseEntity.status(500).body("Có lỗi xảy ra: " + e.getMessage());
        }
    }

    private User getCurrentUser(HttpServletRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() &&
                !authentication.getPrincipal().equals("anonymousUser")) {
            String email = authentication.getName();
            return userService.getUserByEmail(email);
        }


        return null;
    }
}
