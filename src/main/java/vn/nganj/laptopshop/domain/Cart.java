package vn.nganj.laptopshop.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;

import java.util.List;

@Entity
@Table(name = "carts")
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 1-1 với User
    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    // 1-N với CartDetail
    @OneToMany(mappedBy = "cart")
    private List<CartDetail> cartDetails;

    @Min(value = 0)
    private Integer sum; // tổng số lượng sản phẩm

    // Getter & Setter
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public List<CartDetail> getCartDetails() { return cartDetails; }
    public void setCartDetails(List<CartDetail> cartDetails) { this.cartDetails = cartDetails; }

    public Integer getSum() { return sum; }
    public void setSum(Integer sum) { this.sum = sum; }
}