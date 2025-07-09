package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.DBConnection;
import org.example.module3casestudy.dao.DashboardDAO;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

public class DashboardService {
    public Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();
        try (Connection conn = DBConnection.getConnection()) {
            DashboardDAO dao = new DashboardDAO(conn);
            stats.put("users", dao.getTotalUsers());
            stats.put("products", dao.getTotalProducts());
            stats.put("orders", dao.getTotalOrders());
            stats.put("lowStock", dao.getLowStockProducts());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }
}