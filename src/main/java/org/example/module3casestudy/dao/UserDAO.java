package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.Role;
import org.example.module3casestudy.model.User;

import java.sql.*;
import java.util.*;

public class UserDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/khohangmini";
    private String jdbcUsername = "codegym";
    private String jdbcPassword = "codegym";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void insert(User user) throws SQLException {
        String sql = "INSERT INTO users(name, email, password, address, phone, role_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPhone());
            ps.setInt(6, user.getRole().getRoleId());
            ps.executeUpdate();
        }
    }

    public User checkLogin(String email, String password) {
        String sql = "SELECT u.*, r.role_id, r.role_name FROM users u JOIN roles r ON u.role_id = r.role_id WHERE email=? AND password=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                return new User(
                        rs.getInt("user_id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("address"), rs.getString("phone"), role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> selectAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.*, r.role_id, r.role_name FROM users u JOIN roles r ON u.role_id = r.role_id";
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                users.add(new User(
                        rs.getInt("user_id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("address"), rs.getString("phone"), role));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}