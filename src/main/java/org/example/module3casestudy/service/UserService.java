package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.UserDAO;
import org.example.module3casestudy.model.User;

import java.util.List;
import java.util.regex.Pattern;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public User getById(int id) {
        return userDAO.findById(id);
    }

    public void register(User user) {
        userDAO.insert(user);
    }

    public User login(String email, String password) {
        return userDAO.checkLogin(email, password);
    }

    public List<User> getAll() {
        return userDAO.selectAll();
    }

    public boolean isEmailExists(String email) {
        return userDAO.emailExists(email);
    }

    public boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }

    public boolean isValidPhone(String phone) {
        // Regex for Vietnamese phone numbers (10 digits, starting with 0)
        String phoneRegex = "^0\\d{9}$";
        Pattern pattern = Pattern.compile(phoneRegex);
        return pattern.matcher(phone).matches();
    }
}