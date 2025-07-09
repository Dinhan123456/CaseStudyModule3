package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public Order createOrderFromCart(int userId, Cart cart) throws SQLException {
        String insertOrderSql = "INSERT INTO `order` (user_id, status_id, total_amount, created_at) VALUES (?, ?, ?, NOW())";
        String insertDetailSql = "INSERT INTO orderdetail (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        Order newOrder = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // 1. Chèn vào bảng `order`
            int orderId;
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, userId);
                psOrder.setInt(2, 1); // 1: Chờ xử lý (dựa trên dữ liệu mẫu)
                psOrder.setDouble(3, cart.getTotalAmount());
                psOrder.executeUpdate();

                ResultSet rs = psOrder.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                    newOrder = new Order(orderId, null, new java.util.Date(), cart.getTotalAmount(), null);
                } else {
                    throw new SQLException("Tạo đơn hàng thất bại, không nhận được ID.");
                }
            }

            // 2. Chèn vào bảng `orderdetail`
            try (PreparedStatement psDetail = conn.prepareStatement(insertDetailSql)) {
                for (CartItem item : cart.getItems()) {
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, item.getProduct().getProductId());
                    psDetail.setInt(3, item.getQuantity());
                    psDetail.setDouble(4, item.getProduct().getPrice());
                    psDetail.addBatch();
                }
                psDetail.executeBatch();
            }

            conn.commit(); // Hoàn tất transaction

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback(); // Rollback nếu có lỗi
            }
            e.printStackTrace();
            throw e; // Ném lại exception để lớp Service có thể xử lý
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
        return newOrder;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, os.status_name " +
                "FROM `order` o " +
                "JOIN orderstatus os ON o.status_id = os.status_id " +
                "WHERE o.user_id = ? ORDER BY o.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderDate(rs.getTimestamp("created_at"));
                order.setTotalAmount(rs.getDouble("total_amount"));

                OrderStatus status = new OrderStatus(rs.getInt("status_id"), rs.getString("status_name"));
                order.setStatus(status);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}