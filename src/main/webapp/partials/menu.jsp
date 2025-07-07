<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.module3casestudy.model.User" %>
<%
  User currentUser = (User) session.getAttribute("user");
%>

<div class="menu">
  <a href="<%= request.getContextPath() %>/product?action=list"> Xem sản phẩm</a>

  <%
    if (currentUser != null && currentUser.getRole().getRoleId() == 1) {
  %>
  <a href="<%= request.getContextPath() %>/product?action=add"> Thêm sản phẩm</a>
  <a href="<%= request.getContextPath() %>/user?action=list"> Quản lý người dùng</a>
  <% } %>
</div>

