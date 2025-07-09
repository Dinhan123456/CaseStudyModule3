<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container">
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-md-5">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4">Đăng nhập</h3>

                    <%-- THÊM KHỐI NÀY: Hiển thị thông báo đăng ký thành công --%>
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success" role="alert">
                                ${sessionScope.successMessage}
                        </div>
                        <%-- Xóa thông báo sau khi hiển thị --%>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/user?action=login">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <%-- Hiển thị lỗi đăng nhập sai --%>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                    ${error}
                            </div>
                        </c:if>

                        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                    </form>

                    <div class="text-center mt-3">
                        <p>Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>