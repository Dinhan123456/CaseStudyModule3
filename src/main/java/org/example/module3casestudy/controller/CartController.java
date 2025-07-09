package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.Cart;
import org.example.module3casestudy.model.User;
import org.example.module3casestudy.service.CartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private final CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "view"; // Mặc định là xem giỏ hàng
        }

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        switch (action) {
            case "add":
                addToCart(req, resp, user);
                break;
            case "view":
            default:
                viewCart(req, resp, user);
                break;
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = 1; // Mặc định thêm 1 sản phẩm từ trang danh sách

            cartService.addToCart(user.getUserId(), productId, quantity);

            req.getSession().setAttribute("message", "Đã thêm sản phẩm vào giỏ hàng!");
            resp.sendRedirect(req.getContextPath() + "/products?action=list");

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ.");
        }
    }

    private void viewCart(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        Cart cart = cartService.getCartByUserId(user.getUserId());
        req.setAttribute("cart", cart);
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        if ("remove".equals(action)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                cartService.removeFromCart(user.getUserId(), productId);
                req.getSession().setAttribute("message", "Đã xóa sản phẩm khỏi giỏ hàng!");
                resp.sendRedirect(req.getContextPath() + "/cart?action=view");
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ.");
            }
        } else {
            // Có thể thêm logic cập nhật số lượng ở đây nếu cần
            resp.sendRedirect(req.getContextPath() + "/cart?action=view");
        }
    }
}