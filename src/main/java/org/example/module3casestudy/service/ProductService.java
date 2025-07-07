package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.ProductDAO;
import org.example.module3casestudy.model.Product;
import java.util.List;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();

    public List<Product> getAllProducts() {
        return productDAO.findAll();
    }

    public void addProduct(Product product) {
        productDAO.insert(product);
    }
}
