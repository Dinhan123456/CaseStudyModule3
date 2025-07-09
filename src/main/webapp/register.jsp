<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container">
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4">Đăng ký tài khoản</h3>

                    <form method="post" action="${pageContext.request.contextPath}/user?action=register">
                        <div class="mb-3">
                            <label for="name" class="form-label">Họ tên</label>
                            <input type="text" class="form-control ${not empty errors.name ? 'is-invalid' : ''}" id="name" name="name" value="<c:out value='${userInput.name}'/>">
                            <div class="invalid-feedback">${errors.name}</div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control ${not empty errors.email ? 'is-invalid' : ''}" id="email" name="email" value="<c:out value='${userInput.email}'/>">
                            <div class="invalid-feedback">${errors.email}</div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control ${not empty errors.password ? 'is-invalid' : ''}" id="password" name="password">
                            <div class="invalid-feedback">${errors.password}</div>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control ${not empty errors.address ? 'is-invalid' : ''}" id="address" name="address" value="<c:out value='${userInput.address}'/>">
                            <div class="invalid-feedback">${errors.address}</div>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control ${not empty errors.phone ? 'is-invalid' : ''}" id="phone" name="phone" value="<c:out value='${userInput.phone}'/>">
                            <div class="invalid-feedback">${errors.phone}</div>
                        </div>

                        <button type="submit" class="btn btn-success w-100">Đăng ký</button>
                    </form>

                    <div class="text-center mt-3">
                        <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a></p>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>