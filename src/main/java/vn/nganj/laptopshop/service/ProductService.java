package vn.nganj.laptopshop.service;

import org.springframework.stereotype.Service;
import vn.nganj.laptopshop.domain.Product;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.repository.ProductRepository;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

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
}
