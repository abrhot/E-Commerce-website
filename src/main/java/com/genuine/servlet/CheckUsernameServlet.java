package com.genuine.servlet;


import com.genuine.dao.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/CheckUsernameServlet")
public class CheckUsernameServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        response.setContentType("text/plain");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement pst = conn.prepareStatement(
                    "SELECT username FROM users WHERE username = ?"
            );
            pst.setString(1, username);
            ResultSet rs = pst.executeQuery();

            if(rs.next()) {
                response.getWriter().write("taken");
            } else {
                response.getWriter().write("available");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}