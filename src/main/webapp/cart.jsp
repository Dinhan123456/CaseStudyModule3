<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Giỏ hàng của bạn</title>
  <style>
    .container {
      width: 80%;
      margin: 20px auto;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
    .cart-actions form {
      display: inline;
    }
    .total-row {
      font-weight: bold;
      font-size: 1.2em;
    }
    .empty-cart {
      text-align: center;
      padding: 40px;
      font-size: 1.2em;
      color: #777;
    }
    .checkout-container {
      text-align: right;
      margin-top: 20px;
    }
    .btn {
      padding: 10px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      text-decoration: none;
      color: white;
    }
    .btn-danger { background-color: #e74c3c; }
    .btn-success { background-color: #27ae60; }
    .btn-primary { background-color: #3498db; }
  </style>
</head>
<body>
<jsp:include page="/partials/header.jsp"/>

<div class="container">
  <h2>Giỏ hàng của bạn</h2>

  <c:if test="${not empty sessionScope.message}">
    <p style="color: green;">${sessionScope.message}</p>
    <c:remove var="message" scope="session"/>
  </c:if>

  <c:if test="${empty cart or empty cart.items}">
    <div class="empty-cart">
      <p>Giỏ hàng của bạn đang trống.</p>
      <a href="${pageContext.request.contextPath}/products?action=list" class="btn btn-primary">Tiếp tục mua sắm</a>
    </div>
  </c:if>

  <c:if test="${not empty cart.items}">
    <table>
      <thead>
      <tr>
        <th>Sản phẩm</th>
        <th>Đơn giá</th>
        <th>Số lượng</th>
        <th>Thành tiền</th>
        <th>Hành động</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="item" items="${cart.items}">
        <tr>
          <td><c:out value="${item.product.productName}"/></td>
          <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
          <td><c:out value="${item.quantity}"/></td>
          <td><fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
          <td class="cart-actions">
            <form action="${pageContext.request.contextPath}/cart" method="post">
              <input type="hidden" name="action" value="remove"/>
              <input type="hidden" name="productId" value="${item.product.productId}"/>
              <button type="submit" class="btn btn-danger">Xóa</button>
            </form>
          </td>
        </tr>
      </c:forEach>
      </tbody>
      <tfoot>
      <tr class="total-row">
        <td colspan="3">Tổng cộng</td>
        <td colspan="2"><fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
      </tr>
      </tfoot>
    </table>

    <div class="checkout-container">
      <a href="${pageContext.request.contextPath}/products?action=list" class="btn btn-primary">Tiếp tục mua sắm</a>
      <form action="order" method="post" style="display:inline;">
        <button type="submit" class="btn btn-success">Tiến hành thanh toán</button>
      </form>
    </div>
  </c:if>
</div>

<jsp:include page="/partials/footer.jsp"/>
</body>
</html>