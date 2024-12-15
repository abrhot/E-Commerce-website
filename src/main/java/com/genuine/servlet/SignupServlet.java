package com.genuine.servlet;

import com.genuine.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input parameters
        if (fullName == null || username == null || email == null ||
                phone == null || password == null || confirmPassword == null ||
                fullName.trim().isEmpty() || username.trim().isEmpty() ||
                email.trim().isEmpty() || phone.trim().isEmpty() ||
                password.trim().isEmpty() || confirmPassword.trim().isEmpty()) {

            response.sendRedirect("pages/signup.jsp?error=missing_fields");
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("pages/signup.jsp?error=password_mismatch");
            return;
        }

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            // Get database connection
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Database connection could not be established");
            }

            // Prepare SQL statement
            String sql = "INSERT INTO users (full_name, username, email, phone, password) VALUES (?, ?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);

            // Set parameters
            pst.setString(1, fullName.trim());
            pst.setString(2, username.trim());
            pst.setString(3, email.trim());
            pst.setString(4, phone.trim());
            pst.setString(5, password); // In production, you should hash the password

            // Add this before the insert operation
            String checkSql = "SELECT username, email FROM users WHERE username = ? OR email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, username.trim());
            checkStmt.setString(2, email.trim());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                if (username.trim().equals(rs.getString("username"))) {
                    response.sendRedirect("pages/signup.jsp?error=username_exists");
                    return;
                }
                if (email.trim().equals(rs.getString("email"))) {
                    response.sendRedirect("pages/signup.jsp?error=email_exists");
                    return;
                }
            }
            // Execute the insert
            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                // Registration successful
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp?success=true");
            } else {
                // No rows were affected
                response.sendRedirect("pages/signup.jsp?error=insert_failed");
            }

        } catch (SQLException e) {
            // Log the error
            e.printStackTrace();
            System.err.println("Database Error: " + e.getMessage());

            // Handle specific SQL errors
            if (e.getMessage().contains("username")) {
                response.sendRedirect("pages/signup.jsp?error=username_exists");
            } else if (e.getMessage().contains("email")) {
                response.sendRedirect("pages/signup.jsp?error=email_exists");
            } else {
                response.sendRedirect("pages/signup.jsp?error=unknown");
            }
        } finally {
            // Close resources
            try {
                if (pst != null) {
                    pst.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}