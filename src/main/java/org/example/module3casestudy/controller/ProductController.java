package org.example.module3casestudy.controller;

import org.example.module3casestudy.model.Category;
import org.example.module3casestudy.model.Product;
import org.example.module3casestudy.service.CategoryService;
import org.example.module3casestudy.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductController", urlPatterns = {"/products", "/products/add"})
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
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null) {
            action = "list"; // default action
        }

        System.out.println("ProductController: doGet - action = " + action);
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

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("ProductController: showAddForm called.");
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/product_form.jsp").forward(req, resp);
    }

    private void showProductList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> productList = productService.getAllProducts();
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/product_list.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.getById(id);
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("product", product);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/product_edit_form.jsp").forward(req, resp);
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        productService.deleteProduct(id);
        HttpSession session = req.getSession();
        session.setAttribute("message", "Xóa sản phẩm thành công!");
        resp.sendRedirect(req.getContextPath() + "/products?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        System.out.println("ProductController: doPost - action = " + action);
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

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        
        int categoryId = Integer.parseInt(req.getParameter("category"));

        Category category = categoryService.getCategoryById(categoryId);
        Product product = new Product(0, name, description, price, quantity, category);
        productService.addProduct(product);

        HttpSession session = req.getSession();
        session.setAttribute("message", "Thêm sản phẩm thành công!");
        resp.sendRedirect(req.getContextPath() + "/products?action=add");
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int categoryId = Integer.parseInt(req.getParameter("category"));

        Category category = categoryService.getCategoryById(categoryId);
        Product product = new Product(id, name, description, price, quantity, category);
        productService.updateProduct(product);

        HttpSession session = req.getSession();
        session.setAttribute("message", "Cập nhật sản phẩm thành công!");
        resp.sendRedirect(req.getContextPath() + "/products?action=list");
    }
}