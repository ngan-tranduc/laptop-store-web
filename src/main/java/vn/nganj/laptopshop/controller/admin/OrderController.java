package vn.nganj.laptopshop.controller.admin;

import vn.nganj.laptopshop.domain.Order;
import vn.nganj.laptopshop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * Hiển thị danh sách đơn hàng
     */
    @GetMapping
    public String showOrders(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate fromDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate toDate,
            Model model) {

        // Tạo Pageable với sắp xếp theo ID giảm dần
        Pageable pageable = PageRequest.of(page - 1, size,
                Sort.by(Sort.Direction.DESC, "id"));

        // Chuyển đổi LocalDate thành LocalDateTime
        LocalDateTime fromDateTime = null;
        LocalDateTime toDateTime = null;

        if (fromDate != null) {
            fromDateTime = fromDate.atStartOfDay();
        }
        if (toDate != null) {
            toDateTime = toDate.atTime(LocalTime.MAX);
        }

        // Lấy danh sách đơn hàng
        Page<Order> orderPage = orderService.findOrdersWithFilters(
                status, fromDateTime, toDateTime, pageable);

        // Lấy thống kê
        Map<String, Long> orderStats = orderService.getOrderStatistics();

        // Thêm dữ liệu vào model
        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("totalOrders", orderPage.getTotalElements());

        // Thống kê theo trạng thái
        model.addAttribute("pendingOrders", orderStats.getOrDefault("PENDING", 0L));
        model.addAttribute("confirmedOrders", orderStats.getOrDefault("CONFIRMED", 0L));
        model.addAttribute("shippingOrders", orderStats.getOrDefault("SHIPPING", 0L));
        model.addAttribute("deliveredOrders", orderStats.getOrDefault("DELIVERED", 0L));

        return "admin/order/show";
    }

    /**
     * Xem chi tiết đơn hàng - FIXED URL mapping
     */
    @GetMapping("/{id}")
    public String showOrderDetail(@PathVariable Long id, Model model,
                                  RedirectAttributes redirectAttributes) {
        try {
            Order order = orderService.findById(id);
            if (order == null) {
                redirectAttributes.addFlashAttribute("error",
                        "Không tìm thấy đơn hàng với mã #" + id);
                return "redirect:/admin/order";
            }

            model.addAttribute("order", order);
            return "admin/order/detail";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/order";
        }
    }

    /**
     * Cập nhật trạng thái đơn hàng - FIXED URL mapping
     */
    @PostMapping("/{id}/update-status")
    public String updateOrderStatus(
            @PathVariable Long id,
            @RequestParam String status,
            @RequestParam(required = false) String note,
            RedirectAttributes redirectAttributes) {

        try {
            Order order = orderService.findById(id);
            if (order == null) {
                redirectAttributes.addFlashAttribute("error",
                        "Không tìm thấy đơn hàng với mã #" + id);
                return "redirect:/admin/order";
            }

            // Cập nhật trạng thái
            boolean updated = orderService.updateOrderStatus(id, status, note);

            if (updated) {
                redirectAttributes.addFlashAttribute("success",
                        "Cập nhật trạng thái đơn hàng #" + id + " thành công");

                // Gửi thông báo
                try {
                    orderService.sendStatusUpdateNotification(order, status);
                } catch (Exception e) {
                    // Log lỗi nhưng không fail toàn bộ request
                    System.err.println("Lỗi gửi thông báo: " + e.getMessage());
                }
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "Không thể cập nhật trạng thái đơn hàng");
            }

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace(); // Debug log
        }

        return "redirect:/admin/order";
    }

    /**
     * API cập nhật trạng thái qua AJAX - FIXED URL mapping
     */
    @PostMapping("/{id}/status")
    @ResponseBody
    public Map<String, Object> updateOrderStatusAjax(
            @PathVariable Long id,
            @RequestParam String status,
            @RequestParam(required = false) String note) {

        Map<String, Object> response = new HashMap<>();

        try {
            Order order = orderService.findById(id);
            if (order == null) {
                response.put("success", false);
                response.put("message", "Không tìm thấy đơn hàng");
                return response;
            }

            boolean updated = orderService.updateOrderStatus(id, status, note);

            if (updated) {
                response.put("success", true);
                response.put("message", "Cập nhật trạng thái thành công");
                response.put("newStatus", status);

                // Gửi thông báo
                try {
                    orderService.sendStatusUpdateNotification(order, status);
                } catch (Exception e) {
                    // Log lỗi nhưng không fail toàn bộ request
                    System.err.println("Lỗi gửi thông báo: " + e.getMessage());
                }
            } else {
                response.put("success", false);
                response.put("message", "Không thể cập nhật trạng thái");
            }

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace(); // Debug log
        }

        return response;
    }
}