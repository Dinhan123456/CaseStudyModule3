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
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        category // Removed image field
                );
                list.add(p);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error interacting with the database", e);
        }
        return list;
    }

    public void insert(Product p) {
        String sql = "INSERT INTO product (name, description, price, quantity, category_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setInt(5, p.getCategory().getCategoryId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error interacting with the database", e);
        }
    }

    public void updateQuantity(int productId, int newQuantity) {
        String sql = "UPDATE product SET quantity = ? WHERE product_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error interacting with the database", e);
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
                Category category = categoryDAO.findById(rs.getInt("category_id"));
                product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        category // Removed image field
                );
            }

        } catch (Exception e) {
            throw new RuntimeException("Error interacting with the database", e);
        }

        return product;
    }

    public void delete(int id) {
        String sql = "DELETE FROM product WHERE product_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting product", e);
        }
    }

    public void update(Product p) {
        String sql = "UPDATE product SET name = ?, description = ?, price = ?, quantity = ?, category_id = ? WHERE product_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getQuantity());
            ps.setInt(5, p.getCategory().getCategoryId());
            ps.setInt(6, p.getProductId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error updating product", e);
        }
    }
}