<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Đặt hàng thành công</title>
</head>
<body>
<h2>Đặt hàng thành công!</h2>
<p>Mã đơn hàng: ${order.orderId}</p>
<p>Ngày đặt: ${order.orderDate}</p>
<p>Tổng tiền: ${order.totalAmount}</p>
<p>Trạng thái: ${order.status}</p>

<h3>Chi tiết đơn hàng:</h3>
<table border="1">
    <tr>
        <th>Sản phẩm</th>
        <th>Số lượng</th>
        <th>Giá</th>
    </tr>
    <c:forEach var="item" items="${details}">
        <tr>
            <td>${item.product.productName}</td>
            <td>${item.quantity}</td>
            <td>${item.price}</td>
        </tr>
    </c:forEach>
</table>

<a href="order_history.jsp">Xem lịch sử đơn hàng</a>
</body>
</html>