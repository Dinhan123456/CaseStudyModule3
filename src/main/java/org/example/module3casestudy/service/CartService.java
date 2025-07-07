package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.CartDAO;
import org.example.module3casestudy.model.*;

public class CartService {
    private CartDAO cartDAO = new CartDAO();

    public Cart getCartByUserId(int userId) {
        return cartDAO.getCartByUserId(userId);
    }

    public void addToCart(int userId, Product product, int quantity) {
        Cart cart = getCartByUserId(userId);
        cart.addItem(product, quantity);
        cartDAO.saveCart(cart);
    }

    public void clearCart(int userId) {
        cartDAO.clearCart(userId);
    }

    public void removeFromCart(int userId, int productId) {
        Cart cart = getCartByUserId(userId);
        cart.removeItem(productId);
        cartDAO.saveCart(cart);
    }

}
