package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.Role;
import org.example.module3casestudy.model.User;
import org.example.module3casestudy.service.UserService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/user")
public class UserController extends HttpServlet {
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("register".equals(action)) {
            User user = new User();
            user.setName(request.getParameter("name"));
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("password"));
            user.setAddress(request.getParameter("address"));
            user.setPhone(request.getParameter("phone"));
            user.setRole(new Role(2, "user")); // default role user

            try {
                userService.register(user);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("login.jsp");

        } else if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            User user = userService.login(email, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                if ("admin".equals(user.getRole().getRoleName())) {
                    response.sendRedirect("user?action=list");
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equals(user.getRole().getRoleName())) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("list".equals(action)) {
            List<User> users = userService.getAll();
            request.setAttribute("users", users);
            RequestDispatcher dispatcher = request.getRequestDispatcher("user_list.jsp");
            dispatcher.forward(request, response);
        }
    }
}