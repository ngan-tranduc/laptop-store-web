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
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.service.ProductService;
import vn.nganj.laptopshop.service.UserService;

import java.util.HashMap;
import java.util.Map;

@Controller
public class CartController {
    UserService userService;
    ProductService productService;

    public CartController(UserService userService, ProductService productService) {
        this.userService = userService;
        this.productService = productService;
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
}
