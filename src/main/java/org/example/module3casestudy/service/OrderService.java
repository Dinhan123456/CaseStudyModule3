package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.*;
import org.example.module3casestudy.model.*;

import java.util.List;

public class OrderService {
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderDetailDAO detailDAO = new OrderDetailDAO();
    private final CartService cartService = new CartService();

    public Order placeOrder(User user) {
        Cart cart = cartService.getCartByUserId(user.getUserId());
        if (cart.getItems().isEmpty()) return null;

        double total = cart.getTotalAmount();
        Order order = orderDAO.createOrder(user, total);
        if (order == null) return null;

        for (CartItem item : cart.getItems()) {
            detailDAO.saveOrderDetail(order, item);
        }

        cartService.clearCart(user.getUserId());

        return order;
    }

    public List<Order> getOrdersByUser(User user) {
        return orderDAO.getOrdersByUser(user);
    }

    public List<OrderDetail> getOrderDetails(Order order) {
        return detailDAO.getDetailsByOrder(order);
    }
}
