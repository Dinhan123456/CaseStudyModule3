<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.module3casestudy.model.User" %>
<%@ page import="java.util.List" %>
<%
  List<User> users = (List<User>) request.getAttribute("users");
%>
<html>
<head>
  <title>Danh sách người dùng</title>
</head>
<body>
<h2>Danh sách người dùng</h2>
<table border="1" cellpadding="5">
  <tr>
    <th>ID</th>
    <th>Tên</th>
    <th>Email</th>
    <th>Địa chỉ</th>
    <th>SĐT</th>
    <th>Vai trò</th>
  </tr>
  <%
    if (users != null) {
      for (User u : users) {
  %>
  <tr>
    <td><%= u.getUserId() %></td>
    <td><%= u.getName() %></td>
    <td><%= u.getEmail() %></td>
    <td><%= u.getAddress() %></td>
    <td><%= u.getPhone() %></td>
    <td><%= u.getRole().getRoleName() %></td>
  </tr>
  <%
      }
    }
  %>
</table>
</body>
</html>
