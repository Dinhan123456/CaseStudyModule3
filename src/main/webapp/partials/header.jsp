<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="org.example.module3casestudy.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String roleName = (user != null && user.getRole() != null) ? user.getRole().getRoleName() : "";
    request.setAttribute("roleName", roleName);
%>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home.jsp">
            <i class="bi bi-house-door"></i> Trang chủ
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center">
                <% if (user != null) { %>
                <li class="nav-item">
                    <span class="nav-link text-dark">
                        <i class="bi bi-person"></i> Xin chào, <strong><%= user.getName() %></strong>
                    </span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-sm btn-outline-danger ms-2" href="${pageContext.request.contextPath}/user?action=logout">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </a>
                </li>
                <% } else { %>
                <li class="nav-item">
                    <a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/login.jsp">
                        <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                    </a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>