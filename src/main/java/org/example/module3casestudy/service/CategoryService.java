package org.example.module3casestudy.service;

import org.example.module3casestudy.dao.CategoryDAO;
import org.example.module3casestudy.model.Category;
import java.util.List;

public class CategoryService {
    private CategoryDAO categoryDAO = new CategoryDAO();

    public List<Category> getAllCategories() {
        return categoryDAO.findAll();
    }

    public Category getCategoryById(int id) {
        return categoryDAO.findById(id);
    }
}