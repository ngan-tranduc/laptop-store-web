package vn.nganj.laptopshop.controller.client;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.nganj.laptopshop.domain.Cart;
import vn.nganj.laptopshop.domain.CartDetail;
import vn.nganj.laptopshop.domain.Product;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.repository.CartDetailRepository;
import vn.nganj.laptopshop.repository.CartRepository;
import vn.nganj.laptopshop.repository.OrderDetailRepository;
import vn.nganj.laptopshop.repository.OrderRepository;
import vn.nganj.laptopshop.service.ProductService;
import vn.nganj.laptopshop.service.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CartController {
    private final UserService userService;
    private final ProductService productService;
    private final CartDetailRepository cartDetailRepository;
    private final CartRepository cartRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public CartController(UserService userService, ProductService productService, CartDetailRepository cartDetailRepository, CartRepository cartRepository, OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.userService = userService;
        this.productService = productService;
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            return "redirect:/login";
        }
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("cart", user.getCart());
        return "client/cart/show";
    }

    @PostMapping("/cart/update")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCartQuantity(
            @RequestParam Long cartDetailId,
            @RequestParam String action,
            HttpServletRequest request) {

        Map<String, Object> response = new HashMap<>();

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("email") == null) {
                response.put("error", "Vui lòng đăng nhập");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }

            String email = (String) session.getAttribute("email");
            User user = this.userService.getUserByEmail(email);
            if (user == null) {
                response.put("error", "Người dùng không tồn tại");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }

            CartDetail cartDetail = this.cartDetailRepository.findById(cartDetailId).orElse(null);
            if (cartDetail == null) {
                response.put("error", "Không tìm thấy sản phẩm trong giỏ hàng");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            if (!cartDetail.getCart().getUser().getId().equals(user.getId())) {
                response.put("error", "Không có quyền truy cập");
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body(response);
            }

            Cart cart = cartDetail.getCart();
            int currentQuantity = cartDetail.getQuantity();

            if ("increase".equals(action)) {
                Product product = cartDetail.getProduct();
                if (currentQuantity >= product.getQuantity()) {
                    response.put("error", "Số lượng sản phẩm trong kho không đủ");
                    return ResponseEntity.badRequest().body(response);
                }
                cartDetail.setQuantity(currentQuantity + 1);
            } else if ("decrease".equals(action)) {
                if (currentQuantity <= 1) {
                    // Xóa sản phẩm nếu quantity = 1
                    this.cartDetailRepository.delete(cartDetail);
                    updateCartSum(cart, session);

                    response.put("success", true);
                    response.put("message", "Đã xóa sản phẩm khỏi giỏ hàng");
                    response.put("deleted", true);
                    response.put("cartSum", cart.getSum());
                    return ResponseEntity.ok(response);
                } else {
                    cartDetail.setQuantity(currentQuantity - 1);
                }
            } else {
                response.put("error", "Hành động không hợp lệ");
                return ResponseEntity.badRequest().body(response);
            }

            this.cartDetailRepository.save(cartDetail);
            updateCartSum(cart, session);

            response.put("success", true);
            response.put("message", "Cập nhật giỏ hàng thành công");
            response.put("newQuantity", cartDetail.getQuantity());
            response.put("cartSum", cart.getSum());

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("error", "Có lỗi xảy ra: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/cart/delete/{id}")
    @ResponseBody
    public ResponseEntity<?> deleteCartItem(@PathVariable Long id, HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("email") == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("error", "Vui lòng đăng nhập"));
            }

            String email = (String) session.getAttribute("email");
            User user = this.userService.getUserByEmail(email);
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("error", "Người dùng không tồn tại"));
            }

            // Tìm CartDetail
            CartDetail cartDetail = this.cartDetailRepository.findById(id).orElse(null);
            if (cartDetail == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Map.of("error", "Không tìm thấy sản phẩm trong giỏ hàng"));
            }

            // Kiểm tra quyền sở hữu
            if (!cartDetail.getCart().getUser().getId().equals(user.getId())) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body(Map.of("error", "Không có quyền truy cập"));
            }

            Cart cart = cartDetail.getCart();

            // Xóa CartDetail
            this.cartDetailRepository.delete(cartDetail);

            // Cập nhật lại tổng số lượng trong cart
            updateCartSum(cart, session);

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "message", "Xóa sản phẩm thành công",
                    "cartSum", cart.getSum()
            ));

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Có lỗi xảy ra: " + e.getMessage()));
        }
    }

    @PostMapping("/cart/apply-coupon")
    @ResponseBody
    public ResponseEntity<?> applyCoupon(@RequestParam String couponCode, HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("email") == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("error", "Vui lòng đăng nhập"));
            }

            String email = (String) session.getAttribute("email");
            User user = this.userService.getUserByEmail(email);
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("error", "Người dùng không tồn tại"));
            }

            Cart cart = user.getCart();
            if (cart == null || cart.getCartDetails().isEmpty()) {
                return ResponseEntity.badRequest()
                        .body(Map.of("error", "Giỏ hàng trống"));
            }

            // Kiểm tra mã giảm giá (bạn có thể tùy chỉnh logic này)
            double discountPercent = 0;
            String discountMessage = "";

            switch (couponCode.toUpperCase()) {
                case "SAVE10":
                    discountPercent = 0.1; // 10%
                    discountMessage = "Giảm 10%";
                    break;
                case "SAVE20":
                    discountPercent = 0.2; // 20%
                    discountMessage = "Giảm 20%";
                    break;
                case "FREESHIP":
                    discountPercent = 0; // Miễn phí ship
                    discountMessage = "Miễn phí vận chuyển";
                    break;
                case "VIP30":
                    discountPercent = 0.3; // 30%
                    discountMessage = "Giảm 30% - VIP";
                    break;
                default:
                    return ResponseEntity.badRequest()
                            .body(Map.of("error", "Mã giảm giá không hợp lệ hoặc đã hết hạn"));
            }

            // Tính tổng giá trị giỏ hàng
            double totalPrice = cart.getCartDetails().stream()
                    .mapToDouble(cd -> cd.getPrice() * cd.getQuantity())
                    .sum();

            double discountAmount = totalPrice * discountPercent;
            double finalPrice = totalPrice - discountAmount;

            // Lưu thông tin giảm giá vào session
            session.setAttribute("couponCode", couponCode);
            session.setAttribute("discountPercent", discountPercent);
            session.setAttribute("discountAmount", discountAmount);
            session.setAttribute("discountMessage", discountMessage);

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "message", "Áp dụng mã giảm giá thành công",
                    "couponCode", couponCode,
                    "discountMessage", discountMessage,
                    "discountPercent", discountPercent * 100,
                    "discountAmount", discountAmount,
                    "originalPrice", totalPrice,
                    "finalPrice", finalPrice
            ));

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Có lỗi xảy ra: " + e.getMessage()));
        }
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            return "redirect:/login";
        }

        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        if (user == null) {
            return "redirect:/login";
        }

        Cart cart = user.getCart();
        if (cart == null || cart.getCartDetails().isEmpty()) {
            return "redirect:/cart";
        }

        model.addAttribute("cart", cart);
        model.addAttribute("user", user);

        // Thông tin giảm giá từ session
        model.addAttribute("couponCode", session.getAttribute("couponCode"));
        model.addAttribute("discountAmount", session.getAttribute("discountAmount"));
        model.addAttribute("discountMessage", session.getAttribute("discountMessage"));

        return "client/checkout/show";
    }

    private void updateCartSum(Cart cart, HttpSession session) {
        List<CartDetail> cartDetails = this.cartDetailRepository.findByCart(cart);

        // Sum = số lượng CartDetail (số loại sản phẩm khác nhau)
        int uniqueProductTypes = cartDetails.size();

        cart.setSum(uniqueProductTypes);
        this.cartRepository.save(cart);

        if (session != null) {
            session.setAttribute("sum", uniqueProductTypes);
        }
    }

    // Phương thức lấy tổng giá trị giỏ hàng
    @GetMapping("/cart/total")
    @ResponseBody
    public ResponseEntity<?> getCartTotal(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("email") == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("error", "Vui lòng đăng nhập"));
            }

            String email = (String) session.getAttribute("email");
            User user = this.userService.getUserByEmail(email);
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("error", "Người dùng không tồn tại"));
            }

            Cart cart = user.getCart();
            if (cart == null) {
                return ResponseEntity.ok(Map.of(
                        "success", true,
                        "totalItems", 0,
                        "totalPrice", 0
                ));
            }

            double totalPrice = cart.getCartDetails().stream()
                    .mapToDouble(cd -> cd.getPrice() * cd.getQuantity())
                    .sum();

            int totalItems = cart.getCartDetails().stream()
                    .mapToInt(CartDetail::getQuantity)
                    .sum();

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "totalItems", totalItems,
                    "totalPrice", totalPrice
            ));

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Có lỗi xảy ra: " + e.getMessage()));
        }
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {

        User currentUser = new User(); // null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone);

        return "redirect:/";
    }

}
