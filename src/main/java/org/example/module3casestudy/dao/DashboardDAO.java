package org.example.module3casestudy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardDAO {
    private final Connection conn;

    public DashboardDAO(Connection conn) {
        this.conn = conn;
    }

    public int getTotalUsers() {
        return getCount("SELECT COUNT(*) FROM user");
    }

    public int getTotalProducts() {
        return getCount("SELECT COUNT(*) FROM product");
    }

    public int getTotalOrders() {
        return getCount("SELECT COUNT(*) FROM `order`");
    }

    public int getLowStockProducts() {
        return getCount("SELECT COUNT(*) FROM product WHERE quantity < 10");
    }

    private int getCount(String sql) {
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
