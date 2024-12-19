package com.genuine.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.genuine.model.MobileSpec;
import com.genuine.model.Product;

public class ProductDAO {

    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setCategory(rs.getString("category"));
                product.setName(rs.getString("name"));
                product.setCompany(rs.getString("company"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImagePath(rs.getString("image_path"));
                product.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                products.add(product);
            }
        }
        return products;
    }

    public Product getProductWithSpecs(int productId) throws SQLException {
        Product product = null;

        try (Connection conn = DBConnection.getConnection()) {
            // Get basic product info
            String sql = "SELECT * FROM products WHERE product_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setCategory(rs.getString("category"));
                // Set other basic properties

                // Get specifications based on category
                switch (product.getCategory()) {
                    case "mobile":
                        product.setSpecs(getMobileSpecs(conn, productId));
                        break;
                }
            }
        }
        return product;
    }

    private MobileSpec getMobileSpecs(Connection conn, int productId) throws SQLException {
        String sql = "SELECT * FROM mobile_specs WHERE product_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, productId);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            MobileSpec specs = new MobileSpec();
            specs.setStorage(rs.getString("storage"));
            specs.setRam(rs.getString("ram"));
            specs.setBattery(rs.getString("battery"));
            specs.setCameraSpecs(rs.getString("camera_specs"));
            return specs;
        }
        return null;
    }

    // Similar methods for getLaptopSpecs and getWatchSpecs
}