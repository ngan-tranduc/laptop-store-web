package vn.nganj.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.nganj.laptopshop.domain.Product;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.service.ProductService;
import vn.nganj.laptopshop.service.UploadService;
import vn.nganj.laptopshop.service.UserService;

import java.util.List;

@Controller
public class ProductController {
    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    //show
    @GetMapping("/admin/product")
    public String showAllProducts(Model model) {
        List<Product> products = productService.findAll();
        model.addAttribute("products", products);
        return "admin/product/show";
    }


    // create
    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping(value = "/admin/product/create")
    public String createProduct(Model model, @ModelAttribute("newProduct") Product product, @RequestParam("imageFile") MultipartFile file){
        if (!file.isEmpty() && file.getOriginalFilename() != null && !file.getOriginalFilename().trim().isEmpty()) {
            String image = this.uploadService.handleUploadFile(file, "product");
            product.setImage(image);
        }

        this.productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }
}
