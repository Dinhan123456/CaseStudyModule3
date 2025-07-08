package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.Cart;
import org.example.module3casestudy.model.Order;
import org.example.module3casestudy.model.User;
import org.example.module3casestudy.model.UserDatabase;
import org.example.module3casestudy.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/checkout")
public class OrderController extends HttpServlet {
    private final OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(req.getParameter("userId"));
            String paymentMethod = req.getParameter("paymentMethod");

            // ✅ Validate: user tồn tại
            User user = UserDatabase.findById(userId);
            if (user == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Người dùng không tồn tại.");
                return;
            }

            // ✅ Validate: cart không rỗng
            Cart cart = user.getCart(); // cart đã được gán trong User
            if (cart == null || cart.getItems().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Giỏ hàng rỗng.");
                return;
            }

            // ✅ Validate: tổng tiền > 0
            if (cart.getTotalAmount() <= 0) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tổng tiền không hợp lệ.");
                return;
            }

            // ✅ Validate: đã chọn phương thức thanh toán
            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Vui lòng chọn phương thức thanh toán.");
                return;
            }

            // ✅ Tiến hành đặt hàng
            Order order = orderService.placeOrder(user); // tạm thời chưa dùng paymentMethod
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