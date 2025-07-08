<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
</head>
<body>

<h2>Sửa sản phẩm</h2>

<c:if test="${not empty sessionScope.message}">
    <p style="color: green;">${sessionScope.message}</p>
    <c:remove var="message" scope="session"/>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/products?action=update">
    <input type="hidden" name="id" value="${product.productId}">

    <label>Tên sản phẩm:</label><br>
    <input type="text" name="name" value="${product.productName}" required><br><br>

    <label>Mô tả:</label><br>
    <textarea name="description" rows="4" cols="40">${product.description}</textarea><br><br>

    <label>Giá:</label><br>
    <input type="number" name="price" step="0.01" value="${product.price}" required><br><br>

    <label>Số lượng:</label><br>
    <input type="number" name="quantity" value="${product.quantity}" required><br><br>

    <label>Danh mục:</label><br>
    <select name="category" required>
        <c:forEach var="c" items="${categories}">
            <option value="${c.categoryId}" ${c.categoryId == product.category.categoryId ? 'selected' : ''}>${c.categoryName}</option>
        </c:forEach>
    </select><br><br>

    <input type="submit" value="Lưu thay đổi">
</form>

<p><a href="${pageContext.request.contextPath}/products?action=list">Back to Product List</a></p>

</body>
</html>
