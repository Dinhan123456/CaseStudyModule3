package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.Product;
import org.example.module3casestudy.model.Cart;
import org.example.module3casestudy.model.User;
import org.example.module3casestudy.service.CartService;
import org.example.module3casestudy.service.ProductService;
import org.example.module3casestudy.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private final CartService cartService = new CartService();
    private final UserService userService = new UserService();
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(req.getParameter("userId"));
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String action = req.getParameter("action");

            if ("remove".equals(action)) {
                cartService.removeFromCart(userId, productId);
                resp.sendRedirect("cart.jsp");
                return;
            }

            if (userId <= 0 || productId <= 0 || quantity <= 0) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ.");
                return;
            }

            User user = userService.getById(userId);
            if (user == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Người dùng không tồn tại.");
                return;
            }

            Product product = productService.getById(productId);
            if (product == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại.");
                return;
            }

            if (product.getQuantity() < quantity) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số lượng vượt quá hàng tồn.");
                return;
            }

            cartService.addToCart(userId, product, quantity);
            resp.sendRedirect("cart.jsp");

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu đầu vào không hợp lệ.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String userIdParam = req.getParameter("userId");
            if (userIdParam == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin userId");
                return;
            }

            int userId = Integer.parseInt(userIdParam);
            Cart cart = cartService.getCartByUserId(userId);
            req.setAttribute("cart", cart);
            req.getRequestDispatcher("cart.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "userId không hợp lệ");
        }
    }
}
