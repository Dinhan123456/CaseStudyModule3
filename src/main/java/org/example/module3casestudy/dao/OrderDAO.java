package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDAO {
    private final Connection conn = DBConnection.getConnection();

    public Order createOrder(User user, double totalAmount) {
        String sql = "INSERT INTO `order` (user_id, order_date, total_amount, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, user.getUserId());
            ps.setTimestamp(2, new Timestamp(new Date().getTime()));
            ps.setDouble(3, totalAmount);
            ps.setString(4, OrderStatus.PENDING.name());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int orderId = rs.getInt(1);
                    return new Order(orderId, user, new Date(), totalAmount, OrderStatus.PENDING);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> getOrdersByUser(User user) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM `order` WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getUserId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        user,
                        rs.getTimestamp("order_date"),
                        rs.getDouble("total_amount"),
                        OrderStatus.valueOf(rs.getString("status"))
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.name, u.email FROM `order` o JOIN user u ON o.user_id = u.user_id";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Role role = new Role(0, "User"); // có thể dùng RoleDAO nếu cần chính xác
                User user = new User(rs.getInt("user_id"), rs.getString("name"),
                        rs.getString("email"), null, null, null, role);
                Order order = new Order(
                        rs.getInt("order_id"),
                        user,
                        rs.getTimestamp("order_date"),
                        rs.getDouble("total_amount"),
                        OrderStatus.valueOf(rs.getString("status"))
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
