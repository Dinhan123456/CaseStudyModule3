<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="partials/header.jsp" %>
<%@ include file="partials/menu.jsp" %>

<h2>Thêm sản phẩm mới</h2>

<form method="post" action="${pageContext.request.contextPath}/products/add">
  <label>Tên sản phẩm:</label><br>
  <input type="text" name="name" required><br><br>

  <label>Mô tả:</label><br>
  <textarea name="description" rows="4" cols="40"></textarea><br><br>

  <label>Giá:</label><br>
  <input type="number" name="price" step="0.01" required><br><br>

  <label>Số lượng:</label><br>
  <input type="number" name="quantity" required><br><br>

  <label>URL hình ảnh:</label><br>
  <input type="text" name="image"><br><br>

  <label>Danh mục:</label><br>
  <select name="category" required>
    <c:forEach var="c" items="${categories}">
      <option value="${c.categoryId}">${c.categoryName}</option>
    </c:forEach>
  </select><br><br>

  <input type="submit" value="Thêm mới">
</form>

<%@ include file="partials/footer.jsp" %>
