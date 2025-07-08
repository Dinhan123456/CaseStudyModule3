<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Lịch sử đơn hàng</title>
</head>
<body>
<h2>Lịch sử đơn hàng</h2>

<c:if test="${empty orders}">
    <p>Chưa có đơn hàng nào.</p>
</c:if>

<c:if test="${not empty orders}">
    <table border="1">
        <tr>
            <th>Mã đơn</th>
            <th>Ngày đặt</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
        </tr>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.orderId}</td>
                <td>${order.orderDate}</td>
                <td>${order.totalAmount}</td>
                <td>${order.status}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<a href="home.jsp">Quay lại trang chủ</a>
</body>
</html>