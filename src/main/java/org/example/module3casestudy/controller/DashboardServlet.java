package org.example.module3casestudy.controller;

import org.example.module3casestudy.service.DashboardService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

    @WebServlet("/            ")
public class DashboardServlet extends HttpServlet {
    private DashboardService service;

    @Override
    public void init() {
        service = new DashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Integer> stats = service.getDashboardStats();
        req.setAttribute("stats", stats);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/dashboard.jsp");
        dispatcher.forward(req, resp);
    }
}