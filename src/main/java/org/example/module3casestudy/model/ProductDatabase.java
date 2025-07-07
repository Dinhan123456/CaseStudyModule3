package org.example.module3casestudy.model;



import java.util.*;

public class ProductDatabase {
    private static final List<Product> products = new ArrayList<>();

    static {
        products.add(new Product(1, "Sữa rửa mặt", 100_000));
        products.add(new Product(2, "Nước hoa", 200_000));
        products.add(new Product(3, "Dầu gội", 150_000));
        // thêm các sản phẩm khác nếu cần
    }

    public static Product findById(int productId) {
        for (Product p : products) {
            if (p.getProductId() == productId) return p;
        }
        return null;
    }

    public static List<Product> getAll() {
        return products;
    }

}
