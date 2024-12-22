package com.genuine.dao;

import com.genuine.model.Product;
import java.sql.*;
        import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;

public class ProductDAO {

    public List<Product> getRandomProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY RAND() LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setCategory(rs.getString("category"));
                product.setName(rs.getString("name"));
                product.setCompany(rs.getString("company"));
                product.setPrice(rs.getDouble("price"));
                product.setImagePath(rs.getString("image_path"));
                product.setDescription(rs.getString("description"));
                product.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    // Add the getProductsByCategory method here
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, " +
                "CASE " +
                "   WHEN p.category = 'mobile' THEN ms.spec_id " +
                "   WHEN p.category = 'pc & laptop' THEN ps.spec_id " +
                "   WHEN p.category = 'watch' THEN ws.spec_id " +
                "   WHEN p.category = 'headset' THEN hs.spec_id " +
                "   WHEN p.category = 'tv' THEN ts.spec_id " +
                "END as spec_id " +
                "FROM products p " +
                "LEFT JOIN mobile_specs ms ON p.product_id = ms.product_id " +
                "LEFT JOIN pc_specs ps ON p.product_id = ps.product_id " +
                "LEFT JOIN watch_specs ws ON p.product_id = ws.product_id " +
                "LEFT JOIN headset_specs hs ON p.product_id = hs.product_id " +
                "LEFT JOIN tv_specs ts ON p.product_id = ts.product_id " +
                "WHERE p.category = ? " +
                "ORDER BY p.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setCategory(rs.getString("category"));
                product.setName(rs.getString("name"));
                product.setCompany(rs.getString("company"));
                product.setPrice(rs.getDouble("price"));
                product.setImagePath(rs.getString("image_path"));
                product.setDescription(rs.getString("description"));
                product.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}