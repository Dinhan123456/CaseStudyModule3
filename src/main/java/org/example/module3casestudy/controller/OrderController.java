package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.*;
import org.example.module3casestudy.service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/checkout")
public class OrderController extends HttpServlet {
    private final OrderService orderService = new OrderService();
    private final UserService userService = new UserService();
    private final CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(req.getParameter("userId"));
            String paymentMethod = req.getParameter("paymentMethod");

            User user = userService.getById(userId);
            if (user == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Người dùng không tồn tại.");
                return;
            }

            Cart cart = cartService.getCartByUserId(userId);
            if (cart == null || cart.getItems().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Giỏ hàng rỗng.");
                return;
            }

            if (cart.getTotalAmount() <= 0) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tổng tiền không hợp lệ.");
                return;
            }

            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Vui lòng chọn phương thức thanh toán.");
                return;
            }

            Order order = orderService.placeOrder(user);
            if (order != null) {
                req.setAttribute("order", order);
                req.setAttribute("details", orderService.getOrderDetails(order));
                req.getRequestDispatcher("order_success.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("cart.jsp");
            }

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ.");
        }
    }
}
