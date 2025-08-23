package vn.nganj.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.nganj.laptopshop.domain.Order;
import vn.nganj.laptopshop.domain.User;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    Page<Order> findByUserOrderByCreatedAtDesc(User user, Pageable pageable);

    Page<Order> findByUserAndStatusOrderByCreatedAtDesc(User user, String status, Pageable pageable);
    /**
     * Đếm số đơn hàng theo trạng thái
     */
    Long countByStatus(String status);

    /**
     * Tìm đơn hàng theo trạng thái với phân trang
     */
    Page<Order> findByStatus(String status, Pageable pageable);

    /**
     * Tìm đơn hàng theo trạng thái
     */
    List<Order> findByStatus(String status);

    /**
     * Tìm đơn hàng theo user ID
     */
    List<Order> findByUserId(Long userId);

    /**
     * Lấy tất cả đơn hàng với sắp xếp theo ID giảm dần
     */
    Page<Order> findAllByOrderByIdDesc(Pageable pageable);

    /**
     * Tổng doanh thu theo trạng thái
     */
    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE o.status = :status")
    Double sumTotalPriceByStatus(@Param("status") String status);

    /**
     * Tổng doanh thu tất cả đơn hàng đã hoàn thành
     */
    @Query("SELECT COALESCE(SUM(o.totalPrice), 0.0) FROM Order o WHERE o.status IN ('DELIVERED', 'COMPLETED')")
    Double sumTotalRevenue();

    /**
     * Đơn hàng gần đây (sử dụng phương thức có sẵn)
     */
    default List<Order> findRecentOrders(Pageable pageable) {
        return findAllByOrderByIdDesc(pageable).getContent();
    }

    /**
     * Helper method để lấy đơn hàng gần đây với limit
     */
    default List<Order> getRecentOrders(int limit) {
        return findRecentOrders(PageRequest.of(0, limit));
    }

    /**
     * Top đơn hàng có giá trị cao nhất
     */
    @Query("SELECT o FROM Order o ORDER BY o.totalPrice DESC")
    List<Order> findTopOrdersByTotalPrice(Pageable pageable);

    /**
     * Đơn hàng theo khoảng giá
     */
    @Query("SELECT o FROM Order o WHERE o.totalPrice BETWEEN :minPrice AND :maxPrice")
    List<Order> findByTotalPriceBetween(@Param("minPrice") Double minPrice, @Param("maxPrice") Double maxPrice);

    /**
     * Thống kê đơn hàng theo tháng hiện tại
     */
    @Query(value = """
        SELECT COUNT(*) FROM orders 
        WHERE MONTH(created_at) = MONTH(NOW())
        AND YEAR(created_at) = YEAR(NOW())
        """, nativeQuery = true)
    Long countOrdersThisMonth();

    /**
     * Đơn hàng có tổng tiền cao nhất
     */
    @Query("SELECT o FROM Order o WHERE o.totalPrice = (SELECT MAX(o2.totalPrice) FROM Order o2)")
    Order findHighestValueOrder();

    /**
     * Tìm đơn hàng theo số điện thoại
     */
    @Query("SELECT o FROM Order o WHERE o.receiverPhone LIKE %:phone%")
    Page<Order> findByReceiverPhoneContaining(@Param("phone") String phone, Pageable pageable);

    /**
     * Đếm đơn hàng tuần này
     */
    @Query(value = """
        SELECT COUNT(*) FROM orders
        WHERE WEEK(created_at) = WEEK(CURDATE())
        AND YEAR(created_at) = YEAR(CURDATE())
        """, nativeQuery = true)
    Long countThisWeekOrders();

    /**
     * Tính doanh thu theo khoảng thời gian (cho biểu đồ 7 ngày)
     */
    @Query("SELECT COALESCE(SUM(o.totalPrice), 0.0) FROM Order o " +
            "WHERE o.createdAt >= :startDate AND o.createdAt <= :endDate " +
            "AND o.status IN ('DELIVERED', 'COMPLETED')")
    Double calculateRevenueByDateRange(@Param("startDate") LocalDateTime startDate,
                                       @Param("endDate") LocalDateTime endDate);

    /**
     * Tổng số đơn hàng (cho dashboard statistics)
     */
    @Query("SELECT COUNT(o) FROM Order o")
    Long getTotalOrderCount();

    /**
     * Doanh thu theo ngày cụ thể (alternative method)
     */
    @Query(value = """
        SELECT COALESCE(SUM(total_price), 0.0) FROM orders 
        WHERE DATE(created_at) = :date 
        AND status IN ('DELIVERED', 'COMPLETED')
        """, nativeQuery = true)
    Double getDailyRevenue(@Param("date") String date);

    /**
     * Đếm đơn hàng theo ngày cụ thể
     */
    @Query(value = """
        SELECT COUNT(*) FROM orders 
        WHERE DATE(created_at) = :date
        """, nativeQuery = true)
    Long countOrdersByDate(@Param("date") String date);

    /**
     * Lấy doanh thu 7 ngày gần đây (native query)
     */
    @Query(value = """
        SELECT 
            DATE(created_at) as order_date,
            COALESCE(SUM(total_price), 0.0) as daily_revenue
        FROM orders 
        WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
        AND status IN ('DELIVERED', 'COMPLETED')
        GROUP BY DATE(created_at)
        ORDER BY order_date ASC
        """, nativeQuery = true)
    List<Object[]> getWeeklyRevenueData();

    /**
     * Thống kê đơn hàng theo trạng thái (cho biểu đồ)
     */
    @Query(value = """
        SELECT 
            status,
            COUNT(*) as order_count
        FROM orders 
        GROUP BY status
        ORDER BY FIELD(status, 'PENDING', 'CONFIRMED', 'SHIPPING', 'COMPLETED', 'CANCELLED')
        """, nativeQuery = true)
    List<Object[]> getOrderStatusStatistics();
}