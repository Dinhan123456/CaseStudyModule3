<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Báo cáo</title></head>
<body>
<h2>Thống kê hệ thống</h2>
<p>Tổng doanh thu: ${totalRevenue} VNĐ</p>
<p>Số đơn hàng hôm nay: ${ordersToday}</p>
<p>Người dùng mới: ${newUsers}</p>

<h3>Sản phẩm sắp hết hàng</h3>
<ul>
  <c:forEach var="product" items="${lowStockProducts}">
    <li>${product.name} (Còn lại: ${product.quantity})</li>
  </c:forEach>
</ul>

<h3>Sản phẩm bán chạy</h3>
<ol>
  <c:forEach var="item" items="${bestSellers}">
    <li>${item.productName} - ${item.totalSold} đơn</li>
  </c:forEach>
</ol>
</body>
</html>