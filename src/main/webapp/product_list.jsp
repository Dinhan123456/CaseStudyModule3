<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>
</head>
<body>
<jsp:include page="/partials/header.jsp"/>

<c:if test="${not empty sessionScope.message}">
    <p style="color: green; text-align: center;">${sessionScope.message}</p>
    <c:remove var="message" scope="session"/>
</c:if>

<c:if test="${sessionScope.user.role.roleName == 'Admin'}">
    <div class="top-bar">
        <div>
            <a href="products?action=add">Thêm sản phẩm</a>
        </div>
    </div>
</c:if>

<h2 style="text-align:center">DANH SÁCH SẢN PHẨM</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Tên sản phẩm</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Thao tác</th>
    </tr>
    <c:forEach var="p" items="${productList}">
        <tr>
            <td>${p.productId}</td>
            <td><c:out value="${p.productName}"/></td>
            <td>
                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
            </td>
            <td>${p.quantity}</td>
            <td class="actions">
                    <%-- Thao tác cho Admin --%>
                <c:if test="${sessionScope.user.role.roleName == 'Admin'}">
                    <a href="products?action=edit&id=${p.productId}">Sửa</a>
                    |
                    <a href="products?action=delete&id=${p.productId}" onclick="return confirm('Xoá sản phẩm này?');">Xoá</a>
                </c:if>
                    <%-- Thao tác cho User --%>
                <c:if test="${sessionScope.user.role.roleName == 'User'}">
                    <a href="cart?action=add&productId=${p.productId}">Thêm vào giỏ</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty productList}">
        <tr>
            <td colspan="5">Không có sản phẩm nào.</td>
        </tr>
    </c:if>
</table>
<jsp:include page="/partials/footer.jsp"/>
</body>
</html>