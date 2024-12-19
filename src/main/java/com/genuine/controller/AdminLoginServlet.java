package com.genuine.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    // Hard-coded admin credentials (in real applications, use secure storage)
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin@123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("adminUsername");
        String password = request.getParameter("adminPassword");

        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            // Create session for admin
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username);
            session.setAttribute("isAdmin", true);

            // Redirect to admin dashboard or home page
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid admin credentials");
            request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
    }
}