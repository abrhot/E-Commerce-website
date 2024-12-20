package com.genuine.dao;

import java.sql.*;
import java.util.*;
import com.genuine.model.*;

public class ProductDAO {

    public List<Product> getPopularProducts(int limit) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY RAND() LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }
        return products;
    }

    public List<Product> getProductsByCategory(String category) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }
        return products;
    }

    public List<Product> searchProducts(String searchTerm) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR company LIKE ? OR description LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String term = "%" + searchTerm + "%";
            pstmt.setString(1, term);
            pstmt.setString(2, term);
            pstmt.setString(3, term);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }
        return products;
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setCategory(rs.getString("category"));
        product.setName(rs.getString("name"));
        product.setCompany(rs.getString("company"));
        product.setPrice(rs.getDouble("price"));
        product.setDescription(rs.getString("description"));
        product.setImagePath(rs.getString("image_path"));
        product.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return product;
    }
}