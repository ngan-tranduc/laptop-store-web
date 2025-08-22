package vn.nganj.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import vn.nganj.laptopshop.domain.Cart;
import vn.nganj.laptopshop.domain.CartDetail;
import vn.nganj.laptopshop.domain.Product;

import java.util.List;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    CartDetail findByCartAndProduct(Cart cart, Product product);
    List<CartDetail> findByCart(Cart cart);

    @Modifying
    @Transactional
    @Query("DELETE FROM CartDetail cd WHERE cd.cart = :cart")
    void deleteByCart(@Param("cart") Cart cart);

    @Query("SELECT cd FROM CartDetail cd WHERE cd.cart.user.id = :userId")
    List<CartDetail> findByUserId(@Param("userId") Long userId);

    @Query("SELECT SUM(cd.quantity * cd.price) FROM CartDetail cd WHERE cd.cart = :cart")
    Double getTotalPriceByCart(@Param("cart") Cart cart);

    @Query("SELECT SUM(cd.quantity) FROM CartDetail cd WHERE cd.cart = :cart")
    Integer getTotalQuantityByCart(@Param("cart") Cart cart);
}
