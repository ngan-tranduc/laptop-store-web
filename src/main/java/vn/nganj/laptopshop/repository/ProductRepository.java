package vn.nganj.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.nganj.laptopshop.domain.Product;

import java.util.List;


@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    List<Product> findByFactory(String apple);
    @Query(value = "SELECT * FROM products ORDER BY RAND() LIMIT 16", nativeQuery = true)
    List<Product> findRandomProducts();

    @Query(value = "SELECT * FROM products ORDER BY sold DESC LIMIT :limit", nativeQuery = true)
    List<Product> findTopSellingProducts(@Param("limit") int limit);

    /**
     * Tìm 5 sản phẩm sắp hết hàng (quantity < 10)
     */
    @Query(value = "SELECT * FROM products WHERE quantity < 10 ORDER BY quantity ASC LIMIT :limit", nativeQuery = true)
    List<Product> findLowStockProducts(@Param("limit") int limit);
}
