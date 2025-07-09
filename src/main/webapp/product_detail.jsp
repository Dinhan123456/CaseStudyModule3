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

<div class="cart-icon-container" style="position: fixed; top: 20px; right: 20px;">
    <a href="cart.jsp" style="text-decoration: none; color: black;">
        <img src="https://img.icons8.com/ios-filled/50/000000/shopping-cart.png" alt="Cart" style="width: 30px; height: 30px;">
        <span id="cart-item-count" style="background-color: red; color: white; border-radius: 50%; padding: 2px 6px; font-size: 12px; position: relative; top: -10px; left: -5px;">0</span>
    </a>
</div>

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
            <td><strong>Danh mục:</strong></td>
            <td><%= product.getCategory().getCategoryName() %></td>
        </tr>
    </table>

    <div style="margin-top: 20px;">
        <form action="cart?action=add" method="post" style="display:inline;">
            <input type="hidden" name="productId" value="<%= product.getProductId() %>">
            <label for="quantity">Số lượng:</label>
            <input type="number" id="quantity" name="quantity" value="1" min="1" style="width: 60px;">
            <button type="submit">Thêm vào giỏ hàng</button>
        </form>
    </div>

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

