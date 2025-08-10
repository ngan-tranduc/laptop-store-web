package vn.nganj.laptopshop.controller.client;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import vn.nganj.laptopshop.domain.Product;
import vn.nganj.laptopshop.repository.ProductRepository;
import vn.nganj.laptopshop.repository.UserRepository;
import vn.nganj.laptopshop.service.ProductService;

import java.util.List;

@Controller
public class ItemController {
    private ProductService productService;

    public ItemController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable Long id){
        List<Product> randomProducts = productService.getRandomProducts();
        model.addAttribute("products", randomProducts);

        Product product = productService.findById(id);
        model.addAttribute("product", product);

        return "client/product/detail";
    }

    @PostMapping("add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable Long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        Long productId = id;
        this.productService.handleAddProductToCart(email, productId, session);
        return "redirect:/";
    }

}
