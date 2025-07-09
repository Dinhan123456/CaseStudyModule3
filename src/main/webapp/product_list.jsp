<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.module3casestudy.model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String roleName = (String) request.getAttribute("roleName");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách sản phẩm - Quản Lý Kho Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light">
<jsp:include page="/partials/header.jsp" />

<div class="container py-5">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">
            <i class="bi bi-box me-2"></i>Danh sách sản phẩm
        </h2>
        <% if ("ADMIN".equalsIgnoreCase((String) request.getAttribute("roleName"))) { %>
        <a href="${pageContext.request.contextPath}/products/add"
           class="btn btn-primary action-btn">
            <i class="bi bi-plus-lg me-2"></i>Thêm sản phẩm
        </a>
        <% } %>
    </div>

    <!-- Search Form -->
    <form action="${pageContext.request.contextPath}/products" method="get" class="search-form">
        <input type="hidden" name="action" value="search">
        <div class="input-group">
            <input type="search" name="query" class="form-control search-input"
                   placeholder="Tìm kiếm sản phẩm..."
                   value="${param.query}">
            <button type="submit" class="btn btn-primary action-btn">
                <i class="bi bi-search"></i>
            </button>
        </div>
    </form>

    <!-- Products Grid -->
    <div class="row g-4">
        <% if (products != null && !products.isEmpty()) {
            for (Product p : products) { %>
        <div class="col-md-6 col-lg-4">
            <div class="product-card">
                <div class="position-relative">
                    <img src="<%= p.getImage() != null && !p.getImage().isEmpty() ?
                              p.getImage() : "images/default-product.jpg" %>"
                         class="product-image"
                         alt="<%= p.getProductName() %>">
                    <% if (p.getQuantity() > 0) { %>
                    <span class="stock-badge bg-success">
                            Còn <%= p.getQuantity() %> sản phẩm
                        </span>
                    <% } else { %>
                    <span class="stock-badge bg-danger">Hết hàng</span>
                    <% } %>
                </div>

                <div class="card-body">
                    <span class="category-badge">
                        <%= p.getCategory().getCategoryName() %>
                    </span>

                    <h5 class="card-title mb-2"><%= p.getProductName() %></h5>

                    <p class="card-text text-muted mb-3">
                        <%= p.getDescription() != null ?
                                (p.getDescription().length() > 100 ?
                                        p.getDescription().substring(0, 100) + "..." :
                                        p.getDescription()) : "" %>
                    </p>

                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="price-tag">
                            <%= String.format("%,d", p.getPrice()) %>₫
                        </span>
                    </div>

                    <div class="d-flex flex-wrap gap-2">
                        <a href="products?action=view&id=<%= p.getProductId() %>"
                           class="btn btn-outline-primary action-btn">
                            <i class="bi bi-eye me-1"></i>Chi tiết
                        </a>

                        <% if ("ADMIN".equalsIgnoreCase((String) request.getAttribute("roleName"))) { %>
                        <a href="products?action=edit&id=<%= p.getProductId() %>"
                           class="btn btn-outline-warning action-btn">
                            <i class="bi bi-pencil me-1"></i>Sửa
                        </a>

                        <form action="products" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= p.getProductId() %>">
                            <button type="submit" class="btn btn-outline-danger action-btn"
                                    onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                <i class="bi bi-trash me-1"></i>Xóa
                            </button>
                        </form>
                        <% } else if (p.getQuantity() > 0) { %>
                        <form action="cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="btn btn-primary action-btn">
                                <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
                            </button>
                        </form>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <% }
        } else { %>
        <div class="col-12">
            <div class="empty-state">
                <i class="bi bi-inbox display-1 text-muted"></i>
                <h4 class="mt-3">Không có sản phẩm nào</h4>
                <p class="text-muted">Chưa có sản phẩm nào trong kho hàng</p>
                <% if ("ADMIN".equalsIgnoreCase((String) request.getAttribute("roleName"))) { %>
                <a href="${pageContext.request.contextPath}/products/add"
                   class="btn btn-primary action-btn mt-3">
                    <i class="bi bi-plus-lg me-2"></i>Thêm sản phẩm mới
                </a>
                <% } %>
            </div>
        </div>
        <% } %>
    </div>
</div>

<jsp:include page="/partials/footer.jsp" />
</body>
</html>