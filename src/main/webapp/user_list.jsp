<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách người dùng</title>
</head>
<body>
<h2>Danh sách người dùng</h2>
<table border="1" cellpadding="5">
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Email</th>
        <th>Địa chỉ</th>
        <th>SĐT</th>
        <th>Vai trò</th>
    </tr>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.userId}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${user.address}</td>
            <td>${user.phone}</td>
            <td>${user.role.roleName}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>