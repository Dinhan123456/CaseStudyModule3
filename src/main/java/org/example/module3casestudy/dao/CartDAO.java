package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    private final Connection conn = DBConnection.getConnection();
    private final ProductDAO productDAO = new ProductDAO();

    public Cart getCartByUserId(int userId) {
        Cart cart = new Cart(userId);
        try {
            // Lấy cart_id
            int cartId = getOrCreateCartId(userId);

            String sql = "SELECT * FROM cartitem WHERE cart_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, cartId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int quantity = rs.getInt("quantity");
                    Product product = productDAO.findById(productId);
                    if (product != null) {
                        cart.addItem(product, quantity);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    public void saveCart(Cart cart) {
        try {
            int cartId = getOrCreateCartId(cart.getUserId());

            // Xóa toàn bộ cartitem cũ
            String deleteSql = "DELETE FROM cartitem WHERE cart_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(deleteSql)) {
                ps.setInt(1, cartId);
                ps.executeUpdate();
            }

            // Insert lại cartitem mới
            String insertSql = "INSERT INTO cartitem (cart_id, product_id, quantity) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                for (CartItem item : cart.getItems()) {
                    ps.setInt(1, cartId);
                    ps.setInt(2, item.getProduct().getProductId());
                    ps.setInt(3, item.getQuantity());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void clearCart(int userId) {
        try {
            int cartId = getCartId(userId);
            if (cartId == -1) return;

            String sql = "DELETE FROM cartitem WHERE cart_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, cartId);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeItem(int userId, int productId) {
        try {
            int cartId = getCartId(userId);
            if (cartId == -1) return;

            String sql = "DELETE FROM cartitem WHERE cart_id = ? AND product_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, cartId);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private int getOrCreateCartId(int userId) throws SQLException {
        int cartId = getCartId(userId);
        if (cartId != -1) return cartId;

        // Chưa có → tạo mới
        String insert = "INSERT INTO cart (user_id) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        }
        return -1;
    }

    private int getCartId(int userId) throws SQLException {
        String sql = "SELECT cart_id FROM cart WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("cart_id");
        }
        return -1;
    }
}
