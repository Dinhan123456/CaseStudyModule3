<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%-- Sử dụng jsp:include để đảm bảo header được xử lý đúng cách --%>
<jsp:include page="/partials/header.jsp"/>

<div class="dashboard">
    <h2>Chào mừng, <c:out value="${sessionScope.user.name}"/>!</h2>

    <div class="menu">
        <%-- Menu dành cho Admin --%>
        <c:if test="${sessionScope.user.role.roleName == 'Admin'}">
            <a href="${pageContext.request.contextPath}/products?action=list">Quản lý sản phẩm</a>
            <a href="${pageContext.request.contextPath}/user?action=list">Quản lý người dùng</a>
        </c:if>

        <%-- Menu dành cho User --%>
        <c:if test="${sessionScope.user.role.roleName == 'User'}">
            <a href="${pageContext.request.contextPath}/products?action=list">Xem sản phẩm</a>
            <%-- Sửa lại liên kết để trỏ đến CartController --%>
            <a href="${pageContext.request.contextPath}/cart?action=view">Giỏ hàng của tôi</a>
            <%-- Sửa lại liên kết để trỏ đến OrderController (giả định) và sửa lỗi chính tả "oder" -> "order" --%>
            <a href="${pageContext.request.contextPath}/order?action=history">Lịch sử đơn hàng</a>
        </c:if>
    </div>
</div>

<jsp:include page="/partials/footer.jsp"/>
</body>
</html>