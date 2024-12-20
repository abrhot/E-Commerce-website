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
import java.time.LocalDate;

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
            String fileName = getSubmittedFileName(filePart);
            String uploadPath = getServletContext().getRealPath("/uploads");

            // Create uploads directory if it doesn't exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Save the file
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Insert basic product information and get product ID
            int productId = insertBasicProductInfo(conn, request, fileName);

            // Insert specifications based on category
            String category = request.getParameter("category");
            switch (category) {
                case "mobile":
                    insertMobileSpecs(conn, productId, request);
                    break;
                case "pc":
                    insertPCSpecs(conn, productId, request);
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

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    private int insertBasicProductInfo(Connection conn, HttpServletRequest request, String fileName)
            throws SQLException {
        String sql = "INSERT INTO products (category, name, company, price, description, image_path) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, request.getParameter("category"));
        pstmt.setString(2, request.getParameter("name"));
        pstmt.setString(3, request.getParameter("company"));
        pstmt.setDouble(4, Double.parseDouble(request.getParameter("price")));
        pstmt.setString(5, request.getParameter("description"));
        pstmt.setString(6, "uploads/" + fileName);

        pstmt.executeUpdate();

        ResultSet rs = pstmt.getGeneratedKeys();
        if (rs.next()) {
            return rs.getInt(1);
        }
        throw new SQLException("Failed to get product ID");
    }

    private void insertMobileSpecs(Connection conn, int productId, HttpServletRequest request)
            throws SQLException {
        String sql = "INSERT INTO mobile_specs (product_id, brand, os, ram, storage, " +
                "main_camera, rear_camera, network_tech, screen_tech, weight, " +
                "launch_date, battery_capacity, charging_specs) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, productId);
        pstmt.setString(2, request.getParameter("mobile_brand"));
        pstmt.setString(3, request.getParameter("mobile_os"));
        pstmt.setString(4, request.getParameter("mobile_ram"));
        pstmt.setString(5, request.getParameter("mobile_storage"));
        pstmt.setString(6, request.getParameter("mobile_main_camera"));
        pstmt.setString(7, request.getParameter("mobile_rear_camera"));
        pstmt.setString(8, request.getParameter("mobile_network"));
        pstmt.setString(9, request.getParameter("mobile_screen"));
        pstmt.setString(10, request.getParameter("mobile_weight"));
        pstmt.setDate(11, Date.valueOf(request.getParameter("mobile_launch_date")));
        pstmt.setString(12, request.getParameter("mobile_battery"));
        pstmt.setString(13, request.getParameter("mobile_charging"));

        pstmt.executeUpdate();
    }

    private void insertPCSpecs(Connection conn, int productId, HttpServletRequest request)
            throws SQLException {
        String sql = "INSERT INTO pc_specs (product_id, brand, processor_speed, ram, " +
                "storage, display_size, graphics_card, os, battery_capacity, " +
                "charging_specs, touch_sensor, keyboard_light, num_fans) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, productId);
        pstmt.setString(2, request.getParameter("pc_brand"));
        pstmt.setString(3, request.getParameter("pc_processor"));
        pstmt.setString(4, request.getParameter("pc_ram"));
        pstmt.setString(5, request.getParameter("pc_storage"));
        pstmt.setString(6, request.getParameter("pc_display"));
        pstmt.setString(7, request.getParameter("pc_graphics"));
        pstmt.setString(8, request.getParameter("pc_os"));
        pstmt.setString(9, request.getParameter("pc_battery"));
        pstmt.setString(10, request.getParameter("pc_charging"));
        pstmt.setBoolean(11, Boolean.parseBoolean(request.getParameter("pc_touch")));
        pstmt.setBoolean(12, Boolean.parseBoolean(request.getParameter("pc_keyboard_light")));
        pstmt.setInt(13, Integer.parseInt(request.getParameter("pc_fans")));

        pstmt.executeUpdate();
    }
}