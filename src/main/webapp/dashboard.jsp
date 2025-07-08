<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%
  Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
%>
<html>
<head>
  <title>Admin Dashboard</title>
</head>
<body>
<h1>Thống kê hệ thống</h1>
<ul>
  <li>Tổng người dùng: <%= stats.get("users") %></li>
  <li>Tổng sản phẩm: <%= stats.get("products") %></li>
  <li>Tổng đơn hàng: <%= stats.get("orders") %></li>
  <li>Sản phẩm sắp hết hàng: <%= stats.get("lowStock") %></li>
</ul>
</body>
</html>