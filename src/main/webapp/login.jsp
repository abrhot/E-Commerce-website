<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        /* Previous styles remain the same */
        .signup-link {
            text-align: center;
            margin-top: 15px;
        }
        .signup-link a {
            color: #4CAF50;
            text-decoration: none;
        }
        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <% if(request.getAttribute("error") != null) { %>
            <div class="error">${error}</div>
        <% } %>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Username or Email</label>
                <input type="text" name="loginId" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <button type="submit" class="button">Login</button>
            </div>
        </form>
        <div class="signup-link">
            Don't have an account? <a href="${pageContext.request.contextPath}/signup.jsp">Sign Up</a>
        </div>
    </div>
</body>
</html>