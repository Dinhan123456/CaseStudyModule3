package org.example.module3casestudy.model;

public class User {
    private int userId;
    private String name;
    private String email;
    private String password;
    private String address;
    private String phone;
    private Role role;
    private Cart cart;

    public User() {}

    public User(int userId, String name, String email, String password, String address, String phone, Role role) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.address = address;
        this.phone = phone;
        this.role = role;
        this.cart = new Cart(userId); // Initialize cart with userId
    }

    public User(int i, String an, String mail, String number, Role userRole) {
        this.userId = i;
        this.name = an;
        this.email = mail;
        this.password = null; // Password is not set in this constructor
        this.address = null; // Address is not set in this constructor
        this.phone = number;
        this.role = userRole;
        this.cart = new Cart(i); // Initialize cart with userId
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Cart getCart() {
        return cart;
    }
    public void setCart(Cart cart) {
        this.cart = cart;
    }
}
