<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.module3casestudy.model.User" %>
<%@ page import="org.example.module3casestudy.model.Role" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="/partials/header.jsp" %>

<div class="dashboard">
    <h2>Chào mừng, <%= user.getName() %>!</h2>

    <div class="menu">
        <% if ("ADMIN".equalsIgnoreCase(roleName)) { %>
        <a href="products?action=list">Quản lý sản phẩm</a>
        <a href="user?action=list">Quản lý người dùng</a>
        <% } else if ("USER".equalsIgnoreCase(roleName)) { %>
        <a href="products?action=view">Xem sản phẩm</a>
        <a href="cart.jsp?userId=<%= user.getUserId() %>">Giỏ hàng của tôi</a>
        <a href="oder_history.jsp?userId=<%= user.getUserId() %>">Đơn hàng của tôi</a>
        <% } %>
    </div>
</div>

<%@ include file="/partials/footer.jsp" %>
</body>
</html>
