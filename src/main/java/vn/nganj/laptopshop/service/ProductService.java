package vn.nganj.laptopshop.service;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Service;
import vn.nganj.laptopshop.domain.*;
import vn.nganj.laptopshop.repository.*;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository, UserRepository userRepository, CartDetailRepository cartDetailRepository, UserService userService, OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.userRepository = userRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    // Product methods
    public Product handleSaveProduct(Product product) {
        Product productTemp = productRepository.save(product);
        return productTemp;
    }

    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public Product getProductById(Long id){
        return this.productRepository.findById(id).get();
    }

    public void deleteById(long id) {
        productRepository.deleteById(id);
    }

    public Page<Product> findAll(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    public List<Product> findByFactory(String apple) {
        return productRepository.findByFactory(apple);
    }

    public List<Product> getRandomProducts() {
        return productRepository.findRandomProducts();
    }

    public Product findById(Long id) {
        return productRepository.findById(id).get();
    }

    public void handleAddProductToCart(String email, Long productId, HttpSession session) {
        User user = userService.getUserByEmail(email);
        if(user == null) {
            throw new RuntimeException("User not found with email: " + email);
        }

        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null) {
            Cart otherCart = new Cart();
            otherCart.setUser(user);
            otherCart.setSum(0); // Khởi tạo = 0, sẽ được cập nhật bên dưới
            cart = this.cartRepository.save(otherCart);
        }

        Optional<Product> product = this.productRepository.findById(productId);
        if (product.isPresent()) {
            Product realProduct = product.get();

            // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
            CartDetail existingCartDetail = cartDetailRepository.findByCartAndProduct(cart, realProduct);
            if (existingCartDetail != null) {
                // Nếu đã có, chỉ tăng quantity, KHÔNG tăng sum
                existingCartDetail.setQuantity(existingCartDetail.getQuantity() + 1);
                this.cartDetailRepository.save(existingCartDetail);
            } else {
                // Nếu chưa có, tạo mới VÀ tăng sum
                CartDetail cartDetail = new CartDetail();
                cartDetail.setCart(cart);
                cartDetail.setProduct(realProduct);
                cartDetail.setPrice(realProduct.getPrice());
                cartDetail.setQuantity(1);
                this.cartDetailRepository.save(cartDetail);

                // Chỉ tăng sum khi thêm sản phẩm mới
                int totalItems = cart.getSum() + 1;
                cart.setSum(totalItems);
                this.cartRepository.save(cart);
                session.setAttribute("sum", totalItems);
            }
        } else {
            throw new RuntimeException("Product not found with id: " + productId);
        }
    }
    public void handlePlaceOrder(User user, HttpSession session, String receiverName, String receiverAddress, String receiverPhone) {

        // Tạo đơn hàng mới
        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        order.setStatus("Pending");
        order = this.orderRepository.save(order);

        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null || cart.getCartDetails().isEmpty()) {
            throw new RuntimeException("Cart is empty or not found for user: " + user.getEmail());
        }

        // Tính tổng giá trị đơn hàng
        double totalPrice = cart.getCartDetails().stream()
                .mapToDouble(cd -> cd.getPrice() * cd.getQuantity())
                .sum();
        order.setTotalPrice(totalPrice);

        // Lưu đơn hàng
        Order savedOrder = this.orderRepository.save(order);

        // Lưu chi tiết đơn hàng
        for (CartDetail cartDetail : cart.getCartDetails()) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(savedOrder);
            orderDetail.setProduct(cartDetail.getProduct());
            orderDetail.setPrice(cartDetail.getPrice());
            orderDetail.setQuantity(cartDetail.getQuantity());
            this.orderDetailRepository.save(orderDetail);
        }

        // Xóa giỏ hàng sau khi đặt hàng thành công
        for(CartDetail cartDetail : cart.getCartDetails()) {
            this.cartDetailRepository.deleteById(cartDetail.getId());
        }
        this.cartRepository.deleteById(cart.getId());

        // Cập nhật session
        session.setAttribute("sum", 0);
    }
}