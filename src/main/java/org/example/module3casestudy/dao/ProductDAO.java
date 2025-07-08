package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class ProductDAO {
    private Connection conn;
    private CategoryDAO categoryDAO = new CategoryDAO();

    public ProductDAO() {
        this.conn = DBConnection.getConnection();
    }

    public List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category category = categoryDAO.findById(rs.getInt("category_id"));
                Product p = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("image"),
                        category
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(Product p) {
        String sql = "INSERT INTO product (product_name, description, price, quantity, image, category_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setString(5, p.getImage());
            ps.setInt(6, p.getCategory().getCategoryId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuantity(int productId, int newQuantity) {
        String sql = "UPDATE product SET quantity = ? WHERE product_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Product findById(int id) {
        Product product = null;
        String sql = "SELECT * FROM product WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("stock"));
                // ... các trường khác nếu có
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }
}