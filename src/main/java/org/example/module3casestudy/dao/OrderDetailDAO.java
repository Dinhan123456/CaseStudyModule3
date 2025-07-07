package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;

import java.util.*;

public class OrderDetailDAO {
    private static final List<OrderDetail> orderDetails = new ArrayList<>();
    private static int orderDetailIdCounter = 1;

    public void saveOrderDetail(Order order, CartItem cartItem) {
        OrderDetail detail = new OrderDetail(
                orderDetailIdCounter++,
                order,
                cartItem.getProduct(),
                cartItem.getQuantity(),
                cartItem.getProduct().getPrice()
        );
        orderDetails.add(detail);
    }

    public List<OrderDetail> getDetailsByOrder(Order order) {
        List<OrderDetail> result = new ArrayList<>();
        for (OrderDetail d : orderDetails) {
            if (d.getOrder().getOrderId() == order.getOrderId()) {
                result.add(d);
            }
        }
        return result;
    }
}
