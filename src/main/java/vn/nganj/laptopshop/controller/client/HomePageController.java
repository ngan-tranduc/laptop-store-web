package vn.nganj.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.nganj.laptopshop.domain.Product;
import vn.nganj.laptopshop.repository.UserRepository;
import vn.nganj.laptopshop.service.ProductService;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class HomePageController {
    private ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

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
}
