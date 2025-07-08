package org.example.module3casestudy.controller;

import org.example.module3casestudy.dao.RoleDAO;
import org.example.module3casestudy.model.Role;
import org.example.module3casestudy.model.User;
import org.example.module3casestudy.service.UserService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserController", urlPatterns = "/user")
public class UserController extends HttpServlet {
    private UserService userService = new UserService();
    private RoleDAO roleDAO = new RoleDAO();

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "list":
                showUserList(request, response);
                break;
            case "showRegister":
                showRegisterForm(request, response); // Thêm dòng này
                break;
            default:
                response.sendRedirect("login.jsp");
        }
    }

    private void showRegisterForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("roles", roleDAO.findAll()); // Load tất cả vai trò
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "register":
                registerUser(request, response);
                break;
            case "login":
                loginUser(request, response);
                break;
        }
    }

    private void showUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userService.getAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("user_list.jsp").forward(request, response);
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        int roleId = Integer.parseInt(request.getParameter("roleId")); // Lấy roleId từ form
        Role role = roleDAO.findById(roleId); // Lấy đối tượng Role theo ID

        User user = new User(0, name, email, password, address, phone, role);
        userService.register(user);
        response.sendRedirect("login.jsp");
    }



    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = userService.login(email, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("view/home.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
