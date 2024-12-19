package com.genuine.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.genuine.model.Product;

public class ProductDAO {
    private Connection connection;

    public ProductDAO() {
        // Initialize database connection
    }

    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                products.add(product);
            }
        }
        return products;
    }

    // Add methods for inserting, updating, and deleting products
}