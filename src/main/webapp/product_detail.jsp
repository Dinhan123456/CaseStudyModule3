<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.module3casestudy.model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
</head>
<body>
<jsp:include page="/partials/header.jsp" />

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h2 class="card-title text-center mb-4">
                        <i class="bi bi-box"></i> Chi tiết sản phẩm
                    </h2>

                    <% if (product != null) { %>
                    <div class="row">
                        <div class="col-md-4">
                            <img src="<%= product.getImage() %>"
                                 alt="<%= product.getProductName() %>"
                                 class="img-fluid rounded mb-3">
                        </div>
                        <div class="col-md-8">
                            <table class="table table-borderless">
                                <tr>
                                    <th width="30%">ID:</th>
                                    <td><%= product.getProductId() %></td>
                                </tr>
                                <tr>
                                    <th>Tên sản phẩm:</th>
                                    <td><%= product.getProductName() %></td>
                                </tr>
                                <tr>
                                    <th>Giá:</th>
                                    <td><%= String.format("%,d", product.getPrice()) %>₫</td>
                                </tr>
                                <tr>
                                    <th>Số lượng:</th>
                                    <td><%= product.getQuantity() %></td>
                                </tr>
                                <tr>
                                    <th>Danh mục:</th>
                                    <td><%= product.getCategory().getCategoryName() %></td>
                                </tr>
                                <tr>
                                    <th>Mô tả:</th>
                                    <td><%= product.getDescription() %></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <% } else { %>
                    <div class="text-center text-muted py-5">
                        <i class="bi bi-exclamation-circle display-1"></i>
                        <p class="mt-3">Không tìm thấy sản phẩm.</p>
                    </div>
                    <% } %>

                    <div class="text-center mt-4">
                        <a href="products?action=list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Quay lại danh sách
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
