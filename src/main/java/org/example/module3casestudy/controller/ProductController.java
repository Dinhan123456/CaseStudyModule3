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
        resp.setContentType("text/html;charset=UTF-8");


        String action = req.getServletPath();

        switch (action) {
            case "/products/add":
                showAddForm(req, resp);
                break;
            case "/products":
            default:
                showProductList(req, resp);
                break;
        }
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/product_form.jsp").forward(req, resp);
    }

    private void showProductList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> productList = productService.getAllProducts();
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/product_list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");


        String action = req.getServletPath();
        if ("/products/add".equals(action)) {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String image = req.getParameter("image");
            int categoryId = Integer.parseInt(req.getParameter("category"));

            Category category = categoryService.getCategoryById(categoryId);
            Product product = new Product(0, name, description, price, quantity, image, category);
            productService.addProduct(product);

            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }
}
