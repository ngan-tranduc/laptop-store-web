package vn.nganj.laptopshop.controller.admin;

import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.nganj.laptopshop.domain.Product;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.service.ProductService;
import vn.nganj.laptopshop.service.UploadService;
import vn.nganj.laptopshop.service.UserService;

import java.util.List;
import java.util.Optional;

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

    //read
    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable Long id){
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "admin/product/detail";
    }


    //create
    @GetMapping("/admin/product/create")
    public String getCreatePage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }
    @PostMapping("/admin/product/create")
    public String createProductPage(Model model,
                                    @ModelAttribute("newProduct") @Valid Product product,
                                    BindingResult bindingResult,
                                    @RequestParam("imageFile") MultipartFile file,
                                    RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            return "admin/product/create";
        }

        if (!file.isEmpty() && file.getOriginalFilename() != null && !file.getOriginalFilename().trim().isEmpty()) {
            String image = this.uploadService.handleUploadFile(file, "product");
            product.setImage(image);
        }
        if (product.getSold() == 0) {
            product.setSold(0);
        }

        this.productService.handleSaveProduct(product);

        redirectAttributes.addFlashAttribute("successMessage", "Tạo sản phẩm thành công!");

        return "redirect:/admin/product";
    }

    //update
    @GetMapping(value = "/admin/product/edit/{id}")
    public String getProductEditPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("currentProduct", product);
        return "admin/product/edit";
    }
    @PostMapping("/admin/product/edit")
    public String postUpdateProduct(@ModelAttribute("currentProduct") @Valid Product product,
                                    BindingResult bindingResult,
                                    @RequestParam("imageFile") MultipartFile file,
                                    RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "admin/product/edit";
        }
        try {
            Product currentProduct = this.productService.getProductById(product.getId());
            if (currentProduct != null) {
                currentProduct.setName(product.getName());
                currentProduct.setPrice(product.getPrice());
                currentProduct.setQuantity(product.getQuantity());
                currentProduct.setFactory(product.getFactory());
                currentProduct.setTarget(product.getTarget());
                currentProduct.setShortDesc(product.getShortDesc());
                currentProduct.setDetailDesc(product.getDetailDesc());

                if (!file.isEmpty() && file.getOriginalFilename() != null && !file.getOriginalFilename().trim().isEmpty()) {
                    String image = this.uploadService.handleUploadFile(file, "product");
                    currentProduct.setImage(image);
                }

                this.productService.handleSaveProduct(currentProduct);

                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sản phẩm thành công!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật sản phẩm: " + e.getMessage());
        }
        return "redirect:/admin/product";
    }

    //delete
    @PostMapping("/admin/product/delete/{id}")
    public String deleteUser(@PathVariable long id) {
        productService.deleteById(id);
        return "redirect:/admin/product";
    }
}
