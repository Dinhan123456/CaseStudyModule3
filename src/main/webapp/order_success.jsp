<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đặt hàng thành công - Quản Lý Kho Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">
<jsp:include page="/partials/header.jsp" />

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="order-card card">
                <div class="card-body p-5">
                    <div class="text-center mb-5 success-animation">
                        <i class="bi bi-check-circle-fill success-icon display-1 mb-3"></i>
                        <h1 class="h2">Đặt hàng thành công!</h1>
                        <p class="text-muted">Cảm ơn bạn đã mua sắm tại cửa hàng của chúng tôi</p>
                    </div>

                    <div class="order-info mb-5">
                        <div class="row g-4">
                            <div class="col-sm-6">
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-receipt text-primary me-2"></i>
                                    <h6 class="mb-0">Mã đơn hàng</h6>
                                </div>
                                <p class="h5 mb-0">#${order.orderId}</p>
                            </div>
                            <div class="col-sm-6">
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-calendar-check text-primary me-2"></i>
                                    <h6 class="mb-0">Ngày đặt</h6>
                                </div>
                                <p class="h5 mb-0">${order.orderDate}</p>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive mb-4">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th scope="col">Sản phẩm</th>
                                <th scope="col" class="text-center">Số lượng</th>
                                <th scope="col" class="text-end">Đơn giá</th>
                                <th scope="col" class="text-end">Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${details}">
                                <tr class="product-row">
                                    <td>
                                        <span class="product-name">${item.product.productName}</span>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge bg-secondary">${item.quantity}</span>
                                    </td>
                                    <td class="text-end">${String.format("%,d", item.price)}₫</td>
                                    <td class="text-end">${String.format("%,d", item.price * item.quantity)}₫</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr class="table-light">
                                <td colspan="3" class="text-end">
                                    <strong>Tổng cộng:</strong>
                                </td>
                                <td class="text-end">
                                    <span class="order-total">${String.format("%,d", order.totalAmount)}₫</span>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>

                    <div class="d-flex flex-column flex-md-row justify-content-center gap-3 mt-5">
                        <a href="${pageContext.request.contextPath}/products?action=list"
                           class="action-button btn btn-primary">
                            <i class="bi bi-shop me-2"></i>Tiếp tục mua sắm
                        </a>
                        <a href="${pageContext.request.contextPath}/orders/history"
                           class="action-button btn btn-outline-primary">
                            <i class="bi bi-clock-history me-2"></i>Xem lịch sử đơn hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/partials/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>