<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76,175,80,0.2);
        }
        .status-message {
            font-size: 12px;
            margin-top: 5px;
            position: absolute;
            left: 0;
            bottom: -20px;
        }
        .taken {
            color: #f44336;
        }
        .available {
            color: #4CAF50;
        }
        .checking {
            color: #2196F3;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049;
        }
        button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .error-message {
            color: #f44336;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
            display: none;
        }
        .password-match {
            color: #4CAF50;
        }
        .password-mismatch {
            color: #f44336;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Sign Up</h2>

        <div id="errorMessage" class="error-message">
            <%
                String error = request.getParameter("error");
                if (error != null) {
                    switch(error) {
                        case "username_exists":
                            out.println("Username already exists!");
                            break;
                        case "email_exists":
                            out.println("Email already exists!");
                            break;
                        case "missing_fields":
                            out.println("Please fill in all fields!");
                            break;
                        case "password_mismatch":
                            out.println("Passwords do not match!");
                            break;
                        case "insert_failed":
                            out.println("Registration failed. Please try again.");
                            break;
                        case "unknown":
                            out.println("An unexpected error occurred. Please try again.");
                            break;
                        default:
                            out.println("An error occurred. Please try again.");
                            break;
                    }
                }
            %>
        </div>

        <form id="signupForm" action="${pageContext.request.contextPath}/SignupServlet" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>

            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required minlength="3" onkeyup="checkUsername(this.value)">
                <div id="usernameStatus" class="status-message"></div>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="tel" id="phone" name="phone" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required minlength="6" onkeyup="checkPasswordMatch()">
                <div id="passwordStrength" class="status-message"></div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required minlength="6" onkeyup="checkPasswordMatch()">
                <div id="passwordMatch" class="status-message"></div>
            </div>

            <button type="submit" id="submitButton">Sign Up</button>
        </form>
    </div>

    <script>
        let usernameAvailable = false;
        let passwordsMatch = false;
        let debounceTimer;

        function checkUsername(username) {
            const statusDiv = document.getElementById('usernameStatus');
            const submitButton = document.getElementById('submitButton');

            clearTimeout(debounceTimer);

            if (!username || username.length < 3) {
                statusDiv.innerHTML = 'Username must be at least 3 characters';
                statusDiv.className = 'status-message taken';
                usernameAvailable = false;
                updateSubmitButton();
                return;
            }

            statusDiv.innerHTML = 'Checking availability...';
            statusDiv.className = 'status-message checking';

            debounceTimer = setTimeout(() => {
                fetch('${pageContext.request.contextPath}/CheckUsernameServlet?username=' + encodeURIComponent(username))
                    .then(response => response.text())
                    .then(data => {
                        if (data === 'taken') {
                            statusDiv.innerHTML = 'Username is already taken';
                            statusDiv.className = 'status-message taken';
                            usernameAvailable = false;
                        } else {
                            statusDiv.innerHTML = 'Username is available';
                            statusDiv.className = 'status-message available';
                            usernameAvailable = true;
                        }
                        updateSubmitButton();
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        statusDiv.innerHTML = 'Error checking username';
                        statusDiv.className = 'status-message taken';
                        usernameAvailable = false;
                        updateSubmitButton();
                    });
            }, 500);
        }

        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchDiv = document.getElementById('passwordMatch');
            const strengthDiv = document.getElementById('passwordStrength');

            // Check password strength
            if (password.length > 0) {
                let strength = 0;
                if (password.length >= 8) strength++;
                if (password.match(/[a-z]+/)) strength++;
                if (password.match(/[A-Z]+/)) strength++;
                if (password.match(/[0-9]+/)) strength++;
                if (password.match(/[$@#&!]+/)) strength++;

                const strengthText = ['Weak', 'Fair', 'Good', 'Strong', 'Very Strong'];
                strengthDiv.innerHTML = `Password Strength: ${strengthText[strength-1]}`;
                strengthDiv.className = strength < 3 ? 'status-message taken' : 'status-message available';
            } else {
                strengthDiv.innerHTML = '';
            }

            // Check password match
            if (confirmPassword.length > 0) {
                if (password === confirmPassword) {
                    matchDiv.innerHTML = 'Passwords match';
                    matchDiv.className = 'status-message password-match';
                    passwordsMatch = true;
                } else {
                    matchDiv.innerHTML = 'Passwords do not match';
                    matchDiv.className = 'status-message password-mismatch';
                    passwordsMatch = false;
                }
            } else {
                matchDiv.innerHTML = '';
                passwordsMatch = false;
            }

            updateSubmitButton();
        }

        function updateSubmitButton() {
            const submitButton = document.getElementById('submitButton');
            submitButton.disabled = !(usernameAvailable && passwordsMatch);
        }

        function validateForm() {
            const errorMessage = document.getElementById('errorMessage');
            const fullName = document.getElementById('fullName').value;
            const email = document.getElementById('email').value;
            const phone = document.getElementById('phone').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (!usernameAvailable) {
                errorMessage.innerHTML = 'Please choose a different username';
                errorMessage.style.display = 'block';
                return false;
            }

            if (password !== confirmPassword) {
                errorMessage.innerHTML = 'Passwords do not match';
                errorMessage.style.display = 'block';
                return false;
            }

            if (password.length < 6) {
                errorMessage.innerHTML = 'Password must be at least 6 characters';
                errorMessage.style.display = 'block';
                return false;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                errorMessage.innerHTML = 'Please enter a valid email address';
                errorMessage.style.display = 'block';
                return false;
            }

            const phoneRegex = /^\d{10}$/;
            if (!phoneRegex.test(phone)) {
                errorMessage.innerHTML = 'Please enter a valid 10-digit phone number';
                errorMessage.style.display = 'block';
                return false;
            }

            return true;
        }

        window.onload = function() {
            const errorMessage = document.getElementById('errorMessage');
            if (errorMessage.innerHTML.trim() !== '') {
                errorMessage.style.display = 'block';
            }
            updateSubmitButton();
        }
    </script>
</body>
</html>