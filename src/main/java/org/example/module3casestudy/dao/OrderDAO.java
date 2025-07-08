package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;

import java.util.*;

public class OrderDAO {
    private static final List<Order> orderList = new ArrayList<>();
    private static int orderIdCounter = 1;

    public Order createOrder(User user, double totalAmount) {
        Order order = new Order(orderIdCounter++, user, new Date(), totalAmount, OrderStatus.PENDING);
        orderList.add(order);
        return order;
    }

    public List<Order> getOrdersByUser(User user) {
        List<Order> result = new ArrayList<>();
        for (Order o : orderList) {
            if (o.getUser().getUserId() == user.getUserId()) {
                result.add(o);
            }
        }
        return result;
    }

    public List<Order> getAllOrders() {
        return orderList;
    }
}