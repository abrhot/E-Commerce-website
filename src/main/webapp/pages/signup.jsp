<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <style>
        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }
        .error {
            color: red;
            font-size: 12px;
            display: none;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create Account</h2>
        <form id="signupForm" action="SignupServlet" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <input type="text" name="fullName" id="fullName" placeholder="Full Name" required>
            </div>

            <div class="form-group">
                <input type="text" name="username" id="username" placeholder="Username" required
                       onkeyup="checkUsername(this.value)">
                <span id="usernameError" class="error"></span>
            </div>

            <div class="form-group">
                <input type="email" name="email" id="email" placeholder="Email" required>
            </div>

            <div class="form-group">
                <input type="tel" name="phone" id="phone" placeholder="Phone Number" required
                       pattern="[0-9]{10}">
            </div>

            <div class="form-group">
                <input type="password" name="password" id="password" placeholder="Password" required>
            </div>

            <div class="form-group">
                <input type="password" name="confirmPassword" id="confirmPassword"
                       placeholder="Confirm Password" required>
                <span id="passwordError" class="error"></span>
            </div>

            <button type="submit">Sign Up</button>
        </form>
    </div>

    <script>
        function checkUsername(username) {
            if(username.length < 3) {
                return;
            }

            fetch('CheckUsernameServlet?username=' + username)
                .then(response => response.text())
                .then(data => {
                    let errorSpan = document.getElementById('usernameError');
                    if(data === 'taken') {
                        errorSpan.style.display = 'block';
                        errorSpan.textContent = 'Username already taken';
                    } else {
                        errorSpan.style.display = 'none';
                    }
                });
        }

        function validateForm() {
            let password = document.getElementById('password').value;
            let confirmPassword = document.getElementById('confirmPassword').value;
            let errorSpan = document.getElementById('passwordError');

            if(password !== confirmPassword) {
                errorSpan.style.display = 'block';
                errorSpan.textContent = 'Passwords do not match';
                return false;
            }

            if(password.length < 6) {
                errorSpan.style.display = 'block';
                errorSpan.textContent = 'Password must be at least 6 characters';
                return false;
            }

            return true;
        }
    </script>
</body>
</html>