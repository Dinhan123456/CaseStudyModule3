<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng ký - Quản Lý Kho Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">
<div class="container">
    <div class="row justify-content-center py-5">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <i class="bi bi-person-plus display-1 text-primary"></i>
                        <h3 class="mt-2">Đăng ký tài khoản</h3>
                    </div>

                    <form method="post" action="user?action=register" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="name" class="form-label">
                                <i class="bi bi-person"></i> Họ tên
                            </label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="bi bi-envelope"></i> Email
                            </label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock"></i> Mật khẩu
                            </label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">
                                <i class="bi bi-geo-alt"></i> Địa chỉ
                            </label>
                            <input type="text" class="form-control" id="address" name="address" required>
                        </div>

                        <div class="mb-4">
                            <label for="phone" class="form-label">
                                <i class="bi bi-telephone"></i> Số điện thoại
                            </label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-person-plus"></i> Đăng ký
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <p class="mb-0">Đã có tài khoản?
                            <a href="login.jsp" class="text-decoration-none">Đăng nhập</a>
                        </p>
                    </div>

                    <c:if test="${param.error == '1'}">
                        <div class="alert alert-danger mt-3" role="alert">
                            <i class="bi bi-exclamation-triangle"></i> Email đã được sử dụng!
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>