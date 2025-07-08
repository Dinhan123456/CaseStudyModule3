package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.Role;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/khohangmini";
    private final String jdbcUsername = "codegym";
    private final String jdbcPassword = "raisingthebar";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public Role getDefaultRole() {
        String sql = "SELECT * FROM role WHERE role_name = 'User' LIMIT 1";
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                return new Role(rs.getInt("role_id"), rs.getString("role_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new Role(2, "User"); // fallback
    }

    public List<Role> selectAll() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT * FROM role";
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                roles.add(new Role(rs.getInt("role_id"), rs.getString("role_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    public Role findById(int id) {
        String sql = "SELECT * FROM role WHERE role_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Role(rs.getInt("role_id"), rs.getString("role_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Role> findAll() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT * FROM role";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roles.add(new Role(rs.getInt("role_id"), rs.getString("role_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

}
