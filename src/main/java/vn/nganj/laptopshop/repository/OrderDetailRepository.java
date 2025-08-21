package vn.nganj.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.nganj.laptopshop.domain.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
}
