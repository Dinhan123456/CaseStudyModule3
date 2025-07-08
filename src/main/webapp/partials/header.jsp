<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.module3casestudy.model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("title") != null ? request.getAttribute("title") : "Trang web quản lý kho" %>
    </title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="navbar">
    <div class="navbar-left">
        <a href="<%= request.getContextPath() %>/view/home.jsp"> Trang chủ</a>
    </div>
    <div class="navbar-right">
        <% if (user != null) { %>
        Xin chào, <strong><%= user.getName() %>
    </strong> |
        <a href="<%= request.getContextPath() %>/user?action=logout">Đăng xuất</a>
        <% } else { %>
        <a href="<%= request.getContextPath() %>/login.jsp">Đăng nhập</a>
        <% } %>
    </div>
</div>

