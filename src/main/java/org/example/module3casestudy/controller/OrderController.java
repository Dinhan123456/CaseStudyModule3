package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.Order;
import org.example.module3casestudy.model.User;
import org.example.module3casestudy.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/order")
public class OrderController extends HttpServlet {
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "history"; // Mặc định là xem lịch sử
        }

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        if ("history".equals(action)) {
            showOrderHistory(req, resp, user);
        } else {
            showOrderHistory(req, resp, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            Order newOrder = orderService.placeOrder(user.getUserId());
            if (newOrder != null) {
                session.setAttribute("successMessage", "Chúc mừng! Bạn đã đặt hàng thành công.");
                resp.sendRedirect(req.getContextPath() + "/order?action=history");
            } else {
                session.setAttribute("errorMessage", "Đặt hàng thất bại. Giỏ hàng của bạn có thể đang trống.");
                resp.sendRedirect(req.getContextPath() + "/cart?action=view");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình đặt hàng.");
            resp.sendRedirect(req.getContextPath() + "/cart?action=view");
        }
    }

    private void showOrderHistory(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        List<Order> orders = orderService.getOrdersByUserId(user.getUserId());
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("order_history.jsp").forward(req, resp);
    }
}