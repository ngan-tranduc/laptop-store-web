package vn.nganj.laptopshop.controller.client;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.nganj.laptopshop.domain.Product;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.domain.dto.RegisterDTO;
import vn.nganj.laptopshop.repository.UserRepository;
import vn.nganj.laptopshop.service.ProductService;
import vn.nganj.laptopshop.service.UserService;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    //trang chu
    @GetMapping("/")
    public String getHomePage(Model model){
        List<Product> products = this.productService.findAll();
        Map<String, List<Product>> productsByFactory = products.stream()
                .filter(p -> Arrays.asList("Apple", "Dell", "Acer", "MSI").contains(p.getFactory()))
                .collect(Collectors.groupingBy(Product::getFactory));

        model.addAttribute("products", products);
        model.addAttribute("productsByFactory", productsByFactory);
        return "client/homepage/show";
    }

    //dang nhap
    @GetMapping("/login")
    public String getPageLogin(Model model) {

        return "client/auth/login";
    }

    //dang ky
    @GetMapping("/register")
    public String getPageRegister(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }
    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") RegisterDTO registerDTO) {
        User user = this.userService.registerDTOtoUser(registerDTO);
        String hashedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(hashedPassword);
        this.userService.handleSaveUser(user);
        return "redirect:/login";
    }

}
