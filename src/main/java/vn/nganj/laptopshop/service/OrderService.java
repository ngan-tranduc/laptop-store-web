package vn.nganj.laptopshop.service;


import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import vn.nganj.laptopshop.domain.Order;
import vn.nganj.laptopshop.repository.OrderRepository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDateTime;
import java.util.*;

@Service
@Transactional
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    /**
     * Tìm đơn hàng theo ID
     */
    public Order findById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    /**
     * Tìm đơn hàng với các điều kiện lọc
     */
    public Page<Order> findOrdersWithFilters(String status, LocalDateTime fromDate,
                                             LocalDateTime toDate, Pageable pageable) {

        // Nếu entity không có createdAt, bạn có thể bỏ phần lọc theo ngày
        // hoặc thêm trường createdAt vào entity
        if (status != null && !status.trim().isEmpty()) {
            return orderRepository.findByStatus(status.trim(), pageable);
        }

        return orderRepository.findAll(pageable);
    }

    /**
     * Thống kê đơn hàng theo trạng thái
     */
    public Map<String, Long> getOrderStatistics() {
        Map<String, Long> stats = new HashMap<>();

        stats.put("PENDING", orderRepository.countByStatus("PENDING"));
        stats.put("CONFIRMED", orderRepository.countByStatus("CONFIRMED"));
        stats.put("SHIPPING", orderRepository.countByStatus("SHIPPING"));
        stats.put("DELIVERED", orderRepository.countByStatus("DELIVERED"));
        stats.put("CANCELLED", orderRepository.countByStatus("CANCELLED"));

        return stats;
    }

    /**
     * Cập nhật trạng thái đơn hàng
     */
    public boolean updateOrderStatus(Long orderId, String newStatus, String note) {
        try {
            Order order = orderRepository.findById(orderId).orElse(null);
            if (order == null) {
                return false;
            }

            order.setStatus(newStatus);
            // Vì entity không có updatedAt và note, chỉ cập nhật status

            orderRepository.save(order);
            return true;

        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Gửi email thông báo (tùy chọn)
     */
    public void sendStatusUpdateNotification(Order order, String newStatus) {
        // TODO: Implement email notification
        System.out.println("Gửi email cho: " + order.getUser().getEmail()
                + " - Đơn hàng #" + order.getId() + " - Trạng thái: " + newStatus);
    }

    /**
     * Export Excel (placeholder)
     */
    public void exportOrdersToExcel(String status, LocalDateTime fromDate,
                                    LocalDateTime toDate, HttpServletResponse response) {
        // TODO: Implement Excel export
        throw new UnsupportedOperationException("Excel export chưa được implement");
    }
}