package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {
    private final Connection conn = DBConnection.getConnection();
    private final ProductDAO productDAO = new ProductDAO();

    public void saveOrderDetail(Order order, CartItem cartItem) {
        String sql = "INSERT INTO orderdetail (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, order.getOrderId());
            ps.setInt(2, cartItem.getProduct().getProductId());
            ps.setInt(3, cartItem.getQuantity());
            ps.setDouble(4, cartItem.getProduct().getPrice());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OrderDetail> getDetailsByOrder(Order order) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT * FROM orderdetail WHERE order_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, order.getOrderId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = productDAO.findById(rs.getInt("product_id"));
                if (product != null) {
                    OrderDetail detail = new OrderDetail(
                            rs.getInt("order_detail_id"),
                            order,
                            product,
                            rs.getInt("quantity"),
                            rs.getDouble("price")
                    );
                    details.add(detail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
}
