package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.CartDAO;
import org.example.module3casestudy.dao.OrderDAO;
import org.example.module3casestudy.model.Cart;
import org.example.module3casestudy.model.Order;

import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private final OrderDAO orderDAO = new OrderDAO();
    private final CartDAO cartDAO = new CartDAO();

    public Order placeOrder(int userId) throws SQLException {
        Cart cart = new CartDAO().getCartByUserId(userId);
        if (cart == null || cart.getItems().isEmpty()) {
            return null;
        }

        // Tạo đơn hàng và chi tiết đơn hàng trong một giao dịch
        Order newOrder = orderDAO.createOrderFromCart(userId, cart);

        // Nếu tạo đơn hàng thành công, xóa giỏ hàng
        if (newOrder != null) {
            cartDAO.clearCart(userId);
        }
        return newOrder;
    }

    public List<Order> getOrdersByUserId(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }
}