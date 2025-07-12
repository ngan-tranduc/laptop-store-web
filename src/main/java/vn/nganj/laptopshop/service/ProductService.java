package vn.nganj.laptopshop.service;

import org.springframework.stereotype.Service;
import vn.nganj.laptopshop.domain.Product;
import vn.nganj.laptopshop.repository.ProductRepository;

import java.util.List;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Product handleSaveProduct(Product product) {
        Product productTemp = productRepository.save(product);
        return productTemp;
    }

    public List<Product> findAll() {
        return productRepository.findAll();
    }
}
