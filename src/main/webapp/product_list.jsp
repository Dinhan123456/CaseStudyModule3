<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="partials/header.jsp" %>
<%@ include file="partials/menu.jsp" %>

<h2>Danh sách sản phẩm</h2>

<a href="${pageContext.request.contextPath}/products/add">➕ Thêm sản phẩm</a>

<table border="1" cellpadding="10" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên sản phẩm</th>
        <th>Mô tả</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Hình ảnh</th>
        <th>Danh mục</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="p" items="${productList}">
        <tr>
            <td>${p.productId}</td>
            <td>${p.productName}</td>
            <td>${p.description}</td>
            <td>${p.price}</td>
            <td>${p.quantity}</td>
            <td>
                <img src="${p.image}" width="60" height="60" alt="Ảnh sản phẩm" />
            </td>
            <td>${p.category.categoryName}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<%@ include file="partials/footer.jsp" %>
