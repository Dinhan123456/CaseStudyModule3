package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.Category;
import org.example.module3casestudy.model.Product;
import org.example.module3casestudy.service.CategoryService;
import org.example.module3casestudy.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductController", urlPatterns = "/products")
public class ProductController extends HttpServlet {
    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init() {
        productService = new ProductService();
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                showAddForm(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "delete":
                deleteProduct(req, resp);
                break;
            case "list":
            default:
                showProductList(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                addProduct(req, resp);
                break;
            case "update":
                updateProduct(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/products?action=list");
                break;
        }
    }

    private Map<String, String> validateProduct(HttpServletRequest req) {
        Map<String, String> errors = new HashMap<>();
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String categoryIdStr = req.getParameter("category");

        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Tên sản phẩm không được để trống.");
        }

        // Validate Category
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            errors.put("category", "Vui lòng chọn danh mục.");
        }

        // Validate Price
        if (priceStr == null || priceStr.trim().isEmpty()) {
            errors.put("price", "Giá sản phẩm không được để trống.");
        } else {
            try {
                // Sửa lại: Xử lý chuỗi giá có dấu phẩy
                double price = Double.parseDouble(priceStr.replaceAll(",", ""));
                if (price < 0) {
                    errors.put("price", "Giá sản phẩm không được âm.");
                }
            } catch (NumberFormatException e) {
                errors.put("price", "Giá sản phẩm phải là một con số hợp lệ.");
            }
        }

        // Validate Quantity
        if (quantityStr == null || quantityStr.trim().isEmpty()) {
            errors.put("quantity", "Số lượng không được để trống.");
        } else {
            try {
                int quantity = Integer.parseInt(quantityStr);
                if (quantity < 0) {
                    errors.put("quantity", "Số lượng không được âm.");
                }
            } catch (NumberFormatException e) {
                errors.put("quantity", "Số lượng phải là một số nguyên.");
            }
        }
        return errors;
    }

    private Product getProductFromRequest(HttpServletRequest req) {
        Product product = new Product();
        String idStr = req.getParameter("id");
        if(idStr != null && !idStr.isEmpty()) {
            product.setProductId(Integer.parseInt(idStr));
        }
        product.setProductName(req.getParameter("name"));
        product.setDescription(req.getParameter("description"));

        String priceStr = req.getParameter("price").replaceAll(",", "");
        String quantityStr = req.getParameter("quantity");
        String categoryIdStr = req.getParameter("category");

        try { product.setPrice(Double.parseDouble(priceStr)); } catch (Exception ignored) {}
        try { product.setQuantity(Integer.parseInt(quantityStr)); } catch (Exception ignored) {}

        Category category = new Category();
        try { category.setCategoryId(Integer.parseInt(categoryIdStr)); } catch (Exception ignored) {}
        product.setCategory(category);

        return product;
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> errors = validateProduct(req);
        if (errors.isEmpty()) {
            Product product = getProductFromRequest(req);
            productService.addProduct(product);
            req.getSession().setAttribute("message", "Thêm sản phẩm thành công!");
            resp.sendRedirect(req.getContextPath() + "/products?action=list");
        } else {
            req.setAttribute("product", getProductFromRequest(req));
            req.setAttribute("errors", errors);
            showAddForm(req, resp);
        }
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> errors = validateProduct(req);
        if (errors.isEmpty()) {
            Product product = getProductFromRequest(req);
            productService.updateProduct(product);
            req.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
            resp.sendRedirect(req.getContextPath() + "/products?action=list");
        } else {
            req.setAttribute("product", getProductFromRequest(req));
            req.setAttribute("errors", errors);
            req.setAttribute("categories", categoryService.getAllCategories());
            req.getRequestDispatcher("/product_edit_form.jsp").forward(req, resp);
        }
    }

    // Các phương thức doGet khác không thay đổi
    private void showProductList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> productList = productService.getAllProducts();
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/product_list.jsp").forward(req, resp);
    }
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/product_form.jsp").forward(req, resp);
    }
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.getById(id);
            if (product != null) {
                List<Category> categories = categoryService.getAllCategories();
                req.setAttribute("product", product);
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/product_edit_form.jsp").forward(req, resp);
            } else { resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm."); }
        } catch (NumberFormatException e) { resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ."); }
    }
    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            productService.deleteProduct(id);
            req.getSession().setAttribute("message", "Xóa sản phẩm thành công!");
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("errorMessage", "ID sản phẩm không hợp lệ.");
        }
        resp.sendRedirect(req.getContextPath() + "/products?action=list");
    }
}