<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
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
            background-color: #2196F3;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .button:hover {
            background-color: #1976D2;
        }
        .error {
            color: red;
            margin-bottom: 15px;
        }
        .back-link {
            text-align: center;
            margin-top: 15px;
        }
        .back-link a {
            color: #2196F3;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Admin Login</h2>
        <% if(request.getAttribute("error") != null) { %>
            <div class="error">${error}</div>
        <% } %>
        <form action="${pageContext.request.contextPath}/adminLogin" method="post">
            <div class="form-group">
                <label>Admin Username</label>
                <input type="text" name="adminUsername" required>
            </div>
            <div class="form-group">
                <label>Admin Password</label>
                <input type="password" name="adminPassword" required>
            </div>
            <div class="form-group">
                <button type="submit" class="button">Login as Admin</button>
            </div>
        </form>
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/login.jsp">Back to User Login</a>
        </div>
    </div>
</body>
</html>