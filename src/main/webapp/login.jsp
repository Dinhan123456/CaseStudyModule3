<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Đăng nhập</title>
</head>
<body>
<h2>Đăng nhập</h2>
<form method="post" action="user?action=login">
    Email: <input type="text" name="email" required><br><br>
    Mật khẩu: <input type="password" name="password" required><br><br>
    <input type="submit" value="Đăng nhập">
</form>
<c:if test="${param.error == '1'}">
    <p style="color:red;">Sai email hoặc mật khẩu!</p>
</c:if>
<p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký</a></p>
</body>
</html>