package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.UserDAO;
import org.example.module3casestudy.model.User;

import java.util.List;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public void register(User user) {
        userDAO.insert(user);
    }

    public User login(String email, String password) {
        return userDAO.checkLogin(email, password);
    }

    public List<User> getAll() {
        return userDAO.selectAll();
    }
}
