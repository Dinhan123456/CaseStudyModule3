package org.example.module3casestudy.model;

public enum OrderStatus {
    PENDING(1, "Chờ xử lý"),
    CONFIRMED(2, "Đã xác nhận"),
    SHIPPED(3, "Đang giao"),
    DELIVERED(4, "Đã giao"),
    CANCELLED(5, "Đã hủy");

    private final int id;
    private final String description;

    OrderStatus(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public static OrderStatus fromId(int id) {
        for (OrderStatus status : OrderStatus.values()) {
            if (status.id == id) {
                return status;
            }
        }
        return null;
    }
}