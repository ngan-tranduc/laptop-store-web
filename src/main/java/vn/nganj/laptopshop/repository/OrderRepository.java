package vn.nganj.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.nganj.laptopshop.domain.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {
    // Additional query methods can be defined here if needed
}
