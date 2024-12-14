<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 400px;
            width: 90%;
        }
        .error-icon {
            color: #f44336;
            font-size: 48px;
            margin-bottom: 20px;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            margin-bottom: 30px;
        }
        .back-btn {
            background-color: #2196F3;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 3px;
            display: inline-block;
        }
        .back-btn:hover {
            background-color: #1976D2;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-icon">✗</div>
        <h1>Error</h1>
        <p>An error occurred during the registration process. Please try again.</p>
        <a href="${pageContext.request.contextPath}/pages/signup.jsp" class="back-btn">Back to Registration</a>
    </div>
</body>
</html>