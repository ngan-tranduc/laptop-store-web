package vn.nganj.laptopshop.service;


import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import vn.nganj.laptopshop.domain.Order;
import vn.nganj.laptopshop.repository.OrderRepository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDate;
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

    /**
     * Tổng số đơn hàng
     */
    public Long getTotalOrders() {
        return orderRepository.count();
    }

    /**
     * Tổng doanh thu (chỉ tính các đơn hàng đã hoàn thành)
     */
    public Double getTotalRevenue() {
        try {
            Double revenue = orderRepository.sumTotalPriceByStatus("DELIVERED");
            return revenue != null ? revenue : 0.0;
        } catch (Exception e) {
            return 0.0;
        }
    }

    public List<Double> getWeeklyRevenueLastSevenDays() {
        List<Double> weeklyRevenue = new ArrayList<>();

        try {
            // Cách 1: Sử dụng native query (dễ hơn)
            List<Object[]> revenueData = orderRepository.getWeeklyRevenueData();

            // Tạo map để lưu doanh thu theo ngày
            Map<String, Double> revenueMap = new HashMap<>();
            for (Object[] row : revenueData) {
                String date = row[0].toString();
                Double revenue = ((Number) row[1]).doubleValue();
                revenueMap.put(date, revenue);
            }

            // Tạo dữ liệu cho 7 ngày gần đây
            for (int i = 6; i >= 0; i--) {
                LocalDate date = LocalDate.now().minusDays(i);
                String dateStr = date.toString();
                Double revenue = revenueMap.getOrDefault(dateStr, 0.0);
                weeklyRevenue.add(revenue);
            }

            System.out.println("Weekly Revenue (Native Query): " + weeklyRevenue);

        } catch (Exception e) {
            System.err.println("Error with native query, using alternative method: " + e.getMessage());

            // Cách 2: Fallback - query từng ngày
            for (int i = 6; i >= 0; i--) {
                LocalDate date = LocalDate.now().minusDays(i);
                LocalDateTime startOfDay = date.atStartOfDay();
                LocalDateTime endOfDay = date.atTime(23, 59, 59);

                Double dailyRevenue = orderRepository.calculateRevenueByDateRange(startOfDay, endOfDay);
                weeklyRevenue.add(dailyRevenue != null ? dailyRevenue : 0.0);
            }

            System.out.println("Weekly Revenue (Fallback): " + weeklyRevenue);
        }

        return weeklyRevenue;
    }

    /**
     * Số đơn hàng theo từng trạng thái (cho biểu đồ)
     * Trả về chuỗi JSON format cho JavaScript
     */
    public String getOrderStatusData() {
        try {
            Long pending = orderRepository.countByStatus("PENDING");
            Long confirmed = orderRepository.countByStatus("CONFIRMED");
            Long shipping = orderRepository.countByStatus("SHIPPING");
            Long delivered = orderRepository.countByStatus("DELIVERED");
            Long cancelled = orderRepository.countByStatus("CANCELLED");

            return "[" +
                    (pending != null ? pending : 0) + "," +
                    (confirmed != null ? confirmed : 0) + "," +
                    (shipping != null ? shipping : 0) + "," +
                    (delivered != null ? delivered : 0) + "," +
                    (cancelled != null ? cancelled : 0) + "]";
        } catch (Exception e) {
            return "[0, 0, 0, 0, 0]";
        }
    }

    /**
     * Lấy danh sách đơn hàng gần đây
     */
    public List<Order> getRecentOrders(int limit) {
        try {
            Pageable pageable = PageRequest.of(0, limit);
            return orderRepository.findRecentOrders(pageable);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    /**
     * Thống kê tổng quan cho dashboard
     */
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();

        stats.put("totalOrders", getTotalOrders());
        stats.put("totalRevenue", getTotalRevenue());
        stats.put("weekRevenue", getWeeklyRevenueLastSevenDays());
        stats.put("orderStatusData", getOrderStatusData());
        stats.put("recentOrders", getRecentOrders(10));

        return stats;
    }

    /**
     * Tính doanh thu theo khoảng thời gian
     */
//    public Double getRevenueByDateRange(LocalDateTime fromDate, LocalDateTime toDate) {
//        try {
//            // Nếu Order entity có trường createdAt
//            // return orderRepository.getRevenueBetweenDates(fromDate, toDate);
//
//            // Tạm thời trả về tổng doanh thu
//            return getTotalRevenue();
//        } catch (Exception e) {
//            return 0.0;
//        }
//    }

    /**
     * Đếm đơn hàng theo trạng thái
     */
    public Long countOrdersByStatus(String status) {
        try {
            return orderRepository.countByStatus(status);
        } catch (Exception e) {
            return 0L;
        }
    }

    /**
     * Lấy top đơn hàng có giá trị cao nhất
     */
    public List<Order> getTopValueOrders(int limit) {
        try {
            Pageable pageable = PageRequest.of(0, limit);
            return orderRepository.findTopOrdersByTotalPrice(pageable);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
}