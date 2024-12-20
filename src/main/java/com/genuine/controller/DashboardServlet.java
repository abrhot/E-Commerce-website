package com.genuine.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.genuine.dao.ProductDAO;
import com.genuine.model.Product;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get popular products
            List<Product> popularProducts = productDAO.getPopularProducts(4);
            request.setAttribute("popularProducts", popularProducts);

            // Get products by category
            String[] categories = {"mobile", "laptop", "watch", "headset", "tv"};
            for (String category : categories) {
                List<Product> categoryProducts = productDAO.getProductsByCategory(category);
                request.setAttribute(category + "Products", categoryProducts);
            }

            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchTerm = request.getParameter("search");
        try {
            List<Product> searchResults = productDAO.searchProducts(searchTerm);
            request.setAttribute("searchResults", searchResults);
            request.getRequestDispatcher("/search-results.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}