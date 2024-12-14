package com.genuine.dao;

import java.sql.Connection;
import java.sql.DriverManager;

// DBConnection.java
public class DBConnection {
    private static Connection conn = null;

    public static Connection getConnection() {
        try {
            if (conn == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/electronics_db",
                        "root",
                        "1234"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}