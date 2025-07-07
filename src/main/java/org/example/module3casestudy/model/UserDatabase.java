package org.example.module3casestudy.model;

import org.example.module3casestudy.model.User;
import org.example.module3casestudy.model.Role;

import java.util.*;

public class UserDatabase {
    private static final List<User> users = new ArrayList<>();

    static {
        // Tạo vai trò mẫu
        Role userRole = new Role(1, "USER");
        Role adminRole = new Role(2, "ADMIN");

        // Danh sách người dùng mẫu
        users.add(new User(1, "An", "an@example.com", "123456", userRole));
        users.add(new User(2, "Tuấn", "tuan@example.com", "123456", adminRole));
        users.add(new User(3, "Hà", "ha@example.com", "123456", userRole));
    }

    public static User findById(int userId) {
        for (User u : users) {
            if (u.getUserId() == userId) return u;
        }
        return null;
    }

    public static List<User> getAll() {
        return users;
    }

    public static User findByEmail(String email) {
        for (User u : users) {
            if (u.getEmail().equalsIgnoreCase(email)) return u;
        }
        return null;
    }
}
