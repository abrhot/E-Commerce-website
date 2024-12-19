package com.genuine.controller;

import com.genuine.dao.UserDAO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/check-email")
public class CheckEmailServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String email = request.getParameter("email");
        response.setContentType("text/plain");
        response.getWriter().write(userDAO.isEmailAvailable(email) ? "available" : "taken");
    }
}