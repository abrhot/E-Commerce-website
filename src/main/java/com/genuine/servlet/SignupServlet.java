package com.genuine.servlet;

import com.genuine.dao.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/SignupServlet")  // This should match the form action
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement pst = conn.prepareStatement(
                    "INSERT INTO users (full_name, username, email, phone, password) VALUES (?, ?, ?, ?, ?)"
            );

            pst.setString(1, fullName);
            pst.setString(2, username);
            pst.setString(3, email);
            pst.setString(4, phone);
            pst.setString(5, password); // In production, you should hash the password

            int rowsAffected = pst.executeUpdate();

            if(rowsAffected > 0) {
                // Registration successful
                response.sendRedirect(request.getContextPath() + "/pages/registration-success.jsp");
            } else {
                // Registration failed
                response.sendRedirect(request.getContextPath() + "/pages/signup.jsp?error=1");
            }

        } catch (SQLException e) {
            if(e.getMessage().contains("username_unique")) {
                response.sendRedirect("pages/signup.jsp?error=username");
            } else if(e.getMessage().contains("email_unique")) {
                response.sendRedirect("pages/signup.jsp?error=email");
            } else {
                e.printStackTrace();
                response.sendRedirect("pages/signup.jsp?error=unknown");
            }
        }
    }
}