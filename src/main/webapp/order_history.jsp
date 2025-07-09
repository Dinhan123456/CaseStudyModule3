<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Lịch sử đơn hàng</title>
  <style>
    .container { width: 80%; margin: 20px auto; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
    th { background-color: #f2f2f2; }
    .empty-history { text-align: center; padding: 40px; font-size: 1.2em; color: #777; }
    .message { padding: 15px; margin-bottom: 20px; border-radius: 5px; }
    .success { color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; }
    .error { color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; }
  </style>
</head>
<body>
<jsp:include page="/partials/header.jsp"/>

<div class="container">
  <h2>Lịch sử đơn hàng của bạn</h2>

  <c:if test="${not empty sessionScope.successMessage}">
    <div class="message success">
      <c:out value="${sessionScope.successMessage}"/>
    </div>
    <c:remove var="successMessage" scope="session"/>
  </c:if>

  <c:if test="${not empty sessionScope.errorMessage}">
    <div class="message error">
      <c:out value="${sessionScope.errorMessage}"/>
    </div>
    <c:remove var="errorMessage" scope="session"/>
  </c:if>

  <c:if test="${empty orders}">
    <div class="empty-history">
      <p>Bạn chưa có đơn hàng nào.</p>
    </div>
  </c:if>

  <c:if test="${not empty orders}">
    <table>
      <thead>
      <tr>
        <th>Mã đơn hàng</th>
        <th>Ngày đặt</th>
        <th>Tổng tiền</th>
        <th>Trạng thái</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="order" items="${orders}">
        <tr>
          <td>#<c:out value="${order.orderId}"/></td>
          <td><fmt:formatDate value="${order.orderDate}" pattern="HH:mm:ss dd/MM/yyyy"/></td>
          <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
          <td><c:out value="${order.status.statusName}"/></td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </c:if>
</div>

<jsp:include page="/partials/footer.jsp"/>
</body>
</html>