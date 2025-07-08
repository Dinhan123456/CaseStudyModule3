<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.module3casestudy.model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
</head>
<body>
<jsp:include page="/partials/header.jsp"/>
<jsp:include page="/partials/menu.jsp"/>
<div class="container">
    <h2>CHI TIẾT SẢN PHẨM</h2>

    <%
        if (product != null) {
    %>
    <table>
        <tr>
            <td><strong>ID:</strong></td>
            <td><%= product.getProductId() %></td>
        </tr>
        <tr>
            <td><strong>Tên sản phẩm:</strong></td>
            <td><%= product.getProductName() %></td>
        </tr>
        <tr>
            <td><strong>Hình ảnh:</strong></td>
            <td><img src="<%= product.getImage() %>" alt="<%= product.getProductName() %>" width="100"></td>
        </tr>
        <tr>
            <td><strong>Giá:</strong></td>
            <td><%= product.getPrice() %> VND</td>
        </tr>
        <tr>
            <td><strong>Số lượng:</strong></td>
            <td><%= product.getQuantity() %></td>
        </tr>
        <tr>
            <td><strong>Mô tả:</strong></td>
            <td><%= product.getDescription() %></td>
        </tr>
        <tr>
            <td><strong>Danh mục</strong></td>
            <td><%= product.getCategory().getCategoryName() %></td>
        </tr>
    </table>
    <%
    } else {
    %>
    <p style="color:red; text-align:center;">Không tìm thấy sản phẩm.</p>
    <%
        }
    %>
    <a href="product?action=list" class="btn"> Quay lại danh sách</a>
</div>
<jsp:include page="/partials/footer.jsp"/>
</body>
</html>

