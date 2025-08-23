package vn.nganj.laptopshop.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.nganj.laptopshop.domain.Order;


import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

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
}