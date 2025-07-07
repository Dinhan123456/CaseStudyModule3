<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang quản trị</title>

</head>
<body>
<%@ include file="/partials/header.jsp" %>
<%@ include file="/partials/menu.jsp" %>
<div class="dashboard">
    <h2>Xin chào Quản trị viên!</h2>
    <p>Chọn chức năng để quản lý hệ thống</p>

    <div class="menu">
        <a href="product?action=list"> Quản lý sản phẩm</a>
        <a href="user?action=list"> Quản lý người dùng</a>
        <a href="user?action=logout"> Đăng xuất</a>
    </div>
</div>
<%@ include file="/partials/footer.jsp" %>
</body>
</html>

