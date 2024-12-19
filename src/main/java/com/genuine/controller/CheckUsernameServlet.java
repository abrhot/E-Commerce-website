package com.genuine.controller;

import com.genuine.dao.UserDAO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/check-username")
public class CheckUsernameServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String username = request.getParameter("username");
        response.setContentType("text/plain");
        response.getWriter().write(userDAO.isUsernameAvailable(username) ? "available" : "taken");
    }
}