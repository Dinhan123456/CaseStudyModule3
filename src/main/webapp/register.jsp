<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Đăng ký tài khoản</title>
</head>
<body>
<h2>Đăng ký tài khoản</h2>
<form method="post" action="user?action=register">
    <label>Họ tên:</label><input type="text" name="name" required><br>
    <label>Email:</label><input type="text" name="email" required><br>
    <label>Mật khẩu:</label><input type="password" name="password" required><br>
    <label>Địa chỉ:</label><input type="text" name="address" required><br>
    <label>Số điện thoại:</label><input type="text" name="phone" required><br>

    <!-- Bỏ dropdown role đi -->
    <input type="submit" value="Đăng ký">
</form>

<p>Đã có tài khoản? <a href="user?action=login">Đăng nhập</a></p>
</body>
</html>
