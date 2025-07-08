<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập - Quản Lý Kho Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">
<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
        <div class="col-md-5">
            <div class="card shadow-sm">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="bi bi-shop display-1 text-primary"></i>
                        <h3 class="mt-2">Đăng nhập</h3>
                        <p class="text-muted">Quản Lý Kho Hàng Mini</p>
                    </div>

                    <form method="post" action="user?action=login">
                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="bi bi-envelope"></i> Email
                            </label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock"></i> Mật khẩu
                            </label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <c:if test="${param.error == '1'}">
                            <div class="alert alert-danger" role="alert">
                                <i class="bi bi-exclamation-triangle"></i> Sai email hoặc mật khẩu!
                            </div>
                        </c:if>

                        <button type="submit" class="btn btn-primary w-100 mb-3">
                            <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <p class="mb-0">Chưa có tài khoản?
                            <a href="register.jsp" class="text-decoration-none">Đăng ký ngay</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
