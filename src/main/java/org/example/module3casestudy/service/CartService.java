package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.CartDAO;
import org.example.module3casestudy.model.*;

public class CartService {
    private final CartDAO cartDAO = new CartDAO();

    public Cart getCartByUserId(int userId) {
        return cartDAO.getCartByUserId(userId);
    }

    public void addToCart(int userId, Product product, int quantity) {
        Cart cart = cartDAO.getCartByUserId(userId);
        cart.addItem(product, quantity); // xử lý cộng dồn
        cartDAO.saveCart(cart); // overwrite toàn bộ cartitem
    }

    public void clearCart(int userId) {
        cartDAO.clearCart(userId);
    }

    public void removeFromCart(int userId, int productId) {
        cartDAO.removeItem(userId, productId);
    }
}
