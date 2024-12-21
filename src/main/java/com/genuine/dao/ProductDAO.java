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
}