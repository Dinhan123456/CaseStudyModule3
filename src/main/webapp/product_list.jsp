<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.module3casestudy.model.Product" %>
<%@ page import="org.example.module3casestudy.model.User" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>
</head>
<body>
<jsp:include page="/partials/header.jsp" />

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-box"></i> Danh sách sản phẩm</h2>
        <% if ("ADMIN".equalsIgnoreCase((String) request.getAttribute("roleName"))) { %>
        <a href="${pageContext.request.contextPath}/products/add" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Thêm sản phẩm
        </a>
        <% } %>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (products != null && !products.isEmpty()) {
                        for (Product p : products) { %>
                    <tr>
                        <td><%= p.getProductId() %></td>
                        <td><%= p.getProductName() %></td>
                        <td><%= String.format("%,d", p.getPrice()) %>₫</td>
                        <td><%= p.getQuantity() %></td>
                        <td class="text-center">
                            <div class="btn-group">
                                <a href="products?action=view&id=<%= p.getProductId() %>"
                                   class="btn btn-sm btn-info me-1">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <% if ("ADMIN".equalsIgnoreCase((String) request.getAttribute("roleName"))) { %>
                                <a href="products?action=edit&id=<%= p.getProductId() %>"
                                   class="btn btn-sm btn-warning me-1">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="products?action=delete&id=<%= p.getProductId() %>"
                                   onclick="return confirm('Xác nhận xóa sản phẩm này?');"
                                   class="btn btn-sm btn-danger">
                                    <i class="bi bi-trash"></i>
                                </a>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <% }
                    } else { %>
                    <tr>
                        <td colspan="5" class="text-center text-muted py-4">
                            <i class="bi bi-inbox display-1"></i>
                            <p class="mt-3">Không có sản phẩm nào.</p>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/partials/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
