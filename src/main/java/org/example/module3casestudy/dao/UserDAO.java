package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.Role;
import org.example.module3casestudy.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public void insert(User user) {
        String sql = "INSERT INTO user(name, email, password, address, phone, role_id, is_active) VALUES (?, ?, ?, ?, ?, ?, 1)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPhone());
            ps.setInt(6, user.getRole().getRoleId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM user WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User checkLogin(String email, String password) {
        String sql = "SELECT u.*, r.role_name FROM user u JOIN role r ON u.role_id = r.role_id WHERE u.email=? AND u.password=? AND u.is_active = 1";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                return new User(rs.getInt("user_id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("address"), rs.getString("phone"), role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> selectAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name FROM user u JOIN role r ON u.role_id = r.role_id";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
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
    public User findById(int id) {
        User user = null;
        String sql = "SELECT u.*, r.role_name FROM user u LEFT JOIN role r ON u.role_id = r.role_id WHERE u.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                Role role = new Role(rs.getInt("role_id"), rs.getString("role_name"));
                user.setRole(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}