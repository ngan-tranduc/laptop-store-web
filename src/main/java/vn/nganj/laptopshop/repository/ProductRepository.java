package vn.nganj.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import vn.nganj.laptopshop.domain.Product;

import java.util.List;


@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    List<Product> findByFactory(String apple);
    @Query(value = "SELECT * FROM products ORDER BY RAND() LIMIT 16", nativeQuery = true)
    List<Product> findRandomProducts();

}
