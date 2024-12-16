package com.genuine.dao;

import com.genuine.model.User;
import java.sql.*;

public class UserDAO {
    public User validateUser(String loginId, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, loginId);
            pstmt.setString(2, loginId);
            pstmt.setString(3, password); // In production, use password hashing

            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setCountryCode(rs.getString("country_code"));
                user.setCountryName(rs.getString("country_name"));
                // Don't set password for security reasons
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }
}