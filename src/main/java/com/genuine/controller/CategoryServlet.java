package com.genuine.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/category/*")
public class CategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryPath = request.getPathInfo();
        String category = categoryPath != null ? categoryPath.substring(1) : "";

        // Add your category handling logic here
        request.setAttribute("category", category);
        request.getRequestDispatcher("/category.jsp").forward(request, response);
    }
}