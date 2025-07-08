<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="/partials/header.jsp" %>

<div class="container">
    <div class="dashboard">
        <h2 class="text-center mb-4">Chào mừng <%= (user != null ? user.getName() : "") %>!</h2>

        <div class="menu">
            <% if ("ADMIN".equalsIgnoreCase(roleName)) { %>
            <a href="products?action=list" class="btn">
                <i class="bi bi-box"></i> Quản lý sản phẩm
            </a>
            <a href="user?action=list" class="btn">
                <i class="bi bi-people"></i> Quản lý người dùng
            </a>
            <a href="checkout?action=history" class="btn">
                <i class="bi bi-clock-history"></i> Lịch sử đơn hàng
            </a>
            <% } else if ("USER".equalsIgnoreCase(roleName)) { %>
            <a href="products?action=view" class="btn">
                <i class="bi bi-shop"></i> Xem sản phẩm
            </a>
            <a href="cart.jsp?userId=<%= user.getUserId() %>" class="btn">
                <i class="bi bi-cart"></i> Giỏ hàng của tôi
            </a>
            <a href="checkout?action=history&userId=<%= user.getUserId() %>" class="btn">
                <i class="bi bi-clock-history"></i> Lịch sử đơn hàng
            </a>
            <% } %>
        </div>
    </div>
</div>

<jsp:include page="/partials/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</body>
</html>