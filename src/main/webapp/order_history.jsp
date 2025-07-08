
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lịch sử đơn hàng - Quản Lý Kho Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">
<jsp:include page="/partials/header.jsp" />

<div class="container py-5">
    <div class="order-card card">
        <div class="card-header bg-white py-4 border-0">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="mb-0">
                        <i class="bi bi-clock-history text-primary me-2"></i>
                        Lịch sử đơn hàng
                    </h2>
                </div>
                <div class="col-md-6">
                    <div class="d-flex justify-content-md-end gap-2 mt-3 mt-md-0">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search text-muted"></i>
                            </span>
                            <input type="text" class="form-control border-start-0"
                                   placeholder="Tìm kiếm đơn hàng...">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-body">
            <div class="filters">
                <div class="row g-2">
                    <div class="col-md-4">
                        <select class="form-select">
                            <option value="">Trạng thái</option>
                            <option value="PENDING">Đang xử lý</option>
                            <option value="COMPLETED">Hoàn thành</option>
                            <option value="CANCELLED">Đã hủy</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <input type="date" class="form-control" placeholder="Từ ngày">
                    </div>
                    <div class="col-md-4">
                        <input type="date" class="form-control" placeholder="Đến ngày">
                    </div>
                </div>
            </div>

            <c:if test="${empty orders}">
                <div class="empty-state">
                    <i class="bi bi-inbox-fill empty-icon d-block"></i>
                    <h4>Chưa có đơn hàng nào</h4>
                    <p class="text-muted mb-4">Bạn chưa có đơn hàng nào trong lịch sử.</p>
                    <a href="${pageContext.request.contextPath}/products?action=list"
                       class="btn btn-primary">
                        <i class="bi bi-cart-plus me-2"></i>Mua sắm ngay
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty orders}">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th scope="col" style="width: 15%">Mã đơn</th>
                            <th scope="col" style="width: 20%">Ngày đặt</th>
                            <th scope="col" style="width: 25%" class="text-end">Tổng tiền</th>
                            <th scope="col" style="width: 25%" class="text-center">Trạng thái</th>
                            <th scope="col" style="width: 15%" class="text-center">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>
                                    <span class="order-id">#${order.orderId}</span>
                                </td>
                                <td>
                                    <div class="order-date">
                                        <i class="bi bi-calendar3 me-1"></i>
                                            ${order.orderDate}
                                    </div>
                                </td>
                                <td class="text-end">
                                        <span class="order-amount">
                                            ${String.format("%,d", order.totalAmount)}₫
                                        </span>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                                <span class="status-badge status-pending">
                                                    <i class="bi bi-hourglass-split me-1"></i>
                                                    Đang xử lý
                                                </span>
                                        </c:when>
                                        <c:when test="${order.status == 'COMPLETED'}">
                                                <span class="status-badge status-completed">
                                                    <i class="bi bi-check-circle me-1"></i>
                                                    Hoàn thành
                                                </span>
                                        </c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">
                                                <span class="status-badge status-cancelled">
                                                    <i class="bi bi-x-circle me-1"></i>
                                                    Đã hủy
                                                </span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="orders/detail?id=${order.orderId}"
                                       class="btn btn-primary detail-btn">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <div class="text-muted">
                        Hiển thị ${orders.size()} đơn hàng
                    </div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination mb-0">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>
                            <li class="page-item active">
                                <a class="page-link" href="#">1</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">2</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">3</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="/partials/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>