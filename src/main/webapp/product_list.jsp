<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.module3casestudy.model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("productList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>
</head>
<body>
<jsp:include page="/partials/header.jsp"/>

<div class="cart-icon-container" style="position: fixed; top: 20px; right: 20px;">
    <a href="cart.jsp" style="text-decoration: none; color: black;">
        <img src="https://img.icons8.com/ios-filled/50/000000/shopping-cart.png" alt="Cart" style="width: 30px; height: 30px;">
        <span id="cart-item-count" style="background-color: red; color: white; border-radius: 50%; padding: 2px 6px; font-size: 12px; position: relative; top: -10px; left: -5px;">0</span>
    </a>
</div>

<div class="top-bar">
    <%-- Admin Only: Add Product Link --%>
    <%-- Example of server-side check: if (session.getAttribute("userRole") != null && session.getAttribute("userRole").equals("admin")) { --%>
    <div>
        <a href="products?action=add">Thêm sản phẩm</a>
    </div>
    <%-- } --%>
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
            <%-- Admin Only Actions --%>
            <%-- Example of server-side check: if (session.getAttribute("userRole") != null && session.getAttribute("userRole").equals("admin")) { --%>
            <a href="products?action=edit&id=<%= p.getProductId() %>">Sửa</a>
            |
            <a href="products?action=delete&id=<%= p.getProductId() %>" onclick="return confirm('Xoá sản phẩm này?');">Xoá</a>
            <%-- } else { --%>
            <%-- User Actions --%>
            <form action="cart?action=add" method="post" style="display:inline;">
                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                <input type="number" name="quantity" value="1" min="1" style="width: 50px;">
                <button type="submit">Thêm vào giỏ hàng</button>
            </form>
            <%-- } --%>
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
<script>
    // This is a placeholder. In a real application, this count would come from the server (e.g., session or database).
    // For demonstration, you can manually set it or connect it to your cart logic.
    function updateCartItemCount(count) {
        document.getElementById('cart-item-count').textContent = count;
    }

    // Example: Call this function when a product is added to cart or on page load
    // updateCartItemCount(5); // Example: 5 items in cart
</script>
</body>
</html>

