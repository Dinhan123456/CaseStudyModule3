package org.example.module3casestudy.controller;

import org.example.module3casestudy.dao.RoleDAO;
import org.example.module3casestudy.model.Role;
import org.example.module3casestudy.model.User;
import org.example.module3casestudy.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "UserController", urlPatterns = "/user")
public class UserController extends HttpServlet {
    private UserService userService;
    private RoleDAO roleDAO;

    @Override
    public void init() {
        userService = new UserService();
        roleDAO = new RoleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "list":
                showUserList(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                response.sendRedirect("login.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "register":
                registerUser(request, response);
                break;
            case "login":
                loginUser(request, response);
                break;
            default:
                response.sendRedirect("login.jsp");
                break;
        }
    }

    private Map<String, String> validateRegistration(HttpServletRequest req) {
        Map<String, String> errors = new HashMap<>();
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        if (name == null || name.trim().isEmpty()) errors.put("name", "Họ tên không được để trống.");
        if (address == null || address.trim().isEmpty()) errors.put("address", "Địa chỉ không được để trống.");

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email không được để trống.");
        } else if (!userService.isValidEmail(email)) {
            errors.put("email", "Định dạng email không hợp lệ.");
        } else if (userService.isEmailExists(email)) {
            errors.put("email", "Email này đã được sử dụng.");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống.");
        } else if (password.length() < 6) {
            errors.put("password", "Mật khẩu phải có ít nhất 6 ký tự.");
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.put("phone", "Số điện thoại không được để trống.");
        } else if (!userService.isValidPhone(phone)) {
            errors.put("phone", "Số điện thoại không hợp lệ (phải có 10 số, bắt đầu bằng 0).");
        }
        return errors;
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Map<String, String> errors = validateRegistration(request);
        if (errors.isEmpty()) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            Role defaultRole = roleDAO.getDefaultRole();
            User user = new User(0, name, email, password, address, phone, defaultRole);
            userService.register(user);

            // THÊM DÒNG NÀY: Lưu thông báo thành công vào session
            request.getSession().setAttribute("successMessage", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");

            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            User userInput = new User();
            userInput.setName(request.getParameter("name"));
            userInput.setEmail(request.getParameter("email"));
            userInput.setAddress(request.getParameter("address"));
            userInput.setPhone(request.getParameter("phone"));

            request.setAttribute("userInput", userInput);
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = userService.login(email, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/home.jsp");
        } else {
            request.setAttribute("error", "Sai email hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }

    private void showUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userService.getAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("user_list.jsp").forward(request, response);
    }
}