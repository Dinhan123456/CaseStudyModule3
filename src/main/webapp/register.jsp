<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Đăng ký tài khoản</title>
</head>
<body>
<h2>Đăng ký tài khoản</h2>
<form method="post" action="user?action=register">
  <label>Họ tên:</label><input type="text" name="name"><br>
  <label>Email:</label><input type="text" name="email"><br>
  <label>Mật khẩu:</label><input type="password" name="password"><br>
  <label>Địa chỉ:</label><input type="text" name="address"><br>
  <label>Số điện thoại:</label><input type="text" name="phone"><br>

  <!-- Bỏ dropdown role đi -->
  <input type="submit" value="Đăng ký">
</form>

<p>Đã có tài khoản? <a href="user?action=showRegister">Đăng ký</a></p>
</body>
</html>