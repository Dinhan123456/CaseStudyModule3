package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;
import java.sql.*;

public class CartDAO {

    public void addToCart(int userId, int productId, int quantity) {
        String checkItemSql = "SELECT quantity FROM cartitem ci JOIN cart c ON ci.cart_id = c.cart_id WHERE c.user_id = ? AND ci.product_id = ?";
        String updateItemSql = "UPDATE cartitem SET quantity = ? WHERE cart_item_id = (SELECT ci.cart_item_id FROM cartitem ci JOIN cart c ON ci.cart_id = c.cart_id WHERE c.user_id = ? AND ci.product_id = ?)";
        String insertItemSql = "INSERT INTO cartitem (cart_id, product_id, quantity) VALUES (?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            int cartId = getOrCreateCartId(conn, userId);
            if (cartId == -1) {
                throw new SQLException("Không thể tạo hoặc tìm thấy giỏ hàng.");
            }

            // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
            int currentQuantity = -1;
            try (PreparedStatement ps = conn.prepareStatement(checkItemSql)) {
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    currentQuantity = rs.getInt("quantity");
                }
            }

            if (currentQuantity != -1) {
                // Nếu đã có, cập nhật số lượng
                try (PreparedStatement ps = conn.prepareStatement(updateItemSql)) {
                    ps.setInt(1, currentQuantity + quantity);
                    ps.setInt(2, userId);
                    ps.setInt(3, productId);
                    ps.executeUpdate();
                }
            } else {
                // Nếu chưa có, thêm mới
                try (PreparedStatement ps = conn.prepareStatement(insertItemSql)) {
                    ps.setInt(1, cartId);
                    ps.setInt(2, productId);
                    ps.setInt(3, quantity);
                    ps.executeUpdate();
                }
            }

            conn.commit(); // Hoàn tất transaction

        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public Cart getCartByUserId(int userId) {
        Cart cart = new Cart(userId);
        String sql = "SELECT p.*, ci.quantity as cart_quantity " +
                "FROM cartitem ci " +
                "JOIN product p ON ci.product_id = p.product_id " +
                "JOIN cart c ON ci.cart_id = c.cart_id " +
                "WHERE c.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                // Lấy số lượng sản phẩm trong giỏ hàng, không phải tổng số lượng trong kho
                int quantityInCart = rs.getInt("cart_quantity");
                cart.addItem(product, quantityInCart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    public void removeItem(int userId, int productId) {
        String sql = "DELETE ci FROM cartitem ci JOIN cart c ON ci.cart_id = c.cart_id WHERE c.user_id = ? AND ci.product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void clearCart(int userId) {
        String sql = "DELETE ci FROM cartitem ci JOIN cart c ON ci.cart_id = c.cart_id WHERE c.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private int getOrCreateCartId(Connection conn, int userId) throws SQLException {
        String selectSql = "SELECT cart_id FROM cart WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(selectSql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cart_id");
            }
        }

        String insertSql = "INSERT INTO cart (user_id) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }
}