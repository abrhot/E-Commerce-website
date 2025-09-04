<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        .login-container {
            width: 300px;
            margin: 100px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .button {
            background-color: #000000;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            margin-bottom: 15px;
        }
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
        .admin-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #2196F3;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 15px;
        }
        .admin-button:hover {
            background-color: #1976D2;
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
        <a href="${pageContext.request.contextPath}/adminLogin.jsp" class="admin-button">Admin Login</a>
    </div>
</body>
</html>
