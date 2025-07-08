<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/partials/header.jsp" %>
<%@ include file="/partials/menu.jsp" %>

<div class="product-detail">
    <h2>Chi tiết sản phẩm</h2>

    <c:if test="${not empty product}">
        <table border="1" cellpadding="10">
            <tr>
                <th>ID</th>
                <td>${product.productId}</td>
            </tr>
            <tr>
                <th>Tên sản phẩm</th>
                <td>${product.productName}</td>
            </tr>
            <tr>
                <th>Mô tả</th>
                <td>${product.description}</td>
            </tr>
            <tr>
                <th>Giá</th>
                <td>${product.price} VNĐ</td>
            </tr>
            <tr>
                <th>Số lượng</th>
                <td>${product.quantity}</td>
            </tr>
            <tr>
                <th>Hình ảnh</th>
                <td><img src="${product.image}" alt="Ảnh sản phẩm" width="150"></td>
            </tr>
            <tr>
                <th>Danh mục</th>
                <td>${product.category.categoryName}</td>
            </tr>
        </table>
    </c:if>

    <c:if test="${empty product}">
        <p style="color: red;">Không tìm thấy thông tin sản phẩm.</p>
    </c:if>

    <br>
    <a href="${pageContext.request.contextPath}/products">⬅ Quay lại danh sách sản phẩm</a>
</div>

<%@ include file="/partials/footer.jsp" %>
</body>
</html>
