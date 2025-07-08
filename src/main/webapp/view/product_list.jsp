<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.module3casestudy.model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>

</head>
<body>
<jsp:include page="/partials/header.jsp"/>
<jsp:include page="/partials/menu.jsp"/>
<div class="top-bar">
    <div>
        <a href="product?action=add">Thêm sản phẩm</a>
    </div>
</div>

<h2 style="text-align:center">DANH SÁCH SẢN PHẨM</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Tên sản phẩm</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Thao tác</th>
    </tr>
    <%
        if (products != null && !products.isEmpty()) {
            for (Product p : products) {
    %>
    <tr>
        <td><%= p.getProductId() %></td>
        <td><%= p.getProductName() %></td>
        <td><%= p.getPrice() %></td>
        <td><%= p.getQuantity() %></td>
        <td class="actions">
            <a href="product?action=edit&id=<%= p.getProductId() %>">Sửa</a>
            |
            <a href="product?action=delete&id=<%= p.getProductId() %>" onclick="return confirm('Xoá sản phẩm này?');">Xoá</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="5">Không có sản phẩm nào.</td>
    </tr>
    <% } %>
</table>
<jsp:include page="/partials/footer.jsp"/>
</body>
</html>

