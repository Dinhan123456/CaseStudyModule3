<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm sản phẩm mới - Quản Lý Kho Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .form-control:focus, .form-select:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }
        .custom-card {
            border-radius: 15px;
            border: none;
        }
        .preview-image {
            max-width: 200px;
            max-height: 200px;
            object-fit: contain;
        }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card custom-card shadow">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="bi bi-box-seam display-1 text-primary"></i>
                        <h2 class="mt-3">Thêm sản phẩm mới</h2>
                        <p class="text-muted">Điền thông tin chi tiết về sản phẩm của bạn</p>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/products?action=add"
                          class="needs-validation" novalidate>

                        <div class="mb-4">
                            <label for="name" class="form-label">
                                <i class="bi bi-tag"></i> Tên sản phẩm
                            </label>
                            <input type="text" class="form-control form-control-lg"
                                   id="name" name="name" required
                                   placeholder="Nhập tên sản phẩm">
                            <div class="invalid-feedback">Vui lòng nhập tên sản phẩm</div>
                        </div>

                        <div class="mb-4">
                            <label for="description" class="form-label">
                                <i class="bi bi-file-text"></i> Mô tả
                            </label>
                            <textarea class="form-control" id="description" name="description"
                                      rows="4" placeholder="Mô tả chi tiết về sản phẩm"></textarea>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label for="price" class="form-label">
                                    <i class="bi bi-currency-dollar"></i> Giá
                                </label>
                                <div class="input-group">
                                    <input type="number" class="form-control form-control-lg"
                                           id="price" name="price" step="1000" required
                                           placeholder="Nhập giá">
                                    <span class="input-group-text">₫</span>
                                    <div class="invalid-feedback">Vui lòng nhập giá</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="quantity" class="form-label">
                                    <i class="bi bi-boxes"></i> Số lượng
                                </label>
                                <input type="number" class="form-control form-control-lg"
                                       id="quantity" name="quantity" required
                                       placeholder="Nhập số lượng">
                                <div class="invalid-feedback">Vui lòng nhập số lượng</div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="image" class="form-label">
                                <i class="bi bi-image"></i> URL hình ảnh
                            </label>
                            <input type="url" class="form-control form-control-lg"
                                   id="image" name="image"
                                   placeholder="Nhập URL hình ảnh">
                            <div id="imagePreview" class="mt-2 text-center"></div>
                        </div>

                        <div class="mb-4">
                            <label for="category" class="form-label">
                                <i class="bi bi-folder"></i> Danh mục
                            </label>
                            <select class="form-select form-select-lg" id="category" name="category" required>
                                <option value="">Chọn danh mục</option>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryId}">${c.categoryName}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn danh mục</div>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-primary btn-lg px-5 me-2">
                                <i class="bi bi-check-lg"></i> Lưu
                            </button>
                            <a href="${pageContext.request.contextPath}/products?action=list"
                               class="btn btn-outline-secondary btn-lg px-5">
                                <i class="bi bi-x-lg"></i> Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/partials/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()

    // Image preview
    document.getElementById('image').addEventListener('input', function() {
        const imageUrl = this.value;
        const previewDiv = document.getElementById('imagePreview');

        if (imageUrl) {
            const img = document.createElement('img');
            img.src = imageUrl;
            img.classList.add('preview-image', 'mt-2', 'rounded');
            img.onerror = function() {
                previewDiv.innerHTML = '<p class="text-danger">Không thể tải hình ảnh</p>';
            };
            previewDiv.innerHTML = '';
            previewDiv.appendChild(img);
        } else {
            previewDiv.innerHTML = '';
        }
    });
</script>
</body>
</html>