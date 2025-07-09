package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.OrderDetail;
import org.example.module3casestudy.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {
    // Lấy chi tiết của một đơn hàng cụ thể
    public List<OrderDetail> getDetailsByOrderId(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.*, p.name as product_name FROM orderdetail od JOIN product p ON od.product_id = p.product_id WHERE od.order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));

                OrderDetail detail = new OrderDetail();
                detail.setOrderDetailId(rs.getInt("order_detail_id"));
                detail.setProduct(product);
                detail.setQuantity(rs.getInt("quantity"));
                detail.setPrice(rs.getDouble("price"));
                details.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
}