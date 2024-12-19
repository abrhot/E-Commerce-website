package com.genuine.controller;

import com.genuine.dao.UserDAO;
import com.genuine.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = new User();
            user.setFullName(request.getParameter("fullName"));
            user.setUsername(request.getParameter("username"));
            user.setEmail(request.getParameter("email"));
            user.setCountryCode(request.getParameter("countryCode"));
            user.setPhoneNumber(request.getParameter("phoneNumber"));
            user.setCountryName(request.getParameter("country"));
            user.setPassword(request.getParameter("password"));

            if (userDAO.createUser(user)) {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            } else {
                request.setAttribute("error", "Failed to create account. Please try again.");
                request.getRequestDispatcher("/signup.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred. Please try again later.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }
}