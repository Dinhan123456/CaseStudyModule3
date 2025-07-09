<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.example.module3casestudy.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:out value="${title != null ? title : 'Trang web quản lý kho'}"/></title>
    <style>
        body { font-family: sans-serif; }
        .navbar {
            background-color: #2c3e50;
            color: white;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 16px;
            font-weight: 500;
        }
        .navbar a:hover { text-decoration: underline; }
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .logout-btn {
            background-color: #e74c3c;
            padding: 6px 12px;
            border-radius: 5px;
            font-weight: bold;
            color: white;
            transition: background-color 0.3s ease;
        }
        .logout-btn:hover { background-color: #c0392b; }
    </style>
</head>
<body>

<div class="navbar">
    <div class="navbar-left">
        <a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/products?action=list">Sản phẩm</a>
    </div>
    <div class="navbar-right">
        <span>Xin chào, <strong><c:out value="${sessionScope.user.name}"/></strong></span>
        <c:if test="${sessionScope.user.role.roleName == 'User'}">
            <a href="${pageContext.request.contextPath}/cart?action=view">Giỏ hàng</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/user?action=logout" class="logout-btn">Đăng xuất</a>
    </div>
</div>