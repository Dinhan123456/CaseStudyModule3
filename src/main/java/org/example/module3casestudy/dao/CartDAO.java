package org.example.module3casestudy.dao;

import org.example.module3casestudy.model.*;

import java.util.*;

public class CartDAO {
    private static final Map<Integer, Cart> userCarts = new HashMap<>();

    public Cart getCartByUserId(int userId) {
        return userCarts.getOrDefault(userId, new Cart(userId));
    }

    public void saveCart(Cart cart) {
        userCarts.put(cart.getUserId(), cart);
    }

    public void clearCart(int userId) {
        userCarts.remove(userId);
    }
}