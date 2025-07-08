<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý người dùng - Quản Lý Kho Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">
<jsp:include page="/partials/header.jsp" />

<div class="container py-4">
    <div class="card">
        <div class="card-header bg-white py-4">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="mb-0">
                        <i class="bi bi-people-fill text-primary me-2"></i>
                        Quản lý người dùng
                    </h2>
                </div>
                <div class="col-md-6">
                    <div class="d-flex justify-content-md-end gap-3 mt-3 mt-md-0">
                        <form action="${pageContext.request.contextPath}/user" method="get" class="search-box">
                            <i class="bi bi-search"></i>
                            <input type="hidden" name="action" value="search">
                            <input type="text" name="query" class="form-control search-input"
                                   placeholder="Tìm kiếm người dùng...">
                        </form>
                        <a href="${pageContext.request.contextPath}/user?action=showAdd"
                           class="btn btn-primary">
                            <i class="bi bi-person-plus-fill me-2"></i>
                            Thêm người dùng
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Người dùng</th>
                        <th>Liên hệ</th>
                        <th>Địa chỉ</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="user-avatar">
                                            ${user.name.charAt(0)}
                                    </div>
                                    <div>
                                        <div class="fw-bold">${user.name}</div>
                                        <small class="text-muted">ID: ${user.userId}</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div>
                                    <i class="bi bi-envelope text-muted me-2"></i>${user.email}
                                </div>
                                <div>
                                    <i class="bi bi-telephone text-muted me-2"></i>${user.phone}
                                </div>
                            </td>
                            <td>
                                <i class="bi bi-geo-alt text-muted me-2"></i>${user.address}
                            </td>
                            <td>
                                    <span class="badge rounded-pill
                                        ${user.role.roleName == 'ADMIN' ? 'role-admin' : 'role-user'}">
                                        <i class="bi ${user.role.roleName == 'ADMIN' ? 'bi-shield-fill' : 'bi-person'}">
                                        </i>
                                        ${user.role.roleName}
                                    </span>
                            </td>
                            <td>
                                    <span class="badge rounded-pill status-active">
                                        <i class="bi bi-check-circle-fill me-1"></i>
                                        Hoạt động
                                    </span>
                            </td>
                            <td>
                                <div class="text-center">
                                    <a href="${pageContext.request.contextPath}/user?action=view&id=${user.userId}"
                                       class="btn btn-info action-btn">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/user?action=edit&id=${user.userId}"
                                       class="btn btn-warning action-btn">
                                        <i class="bi bi-pencil-fill"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/user?action=delete&id=${user.userId}"
                                       class="btn btn-danger action-btn"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">
                                        <i class="bi bi-trash-fill"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="card-footer bg-white py-3">
            <nav>
                <ul class="pagination justify-content-end mb-0">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="user?action=list&page=${currentPage - 1}">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="user?action=list&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="user?action=list&page=${currentPage + 1}">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<jsp:include page="/partials/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>