package com.genuine.controller;

import com.genuine.dao.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.*;

@WebServlet("/addProduct")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10,  // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Handle file upload
            Part filePart = request.getPart("image");

            String contentDisposition = filePart.getHeader("content-disposition");
            String fileName = null;

            if (contentDisposition != null) {
                for (String content : contentDisposition.split(";")) {
                    if (content.trim().startsWith("filename")) {
                        fileName = content.substring(content.indexOf("=") + 1).trim().replace("\"", "");
                        break;
                    }
                }
            }

            String uploadPath = getServletContext().getRealPath("/images/uploads");
            String filePath = uploadPath + File.separator + fileName;

            // Create uploads directory if it doesn't exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Save the file
            filePart.write(filePath);

            // Insert basic product information
            String sql = "INSERT INTO products (category, name, company, price, description, image_path) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, request.getParameter("category"));
            pstmt.setString(2, request.getParameter("name"));
            pstmt.setString(3, request.getParameter("company"));
            pstmt.setDouble(4, Double.parseDouble(request.getParameter("price")));
            pstmt.setString(5, request.getParameter("description"));
            pstmt.setString(6, "uploads/" + fileName);

            pstmt.executeUpdate();

            // Get the generated product ID
            ResultSet rs = pstmt.getGeneratedKeys();
            int productId = 0;
            if (rs.next()) {
                productId = rs.getInt(1);
            }

            // Insert specifications based on category
            String category = request.getParameter("category");
            switch (category) {
                case "mobile":
                    insertMobileSpecs(conn, productId, request);
                    break;
            }

            conn.commit();
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp?success=true");

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp?error=true");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void insertMobileSpecs(Connection conn, int productId, HttpServletRequest request)
            throws SQLException {
        String sql = "INSERT INTO mobile_specs (product_id, storage, ram, battery, camera_specs) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, productId);
        pstmt.setString(2, request.getParameter("mobile_storage"));
        pstmt.setString(3, request.getParameter("mobile_ram"));
        pstmt.setString(4, request.getParameter("mobile_battery"));
        pstmt.setString(5, request.getParameter("mobile_camera"));
        pstmt.executeUpdate();
    }

    // Similar methods for insertLaptopSpecs and insertWatchSpecs
}