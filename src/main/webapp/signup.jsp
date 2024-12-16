<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
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
        .signup-container {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 400px;
            margin: 20px;
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
            box-sizing: border-box;
        }
        .button {
            background-color: #4CAF50;
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
            font-size: 0.9em;
            margin-top: 5px;
        }
        .success {
            color: green;
            font-size: 0.9em;
            margin-top: 5px;
        }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
        .login-link a {
            color: #4CAF50;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>Sign Up</h2>
        <form id="signupForm" action="${pageContext.request.contextPath}/signup" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" required minlength="2">
            </div>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" id="username" required minlength="4" onkeyup="checkUsername()">
                <div id="usernameStatus"></div>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" id="email" required onkeyup="checkEmail()">
                <div id="emailStatus"></div>
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <input type="tel" name="phone" required pattern="[0-9]{10}">
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required minlength="6">
            </div>
            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" required minlength="6">
            </div>
            <div class="form-group">
                <button type="submit" class="button">Sign Up</button>
            </div>
        </form>
        <div class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
        </div>
    </div>

    <script>
        let usernameValid = false;
        let emailValid = false;

        function checkUsername() {
            const username = document.getElementById('username').value;
            if (username.length < 4) {
                document.getElementById('usernameStatus').className = 'error';
                document.getElementById('usernameStatus').textContent = 'Username must be at least 4 characters';
                usernameValid = false;
                return;
            }

            fetch('${pageContext.request.contextPath}/check-username?username=' + encodeURIComponent(username))
                .then(response => response.text())
                .then(data => {
                    if (data === 'available') {
                        document.getElementById('usernameStatus').className = 'success';
                        document.getElementById('usernameStatus').textContent = 'Username is available';
                        usernameValid = true;
                    } else {
                        document.getElementById('usernameStatus').className = 'error';
                        document.getElementById('usernameStatus').textContent = 'Username is already taken';
                        usernameValid = false;
                    }
                });
        }

        function checkEmail() {
            const email = document.getElementById('email').value;
            if (!email) return;

            fetch('${pageContext.request.contextPath}/check-email?email=' + encodeURIComponent(email))
                .then(response => response.text())
                .then(data => {
                    if (data === 'available') {
                        document.getElementById('emailStatus').className = 'success';
                        document.getElementById('emailStatus').textContent = 'Email is available';
                        emailValid = true;
                    } else {
                        document.getElementById('emailStatus').className = 'error';
                        document.getElementById('emailStatus').textContent = 'Email is already registered';
                        emailValid = false;
                    }
                });
        }

        function validateForm() {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;

            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }

            if (!usernameValid || !emailValid) {
                alert('Please fix the errors in the form before submitting.');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>