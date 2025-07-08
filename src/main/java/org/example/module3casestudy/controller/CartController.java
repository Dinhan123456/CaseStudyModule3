package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.Cart;
import org.example.module3casestudy.model.Product;
import org.example.module3casestudy.model.ProductDatabase;
import org.example.module3casestudy.model.UserDatabase;
import org.example.module3casestudy.service.CartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private CartService cartService = new CartService();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        try {
            int userId = Integer.parseInt(req.getParameter("userId"));
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String action = req.getParameter("action");

            // Nếu là hành động xóa
            if ("remove".equals(action)) {
                cartService.removeFromCart(userId, productId);
                resp.sendRedirect("cart.jsp");
                return;
            }

            // Validate: userId, productId, quantity phải > 0
            if (userId <= 0 || productId <= 0 || quantity <= 0) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ.");
                return;
            }

            // Validate: kiểm tra user có tồn tại
            if (UserDatabase.findById(userId) == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Người dùng không tồn tại.");
                return;
            }

            // Validate: kiểm tra sản phẩm có tồn tại
            Product product = ProductDatabase.findById(productId);
            if (product == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại.");
                return;
            }

            // Validate: kiểm tra hàng còn đủ không
            if (product.getQuantity() < quantity) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Số lượng vượt quá số lượng còn trong kho.");
                return;
            }

            // Tất cả đều hợp lệ → thêm vào giỏ hàng
            cartService.addToCart(userId, product, quantity);
            resp.sendRedirect("cart.jsp");

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu đầu vào không hợp lệ.");
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        int userId = Integer.parseInt(req.getParameter("userId"));
        Cart cart = cartService.getCartByUserId(userId);
        req.setAttribute("cart", cart);
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }
}