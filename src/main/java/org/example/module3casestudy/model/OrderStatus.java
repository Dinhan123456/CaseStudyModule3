package org.example.module3casestudy.model;

public class OrderStatus {
    private int statusId;
    private String statusName;

    // Default constructor
    public OrderStatus() {
    }

    // Constructor with parameters
    public OrderStatus(int statusId, String statusName) {
        this.statusId = statusId;
        this.statusName = statusName;
    }

    // Getters and Setters
    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
}