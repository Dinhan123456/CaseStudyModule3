<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ hàng</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/partials/header.jsp" />

<div class="container py-4">
  <div class="card shadow-sm">
    <div class="card-body">
      <h2 class="card-title mb-4">
        <i class="bi bi-cart"></i> Giỏ hàng của bạn
      </h2>

      <c:if test="${empty cart.items}">
        <div class="text-center text-muted py-5">
          <i class="bi bi-cart-x display-1"></i>
          <p class="mt-3">Giỏ hàng đang trống</p>
          <a href="products?action=list" class="btn btn-primary mt-2">
            <i class="bi bi-shop"></i> Tiếp tục mua sắm
          </a>
        </div>
      </c:if>

      <c:if test="${not empty cart.items}">
        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead class="table-light">
            <tr>
              <th>Sản phẩm</th>
              <th class="text-end">Giá</th>
              <th class="text-center">Số lượng</th>
              <th class="text-end">Thành tiền</th>
              <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${cart.items}">
              <tr>
                <td>
                  <div class="d-flex align-items-center">
                    <img src="${item.product.image}" alt="${item.product.productName}"
                         class="rounded me-3" style="width: 64px; height: 64px; object-fit: cover;">
                    <div>
                      <h6 class="mb-0">${item.product.productName}</h6>
                    </div>
                  </div>
                </td>
                <td class="text-end">
                    ${String.format("%,d", item.product.price)}₫
                </td>
                <td class="text-center" style="width: 200px;">
                  <div class="input-group">
                    <button class="btn btn-outline-secondary btn-sm" type="button">-</button>
                    <input type="text" class="form-control text-center" value="${item.quantity}">
                    <button class="btn btn-outline-secondary btn-sm" type="button">+</button>
                  </div>
                </td>
                <td class="text-end">
                    ${String.format("%,d", item.totalPrice)}₫
                </td>
                <td class="text-center">
                  <form action="cart" method="post" class="d-inline">
                    <input type="hidden" name="action" value="remove" />
                    <input type="hidden" name="userId" value="${cart.userId}" />
                    <input type="hidden" name="productId" value="${item.product.productId}" />
                    <button type="submit" class="btn btn-outline-danger btn-sm">
                      <i class="bi bi-trash"></i>
                    </button>
                  </form>
                </td>
              </tr>
            </c:forEach>
            </tbody>
            <tfoot>
            <tr>
              <td colspan="3" class="text-end"><strong>Tổng cộng:</strong></td>
              <td class="text-end"><strong>${String.format("%,d", cart.totalAmount)}₫</strong></td>
              <td></td>
            </tr>
            </tfoot>
          </table>
        </div>

        <div class="d-flex justify-content-between mt-4">
          <a href="products?action=list" class="btn btn-outline-primary">
            <i class="bi bi-arrow-left"></i> Tiếp tục mua sắm
          </a>
          <form action="checkout" method="post" class="d-inline">
            <input type="hidden" name="userId" value="${cart.userId}" />
            <button type="submit" class="btn btn-success">
              <i class="bi bi-check-circle"></i> Thanh toán
            </button>
          </form>
        </div>
      </c:if>
    </div>
  </div>
</div>
<jsp:include page="/partials/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
