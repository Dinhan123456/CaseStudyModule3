<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Giỏ hàng</title>
</head>
<body>
<h2>Giỏ hàng của bạn</h2>

<c:if test="${empty cart.items}">
    <p>Giỏ hàng đang trống.</p>
</c:if>

<c:if test="${not empty cart.items}">
    <table border="1">
        <tr>
            <th>Sản phẩm</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Hành động</th>
        </tr>

        <c:forEach var="item" items="${cart.items}">
            <tr>
                <td>${item.product.productName}</td>
                <td>${item.product.price}</td>
                <td>${item.quantity}</td>
                <td>${item.totalPrice}</td>
                <td>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="remove"/>
                        <input type="hidden" name="userId" value="${cart.userId}"/>
                        <input type="hidden" name="productId" value="${item.product.productId}"/>
                        <button type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <p><strong>Tổng tiền:</strong> ${cart.totalAmount}</p>

    <form action="checkout" method="post">
        <input type="hidden" name="userId" value="${cart.userId}"/>
        <button type="submit">Đặt hàng</button>
    </form>
</c:if>
</body>
</html>
