<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm mới</title>
    <style>
        .error { color: red; font-size: 0.9em; }
        .form-group { margin-bottom: 15px; }
    </style>
</head>
<body>
<jsp:include page="/partials/header.jsp"/>

<div style="width: 50%; margin: 20px auto;">
    <h2>Thêm sản phẩm mới</h2>

    <form method="post" action="${pageContext.request.contextPath}/products?action=add">
        <div class="form-group">
            <label for="name">Tên sản phẩm:</label><br>
            <input type="text" id="name" name="name" value="<c:out value='${product.productName}'/>" size="50">
            <c:if test="${not empty errors.name}"><br><span class="error">${errors.name}</span></c:if>
        </div>

        <div class="form-group">
            <label for="description">Mô tả:</label><br>
            <textarea id="description" name="description" rows="4" cols="50"><c:out value='${product.description}'/></textarea>
        </div>

        <div class="form-group">
            <label for="price">Giá:</label><br>
            <input type="text" id="price" name="price" value="<c:out value='${requestScope.product.price > 0 ? requestScope.product.price : ""}'/>">
            <c:if test="${not empty errors.price}"><br><span class="error">${errors.price}</span></c:if>
        </div>

        <div class="form-group">
            <label for="quantity">Số lượng:</label><br>
            <input type="text" id="quantity" name="quantity" value="<c:out value='${requestScope.product.quantity > 0 ? requestScope.product.quantity : ""}'/>">
            <c:if test="${not empty errors.quantity}"><br><span class="error">${errors.quantity}</span></c:if>
        </div>

        <div class="form-group">
            <label for="category">Danh mục:</label><br>
            <select id="category" name="category">
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.categoryId}" ${c.categoryId == product.category.categoryId ? 'selected' : ''}>
                        <c:out value="${c.categoryName}"/>
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty errors.category}"><br><span class="error">${errors.category}</span></c:if>
        </div>

        <input type="submit" value="Thêm mới">
    </form>

    <p><a href="${pageContext.request.contextPath}/products?action=list">Quay lại danh sách</a></p>
</div>
<jsp:include page="/partials/footer.jsp"/>

<script>
    // Script để định dạng số khi người dùng nhập vào ô giá
    const priceInput = document.getElementById('price');
    priceInput.addEventListener('input', function (e) {
        let value = e.target.value.replace(/,/g, '');
        if (!isNaN(value) && value.length > 0) {
            e.target.value = parseFloat(value).toLocaleString('en-US');
        }
    });
</script>

</body>
</html>