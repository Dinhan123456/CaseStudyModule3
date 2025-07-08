<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.module3casestudy.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String roleName = user.getRole().getRoleName(); // "ADMIN" hoặc "USER"
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("title") != null ? request.getAttribute("title") : "Trang web quản lý kho" %>
    </title>
    <style>
        /* Navbar styles */
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

        .navbar a:hover {
            text-decoration: underline;
        }

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
            text-decoration: none;
            color: white;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

    </style>
</head>
<body>

<div class="navbar">
    <div class="navbar-left">
        <a href="<%= request.getContextPath() %>/home.jsp"> Trang chủ</a>
    </div>
    <div class="navbar-right">
        <% if (user != null) { %>
        <span>Xin chào, <strong><%= user.getName() %></strong></span>
        <a href="<%= request.getContextPath() %>/user?action=logout" class="logout-btn">Đăng xuất</a>
        <% } %>
    </div>
</div>